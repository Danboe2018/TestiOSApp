//
//  SearchViewController.m
//  Lemon and honey Intake form App
//
//  Created by Gurie on 02/03/17.
//  Copyright © 2017 Gurie. All rights reserved.
//

#import "SearchViewController.h"
#import "MBProgressHUD.h"
#import "UIViewController+BasicFunctions.h"
#import "AppDelegate.h"

@interface SearchViewController ()
{
    BOOL _isSearchingForSuggestions;
    NSArray* _searchedClients;
    NSArray* _searchAppointments;
    NSString * _searchString;

}
@end

@implementation SearchViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
        self.title = ([self.searchBy  isEqual: @"Search Client"])?@"Search Client":@"Search Appointment";
        
        XLFormDescriptor * form;
        XLFormSectionDescriptor * section;
        XLFormRowDescriptor * row;
        
        form = [XLFormDescriptor formDescriptor];
    
        section = [XLFormSectionDescriptor formSection];
        section.title = ([self.searchBy  isEqual: @"Search Client"])?@"Search By Client Name":@"Seach by Appointment";
        [form addFormSection:section];
        
        row = [XLFormRowDescriptor formRowDescriptorWithTag:([self.searchBy  isEqual: @"Search Client"])?@"name":@"appointment" rowType:XLFormRowDescriptorTypeName title:([self.searchBy  isEqual: @"Search Client"])?@"Full Name":@"Appointment"];
        [row.cellConfigAtConfigure setObject:@"" forKey:@"textField.placeholder"];
        [row.cellConfigAtConfigure setObject:@(NSTextAlignmentRight) forKey:@"textField.textAlignment"];
        [row.cellConfigAtConfigure setObject:[UIColor blackColor] forKey:@"detailTextLabel.textColor"];
        
        [section addFormRow:row];
        
        self.form = form;
    
    // Do any additional setup after loading the view.
}

#pragma mark- Set Up Search By
-(void)formRowDescriptorValueHasChanged:(XLFormRowDescriptor *)formRow oldValue:(id)oldValue newValue:(id)newValue
{
    if ([formRow isKindOfClass:[GMFormRowDescriptor class]]) {
        [(GMFormRowDescriptor *)formRow applyRule];
    }
    
    if ([newValue isKindOfClass:[NSNull class]]) {
        return;
    }
    
    if ([formRow.tag isEqualToString:@"name"])
    {
        if (((NSString*)newValue).length == 3 && !_isSearchingForSuggestions && _searchedClients.count == 0)
        {
            
            [self getClientSuggestions:newValue];
        }else if (((NSString*)newValue).length < 3)
        {
            _searchedClients = [NSArray new];
        }
        
        _searchString = newValue;
        [self showSuggestions:newValue];
    }
    
    if ([formRow.tag isEqualToString:@"appointment"])
    {
        if (((NSString*)newValue).length == 3 && !_isSearchingForSuggestions && _searchAppointments.count == 0)
        {
            [self getAppointmentsSuggestions:newValue];
        }else if (!_searchAppointments)
        {
            _searchAppointments = [NSArray new];
        }
        
        _searchString = newValue;
        [self showAppointmentsSuggestions:_searchString];
    }
}

-(void)getClientSuggestions:(NSString*)name
{
    _isSearchingForSuggestions = true;
    NSString * url = [NSString stringWithFormat:WS_GetClientSuggestions];
    [self showHUD];
    [self POSTHTTP:url parameters:@{@"salon_id":[self salonId], @"client_name":name} handler:^(NSError *error, id responseObject) {
        
        [self hideHUD];
        
        if (error) {
            
            _isSearchingForSuggestions = false;
            alert(@"ERROR", error.localizedDescription);
        }else {
            
            NSLog(@"%@",responseObject);
            
            if ([responseObject[@"status"] boolValue])
            {
                _searchedClients = responseObject[@"client_names"];
            }else
            {
                alert(@"", [NSString stringWithFormat:@"No client found matching %@. Please check your search and try again.",name.uppercaseString]);
            }
            
            [self showSuggestions:_searchString];
            
            _isSearchingForSuggestions = false;
        }
    }];
}

