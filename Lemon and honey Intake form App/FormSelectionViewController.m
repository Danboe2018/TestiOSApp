//
//  SearchClientViewController.m
//  Lemon and honey Intake form App
//
//  Created by Gurie on 14/02/17.
//  Copyright © 2017 Gurie. All rights reserved.
//

#import "FormSelectionViewController.h"
#import "FormHeader.h"
#import "GMFormJsonManager.h"
#import "FormDisplayCollectionViewController.h"
#import "UIViewController+BasicFunctions.h"
#import "FormFieldObject.h"
#import "SearchViewController.h"
#import "UIAlertController+Helper.h"
#import "AppDelegate.h"
#import "AppointmentsViewController.h"
#import "THPinViewController.h"
#import "THPinView.h"
@interface FormSelectionViewController ()<UIActionSheetDelegate, THPinViewControllerDelegate>
{

}
@property (nonatomic, assign) NSUInteger remainingPinEntries;

@end

@implementation FormSelectionViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    self.viewLogout.hidden = true;
        self.navigationController.navigationItem.hidesBackButton = true;
    UIBarButtonItem *backButton = [[UIBarButtonItem alloc] initWithImage:[UIImage imageNamed:@"back"] style:UIBarButtonItemStyleDone                                                                              target:self action:@selector(backAction)];
    backButton.tintColor = [UIColor blackColor];
    self.navigationItem.leftBarButtonItem = backButton;
    KappDelegate.fromValidatePin =@"NO";

    // Do any additional setup after loading the view.
}

-(void)backAction
{
    if (KappDelegate.clientValues)
    {
        [self actionLogoutButton:nil];
    }
    else
    {
        [self.navigationController popViewControllerAnimated:YES];
    }
}
-(void)viewWillAppear:(BOOL)animated
{
    KappDelegate.stringClass = @"Form";

    if (KappDelegate.clientValues)
    {
        
        
        self.labelClientName.text = [NSString stringWithFormat:@"Saved Client: %@",KappDelegate.clientValues[@"client_name"]];
        if([KappDelegate.fromValidatePin isEqualToString:@"NO"])
            self.clientSwitchButton.hidden =YES;
        else
            self.clientSwitchButton.hidden =NO;
        self.viewLogout.hidden = false;
    }
    else
    {
        self.labelClientName.text = @"";
        self.viewLogout.hidden = true;
        self.guestButton.hidden = false;
        self.memebershipButton.hidden = false;
        self.buttonGuestConsultation.hidden = false;
        self.programsButton.hidden = false;
    }
}
-(void)viewDidAppear:(BOOL)animated {
    [super viewDidAppear:animated];
}

-(IBAction)actionLogoutButton:(id)sender
{
    //    NSMutableDictionary *dict = [NSMutableDictionary new];
    //    NSUserDefaults *clientDef = [NSUserDefaults standardUserDefaults];
    //    [clientDef setObject:dict forKey:@"ClientDetails"];
    //    [clientDef synchronize];
    
    KappDelegate.fromValidatePin = @"NO";

    self.viewLogout.hidden = true;
    KappDelegate.clientValues = nil;
    KappDelegate.isAllowedClientForm = true;
    self.guestButton.hidden = false;
    self.memebershipButton.hidden = false;
    self.buttonGuestConsultation.hidden = false;
    self.programsButton.hidden = false;
    
}

-(IBAction)actionSwitchClientButton:(id)sender
{
    [self actionKeyForClientLogin:sender];
//    UIActionSheet *actionSheet = [[UIActionSheet alloc] initWithTitle:@"Select an Options" delegate:self cancelButtonTitle:@"Cancel" destructiveButtonTitle:nil otherButtonTitles:@"Search by Name", @"Search by appointment", nil];
//    [actionSheet showInView:self.view];
}
- (IBAction)buttonActionClientConsultationForm:(UIButton *)sender {
    if (!self.viewLogout.hidden)
    {
    [FORMDefaultStyle applyStyle];
    
    GMForm * form = [GMFormJsonManager clientConsultationForm:self.isStylist];
    [self getFormFieldInformation:form];
    }
    else
    {
        alert(@"Please fill the Customer Intake Form!", nil);
    }
}

