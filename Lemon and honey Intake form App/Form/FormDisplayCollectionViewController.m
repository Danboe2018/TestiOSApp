#import "FormDisplayCollectionViewController.h"
#import "GMCheckBoxFormFieldCell.h"
#import "FormHeader.h"
#import "GMRadioButtonFormFieldCell.h"
#import "GMSignatureViewFieldCell.h"
#import "GMFormTextFieldCell.h"
#import "HYPImageFormFieldCell.h"
#import <HYPImagePicker/HYPImagePicker.h>
#import "FormFieldObject.h"
#import "UIViewController+BasicFunctions.h"
#import "AWSManager.h"
#import "GMFormLabelCell.h"
#import "AppDelegate.h"
#import "GMRatingViewFieldCell.h"
#import "UIAlertController+Helper.h"
#import "PopViewController.h"
#import "GMFormJsonManager.h"
#import "GMFormDisabledTextFieldCell.h"
#define kApppDelegate ((AppDelegate*)[[UIApplication sharedApplication] delegate])

@interface FormDisplayCollectionViewController () <HYPImagePickerDelegate,UIPopoverPresentationControllerDelegate,PopViewDelegate>
{
    NSDictionary * parsedDefaultData;
    NSString *statusStr;
    UIBarButtonItem *printValuesButton;
}

@property (nonatomic, retain) NSDictionary *values;
@property (nonatomic) HYPImagePicker *imagePicker;
@property (nonatomic) GMForm *form;
@property (nonatomic, strong) PopViewController *formDisplay;
@property (nonatomic, strong) UIBarButtonItem *printValuesButton;

@end

@implementation FormDisplayCollectionViewController

#pragma mark - Initialization

-(instancetype)initWithForm:(GMForm *)form {
    self = [self initWithJSON:form.formGroups andInitialValues:@{}];
    self.form = form;
    self.title = form.name;
    return self;
}
- (instancetype)initWithJSON:(NSArray *)JSON
            andInitialValues:(NSDictionary *)initialValues {
    self = [super initWithJSON:JSON
              andInitialValues:initialValues
                      disabled:NO];
    if (!self) return nil;

    [self.collectionView registerClass:[HYPImageFormFieldCell class]
            forCellWithReuseIdentifier:HYPImageFormFieldCellIdentifier];
    [self.collectionView registerClass:[GMCheckBoxFormFieldCell class]
            forCellWithReuseIdentifier:GMCheckBoxFormFieldCellIdentifier];
    [self.collectionView registerClass:[GMRadioButtonFormFieldCell class]
            forCellWithReuseIdentifier:GMRadioButtonFormFieldCellIdentifier];
    [self.collectionView registerClass:[GMSignatureViewFieldCell class]
            forCellWithReuseIdentifier:GMSignatureViewFieldCellIdentifier];
    [self.collectionView registerClass:[GMFormTextFieldCell class]
            forCellWithReuseIdentifier:GMFormTextFieldCellIdentifier];
    [self.collectionView registerClass:[GMRatingViewFieldCell class] forCellWithReuseIdentifier:GMRatingViewFieldCellIdentifier];
    [self.collectionView registerClass:[GMFormLabelCell class]
            forCellWithReuseIdentifier:GMFormLabelCellIdentifier];
    [self.collectionView registerClass:[GMFormDisabledTextFieldCell class]
            forCellWithReuseIdentifier:GMFormDisabledTextFieldCellIdentifier];

    
    return self;
}

#pragma mark - Getters

- (HYPImagePicker *)imagePicker {
    if (_imagePicker) return _imagePicker;

    _imagePicker = [[HYPImagePicker alloc] initForViewController:self
                                                    usingCaption:@"caption"];
    _imagePicker.delegate = self;

    return _imagePicker;
}

-(NSArray *)fieldsInfo {
    return self.form.fieldsInfo;
}

#pragma mark - View Lifecycle

- (void)viewDidLoad
{
    [super viewDidLoad];
    
//    NSMutableDictionary * parsedData = [NSMutableDictionary new];
//    NSString * stringDate = stringFromCurrentDate(@"yyyy-MM-dd");
//    NSDate * date = dateFromString(stringDate, @"yyyy-MM-dd");
//    [parsedData setObject:date forKey:@"date"];
//    [parsedData setObject:date forKey:@"date_1"];
//    [parsedData setObject:date forKey:@"date_2"];
//    [parsedData setObject:date forKey:@"date_3"];
//    [parsedData setObject:date forKey:@"date_4"];
//    [parsedData setObject:date forKey:@"date_5"];
//    [parsedData setObject:date forKey:@"date_6"];
//    [parsedData setObject:date forKey:@"tech_date"];
//    [parsedData setObject:date forKey:@"auth_date"];
//    [self.dataSource reloadWithDictionary:parsedData];
    
    
   
    self.collectionView.contentInset = UIEdgeInsetsMake(20.0f, 0.0f, 0.0f, 0.0f);

    self.collectionView.backgroundColor = [UIColor colorWithHexString:@"DAE2EA"];

    
    
}
-(void)backAction
{
    UIAlertController * controller = [UIAlertController alertWithTitle:@"" message:@"Are you sure to go to back without submitting this form?" cancelButton:@"Cancel" otherButtons:@[@"Yes"] handler:^(UIAlertAction *action) {
        if (action.style == UIAlertActionStyleDefault) {
            [self.navigationController popViewControllerAnimated:YES];
        }
    }];
    [self.navigationController presentViewController:controller animated:YES completion:nil];

}