-(void)showSuggestions:(NSString *)newValue
{
    if (_searchedClients != nil)
    {
        XLFormSectionDescriptor * firstSection = [[self.form formSections] firstObject];
        
        NSArray * allsections = [[self.form formSections] copy];
        
        for (XLFormSectionDescriptor * section in allsections)
        {
            if (section != firstSection)
            {
                [self.form removeFormSection:section];
            }
        }
        
        XLFormSectionDescriptor * secondSection = [XLFormSectionDescriptor formSection];
        [self.form addFormSection:secondSection];
        
        //--
        for (NSString * name  in _searchedClients)
        {
            if ([name.uppercaseString containsString:newValue.uppercaseString])
            {
                XLFormRowDescriptor * row = [XLFormRowDescriptor formRowDescriptorWithTag:@"client" rowType:XLFormRowDescriptorTypeButton title:name];
                [row.cellConfig setObject:[UIColor blackColor] forKey:@"textLabel.textColor"];
                [row.cellConfig setObject:@(NSTextAlignmentNatural) forKey:@"textLabel.textAlignment"];
                
                __typeof(self) __weak weakSelf = self;
                row.action.formBlock = ^(XLFormRowDescriptor * sender){
                    
                    dispatch_async(dispatch_get_main_queue(), ^{
                        
                        //[self updateClient];
                        [weakSelf getClientDetails:name];
                    });
                };
                
                [secondSection addFormRow:row];
            }
            
            if (secondSection.formRows.count >= 15) {
                break;
            }
        }
    }
}

-(void)getClientDetails:(NSString *)name
{
    NSString * url = [NSString stringWithFormat:WS_GetClientDetails];
    
    NSDictionary * dic = @{@"salon_id":[self salonId], @"client_name":name};
    
    [self showHUD];
    [self POSTHTTP:url parameters:dic handler:^(NSError *error, id responseObject) {
        
        [self hideHUD];
        
        if (error) {
            alert(@"ERROR", error.localizedDescription);
        }else {
            NSLog(@"%@",responseObject);
            
            if ([responseObject[@"status"] boolValue])
            {
                dispatch_async(dispatch_get_main_queue(), ^{
                    
                    NSDictionary * data = responseObject[@"data"];
                    
                    if (data[@"Id"])
                    {
                        KappDelegate.clientValues = data;
                        NSLog(@"%@",KappDelegate.clientValues);
                        NSUserDefaults * users = [NSUserDefaults standardUserDefaults];

                        [users setValue:[NSString stringWithFormat:@"%@ %@",KappDelegate.clientValues[@"clientProfileData"][@"FirstName"],KappDelegate.clientValues[@"clientProfileData"][@"LastName"]] forKey:@"Name"];
                        [users setValue:KappDelegate.clientValues[@"clientProfileData"][@"Address1"] forKey:Address];
                        [users setValue:KappDelegate.clientValues[@"clientProfileData"][City] forKey:City];
                        [users setValue:KappDelegate.clientValues[@"clientProfileData"][State] forKey:State];
                        [users setValue:KappDelegate.clientValues[@"clientProfileData"][@"ZipCode"] forKey:Zip];
                        [users setValue:KappDelegate.clientValues[@"clientProfileData"][@"EmailAddress"] forKey:Email_address];
                        [users setValue:[NSString stringWithFormat:@"%@ %@",KappDelegate.clientValues[@"clientProfileData"][@"CellAreaCode"],KappDelegate.clientValues[@"clientProfileData"][@"CellPhoneNumber"]] forKey:Cell_Phone];
                        [users setValue:KappDelegate.clientValues[@"clientProfileData"][@"Birthday"] forKey:Date_of_Birth];
                        KappDelegate.fromValidatePin =@"YES";
                        [self.navigationController popViewControllerAnimated:YES];
                    }
                    else
                    {
                        alert(@"ERROR", @"Failed to get Client ID");

                    }
                    
                });
            }else
            {
                alert(@"", responseObject[@"message"]);
            }
        }
    }];
}

-(void)getAppointmentsSuggestions:(NSString*)name
{
    _isSearchingForSuggestions = true;
    NSString * url = [NSString stringWithFormat:@"%@/%@",WS_GetAppointmentSuggestions,[self staffId]];
    NSLog(@"%@",url);
    [self showHUD];
    [self POSTHTTP:url parameters:@{@"salon_id":[self salonId]} handler:^(NSError *error, id responseObject) {
        
        [self hideHUD];
        
        if (error) {
            
            _isSearchingForSuggestions = false;
            alert(@"ERROR", error.localizedDescription);
        }else {
            
            NSLog(@"%@",responseObject);
            
            if ([responseObject[@"status"] boolValue])
            {
                _searchAppointments = responseObject[@"Appointments"];
            }else
            {
                alert(@"", [NSString stringWithFormat:@"No Appointment found matching %@. Please check your search and try again.",name.uppercaseString]);
            }
            
            [self showAppointmentsSuggestions:_searchString];
            
            _isSearchingForSuggestions = false;
        }
    }];
}