-(IBAction)actionClientIntakeButton:(id)sender
{
    [FORMDefaultStyle applyStyle];
    
    GMForm * form = [GMFormJsonManager electronicGuestIntakeForm:self.isStylist];
    [self getFormFieldInformation:form];
}

-(IBAction)actionwellnessMembershipAgreementsButton:(id)sender
{
    if (!self.viewLogout.hidden)
    {
        [FORMDefaultStyle applyStyle];
        
        GMForm * form = [GMFormJsonManager membershipAgreement:self.isStylist];
        [self getFormFieldInformation:form];
    }
    else
    {
        alert(@"Please fill the Customer Intake Form!", nil);
    }
    
    
}
-(IBAction)actionWaxCaonsuntationForm :(id)sender
{
    if (!self.viewLogout.hidden)
    {
        [FORMDefaultStyle applyStyle];
        
        GMForm * form = [GMFormJsonManager SpaRemedeasePrograms:self.isStylist];
        [self getFormFieldInformation:form];
    }
    else
    {
        alert(@"Please fill the Customer Intake Form!", nil);
    }
    
}

-(BOOL)isStylist {
    return [userDefaults() boolForKey:@"isStylist"];
}

- (void)showPinViewAnimated:(BOOL)animated
{
    THPinViewController *pinViewController = [[THPinViewController alloc] initWithDelegate:self];
    pinViewController.promptTitle = @"Enter PIN";
    UIColor *darkBlueColor = [UIColor colorWithRed:0.012f green:0.071f blue:0.365f alpha:1.0f];
    pinViewController.promptColor = darkBlueColor;
    pinViewController.view.tintColor = darkBlueColor;
    
    // for a solid background color, use this:
    pinViewController.backgroundColor = [UIColor whiteColor];
    
    // for a translucent background, use this:
    self.view.tag = THPinViewControllerContentViewTag;
    self.modalPresentationStyle = UIModalPresentationCurrentContext;
    pinViewController.translucentBackground = YES;
    
    [self presentViewController:pinViewController animated:animated completion:nil];
}

/*-(IBAction)actionKeyForClientLogin :(id)sender
{
    [self showPinViewAnimated:YES];
}*/

-(IBAction)actionKeyForClientLogin :(id)sender
{
    UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"Staff Access"
                                                                   message:nil
                                                            preferredStyle:UIAlertControllerStyleAlert];
    [alert addTextFieldWithConfigurationHandler:^(UITextField *textField) {
        // optionally configure the text field
        textField.keyboardType = UIKeyboardTypeAlphabet;
    }];
    
    UIAlertAction *okAction = [UIAlertAction actionWithTitle:@"Validate Pin"
                                                       style:UIAlertActionStyleDefault
                                                     handler:^(UIAlertAction *action)
                               {
                                   UITextField *textField = [alert.textFields firstObject];
                                   [self checkValidatePin:textField.text];
                                   NSLog(@"%@",textField.text);
                               }];
    [alert addAction:okAction];
    
    [self presentViewController:alert animated:YES completion:nil];
}