-(void)getHistory:(UIBarButtonItem*)bar
{
    // grab the view controller we want to show
    
    UIStoryboard *storyboard = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
    PopViewController *controller = [storyboard instantiateViewControllerWithIdentifier:@"Pop"];
    controller.delegate = self;
    
    // present the controller
    // on iPad, this will be a Popover
    // on iPhone, this will be an action sheet
    
    controller.modalPresentationStyle = UIModalPresentationPopover;
    [self presentViewController:controller animated:YES completion:nil];
    
    // configure the Popover presentation controller
    
    UIPopoverPresentationController *popController = [controller popoverPresentationController];
    popController.permittedArrowDirections = UIPopoverArrowDirectionAny;
    popController.barButtonItem = bar;
    popController.delegate = self;
}

-(void)viewController:(PopViewController *)vc didSelectHistory:(NSMutableDictionary *)obj
{
    self.printValuesButton.enabled = false;
    KappDelegate.stringClass = @"history";
    
    [self showHUD];
    [self POSTHTTP:@"https://saloncloudsplus.com/wsforms/get_form_data" parameters:obj handler:^(NSError *error, id responseObject) {
        [self hideHUD];
        if (responseObject) {
            if ([responseObject[@"status"] boolValue])
            {
                NSArray * data = responseObject[@"data"];
                NSDictionary * dictionary = data.firstObject;
                NSArray * list = dictionary[@"fieldsList"];
                
                NSMutableDictionary * parsedData = [NSMutableDictionary new];
                
                for (NSDictionary * fieldInfo in list) {
                    NSString * _id = fieldInfo[@"form_field_id"];
                    NSString * _value = fieldInfo[@"form_field_value"];
                    NSString * _name = [self fieldNameForId:_id];
                    
                    if (_name)
                    {
                        [parsedData setObject:_value forKey:_name];
                    }
                }
                GMForm * form ;
                [FORMDefaultStyle applyStyle];
                if ([self.form.formName isEqualToString:FNClientIntakeForm])
                {
                    form = [GMFormJsonManager electronicGuestIntakeForm:self.isStylist];
                }
                else if ([self.form.formName isEqualToString:FNSpaRemedeForm])
                {
                    form = [GMFormJsonManager SpaRemedeasePrograms:self.isStylist];
                }
                else if ([self.form.formName isEqualToString:FNMembershipAgreement])
                {
                    form = [GMFormJsonManager membershipAgreement:self.isStylist];
                }
                else if ([self.form.formName isEqualToString:FNClientConsultationForm])
                {
                    form = [GMFormJsonManager clientConsultationForm:self.isStylist];
                }
                FormDisplayCollectionViewController *sampleController = [[FormDisplayCollectionViewController alloc] initWithForm:form];
                sampleController.formValues = parsedData;
                [self.navigationController pushViewController:sampleController animated:YES];
                
            }
            else
            {
            }
        }else if (error) {
            alert(@"", error.localizedDescription);
        }else {
            alert(@"", @"Something went wrong. Please try again later.");
        }
    }];
}

# pragma mark - Popover Presentation Controller Delegate

- (void)popoverPresentationControllerDidDismissPopover:(UIPopoverPresentationController *)popoverPresentationController {
    
    // called when a Popover is dismissed
    NSLog(@"Popover was dismissed with external tap. Have a nice day!");
}

- (BOOL)popoverPresentationControllerShouldDismissPopover:(UIPopoverPresentationController *)popoverPresentationController {
    
    // return YES if the Popover should be dismissed
    // return NO if the Popover should not be dismissed
    return YES;
}

- (void)popoverPresentationController:(UIPopoverPresentationController *)popoverPresentationController willRepositionPopoverToRect:(inout CGRect *)rect inView:(inout UIView *__autoreleasing  _Nonnull *)view {
    
    // called when the Popover changes positon
}


-(NSString *)fieldNameForId:(NSString *)_id {
    for (FormFieldObject * field in self.fieldsInfo)
    {
        if ([field.formSalonFieldId isEqual:_id]) {
            return field.formSalonFieldName;
        }
    }
    return nil;
}

-(BOOL)isStylist {
    return [userDefaults() boolForKey:@"isStylist"];
}

