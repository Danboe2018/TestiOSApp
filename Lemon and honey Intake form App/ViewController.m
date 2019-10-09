//
//  ViewController.m
//  Lemon and honey Intake form App
//
//  Created by Gurie on 14/02/17.
//  Copyright © 2017 Gurie. All rights reserved.
//

#import "ViewController.h"
#import "HelperFunctions.h"
#import "UIViewController+BasicFunctions.h"
#import "FormSelectionViewController.h"
#import "AppDelegate.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    
    
    if ([userDefaults() boolForKey:@"rememberMe"] == true)
    {
        self.textFieldEmail.text = [NSString stringWithFormat:@"%@",[userDefaults() objectForKey:@"email"]];
        self.textFieldPassword.text = [NSString stringWithFormat:@"%@",[userDefaults() objectForKey:@"password"]];
        self.textFieldSalonId.text = [NSString stringWithFormat:@"%@",[userDefaults() objectForKey:@"salonid"]];
        self.buttonCheck.selected = true;
    }
    
    //Do any additional setup after loading the view, typically from a nib.
    //[self configureTextfield:self.textFieldEmail placeholder:@"Email"];
    //[self configureTextfield:self.textFieldPassword placeholder:@"Password"];
    //self.textFieldPassword.secureTextEntry = true;
    //[self configureTextfield:self.textFieldSalonId placeholder:@"Salon Id"];
    //self.textFieldSalonId.keyboardType = UIKeyboardTypePhonePad;
    
    HFAddShadowToView(self.viewLogin);
}


-(void)configureTextfield:(ACFloatingTextField *)textField placeholder:(NSString*)stringPlaceholder
{
    [textField setTextFieldPlaceholderText:stringPlaceholder];
    textField.selectedLineColor = [UIColor blackColor];
    textField.placeHolderColor = [UIColor blackColor];
    textField.selectedPlaceHolderColor = [UIColor clearColor];
    textField.lineColor = [UIColor blackColor];
    textField.backgroundColor = [UIColor clearColor];
    
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)rememberMeAction:(UIButton*)sender
{
    if ([sender isSelected])
    {
        [userDefaults()setBool:false forKey:@"rememberMe"];
        
    }
    else
    {
        [userDefaults()setBool:true forKey:@"rememberMe"];
        
    }
}
- (IBAction)loginAction:(id)sender
{
    
    if (self.textFieldEmail.text.length == 0)
    {
        alert(@"", @"Email is required");
        return;
    }
    
    if (self.textFieldPassword.text.length == 0)
    {
        alert(@"", @"Password is required");
        return;
    }
    
    if (self.textFieldSalonId.text.length == 0)
    {
        alert(@"", @"Account Number is required");
        return;
    }
    
    if (!isValidEmail(self.textFieldEmail.text))
    {
        alert(@"", @"Invalid email.");
        return;
    }
    
    NSDictionary * param = @{@"email":self.textFieldEmail.text,
                             @"password":self.textFieldPassword.text,
                             @"salon_code":self.textFieldSalonId.text,
                             @"device_type":@"ios",
                             @"push_token":@""};
    
    [self showHUD];
    
    [self POSTHTTP:WS_Login parameters:param handler:^(NSError *error, NSDictionary *responseObject) {
        [self hideHUD];
        if (error) {
            alert(@"", error.localizedDescription);
        }else {
            NSLog(@"%@",responseObject);
            if (responseObject)
            {
                if ([responseObject[@"status"] boolValue])
                {
                    if ([userDefaults() boolForKey:@"rememberMe"] == true)
                    {
                        [userDefaults() setValue:self.textFieldEmail.text forKey:@"email"];
                        [userDefaults() setValue:self.textFieldPassword.text forKey:@"password"];
                        [userDefaults() setValue:self.textFieldSalonId.text forKey:@"salonid"];
                    }
                    else
                    {
                        [userDefaults() setValue:self.textFieldEmail.text forKey:@"email"];
                        [userDefaults() setValue:self.textFieldPassword.text forKey:@"password"];
                        [userDefaults() setValue:self.textFieldSalonId.text forKey:@"salonid"];
                    }
                    
                    [userDefaults() setValue:responseObject[@"S3AccessKey"] forKey:@"S3AccessKey"];
                    [userDefaults() setValue:responseObject[@"S3BucketName"] forKey:@"S3BucketName"];
                    [userDefaults() setValue:responseObject[@"S3SecretKey"] forKey:@"S3SecretKey"];
                    [userDefaults() setValue:responseObject[@"ServerBaseUrl"] forKey:@"ServerBaseUrl"];
                    [userDefaults() setValue:responseObject[@"emp_iid"] forKey:@"emp_iid"];
                    // To retrieve Module id
                    if (responseObject[@"modules"]) {
                        NSArray * array = responseObject[@"modules"];
                        for (int i = 0; i < array.count; i++) {
                            NSDictionary * dictionary = array[i];
                            if ([dictionary [@"module_type"] isEqualToString:@"Forms"])
                            {
                                [userDefaults() setValue:dictionary[@"module_id"] forKey:@"module_id"];
                            }
                        }
                    }
                    [self saveUserDetails:responseObject];
                    [self showForm:FormTypeSearchClient];
                }else{
                    alert(@"ERROR!", responseObject[@"msg"]);
                }
            }
        }
    }];
}

-(void)showForm:(FormType)formType {
    
    [self removeBackButtonText];
    //    NSMutableDictionary *dict = [NSMutableDictionary new];
    //    NSUserDefaults *clientDef = [NSUserDefaults standardUserDefaults];
    //    [clientDef setObject:dict forKey:@"ClientDetails"];
    //    [clientDef synchronize];
    FormSelectionViewController * viewController = [self.storyboard instantiateViewControllerWithIdentifier:@"FormSelectionViewController"];
    [self.navigationController pushViewController:viewController animated:YES];
}

@end
