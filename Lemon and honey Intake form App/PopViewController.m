//
//  PopViewController.m
//  Popovers
//
//  Created by Jay Versluis on 17/10/2015.
//  Copyright © 2015 Pinkstone Pictures LLC. All rights reserved.
//

#import "PopViewController.h"
#import "UIAlertController+Helper.h"
#import "UIViewController+BasicFunctions.h"
#import "GMForm.h"
#import "AppDelegate.h"

@interface PopViewController ()
{
    NSMutableArray * arrayHistory;
}
@property (nonatomic) GMForm *form;

@end

@implementation PopViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    arrayHistory = [[NSMutableArray alloc]init];
    [self getHistory];
    // add touch recogniser to dismiss this controller
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(dismissMe)];
    //[self.view addGestureRecognizer:tap];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)dismissMe {
    
    NSLog(@"Popover was dismissed with internal tap");
    [self dismissViewControllerAnimated:YES completion:nil];
}
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return arrayHistory.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"Cell";
    PopTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    NSDictionary * dictionary = arrayHistory[indexPath.row];
    cell.textLabel.text = [NSString stringWithFormat:@"%@",dictionary[@"submittedOn"]];
    return cell;
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSDictionary * dictionary = arrayHistory[indexPath.row];

    NSMutableDictionary * jsonDataDic = [NSMutableDictionary new];
    [jsonDataDic setObject:dictionary[@"client_id"] forKey:@"client_id"];
    [jsonDataDic setObject:dictionary[@"form_id"] forKey:@"form_id"];
    [jsonDataDic setObject:dictionary[@"module_id"] forKey:@"module_id"];
    [jsonDataDic setObject:[self salonId] forKey:@"salon_id"];
    [jsonDataDic setObject:dictionary[@"uniqueEntryId"] forKey:@"uniqueEntryId"];
    [self.delegate viewController:self didSelectHistory:jsonDataDic];
    [self dismissViewControllerAnimated:YES completion:nil];

}

-(void)getHistory
{
    if (kApppDelegate.clientValues) {
        NSMutableDictionary * jsonDataDic = [NSMutableDictionary new];
        
        NSString * stringClientId = @"";
        
        if ([KappDelegate.clientValues valueForKey:@"Id"] && !([KappDelegate.clientValues valueForKey:@"Id"] == 0)) {
            stringClientId = [kApppDelegate.clientValues valueForKey:@"Id"];
        }
        
       
        [jsonDataDic setObject:stringClientId forKey:@"client_id"];
        [jsonDataDic setObject:[self form_id] forKey:@"form_id"];
        [jsonDataDic setObject:[self moduleId] forKey:@"module_id"];
        [jsonDataDic setObject:[self salonId] forKey:@"salon_id"];
        [self showHUD];
        [self POST:@"https://saloncloudsplus.com/wsforms/submittedFormsList" parameters:jsonDataDic handler:^(NSError *error, id responseObject) {
            
            [self hideHUD];
            if (responseObject) {
                if ([responseObject[@"status"] boolValue])
                {
                    id data = responseObject[@"data"];
                    [arrayHistory addObjectsFromArray:data[@"ListOfForms"]];
                    [self.tableView reloadData];
                }else {
                    [self dismissViewControllerAnimated:YES completion:nil];

                    alert(@"", responseObject[@"message"]);
                }
            }else {
                [self dismissViewControllerAnimated:YES completion:nil];

                alert(@"", @"Something went wrong. Please try again later.");
            }
            
            if (error) {
                [self hideHUD];
                if (error) {
                    [self dismissViewControllerAnimated:YES completion:nil];

                    alert(@"", error.localizedDescription);
                }else {
                    [self dismissViewControllerAnimated:YES completion:nil];

                    alert(@"", @"Something went wrong. Please try again later.");
                }
                
            }
        }];
    }
    else
    {
        alert(@"", @"Unable to find history.");
        
    }
}

-(NSString *)form_id {
    return KappDelegate.stringFormid;
}

//-(NSString *)form_id {
//    return self.form.formId;
//}
-(NSString *)clientId {
    return @"2130";//[self userDetails][@"salon_id"];//SalonID; //
}
-(NSString *)salonId {
    return SalonID; //
}
-(NSString *)staffId {
    return [self userDetails][@"staff_id"];
}

-(NSString *)moduleId {
    return ModuleID;
}

@end