-(void)viewWillAppear:(BOOL)animated
{
    //self.navigationItem.hidesBackButton = YES;
    
    
    
    if (KappDelegate.clientValues[@"Id"])
    {
        if (([self.form.formName isEqualToString:FNClientIntakeForm] || [self.form.formName isEqualToString:FNSpaRemedeForm] || [self.form.formName isEqualToString:FNMembershipAgreement] || [self.form.formName isEqualToString:FNClientConsultationForm])  && !self.formValues)
        {
            KappDelegate.stringClass = @"Form";
            UIBarButtonItem *printValuesButton = [[UIBarButtonItem alloc] initWithTitle:@"Update"
                                                                                  style:UIBarButtonItemStyleDone
                                                                                 target:self
                                                                                 action:@selector(printValuesAction)];
            //self.navigationItem.rightBarButtonItem = printValuesButton;
            
            UIBarButtonItem *backButton = [[UIBarButtonItem alloc] initWithTitle:@"Back"
                                                                           style:UIBarButtonItemStyleDone
                                                                          target:self
                                                                          action:@selector(backAction)];
            
            UIBarButtonItem *historyButton = [[UIBarButtonItem alloc] initWithTitle:@"History"
                                                                              style:UIBarButtonItemStyleDone
                                                                             target:self
                                                                             action:@selector(getHistory:)];
            self.navigationItem.leftBarButtonItems = @[backButton];
            if ([KappDelegate.stringClass isEqualToString:@"Form"]) {
                if ([KappDelegate.stringFormid isEqualToString:@"169"])
                {
                    [self getClientDetails:KappDelegate.clientValues[@"client_name"]];
                }
                else
                {
                    [self getFormInformation];
                }
            }
        }
        else if (self.formValues)
        {
            parsedDefaultData = self.formValues;
            [self.dataSource reloadWithDictionary:self.formValues];
            [self.collectionView reloadData];
        }
    }
    else
    {
        printValuesButton = [[UIBarButtonItem alloc] initWithTitle:@"Back"
                                                             style:UIBarButtonItemStyleDone
                                                            target:self
                                                            action:@selector(backAction)];
        self.navigationItem.leftBarButtonItem = printValuesButton;
        printValuesButton = [[UIBarButtonItem alloc] initWithTitle:@"Submit"
                                                             style:UIBarButtonItemStyleDone
                                                            target:self
                                                            action:@selector(printValuesAction)];
        self.navigationItem.rightBarButtonItem = printValuesButton;
        
    }
    
 
    
    if ([self.form.formName isEqualToString:FNMembershipAgreement]||[self.form.formName isEqualToString:FNSpaRemedeForm]||[self.form.formName isEqualToString:FNClientConsultationForm]) {
        NSMutableDictionary * parsedData = [NSMutableDictionary new];
        NSUserDefaults * users = [NSUserDefaults standardUserDefaults];
        
        [parsedData setObject:[users valueForKey:@"Name"] forKey:@"Name"];
        [parsedData setObject:[users valueForKey:Address] forKey:Address];
        [parsedData setObject:[users valueForKey:City] forKey:City];
        [parsedData setObject:[users valueForKey:State] forKey:State];
        [parsedData setObject:[users valueForKey:Zip] forKey:Zip];
        [parsedData setObject:[users valueForKey:Cell_Phone] forKey:Cell_Phone];
        [parsedData setObject:[users valueForKey:Email_address] forKey:@"Email address"];
        NSDate * date2 = dateFromString([users valueForKey:Date_of_Birth], @"yyyy-MM-dd");
        [parsedData setObject:date2 forKey:@"Date of Birth"];
        
        [self.dataSource reloadWithDictionary:parsedData];
    }
    [self setUpDataSource];

}