-(void)showAppointmentsSuggestions:(NSString *)newValue
{
    if (_searchAppointments != nil)
    {
        XLFormSectionDescriptor * firstSection = [[self.form formSections] firstObject];
        
        NSArray * allsections = [[self.form formSections] copy];
        
        for (XLFormSectionDescriptor * section in allsections)
        {
            if (section != firstSection)
            {
                [self.form removeFormSection:section];
            }
        }
        
        XLFormSectionDescriptor * secondSection = [XLFormSectionDescriptor formSection];
        [self.form addFormSection:secondSection];
        
        //--
        for (NSDictionary * details  in _searchAppointments)
        {
            NSString * clientName = details[@"name"];
            NSString * service = details[@"service"];
            
            NSString * name = [NSString stringWithFormat:@"%@ | %@", service, clientName];
            
            if ([service.uppercaseString containsString:newValue.uppercaseString])
            {
                XLFormRowDescriptor * row = [XLFormRowDescriptor formRowDescriptorWithTag:@"client" rowType:XLFormRowDescriptorTypeButton title:name];
                [row.cellConfig setObject:[UIColor blackColor] forKey:@"textLabel.textColor"];
                [row.cellConfig setObject:@(NSTextAlignmentNatural) forKey:@"textLabel.textAlignment"];
                
                __typeof(self) __weak weakSelf = self;
                row.action.formBlock = ^(XLFormRowDescriptor * sender){
                    
                    dispatch_async(dispatch_get_main_queue(), ^{
                        
                        //[self updateClient];
                        [self getClientDetails:name];
                    });
                    
                    NSLog(@"Push Notes here");
                    [weakSelf deselectFormRow:sender];
                };
                
                [secondSection addFormRow:row];
            }
            
            if (secondSection.formRows.count >= 15) {
                break;
            }
        }
    }
}

//--

-(NSString *)salonId {
    return SalonID;
}
-(NSString *)staffId {
    return [self userDetails][@"staff_id"];
}

-(NSString *)moduleId {
    return ModuleID;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
@implementation GMRule

+(instancetype)showRow:(XLFormRowDescriptor *)row ifValueIs:(id)value {
    
    GMRule * rule = [GMRule new];
    rule.rowDepend = row;
    rule.ifValueIs = value;
    rule.actionType = ActionTypeShow;
    
    return rule;
}

-(void)applyByRow:(GMFormRowDescriptor *)mainRow {
    
    switch (self.actionType) {
        case ActionTypeShow:
            [self performActionTypeShow:mainRow];
            break;
            
        default:
            break;
    }
}

-(void)performActionTypeShow:(GMFormRowDescriptor *)mainRow {
    
    XLFormSectionDescriptor * section = mainRow.sectionDescriptor;
    
    //-- if values are array
    if ([self.ifValueIs isKindOfClass:[NSArray class]]) {
        NSArray * values = (NSArray *)self.ifValueIs;
        //-- enumrate all values
        for (id value in values) {
            //-- compare value
            if ([mainRow.value isEqual:value]) {
                //-- show row
                if (![section.formRows containsObject:self.rowDepend]) {
                    [section addFormRow:self.rowDepend];
                }
                //-- return if values matched
                return;
            }
        }
        
        //-- hide row
        //-- values are array and not matched here.
        if ([section.formRows containsObject:self.rowDepend]) {
            [section removeFormRow:self.rowDepend];
        }
        return;
    }
    
    //-- else value is a single value
    if ([mainRow.value isEqual:self.ifValueIs]) {
        //-- show row
        if (![section.formRows containsObject:self.rowDepend]) {
            [section addFormRow:self.rowDepend];
        }
    }else {
        //-- hide row
        if ([section.formRows containsObject:self.rowDepend]) {
            [section removeFormRow:self.rowDepend];
        }
    }
}

@end
@implementation GMFormRowDescriptor

-(void)applyRule {
    
    if (self.rule) {
        [self.rule applyByRow:self];
    }
}
@end