-(void)checkValidatePin:(NSString *)pin
{
    NSMutableDictionary * parameters = [NSMutableDictionary new];
    [parameters setObject:[self salonId] forKey:@"salon_id"];
    [parameters setObject:pin forKey:@"passcode"];
    
    [self showHUD];
    
    [self POSTHTTP:WS_validate_pin parameters:parameters handler:^(NSError *error, id responseObject) {
        [self hideHUD];
        if (responseObject) {
            if ([responseObject[@"status"] boolValue])
            {
                self.memebershipButton.hidden = true;
                self.buttonGuestConsultation.hidden = true;
                self.programsButton.hidden = true;
                self.guestButton.hidden = false;
                
                NSDictionary * dictionary = responseObject[@"data"];
                KappDelegate.isAllowedClientForm = [dictionary[@"access_to_clients_profile"] boolValue];
                KappDelegate.stringStaff_id = dictionary[@"staff_id"];
                KappDelegate.ownerEmployee = dictionary[@"owner_employee"];
                NSArray * arrayAllowedForms = dictionary[@"allowed_forms"];
                for (int i = 0; i < arrayAllowedForms.count; i++)
                {
                    if([arrayAllowedForms[i] isEqualToString:@"Electronic_Guest_Intake"])
                    {
                        self.guestButton.hidden = false;
                    }
                    if([arrayAllowedForms[i] isEqualToString:@"spa_remedease_membership"])
                    {
                        self.memebershipButton.hidden = false;
                    }
                    if([arrayAllowedForms[i] isEqualToString:@"spa_remedease_programs"])
                    {
                        self.programsButton.hidden = false;
                    }
                    
                    if([arrayAllowedForms[i] isEqualToString:@"eyelash_extensions_guest_consultation_consent_form"])
                    {
                        self.buttonGuestConsultation.hidden = false;
                    }
                }
                
                UIActionSheet *actionSheet = [[UIActionSheet alloc] initWithTitle:@"Select an Options" delegate:self cancelButtonTitle:@"Cancel" destructiveButtonTitle:nil otherButtonTitles:@"Search by Name", @"Search by appointment", nil];
                [actionSheet showInView:self.view];
            }
            else
            {
                alert(@"", responseObject[@"message"]);
            }
        }
        else if (error)
        {
            
            alert(@"", error.localizedDescription);
        }
        else
        {
            alert(@"", @"Something went wrong. Please try again later.");
        }
    }];
}
-(void)actionSheet:(UIActionSheet *)actionSheet didDismissWithButtonIndex:(NSInteger)buttonIndex
{
    if (buttonIndex == 0)
    {
        KappDelegate.clientValues = nil;
        KappDelegate.isAllowedClientForm = true;
        
        SearchViewController * search = [self.storyboard instantiateViewControllerWithIdentifier:@"SearchViewController"];
        search.searchBy = (buttonIndex == 0)?@"Search Client":@"Seach by Appointment";
        [self.navigationController pushViewController:search animated:true];
    }
    else if (buttonIndex == 1)
    {
        KappDelegate.clientValues = nil;
        KappDelegate.isAllowedClientForm = true;
        
        AppointmentsViewController * app = [self.storyboard instantiateViewControllerWithIdentifier:@"AppointmentsViewController"];
        [self.navigationController pushViewController:app animated:true];
    }
    else
    {
               KappDelegate.isAllowedClientForm = true;
               self.guestButton.hidden = false;
                self.memebershipButton.hidden = false;
                self.buttonGuestConsultation.hidden = false;
                self.programsButton.hidden = false;
    }
}

-(NSString *)salonId {
    return SalonID;
}
-(NSString *)moduleId {
    return ModuleID;
}

-(void)getFormFieldInformation:(GMForm *)form
{
    NSMutableDictionary * parameters = [NSMutableDictionary new];
    [parameters setObject:[self salonId] forKey:@"salon_id"];
    [parameters setObject:[self moduleId] forKey:@"module_id"];
    [parameters setObject:form.formName forKey:@"form_name"];
    
    [self showHUD];
    
    [self POSTHTTP:WS_form_fields_information parameters:parameters handler:^(NSError *error, id responseObject) {
        [self hideHUD];
        if (responseObject) {
            if ([responseObject[@"status"] boolValue]) {
                NSLog(@"%@",responseObject[@"fields"]);
                
                dispatch_async(dispatch_get_main_queue(), ^{
                    
                    form.fieldsInfo = [self parse:responseObject[@"fields"] ofClass:[FormFieldObject class]];
                    form.formId = responseObject[@"form_id"];
                    KappDelegate.stringFormid = responseObject[@"form_id"];
                    NSLog(@"%@",KappDelegate.stringFormid);
                    FormDisplayCollectionViewController *sampleController = [[FormDisplayCollectionViewController alloc] initWithForm:form];
                    [self.navigationController pushViewController:sampleController animated:YES];
                });
            }else
            {
                alert(@"", responseObject[@"message"]);
            }
        }else if (error) {
            alert(@"", error.localizedDescription);
        }else {
            alert(@"", @"Something went wrong. Please try again later.");
        }
    }];
}