-(void)getClientDetails:(NSString *)name
{
    NSString * url = [NSString stringWithFormat:WS_GetClientDetails];
    NSRange rangeOfSpace = [name rangeOfString:@" "];
    NSString *first = rangeOfSpace.location == NSNotFound ? name : [name substringToIndex:rangeOfSpace.location];
   
    
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
                    NSDictionary * clientProfileData = data[@"clientProfileData"];
                    if (data[@"Id"])
                    {
                        NSMutableDictionary * parsedData = [NSMutableDictionary new];
                        [parsedData setObject:[NSString stringWithFormat:@"%@%@",clientProfileData[@"CellAreaCode"],clientProfileData[@"CellPhoneNumber"]] forKey:@"Cell Phone"];
                        [parsedData setObject:clientProfileData[@"FirstName"] forKey:@"Guest First Name"];
                        [parsedData setObject:clientProfileData[@"LastName"] forKey:@"Guest Last Name "];
                        [parsedData setObject:clientProfileData[@"Address1"] forKey:@"Address"];
                        [parsedData setObject:clientProfileData[@"City"] forKey:@"City"];
                        [parsedData setObject:clientProfileData[@"State"] forKey:@"State"];
                        [parsedData setObject:clientProfileData[@"ZipCode"] forKey:@"Zip"];
                        [parsedData setObject:clientProfileData[@"EmailAddress"] forKey:@"Email"];
                        NSDate * date2 = dateFromString(clientProfileData[@"Birthday"], @"yyyy-MM-dd");
                        [parsedData setObject:date2 forKey:@"Birth Date"];
                        [self.dataSource reloadWithDictionary:parsedData];
                        [self.collectionView reloadData];
                        [self getFormInformation];

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

-(void)getFormInformation
{
    NSMutableDictionary * parameters = [NSMutableDictionary new];
    [parameters setObject:[self salonId] forKey:@"salon_id"];
    [parameters setObject:[self moduleId] forKey:@"module_id"];
    [parameters setObject:KappDelegate.clientValues[@"Id"] forKey:@"client_id"];
    [parameters setObject:KappDelegate.stringFormid forKey:@"form_id"];
    
    [self showHUD];
    
    [self POSTHTTP:WS_get_last_submitted_form_data parameters:parameters handler:^(NSError *error, id responseObject) {
        [self hideHUD];
        if (responseObject) {
            if ([responseObject[@"status"] boolValue])
            {
                NSArray * data = responseObject[@"data"];
                NSDictionary * dictionary = data.firstObject;
                NSArray * list = dictionary[@"fieldsList"];
                
                NSMutableDictionary * parsedData = [NSMutableDictionary new];
                
                for (NSDictionary * fieldInfo in list) {
                    NSString * _id = fieldInfo[@"form_field_id"];
                    NSString * _value = fieldInfo[@"form_field_value"];
                    NSString * _name = [self fieldNameForId:_id];
                    
                    if (_name)
                    {
                        
        
                        if ([_name isEqualToString:@"date"]||[_name isEqualToString:@"date_1"]||[_name isEqualToString:@"tech_date"]||[_name isEqualToString:@"auth_date"]||[_name isEqualToString:@"date_2"]||[_name isEqualToString:@"date_3"]||[_name isEqualToString:@"date_4"]||[_name isEqualToString:@"date_5"]||[_name isEqualToString:@"date_6"]||[_name isEqualToString:@"Birth Date"]||[_name isEqualToString:@"auth_date"]||[_name isEqualToString:@"Account Opening Date"]||[_name isEqualToString:@"Auto-Deposit Date"]||[_name isEqualToString:@"Date"]||[_name isEqualToString:@"Date1"]||[_name isEqualToString:@"Date2"]||[_name isEqualToString:@"Date3"]||[_name isEqualToString:@"Program Start Date"]||[_name isEqualToString:@"1st Payment Date"]||[_name isEqualToString:@"2nd Payment Date"]||[_name isEqualToString:@"3rd Payment Date"]||[_name isEqualToString:@"Date of Birth"]||[_name isEqualToString:@"date2"]||[_name isEqualToString:@"Date4"]||[_name isEqualToString:@"date1"])
                        {
                            NSDate * date = dateFromString(_value, @"yyyy-MM-dd");
                            (date)?[parsedData setObject:date forKey:_name]:[parsedData setObject:@"" forKey:_name];
                        }
                        else if([_name isEqualToString:@"Signature"]){
                            
                        }
                        else
                        {
                            [parsedData setObject:_value forKey:_name];

                        }
                    }
                }
                
                dispatch_async(dispatch_get_main_queue(), ^{
                    parsedDefaultData = parsedData;
                   [self.dataSource reloadWithDictionary:parsedData];
                    [self.collectionView reloadData];
                });
                printValuesButton = [[UIBarButtonItem alloc] initWithTitle:@"Update"
                                                                     style:UIBarButtonItemStyleDone
                                                                    target:self
                                                                    action:@selector(printValuesAction)];
                self.navigationItem.rightBarButtonItem = printValuesButton;

            }else
            {
                printValuesButton = [[UIBarButtonItem alloc] initWithTitle:@"Submit"
                                                                     style:UIBarButtonItemStyleDone
                                                                    target:self
                                                                    action:@selector(printValuesAction)];
                self.navigationItem.rightBarButtonItem = printValuesButton;

                
                //alert(@"", responseObject[@"message"]);
            }
        }else if (error) {
            alert(@"", error.localizedDescription);
        }else {
            alert(@"", @"Something went wrong. Please try again later.");
        }
    }];
}

-(void)setUpDataSource {
    BOOL isHistory = ([KappDelegate.stringClass isEqualToString:@"history"]);

    self.dataSource.configureCellForItemAtIndexPathBlock = ^(FORMField *field, UICollectionView *collectionView, NSIndexPath *indexPath) {
        id cell;
        
        if (field.type == FORMFieldTypeCustom) {

            NSDictionary * mappedDic = @{@"image":HYPImageFormFieldCellIdentifier,
                                         @"checkbox":GMCheckBoxFormFieldCellIdentifier,
                                         @"radiobutton":GMRadioButtonFormFieldCellIdentifier,
                                         @"signature":GMSignatureViewFieldCellIdentifier,
                                         @"textwithlongtitle":(isHistory)?GMFormDisabledTextFieldCellIdentifier:GMFormTextFieldCellIdentifier,
                                         @"label":GMFormLabelCellIdentifier,
                                         @"rating":GMRatingViewFieldCellIdentifier};
            
            cell = [collectionView dequeueReusableCellWithReuseIdentifier:mappedDic[field.typeString]
                                                             forIndexPath:indexPath];
            if ([cell respondsToSelector:NSSelectorFromString(@"field")]) {
                if (parsedDefaultData) {
                    if ([parsedDefaultData objectForKey:field.fieldID]) {
                        if (!field.value) {
                            field.value = parsedDefaultData[field.fieldID];
                        }
                    }
                }
                [cell setValue:field forKey:@"field"];
            }
            
            if ([cell respondsToSelector:NSSelectorFromString(@"viewController")]) {
                [cell setValue:self forKey:@"viewController"];
            }
            
            if ([cell respondsToSelector:NSSelectorFromString(@"delegate")]) {
                [cell setValue:self.dataSource forKey:@"delegate"];
            }
            
            
        }
        if([field.title isEqualToString:@"Date of Birth:"] || [field.title isEqualToString:@"Birth Date:"])
        {
            NSCalendar *gregorian = [[NSCalendar alloc] initWithCalendarIdentifier:NSGregorianCalendar];
            
            NSDate *currentDate = [NSDate date];
            NSDateComponents *comps = [[NSDateComponents alloc] init];
            [comps setYear:-18];
            NSDate *minDate = [gregorian dateByAddingComponents:comps toDate:currentDate  options:0];
            
            field.maximumDate = minDate;
            
            
            NSDateComponents *comps2 = [[NSDateComponents alloc] init];
            [comps2 setYear:-100];
            NSDate *minDate2 = [gregorian dateByAddingComponents:comps2 toDate:currentDate  options:0];
            
            field.minimumDate = minDate2;
        }
        if (isHistory) {
            field.disabled = YES;
        }
        else
        {
            field.disabled = NO;
        }
        return cell;
    };
}

- (void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];

}

#pragma mark - UICollectionViewDelegate

- (BOOL)collectionView:(UICollectionView *)collectionView shouldSelectItemAtIndexPath:(NSIndexPath *)indexPath {
    FORMField *field = [self.dataSource fieldAtIndexPath:indexPath];
    return (field.type == FORMFieldTypeCustom && [field.typeString isEqual:@"image"]);
}

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath {
    FORMField *field = [self.dataSource fieldAtIndexPath:indexPath];

    if (field.type == FORMFieldTypeCustom && [field.typeString isEqual:@"image"]) {
        [self.imagePicker invokeCamera];
    }
}

#pragma mark - HYPImagePickerDelegate

- (void)imagePicker:(HYPImagePicker *)imagePicker
     didPickedImage:(UIImage *)image {
    NSLog(@"picture gotten");
}

#pragma mark - Actions

- (void)validateButtonAction
{
    if ([self.dataSource isValid])
    {
        UIAlertController *controller = [UIAlertController alertControllerWithTitle:@"Everything is valid, you get a candy!" message:nil preferredStyle:UIAlertControllerStyleAlert];
        [controller addAction:[UIAlertAction actionWithTitle:@"No, thanks" style:UIAlertActionStyleCancel handler:nil]];
        [self presentViewController:controller animated:YES completion:nil];
    }
    else
    {
        [self.dataSource validate];
    }
}

-(BOOL)isEmpty : (NSString*)stringKey dictionary: (NSDictionary *)dictionary
{
    return (![dictionary valueForKey:stringKey] || [[dictionary valueForKey:stringKey] isEqual:[NSNull null]] || [[dictionary valueForKey:stringKey] isEqual:@""]);
}


- (void)printValuesAction
{
    NSDictionary *dictionary = self.dataSource.values;

    NSString *trimmedStringfirst = [[dictionary objectForKey:@"Guest First Name"] stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceCharacterSet]];
     NSString *trimmedStringlast = [[dictionary objectForKey:@"Guest Last Name "] stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceCharacterSet]];
    
    
//    if(([self.form.name isEqualToString:@"Spa Remedease Programs"])&&([[dictionary objectForKey:@"Home Phone"] length]>0 && [[dictionary objectForKey:@"Home Phone"] length]<9)){
//        alert(@"Alert", @"Please enter your valid Home Phone Number");
//        return;
//    }
//    else if(([self.form.name isEqualToString:@"Spa Remedease Programs"])&&([[dictionary objectForKey:@"Mobile"] length] == 0)){
//        alert(@"Alert", @"Please enter your  Mobile Number");
//        return;
//    }
//
//    else if(([self.form.name isEqualToString:@"Spa Remedease Programs"])&&([[dictionary objectForKey:@"Mobile"] length]>0 && [[dictionary objectForKey:@"Mobile"] length]<9)){
//        alert(@"Alert", @"Please enter your valid Mobile Number");
//        return;
//    }
    
    if ([self.form.name isEqualToString:@"Eyelash Extensions Guest Consultation & Consent Form"]) {
        
        
        if ([[dictionary objectForKey:@"NAME"] isEqualToString:@""] || [self isEmpty:@"NAME" dictionary:dictionary]) {
            alert(@"Alert", @"Please enter your name");
            return;
        }
        
        if (([[dictionary objectForKey:@"CONTACT NUMBER"] length]>0 && [[dictionary objectForKey:@"CONTACT NUMBER"] length]<9) || [self isEmpty:@"CONTACT NUMBER" dictionary:dictionary]) {
            alert(@"Alert", @"Please enter your Cell Phone");
            return;
        }
        
        if ([[dictionary objectForKey:@"EMAIL"] isEqualToString:@""] || [self isEmpty:@"EMAIL" dictionary:dictionary]) {
            alert(@"Alert", @"Please enter your email id");
            return;
        }
        
        if ([[dictionary valueForKey:@"Have you had any tattooing recently to eyes or eye"] isEqualToString:@"Yes"])
        {
            if ([self isEmpty:@" If so when?" dictionary:dictionary])
            {
                alert(@"Alert", @"Please fill any tattooing recently to eyes or eyebrows");
                return;
            }
        }
        
        if ([[dictionary valueForKey:@"Are you pregnant or is there a chance you could be"] isEqualToString:@"Yes"])
        {
            if ([self isEmpty:@"If yes, how many weeks?" dictionary:dictionary])
            {
                alert(@"Alert", @"Please fill the pregnacy week");
                return;
            }
        }
        
        if(![[dictionary objectForKey:@"Guest Signature"] isKindOfClass:[UIImage class]]){
            alert(@"Alert", @"Please enter your signature");
            return;
        }
        
        
    }
    else {
    
    if(([self.form.name isEqualToString:@"Membership Agreement"]|| [self.form.name isEqualToString:@"Spa Remedease Programs"])&&([[dictionary objectForKey:@"Cell Phone"] length] == 0)){
        alert(@"Alert", @"Please enter your Cell Phone");
        return;
    }
    
    else if(([self.form.name isEqualToString:@"Membership Agreement"]|| [self.form.name isEqualToString:@"Spa Remedease Programs"])&&([[dictionary objectForKey:@"Cell Phone"] length]>0 && [[dictionary objectForKey:@"Cell Phone"] length]<9)){
        alert(@"Alert", @"Please enter your valid Cell Phone");
        return;
    }
    
    else if(([self.form.name isEqualToString:@"Membership Agreement"]|| [self.form.name isEqualToString:@"Spa Remedease Programs"])&&([[dictionary objectForKey:@"Emergency Contact"] length] == 0)){
        alert(@"Alert", @"Please enter your emergency contact's Name");
        return;
    }
    else if(([self.form.name isEqualToString:@"Membership Agreement"]|| [self.form.name isEqualToString:@"Spa Remedease Programs"])&&([[dictionary objectForKey:@"Phone"] length]>0 && [[dictionary objectForKey:@"Phone"] length]<9)){
        alert(@"Alert", @"Please enter your valid  Phone Number");
        return;
    }
    
   else if(([self.form.name isEqualToString:@"Electronic Guest Intake"])&&([[dictionary objectForKey:@"Cell Phone"] length]>0 && [[dictionary objectForKey:@"Cell Phone"] length]<9)){
        alert(@"Alert", @"Please enter your valid Cell Phone Number");
        return;
    }

  else if(![[dictionary objectForKey:@"Signature"] isKindOfClass:[UIImage class]]){
        alert(@"Alert", @"Please enter your signature");
        return;
    }
  else if(([self.form.name isEqualToString:@"Electronic Guest Intake"])&&([self isEmpty:@"Gender" dictionary:dictionary] )){
      alert(@"Alert", @"Please select gender");
      return;
  }
    
  else if ([trimmedStringfirst isEqualToString:@""]) {
        alert(@"Alert", @"Please enter first name");
        return;
    }
  else if ([trimmedStringlast isEqualToString:@""]) {
      alert(@"Alert", @"Please enter last name");
      return;
  }
    
    if ([[dictionary valueForKey:@"do_you_have_any_additional_health"] isEqualToString:@"Yes"])
    {
        if ([self isEmpty:@"If Yes, Please Describe" dictionary:dictionary])
        {
            alert(@"Alert", @"Please fill any additional health and beauty concerns");
            return;
        }
    }

    
    if ([[dictionary valueForKey:@"Any present injury or recent surgeries"] isEqualToString:@"Yes"])
    {
        if ([self isEmpty:@"If Yes, what type of injury/surgery?" dictionary:dictionary])
        {
            alert(@"Alert", @"Please fill any present injury");
            return;
        }
    }


    if ([[dictionary valueForKey:@"Are you currently Pregnant"] isEqualToString:@"Yes"])
    {
        if ([self isEmpty:@"If Yes,How many weeks ? " dictionary:dictionary])
        {
            alert(@"Alert", @"Please fill How many weeks?");
            return;
        }
    }
    }
    
    if ([self.dataSource isValid])
    {
        if ([self.form.formName isEqualToString:FNClientIntakeForm])
        {
            [self addNewClientData:@"1"];
        }
        else
        {
            [self submitFormWith:self.dataSource.values];

        }
        NSLog(@"%@",[self.dataSource.values description]);
    }
    else
    {
        [self.dataSource validate];
    }
}