#pragma mark - THPinViewControllerDelegate

- (NSUInteger)pinLengthForPinViewController:(THPinViewController *)pinViewController
{
    return 4;
}

- (BOOL)pinViewController:(THPinViewController *)pinViewController isPinValid:(NSString *)pin
{
    NSMutableDictionary * parameters = [NSMutableDictionary new];
    [parameters setObject:[self salonId] forKey:@"salon_id"];
    [parameters setObject:pin forKey:@"passcode"];
    __block BOOL correct = YES;

    [self showHUD];
    
    [self POSTHTTP:WS_validate_pin parameters:parameters handler:^(NSError *error, id responseObject) {
        [self hideHUD];

        if (responseObject) {
            if ([responseObject[@"status"] boolValue])
            {
                self.memebershipButton.hidden = true;
                self.buttonGuestConsultation.hidden = true;
                self.programsButton.hidden = true;
                self.guestButton.hidden = false;
                NSDictionary * dictionary = responseObject[@"data"];
                KappDelegate.isAllowedClientForm = [dictionary[@"access_to_clients_profile"] boolValue];
                KappDelegate.stringStaff_id = dictionary[@"staff_id"];
                NSArray * arrayAllowedForms = dictionary[@"allowed_forms"];
                for (int i = 0; i < arrayAllowedForms.count; i++)
                {
                    if([arrayAllowedForms[i] isEqualToString:@"Electronic_Guest_Intake"])
                    {
                        self.guestButton.hidden = false;
                    }
                    if([arrayAllowedForms[i] isEqualToString:@"spa_remedease_membership"])
                    {
                        self.memebershipButton.hidden = false;
                    }
                    if([arrayAllowedForms[i] isEqualToString:@"spa_remedease_programs"])
                    {
                        self.programsButton.hidden = false;
                    }
                    if([arrayAllowedForms[i] isEqualToString:@"eyelash_extensions_guest_consultation_consent_form"])
                    {
                        self.buttonGuestConsultation.hidden = false;
                    }
                }
                
                UIActionSheet *actionSheet = [[UIActionSheet alloc] initWithTitle:@"Select an Options" delegate:self cancelButtonTitle:@"Cancel" destructiveButtonTitle:nil otherButtonTitles:@"Search by Name", @"Search by appointment", nil];
                [actionSheet showInView:self.view];
                
            }
            else
            {
                [self showPinViewAnimated:YES];

                alert(@"", responseObject[@"message"]);
            }
        }
        else if (error)
        {
            [self showPinViewAnimated:YES];

            alert(@"", error.localizedDescription);
        }
        else
        {
            [self showPinViewAnimated:YES];

            alert(@"", @"Something went wrong. Please try again later.");
        }
    }];
    return correct;

}

- (BOOL)userCanRetryInPinViewController:(THPinViewController *)pinViewController
{
    return YES;
}

- (void)incorrectPinEnteredInPinViewController:(THPinViewController *)pinViewController
{
    
}

- (void)pinViewControllerWillDismissAfterPinEntryWasSuccessful:(THPinViewController *)pinViewController
{
    
}

- (void)pinViewControllerWillDismissAfterPinEntryWasUnsuccessful:(THPinViewController *)pinViewController
{
    
}

- (void)pinViewControllerWillDismissAfterPinEntryWasCancelled:(THPinViewController *)pinViewController
{
    
}


@end