-(void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex{
    if(alertView.tag == 100)
    {
        if(buttonIndex == 1){
                       [self showHUD];
           
            [self addNewClientData:@"0"];
        }
    }
}

-(void)addNewClientData:(NSString*)isEmailCheckStr
{
    NSDictionary * dictionary = self.dataSource.values;
    NSUserDefaults * users = [NSUserDefaults standardUserDefaults];
    

    NSString * email = dictionary[@"Email"];
    NSDate * date = dictionary[@"Birth Date"];
    NSString * dateString = stringFromDate(date, @"yyyy-MM-dd");
    NSString * phone = dictionary[@"Cell Phone"];
    NSString * first_name = [NSString stringWithFormat:@"%@",dictionary[@"Guest First Name"]];
    NSString * last_name = [NSString stringWithFormat:@"%@",dictionary[@"Guest Last Name "]];

    
    
    NSString * address = dictionary[@"Address"];
    NSString * city_state = dictionary[@"City"];
    NSString * zipcode = dictionary[@"Zip"];
    
    NSMutableDictionary *param = [NSMutableDictionary new];
    [param setObject:[self salonId] forKey:@"salon_id"];
    [param setObject:first_name?:@"" forKey:@"FirstName"];
    [param setObject:last_name?:@"" forKey:@"LastName"];
    [param setObject:dateString?:@"" forKey:@"Birthday"];
    [param setObject:address?:@"" forKey:@"Address"];
    [param setObject:city_state?:@"" forKey:@"City"];
    
    if (KappDelegate.clientValues[@"Id"])
    {
        [param setObject:first_name?:@"" forKey:@"FirstName"];
        [param setObject:last_name?:@"" forKey:@"LastName"];
        
        
    }
    else
    {
        [param setObject:first_name?:@"" forKey:@"fname"];
        [param setObject:last_name?:@"" forKey:@"lname"];
        
    }
    [param setObject:isEmailCheckStr?isEmailCheckStr:@"" forKey:@"isEmailCheck"];
    
    if ((KappDelegate.clientValues[@"Id"]))
    {
        [param setObject:KappDelegate.clientValues[@"Id"] forKey:@"Id"];
        [param setObject:[dictionary objectForKey:@"State"]?:@"" forKey:@"State"];
        
         }
    else
    {
        [param setObject:[dictionary objectForKey:@"State"]?:@"" forKey:@"St"];
    }
    [param setObject:zipcode forKey:@"ZipCode"];
    
    if (phone) {
        NSString *strCell = phone;
        if (strCell.length != 10) {
            alert(@"", @"Phone number should be of 10 digits");
            
            return;
        }
        NSString *stringCellAreaCode = [strCell substringWithRange:NSMakeRange(0, 3)];
        [param setObject:stringCellAreaCode forKey:@"CellAreaCode"];
        
        NSString *stringCellPhoneN = [strCell substringWithRange:NSMakeRange(3, 7)];
        [param setObject:stringCellPhoneN forKey:@"CellPhoneNumber"];
    }

    //[param setObject:phone forKey:@"CellPhoneNumber"];
    [param setObject:email forKey:@"EmailAddress"];
   
    
     //[self submitFormWith:self.dataSource.values];
        NSString * url;
    url = (KappDelegate.clientValues[@"Id"])?WS_UpdateDetails:WS_AddNewDetails;
    
    [self showHUD];
    [self POSTHTTP:url parameters:param handler:^(NSError *error, id responseObject) {
        
        [self hideHUD];
        if (responseObject) {
            if ([responseObject[@"status"] boolValue])
            {
                NSDictionary * data = responseObject[@"data"];
                
                KappDelegate.clientValues = @{@"client_name":[NSString stringWithFormat:@"%@ %@",first_name,last_name],
                                              @"emailName":email,
                                              @"Id":data[@"clientId"]
                                              };
                [users setValue:[NSString stringWithFormat:@"%@ %@",dictionary[F_Name],dictionary[L_Name]]forKey:@"Name"];
                [users setValue:dictionary[Address] forKey:Address];
                [users setValue:dictionary[City] forKey:City];
                [users setValue:dictionary[State] forKey:State];
                [users setValue:dictionary[Zip] forKey:Zip];
                [users setValue:dictionary[Cell_Phone] forKey:Cell_Phone];
                [users setValue:dictionary[Email_address] forKey:Email_address];
                [users setValue:dateString forKey:Date_of_Birth];

                [self submitFormWith:self.dataSource.values];

            }else {
                
                
                if([responseObject[@"key"] intValue] == 1)
                {
                    NSString *message;
                    if ((KappDelegate.clientValues[@"Id"]))
                    {
                        message = [NSString stringWithFormat:@"%@",[responseObject objectForKey:@"message"]];
                    }
                    
                    else {
                        message = [NSString stringWithFormat:@"%@ Or Would you like to continue as a new client ( Note: Please try with a different name ).",[responseObject objectForKey:@"message"]];
                    }
                    
                    UIAlertView * alert = [[UIAlertView alloc] initWithTitle:[NSString stringWithFormat:@"Hi %@",[responseObject objectForKey:@"clientName"]] message:message delegate:nil cancelButtonTitle:@"Cancel" otherButtonTitles:@"Yes",nil];
                    alert.tag = 100;
                    alert.delegate =self;
                    [alert show];
                    
                    
/*                    Jagan Mohan M [12:20 PM]
                    in putClientDetailsUpdate_clone
                    we r sending for email checking response message "There is an existing client with the same email address. Please enter a different email!"
                        both name and email checking "There is an existing client with the same name and email address. Please enter a different name or email!"
                        but u r showing "There is an existing client with the same email address. Please enter a different email! (or ) login as new client"
                        please remove after (or)
                        please show the messege what we are sending
                        
                        Balkaran [12:25 PM]
                        ok ok got it
                        
                        Jagan Mohan M [12:26 PM]
                        okay
                        
                        Balkaran [12:26 PM]
                        Thanks
                        
                        Jagan Mohan M [12:29 PM]
                        you are welcome
                        
                        Balkaran [12:32 PM]
                        clientName = "Test Email Check Dfafd";
                    data =     (
                    );
                    key = 1;
                    message = "Your email already exists, please contact front desk!";
                    status = 0;
                    I am getting response from web service
                    
                    Jagan Mohan M [12:34 PM]
                    can you send me the web service
                    
                    Balkaran [12:36 PM]
                https://saloncloudsplus.com/wsIntakeForms_new/putClientDetailsAdd
                    This is add client ws. (edited)
                    
                    Jagan Mohan M [12:36 PM]
                    check in update client
                    putClientDetailsUpdate_clone
                    we r updated the messages in update clients
                    
                    Balkaran [12:39 PM]
                    ok got it
                    But   what message show in add client ws ?
                    
                    Jagan Mohan M [12:40 PM]
                    update only for  putClientDetailsUpdate_clone
                        
                        Balkaran [12:40 PM]
                        ok
                        
                        Jagan Mohan M [12:40 PM]
                        can you send me the response for putClientDetailsUpdate_clone
                            
                            Balkaran [12:41 PM]
                        {
                            clientName = "Test Email Check Dfafd";
                            data =     (
                            );
                            key = 1;
                            message = "There is an existing client with the same email address. Please enter a different email!";
                            status = 0;
                        }
                    
                    Jagan Mohan M [12:42 PM]
                    please update popup with  message = "There is an existing client with the same email address. Please enter a different email!";
                    not concatenating with other text
                    
                    Balkaran [12:42 PM]
                    ok
                    
                    Jagan Mohan M [12:43 PM]
                    show messeges what we r sending in update clients
                    
                    Balkaran [12:43 PM]
                    ok
                    
                    Jagan Mohan M [12:50 PM]
                    uploaded this image: Image-1.jpg
                    
                    
                    Jagan Mohan M [12:52 PM]
                    remove or would like to as a new client
                    
                    Balkaran [12:52 PM]
                    ok
                    and no need to yes option right ? (edited)
                    
                    Jagan Mohan M [12:53 PM]
                    we need
                    only change message
                    
                    Balkaran [12:55 PM]
                    ok
                    Fixed it
                    Thanks*/
                }
                else{
                    
                    alert(@"", responseObject[@"message"]);
                }

            }
        }else if (error){
            alert(@"", error.localizedDescription);
        }else {
            alert(@"", @"Something went wrong. Please try again later.");
        }
    }];
}

#pragma mark

-(void)submitFormWith:(NSDictionary *)values {
    
    NSMutableArray * dic = [NSMutableArray new];
    NSMutableArray * imageFields = [NSMutableArray new];

    for (FormFieldObject * field in self.fieldsInfo)
    {
        id value = values[field.formSalonFieldName];
        
        if ([value isKindOfClass:[UIImage class]])
        {
            [imageFields addObject:field.formSalonFieldName];
        }else
        {
            [dic addObject:[field parseWith:values]];
        }
    }
    
    //--
    
    NSMutableArray * imageObjects = [NSMutableArray new];
    

    for (NSString * name in imageFields)
    {
        AWSImageObject * obj1 = [AWSImageObject withImage:values[name] identifier:name];
        [imageObjects addObject:obj1];
    }
    
    AWSManager * manager = [AWSManager sharedManager];
    [manager setProgressBlock:^void(NSInteger uploaded, NSInteger failed, NSInteger total)
     {
        NSLog(@"%ld/%ld",(long)uploaded,(long)total);
    }];
    [manager setFinishBlock:^(NSArray * completed, NSArray *failed)
    {
        
        dispatch_async(dispatch_get_main_queue(), ^{
            
            [self hideHUD];
            NSMutableArray * parameters = [dic mutableCopy];
            
            for (AWSImageObject * obj in completed)
            {
                for (FormFieldObject * info in self.fieldsInfo)
                {
                    if ([info.formSalonFieldName isEqualToString:obj.identifier])
                    {
                        [parameters addObject:[NSDictionary dicWithFieldId:info.formSalonFieldId fieldName:obj.imageUrl]];
                    }
                }
            }
            
            [self saveFormValues:parameters];
        });
    }];
    [self showHUD];
    [manager uploadImages:imageObjects];
}

-(void)saveFormValues:(nonnull NSArray *)formData {
    
    NSMutableDictionary * jsonDataDic = [NSMutableDictionary new];
    NSString * stringClientId = [kApppDelegate.clientValues valueForKey:@"Id"];
    [jsonDataDic setObject:stringClientId?:@"" forKey:@"client_id"];
    [jsonDataDic setObject:formData forKey:@"fieldsList"];
    [jsonDataDic setObject:[self form_id] forKey:@"form_id"];
    [jsonDataDic setObject:[self moduleId] forKey:@"module_id"];
    [jsonDataDic setObject:[self salonId] forKey:@"salon_id"];
    [self showHUD];
    
    [self POST:WS_save_form_fields_data jsonDictionary:jsonDataDic success:^(id responseObject) {
        [self hideHUD];
        if (responseObject) {
            if ([responseObject[@"status"] boolValue])
            {
                if ([printValuesButton.title isEqualToString:@"Update"])
                {
                    alert(@"", @"Your form have been successfully updated");
                }
                else
                {
                    alert(@"", @"Your form have been successfully submitted");
                }
                [self.navigationController popViewControllerAnimated:YES];
            }else {
                alert(@"", responseObject[@"message"]);
            }
        }else {
            alert(@"", @"Something went wrong. Please try again later.");
        }
    } failure:^(NSError *error){
        alert(@"", error.localizedDescription);
        [self hideHUD];
    }];
//    [self POSTHTTP:WS_save_form_fields_data parameters:jsonDataDic handler:^(NSError *error, NSDictionary *responseObject) {
//        [self hideHUD];
//        
//        if (error) {
//            alert(@"", error.localizedDescription);
//        }else {
//            alert(@"", @"Something went wrong. Please try again later.");
//            [self hideHUD];
//            if (responseObject) {
//                if ([responseObject[@"status"] boolValue])
//                {
//                    if ([printValuesButton.title isEqualToString:@"Update"])
//                    {
//                        alert(@"", @"Your form have been successfully updated");
//                    }
//                    else
//                    {
//                        alert(@"", @"Your form have been successfully submitted");
//                    }
//                    [self.navigationController popViewControllerAnimated:YES];
//                }else {
//                    alert(@"", responseObject[@"message"]);
//                }
//            }else {
//                alert(@"", @"Something went wrong. Please try again later.");
//            }
//        }
//    }];
}

//--
-(NSString *)form_id {
    return self.form.formId;
}
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
