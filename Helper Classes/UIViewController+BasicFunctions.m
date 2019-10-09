//
//  UIViewController+BasicFunctions.m
//
//  Created by Gurpreet Singh on 08/04/15.
//  Copyright (c) 2015 Gurpreet Singh. All rights reserved.
//

#import "UIViewController+BasicFunctions.h"
#import "UIAlertController+Helper.h"
#import <Social/Social.h>
#import <AVFoundation/AVFoundation.h>
#import <AssetsLibrary/AssetsLibrary.h>
//#import "HDNotificationView.h"
#import "AppDelegate.h"

#define kShareText @""

#define kAppUrl @""

#define kFacebookShareText @""

@implementation UIViewController (BasicFunctions)

//-(User *)user {
//    
//    if (!KappDelegate.user && [self userDetails]) {
//        KappDelegate.user = [User modelObjectWithDictionary:[self userDetails]];
//    }
//    return KappDelegate.user;
//}

+ (UIStoryboard *)storyboard:(NSString *)name
{
    return [UIStoryboard storyboardWithName:name bundle:[NSBundle mainBundle]];
}

-(void)addBackground
{
    self.view.backgroundColor = [UIColor whiteColor];
}

-(UIBarButtonItem*)addCartButton
{
    UIBarButtonItem *negativeSpacer = [[UIBarButtonItem alloc]
                                       initWithBarButtonSystemItem:UIBarButtonSystemItemFixedSpace
                                       target:nil action:nil];
    negativeSpacer.width = -5;// it was -6 in iOS 6
    
    UIButton * button = [UIButton buttonWithType:UIButtonTypeCustom];
    [button setImage:[UIImage imageNamed:@"cart"] forState:UIControlStateNormal];
    [button setFrame:CGRectMake(0, 0, 25, 25)];
    [button addTarget:self action:@selector(cartAction:) forControlEvents:UIControlEventTouchUpInside];
    
    UIBarButtonItem * item = [[UIBarButtonItem alloc] initWithCustomView:button];
    self.navigationItem.rightBarButtonItems = @[negativeSpacer,item];
    
    return item;
}
-(void)cartAction:(id)sender
{
    [self pushViewControllerWithIdentifier:@"cartVC"];
}
-(void)configureTextField:(UIView*)field
{
    field.layer.cornerRadius = 5.0;
    field.layer.borderWidth  = 0.5;
    field.layer.borderColor  = [UIColor whiteColor].CGColor;
    field.backgroundColor = [UIColor clearColor];
    
    if ([field isKindOfClass:[UITextField class]]) {
        UITextField * tf = (UITextField *)field;
        tf.leftViewMode  = UITextFieldViewModeAlways;
        tf.leftView      = [self leftViewWithIcon:@"" width:10];
    }
}

-(void)setBackgroundImage:(NSString*)image
{
    self.view.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:[self deviceSpecificName:image]]];
}

-(NSString*)deviceSpecificName:(NSString*)name
{
    NSString * postFix = @"4";
    
    if (IS_IPHONE_5) {
        postFix = @"5";
    }
    if (IS_IPHONE_6) {
        postFix = @"6";
    }
    if (IS_IPHONE_6PLUS) {
        postFix = @"6p";
    }
    
    return appentString(name, postFix);
}

-(void)showLoginAlert
{
    UIAlertController * controller = [UIAlertController alertWithTitle:@"" message:@"Please Sign In or Sign Up to book your appointment" cancelButton:@"Cancel" otherButtons:@[@"Sign In/Sign Up"] handler:^(UIAlertAction *action) {
        if (action.style != UIAlertActionStyleCancel) {
            [self removeBackButtonText];
            [self pushViewControllerWithIdentifier:@"loginRegisterVc"];
        }
    }];
    [self.navigationController presentViewController:controller animated:YES completion:nil];
}
-(void)removeBackButtonText
{
    self.navigationItem.backBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"" style:UIBarButtonItemStylePlain target:nil action:nil];
}

-(void)setBackButtonText:(NSString *)text
{
    self.navigationItem.backBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:text style:UIBarButtonItemStylePlain target:nil action:nil];
}

-(void)pushViewControllerWithIdentifier:(NSString*)identifier values:(NSDictionary*)values
{
    [self removeBackButtonText];
    
    UIViewController * vc = [self.storyboard instantiateViewControllerWithIdentifier:identifier];
    
    if (values)
    {
        for (NSString * key in values) {
            [vc setValue:values[key] forKeyPath:key];
        }
    }
    
    [self.navigationController pushViewController:vc animated:YES];
}

-(void)pushViewControllerWithIdentifier:(NSString*)identifier
{
    [self pushViewControllerWithIdentifier:identifier values:nil];
}

-(id)pushViewControllerWithIdentifier:(NSString*)identifier CustomBackButton:(id)btn
{
    [self removeBackButtonText];
    
    UIViewController * vc = [self.storyboard instantiateViewControllerWithIdentifier:identifier];
    vc.navigationItem.leftBarButtonItem = btn;
    [self.navigationController pushViewController:vc animated:NO];
    
    return vc;
}

-(id)pushViewController:(UIViewController *)vc CustomBackButton:(id)btn
{
    [self removeBackButtonText];
    
    vc.navigationItem.leftBarButtonItem = btn;
    [self.navigationController pushViewController:vc animated:NO];
    
    return vc;
}


-(void)pushViewControllerWithIdentifier:(NSString*)identifier values:(NSDictionary*)values CustomBackButton:(id)btn
{
    [self removeBackButtonText];
    
    UIViewController * vc = [self.storyboard instantiateViewControllerWithIdentifier:identifier];
    
    if (values)
    {
        for (NSString * key in values) {
            [vc setValue:values[key] forKeyPath:key];
        }
    }
    
    vc.navigationItem.leftBarButtonItem = btn;
    [self.navigationController pushViewController:vc animated:NO];
}

-(void)presentViewControllerWithIdentifier:(NSString*)identifier
{
    [self presentViewControllerWithIdentifier:identifier animation:YES];
}

-(void)presentViewControllerWithIdentifier:(NSString*)identifier animation:(BOOL)_animation
{
    UIViewController * viewController = [self.storyboard instantiateViewControllerWithIdentifier:identifier];
    [self.navigationController presentViewController:viewController animated:_animation completion:nil];
}

-(UIView*)leftViewWithIcon:(NSString*)imageName
{
    return  [self leftViewWithIcon:imageName width:30];
}
-(UIView*)leftViewWithIcon:(NSString*)imageName width:(NSInteger)w
{
    UIImageView * imageView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:imageName]];
    imageView.contentMode = UIViewContentModeCenter;
    imageView.frame = CGRectMake(0, 0, w, 30);
    return imageView;
}

-(void)addShareButton
{
    UIBarButtonItem *navLeftButton = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemAction target:self action:@selector(showShareAlert:)];
    
    self.navigationItem.rightBarButtonItem = navLeftButton;
}
-(void)activityViewAppear
{
    //-- when activity controller to share appear
    
}
-(void)activityViewDisappear
{
    //-- when activity controller to share dis appear
}

-(void)showShareAlert:(id)sender
{
    NSString *string = kFacebookShareText;
    NSURL *URL = [NSURL URLWithString:kAppUrl];
    
    UIActivityViewController *activityViewController =
    [[UIActivityViewController alloc] initWithActivityItems:@[string, URL]
                                      applicationActivities:nil];
    activityViewController.completionWithItemsHandler = ^(NSString *activityType, BOOL completed, NSArray *returnedItems, NSError *activityError) {
        
        [self activityViewDisappear];
    };
    
    [self.navigationController presentViewController:activityViewController
                                            animated:YES
                                          completion:^{
                                              // ...
                                              [self activityViewAppear];
                                          }];
    return;
}

-(UIView*)sharePopView
{
    CGFloat viewWidth  = 250;
    CGFloat height = 70;
    UIView * view = [[UIView alloc] initWithFrame:CGRectMake(0, 0, viewWidth, height)];
    [view setBackgroundColor:[UIColor clearColor]];
    
    CGFloat x = 0;
    height = 50;
    CGFloat gap = (viewWidth - (height * 3))/2;
    CGFloat width = 50;
    
    UIButton * button = [UIButton buttonWithType:UIButtonTypeCustom];
    [button setFrame:CGRectMake(x, 0, width, height)];
    [button setImage:[UIImage imageNamed:@"facebookShare"] forState:UIControlStateNormal];
    [button addTarget:self action:@selector(facebookShare) forControlEvents:UIControlEventTouchUpInside];
    [view addSubview:button];
    
    UILabel * label = [[UILabel alloc] initWithFrame:CGRectMake(0, height, viewWidth/3, 20)];
    label.font = [UIFont systemFontOfSize:12];
    label.textAlignment = NSTextAlignmentLeft;
    label.text = @"Facebook";
    [view addSubview:label];
    
    x += (gap + height);
    
    button = [UIButton buttonWithType:UIButtonTypeCustom];
    [button setFrame:CGRectMake(x, 0, width, height)];
    [button setImage:[UIImage imageNamed:@"messageShare"] forState:UIControlStateNormal];
    [button addTarget:self action:@selector(shareOnMail) forControlEvents:UIControlEventTouchUpInside];
    [view addSubview:button];
    
    label = [[UILabel alloc] initWithFrame:CGRectMake(viewWidth/3, height, viewWidth/3, 20)];
    label.font = [UIFont systemFontOfSize:12];
    label.textAlignment = NSTextAlignmentCenter;
    label.text = @"Mail";
    [view addSubview:label];
    
    x += (gap + height);
    
    button = [UIButton buttonWithType:UIButtonTypeCustom];
    [button setFrame:CGRectMake(x, 0, width, height)];
    [button setImage:[UIImage imageNamed:@"whatsappShare"] forState:UIControlStateNormal];
    [button addTarget:self action:@selector(shareOnWhatsApp) forControlEvents:UIControlEventTouchUpInside];
    [view addSubview:button];
    
    label = [[UILabel alloc] initWithFrame:CGRectMake(viewWidth*2/3, height, viewWidth/3, 20)];
    label.font = [UIFont systemFontOfSize:12];
    label.textAlignment = NSTextAlignmentRight;
    label.text = @"WhatsApp";
    [view addSubview:label];
    
    return view;
}
-(void)facebookShare
{
    if([SLComposeViewController isAvailableForServiceType:SLServiceTypeFacebook]) {
        
        SLComposeViewController *controller = [SLComposeViewController composeViewControllerForServiceType:SLServiceTypeFacebook];
        
        [controller setInitialText:kFacebookShareText];
        [controller addURL:[NSURL URLWithString:kAppUrl]];
        [controller addImage:[UIImage imageNamed:@"logoNew"]];
        
        [self presentViewController:controller animated:YES completion:Nil];
    }else
    {
        alert(@"", @"Please login to facebook through Settings.");
    }
}
-(void)shareOnMail
{
    
    
    MFMailComposeViewController *mc = [[MFMailComposeViewController alloc] init];
    mc.mailComposeDelegate = self;
    [mc setSubject:@"TRECHIC iPhone App"];
    [mc setMessageBody:kShareText isHTML:NO];
    
    // Present mail view controller on screen
    [self presentViewController:mc animated:YES completion:NULL];
    
}

- (void) mailComposeController:(MFMailComposeViewController *)controller didFinishWithResult:(MFMailComposeResult)result error:(NSError *)error
{
    switch (result)
    {
        case MFMailComposeResultCancelled:
            NSLog(@"Mail cancelled");
            break;
        case MFMailComposeResultSaved:
            NSLog(@"Mail saved");
            break;
        case MFMailComposeResultSent:
            NSLog(@"Mail sent");
            break;
        case MFMailComposeResultFailed:
            NSLog(@"Mail sent failure: %@", [error localizedDescription]);
            break;
        default:
            break;
    }
    
    // Close the Mail Interface
    [self dismissViewControllerAnimated:YES completion:NULL];
}
-(void)shareOnWhatsApp
{
    NSString * urlWhats =   [NSString stringWithFormat:@"whatsapp://send?text=%@",kShareText];
    NSURL * whatsappURL = [NSURL URLWithString:[urlWhats stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding]];
    if ([[UIApplication sharedApplication] canOpenURL: whatsappURL]) {
        [[UIApplication sharedApplication] openURL: whatsappURL];
    } else {
        UIAlertView * alert = [[UIAlertView alloc] initWithTitle:@"WhatsApp not installed." message:@"Your device has no WhatsApp installed." delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil];
        [alert show];
    }
}

-(UIView*)emptyLeftViewForTextField
{
    return [self leftViewWithIcon:@""];
}
-(void)addHideKeyboardGesture
{
    UITapGestureRecognizer* tapGesture = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(hideKeyboard)];
    [self.view addGestureRecognizer:tapGesture];
}

-(void)addCambrianLogo
{
    [self addTitleView:@"cambrianLogo"];
}
-(void)addCamfistoLogo
{
    [self addTitleView:@"camfistoLogo"];
}
- (void)addTitleView:(NSString*)image
{
    UIImageView * logoImageView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:image]];
    logoImageView.frame = CGRectMake(0, 0, 100, 44);
    logoImageView.contentMode = UIViewContentModeScaleAspectFit;
    self.navigationItem.titleView = logoImageView;
}
-(void)addLogoAtPosition:(CGPoint)position
{
    UIImage* image = [UIImage imageNamed:@"logo"];
    UIImageView* logoImageView = [[UIImageView alloc] initWithImage:image];
    logoImageView.frame = CGRectMake(position.x, position.y, image.size.width, image.size.height);
    [self.view addSubview:logoImageView];
}
-(void)applyFont:(NSString*)font forAllSubViewsOfView:(UIView*)view
{
    for (UIView* subview in view.subviews) {
        if ([subview isKindOfClass:[UILabel class]]) {
            UILabel* label = (UILabel*)subview;
            label.font = [UIFont fontWithName:font size:label.font.pointSize];
        }
        if ([subview isKindOfClass:[UIButton class]]) {
            UILabel* label = (UILabel*)([(UIButton*)subview titleLabel]);
            label.font = [UIFont fontWithName:font size:label.font.pointSize];
        }
        if ([subview isKindOfClass:[UITextField class]]) {
            UITextField* field = (UITextField*)subview;
            field.font = [UIFont fontWithName:font size:field.font.pointSize];
        }
        if ([subview isKindOfClass:[UITextView class]]) {
            UITextView* field = (UITextView*)subview;
            field.font = [UIFont fontWithName:font size:field.font.pointSize];
        }
        
        if (subview.subviews.count) {
            [self applyFont:font forAllSubViewsOfView:subview];
        }
    }
}

- (void)hideKeyboard
{
    [self hideKeyboardForView:self.view];
}
-(void)hideKeyboardForView:(UIView*)v
{
    for (UIView* view in v.subviews) {
        if ([view isKindOfClass:[UITextView class]] || [view isKindOfClass:[UITextField class]]) {
            [view resignFirstResponder];
        }
        
        if (view.subviews.count) {
            [self hideKeyboardForView:view];
        }
    }
}

-(MBProgressHUD*)showHUD
{
    MBProgressHUD * _HUD = [MBProgressHUD showHUDAddedTo:self.view animated:YES];
    _HUD.labelText = @"Loading..";
    return _HUD;
}
-(void)hideHUD
{
    [MBProgressHUD hideAllHUDsForView:self.view animated:YES];
}

-(id)parse:(id)rawObjs ofClass:(Class)cls {
    
    NSMutableArray * parsedObjects = [NSMutableArray new];
    if ([rawObjs isKindOfClass:[NSArray class]]) {
        for (NSDictionary * obj in rawObjs) {
            id parsedObj = [cls modelObjectWithDictionary:obj];
            [parsedObjects addObject:parsedObj];
        }
    }else if ([rawObjs isKindOfClass:[NSDictionary class]]) {
        id parsedObj = [cls modelObjectWithDictionary:rawObjs];
        return parsedObj;
    }
    
    return parsedObjects;
}

-(void)HIT:(WSTYPE)type url:(NSString *)URLString
parameters:(NSDictionary *)parameters
   handler:(void (^)(id data))handler {
    
    [self showHUD];
    if (type == WSTYPEGET) {
        [self GET:URLString parameters:parameters handler:^(NSError *error, id responseObject) {
            [self hideHUD];
            [self handleData:responseObject error:error handler:handler];
        }];
    }else {
        [self POST:URLString parameters:parameters handler:^(NSError *error, id responseObject) {
            [self hideHUD];
            [self handleData:responseObject error:error handler:handler];
        }];
    }
}

-(void)handleData:(id)responseObject error:(NSError *)error handler:(void (^)(id data))handler {
    
    if (responseObject) {
        if ([responseObject[@"status"] boolValue]) {
            handler(responseObject[@"data"]);
        }else {
            alert(@"", responseObject[@"message"]);
        }
    }else if (error) {
        alert(@"", error.localizedDescription);
    }else {
        alert(@"", @"Something went wrong. Please try again later.");
    }
}


- (void)POSTHTTP:(NSString *)URLString
      parameters:(NSDictionary *)parameters
         handler:(void (^)(NSError *error, NSDictionary* responseObject))handler
{
    NSMutableArray * params = [NSMutableArray new];
    for (NSString * key  in parameters) {
        [params addObject:[NSString stringWithFormat:@"%@=%@",key,parameters[key]]];
    }
    
    NSString *postMsg = [params componentsJoinedByString:@"&"];
    
    NSURLSessionConfiguration *configuration = [NSURLSessionConfiguration defaultSessionConfiguration];
    NSURLSession *session = [NSURLSession sessionWithConfiguration:configuration delegate:nil delegateQueue:nil];
    NSURL *url = [NSURL URLWithString:URLString];
    NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:url cachePolicy:NSURLRequestUseProtocolCachePolicy timeoutInterval:60.0];
    [request addValue:@"application/x-www-form-urlencoded" forHTTPHeaderField:@"Content-Type"];
    
    [request setHTTPMethod:@"POST"];
    
    NSData *postData = [postMsg dataUsingEncoding:NSASCIIStringEncoding allowLossyConversion:YES];
    [request setHTTPBody:postData];
    
    
    NSURLSessionDataTask *postDataTask = [session dataTaskWithRequest:request completionHandler:^(NSData *data, NSURLResponse *response, NSError *error) {
        
        dispatch_async(dispatch_get_main_queue(), ^{
            
            if (data) {
                NSError * error;
                id res = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingMutableContainers error:&error];
                if (error) {
                    handler(error,nil);
                }else {
                    handler(nil,res);
                }
            }
            else
            {
                handler(error,nil);
            }
            
            
        });
    }];
    
    [postDataTask resume];
}

- (void)GET:(NSString *)URLString
 parameters:(NSDictionary *)parameters
    handler:(void (^)(NSError *error, id responseObject))handler {
    
    if(!isInternetAvaliable())
    {
        alert(@"", @"Internet connection not avaliable. Please try againx later.");
        return;
    }
    
    NSMutableArray * params = [NSMutableArray new];
    for (NSString * key  in parameters) {
        [params addObject:[NSString stringWithFormat:@"%@=%@",key,parameters[key]]];
    }
    
    NSString *paramString = [params componentsJoinedByString:@"&"];
    NSString *urlStr = [NSString stringWithFormat:@"%@?%@",URLString,paramString];
    
    NSMutableURLRequest *request = [[NSMutableURLRequest alloc] init];
    
    [request setURL:[NSURL URLWithString:urlStr]];
    
    [request setHTTPMethod:@"GET"];
    
    [NSURLConnection sendAsynchronousRequest:request queue:[NSOperationQueue mainQueue] completionHandler:^(NSURLResponse * _Nullable response, NSData * _Nullable data, NSError * _Nullable connectionError) {
        
        if (data) {
            NSError * error;
            id res = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingMutableContainers error:&error];
            
            if (error) {
                handler(error,nil);
            }else {
                handler(nil,res);
            }
        }else
        {
            handler(connectionError,nil);
        }
        
    }];
}

- (void)POST:(NSString *)URLString
  parameters:(NSDictionary *)parameters
     handler:(void (^)(NSError *error, id responseObject))handler {
    
    NSMutableArray * params = [NSMutableArray new];
    for (NSString * key  in parameters) {
        [params addObject:[NSString stringWithFormat:@"%@=%@",key,parameters[key]]];
    }
    
    NSString *postMsg = [params componentsJoinedByString:@"&"];

    NSString *urlStr = URLString;
    
    /*
     * dataUsingEncoding:allowLossyConversion: - Returns nil if flag is NO and the receiver can’t be converted without losing some information.
     */
    NSData *postData = [postMsg dataUsingEncoding:NSASCIIStringEncoding allowLossyConversion:YES];
    
    NSString *postLength = [NSString stringWithFormat:@"%lu",(unsigned long)[postData length]];
    
    NSMutableURLRequest *request = [[NSMutableURLRequest alloc] init];
    
    [request setURL:[NSURL URLWithString:urlStr]];
    request.timeoutInterval = 220;
    [request setHTTPMethod:@"POST"];
    
    [request setValue:postLength forHTTPHeaderField:@"Content-Length"];
    
    /*
     * Sets value for default header field
     */
    [request setValue:@"application/x-www-form-urlencoded" forHTTPHeaderField:@"Content-Type"];
    
    /*
     * Add customer header field and value
     */
    //[request addValue:@"apiuser" forHTTPHeaderField:@"X-USERNAME"];
    
    [request setHTTPBody:postData];
    
    [NSURLConnection sendAsynchronousRequest:request queue:[NSOperationQueue mainQueue] completionHandler:^(NSURLResponse * _Nullable response, NSData * _Nullable data, NSError * _Nullable connectionError) {
        
        //        NSString *responseStr = [[NSString alloc] initWithData:data encoding:NSUTF8StringEncoding];
        //        NSLog(@"%s - %d # responseStr = %@", __PRETTY_FUNCTION__, __LINE__, responseStr);
        //
        if (data) {
            NSError * error;
            id res = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingMutableContainers error:&error];
            
            if (error) {
                handler(error,nil);
            }else {
                handler(nil,res);
            }
        }else
        {
            handler(connectionError,nil);
        }
        
    }];
}

- (void)POST:(NSString *)URLString
jsonDictionary:(id)parameters
     success:(void (^)(id responseObject))success
     failure:(void (^)(NSError *error))failure
{
    if(!isInternetAvaliable())
    {
        alert(@"", @"Internet connection not avaliable. Please try again later.");
        return;
    }
    
    NSError *serr;
    
    NSData *jsonData = [NSJSONSerialization
                        dataWithJSONObject:parameters options:NSJSONWritingPrettyPrinted error:&serr];
    NSString *myString = [[NSString alloc] initWithData:jsonData encoding:NSUTF8StringEncoding];
    NSData *data = [myString dataUsingEncoding:NSUTF8StringEncoding];

    NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:[NSURL URLWithString:URLString]];
    
    // Set method, body & content-type
    request.HTTPMethod = @"POST";
    request.HTTPBody = data;
    [request setValue:@"application/json" forHTTPHeaderField:@"Content-Type"];
    [request setValue:@"application/json" forHTTPHeaderField:@"Accept"];
    
    [request setValue:
     [NSString stringWithFormat:@"%lu",
      (unsigned long)[jsonData length]] forHTTPHeaderField:@"Content-Length"];
    
    [NSURLConnection sendAsynchronousRequest:request
                                       queue:[NSOperationQueue mainQueue]
                           completionHandler:^(NSURLResponse *r, NSData *data, NSError *error)
     {
         
         if (error)
         {
             failure(error);
             return;
         }
         
         NSError *deserr;
         NSDictionary *responseDict = [NSJSONSerialization
                                       JSONObjectWithData:data
                                       options:kNilOptions
                                       error:&deserr];
         
         success(responseDict);
     }];
}


//-(void)uploadImages:(NSDictionary*)images parameters:(NSDictionary*)dic url:(NSString*)urlString completion:(void (^)(bool success, NSDictionary* jsonData,  NSError *error))completionHandler progress:(void (^)(float progress))progressHandler
//{
//    // 1. Create `AFHTTPRequestSerializer` which will create your request.
//    AFHTTPRequestSerializer *serializer = [AFHTTPRequestSerializer serializer];
//
//    // 2. Create an `NSMutableURLRequest`.
//    NSMutableURLRequest *request =
//    [serializer multipartFormRequestWithMethod:@"POST" URLString:urlString parameters:dic
//                     constructingBodyWithBlock:^(id<AFMultipartFormData> formData)
//     {
//         for (NSString * key in images) {
//             UIImage * image = images[key];
//             NSData *imageData = UIImageJPEGRepresentation(image, 1.0);
//             [formData appendPartWithFileData:imageData
//                                         name:key
//                                     fileName:@"imageName.jpg"
//                                     mimeType:@"image/jpeg"];
//         }
//     } error:nil];
//
//    // 3. Create and use `AFHTTPRequestOperationManager` to create an `AFHTTPRequestOperation` from the `NSMutableURLRequest` that we just created.
//    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
//    manager.responseSerializer.acceptableContentTypes = [manager.responseSerializer.acceptableContentTypes setByAddingObject:@"text/html"];
//    AFHTTPRequestOperation *operation =
//    [manager HTTPRequestOperationWithRequest:request
//                                     success:^(AFHTTPRequestOperation *operation, id responseObject) {
//                                         NSLog(@"Success %@", responseObject);
//                                         completionHandler(YES, responseObject, nil);
//                                     } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
//                                         NSLog(@"Failure %@", error.description);
//                                         completionHandler(NO, nil, nil);
//                                     }];
//
//    // 4. Set the progress block of the operation.
//    [operation setUploadProgressBlock:^(NSUInteger __unused bytesWritten,
//                                        long long totalBytesWritten,
//                                        long long totalBytesExpectedToWrite) {
//        NSLog(@"Wrote %lld/%lld", totalBytesWritten, totalBytesExpectedToWrite);
//        if (progressHandler) {
//            float progress = ((float)totalBytesWritten/(float)totalBytesExpectedToWrite);
//            NSLog(@"progress %f", ((float)totalBytesWritten/(float)totalBytesExpectedToWrite)*100.0);
//            progressHandler(progress);
//        }
//    }];
//
//    // 5. Begin!
//    [operation start];
//}


-(void)Round:(UIView*)view corners:(UIRectCorner)corners radii:(float)r
{
    UIBezierPath *maskPath;
    maskPath = [UIBezierPath bezierPathWithRoundedRect:view.bounds
                                     byRoundingCorners:corners
                                           cornerRadii:CGSizeMake(r, r)];
    
    CAShapeLayer *maskLayer = [[CAShapeLayer alloc] init];
    maskLayer.frame = view.bounds;
    maskLayer.path = maskPath.CGPath;
    view.layer.mask = maskLayer;
}

#pragma Image Picker

/**
 Implemant imageSelected: to get selected image
 */

-(void)imageActionForTitle:(NSString*)title
{
    if ([title isEqualToString:@"Choose from Gallery"])
    {
        
        [self openImagePickerWithType:UIImagePickerControllerSourceTypePhotoLibrary];
    }
    else if ([title isEqualToString:@"Camera"])
    {
        
        AVAuthorizationStatus authStatus = [AVCaptureDevice authorizationStatusForMediaType:AVMediaTypeVideo];
        if(authStatus == AVAuthorizationStatusAuthorized) {
            // do your logic
            [self openImagePickerWithType:UIImagePickerControllerSourceTypeCamera];
        } else if(authStatus == AVAuthorizationStatusDenied) {
            // denied
            alert(@"Permissions", @"It looks like your privacy settings are preventing us from accessing your Camera. You can fix this by doing the following:\n\n1. Close this app.\n\n2. Open the Settings app.\n\n3. Touch Privacy.\n\n4. Touch the Canera.\n\n5. Turn it on.\n\n6. Open this app and try again.");
        } else if(authStatus == AVAuthorizationStatusRestricted) {
            // restricted, normally won't happen
            alert(@"Permissions", @"It looks like your privacy settings are preventing us from accessing your Camera. You can fix this by doing the following:\n\n1. Close this app.\n\n2. Open the Settings app.\n\n3. Touch Privacy.\n\n4. Touch the Canera.\n\n5. Turn it on.\n\n6. Open this app and try again.");
        } else if(authStatus == AVAuthorizationStatusNotDetermined) {
            // not determined?!
            [AVCaptureDevice requestAccessForMediaType:AVMediaTypeVideo completionHandler:^(BOOL granted) {
                if(granted){
                    NSLog(@"Granted access to %@", AVMediaTypeVideo);
                    [self openImagePickerWithType:UIImagePickerControllerSourceTypeCamera];
                } else {
                    NSLog(@"Not granted access to %@", AVMediaTypeVideo);
                    alert(@"Permissions", @"It looks like your privacy settings are preventing us from accessing your Camera. You can fix this by doing the following:\n\n1. Close this app.\n\n2. Open the Settings app.\n\n3. Touch Privacy.\n\n4. Touch the Canera.\n\n5. Turn it on.\n\n6. Open this app and try again.");
                }
            }];
        } else {
            // impossible, unknown authorization status
        }
    }
}

-(void)videoActionForTitle:(NSString*)title
{
    if ([title isEqualToString:@"Choose Video"])
    {
        
        [self openVideoPickerWithType:UIImagePickerControllerSourceTypePhotoLibrary];
    }
    else if ([title isEqualToString:@"Record Video"])
    {
        
        AVAuthorizationStatus authStatus = [AVCaptureDevice authorizationStatusForMediaType:AVMediaTypeVideo];
        if(authStatus == AVAuthorizationStatusAuthorized) {
            // do your logic
            [self openVideoPickerWithType:UIImagePickerControllerSourceTypeCamera];
        } else if(authStatus == AVAuthorizationStatusDenied) {
            // denied
            alert(@"Permissions", @"It looks like your privacy settings are preventing us from accessing your Camera. You can fix this by doing the following:\n\n1. Close this app.\n\n2. Open the Settings app.\n\n3. Touch Privacy.\n\n4. Touch the Canera.\n\n5. Turn it on.\n\n6. Open this app and try again.");
        } else if(authStatus == AVAuthorizationStatusRestricted) {
            // restricted, normally won't happen
            alert(@"Permissions", @"It looks like your privacy settings are preventing us from accessing your Camera. You can fix this by doing the following:\n\n1. Close this app.\n\n2. Open the Settings app.\n\n3. Touch Privacy.\n\n4. Touch the Canera.\n\n5. Turn it on.\n\n6. Open this app and try again.");
        } else if(authStatus == AVAuthorizationStatusNotDetermined) {
            // not determined?!
            [AVCaptureDevice requestAccessForMediaType:AVMediaTypeVideo completionHandler:^(BOOL granted) {
                if(granted){
                    NSLog(@"Granted access to %@", AVMediaTypeVideo);
                    [self openVideoPickerWithType:UIImagePickerControllerSourceTypeCamera];
                } else {
                    NSLog(@"Not granted access to %@", AVMediaTypeVideo);
                    alert(@"Permissions", @"It looks like your privacy settings are preventing us from accessing your Camera. You can fix this by doing the following:\n\n1. Close this app.\n\n2. Open the Settings app.\n\n3. Touch Privacy.\n\n4. Touch the Canera.\n\n5. Turn it on.\n\n6. Open this app and try again.");
                }
            }];
        } else {
            // impossible, unknown authorization status
        }
    }
}

-(void)postNotification:(NSString*)name
{
    [[NSNotificationCenter defaultCenter] postNotificationName:name object:nil];
}

-(void)catchNotification:(NSString*)notification selector:(SEL)aSelector
{
    [[NSNotificationCenter defaultCenter] addObserver:self selector:aSelector name:notification object:nil];
}

-(void)removeNotification:(NSString*)notification
{
    [[NSNotificationCenter defaultCenter] removeObserver:self name:notification object:nil];
}

#define kNeedRefresh @"kNeedRefreshNotification"

-(void)postRefreshProfileDataNotification
{
    [self postNotification:kNeedRefresh];
}

-(void)catchRefreshProfileNotification
{
    [self catchNotification:kNeedRefresh selector:@selector(refreshRequired)];
}

-(void)removeRefreshProfileNotification
{
    [self removeNotification:kNeedRefresh];
}

-(void)refreshRequired
{
    
}

#define kDidRefresh @"kDidRefreshNotification"

-(void)postDidRefreshProfileDataNotification
{
    [self postNotification:kDidRefresh];
}

-(void)catchDidRefreshProfileNotification
{
    [self catchNotification:kDidRefresh selector:@selector(refreshDone)];
}

-(void)removeDidRefreshProfileNotification
{
    [self removeNotification:kDidRefresh];
}

-(void)refreshDone
{
    
}

-(void)openImagePickerWithType:(UIImagePickerControllerSourceType)type
{
    UIImagePickerController *imagePickerController = [[UIImagePickerController alloc] init];
    
    imagePickerController.sourceType = type;
    
    imagePickerController.delegate = self;
    imagePickerController.allowsEditing  = NO;
    
    dispatch_async(dispatch_get_main_queue(), ^{
        [self presentViewController:imagePickerController animated:YES completion:nil];
    });
}

-(void)openVideoPickerWithType:(UIImagePickerControllerSourceType)type
{
    UIImagePickerController *videoPicker = [[UIImagePickerController alloc] init];
    
    videoPicker.sourceType = type;
    
    videoPicker.delegate = self;
    
    videoPicker.modalPresentationStyle = UIModalPresentationCurrentContext;
    // This code ensures only videos are shown to the end user
    //    videoPicker.mediaTypes = @[(NSString*)kUTTypeMovie, (NSString*)kUTTypeAVIMovie, (NSString*)kUTTypeVideo, (NSString*)kUTTypeMPEG4];
    
    videoPicker.videoQuality = UIImagePickerControllerQualityTypeHigh;
    [videoPicker setVideoMaximumDuration:15];
    
    dispatch_async(dispatch_get_main_queue(), ^{
        [self presentViewController:videoPicker animated:YES completion:nil];
    });
}

- (void)showImagePicker {
    
    [self showImagePicker:nil];
}

- (void)showImagePicker:(UIImage*)image {
    
    [self.view endEditing:YES];
    
    UIAlertController * actionSheet = [UIAlertController actionSheetWithTitle:@"Choose Option.." message:@"" cancelButton:@"Cancel" otherButtons:(image)?@[@"Preview",@"Choose from Gallery", @"Camera"]:@[@"Choose from Gallery", @"Camera"] handler:^(UIAlertAction *action) {
        
        dispatch_async(dispatch_get_main_queue(), ^{
            
            if (action.style == UIActionSheetStyleDefault)
            {
                if ([action.title isEqualToString:@"Preview"])
                {
                    [self previewImage:image];
                }
                else
                {
                    [self imageActionForTitle:action.title];
                }
            }
            
        });
        
    }];
    [self presentViewController:actionSheet animated:YES completion:nil];
}


- (void)showVideoPicker {
    
    [self.view endEditing:YES];
    
    UIAlertController * actionSheet = [UIAlertController actionSheetWithTitle:@"Choose Option.." message:@"" cancelButton:@"Cancel" otherButtons:@[@"Choose Video", @"Record Video"] handler:^(UIAlertAction *action) {
        
        dispatch_async(dispatch_get_main_queue(), ^{
            
            if (action.style == UIActionSheetStyleDefault)
            {
                [self videoActionForTitle:action.title];
            }
        });
        
    }];
    [self presentViewController:actionSheet animated:YES completion:nil];
}

//- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary *)info
//{
//    UIImage * image = [info valueForKey:UIImagePickerControllerOriginalImage];
//    
//    if (image) {
//        CLImageEditor *editor = [[CLImageEditor alloc] initWithImage:image];
//        editor.delegate = self;
//        
//        [self dismissViewControllerAnimated:NO completion:^{
//            [self presentViewController:editor animated:NO completion:nil];
//        }];
//    }else {
//        NSURL *videoURL = [info objectForKey:UIImagePickerControllerMediaURL];
//        [self videoSelected:videoURL];
//    }
//}
//#pragma mark- CLImageEditor delegate
//
//- (void)imageEditor:(CLImageEditor *)editor didFinishEdittingWithImage:(UIImage *)image
//{
//    UIImage * _selectedImage = image;
//    
//    if (_selectedImage)
//    {
//        CGSize size = _selectedImage.size;
//        
//        float max = 800;
//        if (size.width > max) {
//            _selectedImage = [_selectedImage scaleToSize:CGSizeMake(max, (max/size.width)*size.height)];
//        }
//    }
//    
//    [editor dismissViewControllerAnimated:YES completion:^{
//        dispatch_async(dispatch_get_main_queue(), ^{
//            [self imageSelected:_selectedImage];
//        });
//    }];
//    
//}

-(void)imageSelected:(UIImage*)image {
    //-- Implement this method
}

-(void)previewImage {
    //-- Implement this method
}

-(void)videoSelected:(NSURL *)url {
    //-- Implement this method
}

-(void)previewImage:(UIImage*)image text:(NSString *)text showDeleteButton:(BOOL)show
{
//    ImagePreviewViewController * vc = [self.storyboard instantiateViewControllerWithIdentifier:@"ImagePreviewViewController"];
//    vc.image = image;
//    vc.text = text;
//    vc.showDeleteButton = show;
//    vc.delegate = self;
//    [self presentViewController:vc animated:YES completion:nil];
}

-(void)previewImage:(UIImage*)image text:(NSString *)text
{
    [self previewImage:image text:text showDeleteButton:NO];
}

-(void)previewImage:(UIImage*)image
{
    [self previewImage:image text:@""];
}

//-(void)doneButtonPressedForController:(ImagePreviewViewController *)vc
//{
//    [vc dismissViewControllerAnimated:YES completion:nil];
//}
//
//-(void)deleteButtonPressedForController:(ImagePreviewViewController *)vc
//{
//    
//}

-(void)showPicker:(NSArray*)options doneBlock:(ActionStringDoneBlock)doneBlock
{
    [ActionSheetStringPicker showPickerWithTitle:@"Choose one"
                                            rows:options
                                initialSelection:0
                                       doneBlock:^(ActionSheetStringPicker *picker, NSInteger selectedIndex, id selectedValue) {
                                           NSLog(@"Picker: %@, Index: %ld, value: %@",
                                                 picker, (long)selectedIndex, selectedValue);
                                           
                                           doneBlock(picker,selectedIndex,selectedValue);
                                       }
                                     cancelBlock:^(ActionSheetStringPicker *picker) {
                                         NSLog(@"Block Picker Canceled");
                                     }
                                          origin:[UIButton new]];
}

-(void)showMultiPicker:(NSArray*)options doneBlock:(ActionMultipleStringDoneBlock)doneBlock
{
    [ActionSheetMultipleStringPicker showPickerWithTitle:@"Choose one"
                                                    rows:options
                                        initialSelection:0
                                               doneBlock:^(ActionSheetMultipleStringPicker *picker, NSArray *selectedIndexes, id selectedValues) {
                                                   doneBlock(picker, selectedIndexes, selectedValues);
                                               } cancelBlock:^(ActionSheetMultipleStringPicker *picker) {
                                                   
                                               } origin:[UIButton new]];
}

-(void)showTimePicker:(ActionDateDoneBlock)block
{
    [self showTimePickerWithMinDate:nil maxDate:nil doneBlock:block];
}

-(void)showTimePickerWithMinDate:(NSDate*)minDate maxDate:(NSDate*)maxDate doneBlock:(ActionDateDoneBlock)block
{
    [ActionSheetDatePicker showPickerWithTitle:@"Select Time" datePickerMode:UIDatePickerModeTime selectedDate:[NSDate new] minimumDate:minDate maximumDate:maxDate doneBlock:^(ActionSheetDatePicker *picker, id selectedDate, id origin) {
        block(picker, selectedDate, origin);
    } cancelBlock:^(ActionSheetDatePicker *picker) {
        
    } origin:self.view];
}

-(void)showTimePickerWithSelectedDate:(NSDate*)selectedDate minDate:(NSDate*)minDate maxDate:(NSDate*)maxDate doneBlock:(ActionDateDoneBlock)block
{
    [ActionSheetDatePicker showPickerWithTitle:@"Select Time" datePickerMode:UIDatePickerModeTime selectedDate:(selectedDate)?:[NSDate new] minimumDate:minDate maximumDate:maxDate doneBlock:^(ActionSheetDatePicker *picker, id selectedDate, id origin) {
        block(picker, selectedDate, origin);
    } cancelBlock:^(ActionSheetDatePicker *picker) {
        
    } origin:self.view];
}

-(void)showDatePicker:(ActionDateDoneBlock)block
{
    [self showDatePickerWithMinDate:nil maxDate:nil doneBlock:block];
}

-(void)showDatePickerWithMinDate:(NSDate*)minDate maxDate:(NSDate*)maxDate doneBlock:(ActionDateDoneBlock)block
{
    [ActionSheetDatePicker showPickerWithTitle:@"Select Time" datePickerMode:UIDatePickerModeDateAndTime selectedDate:[NSDate new] minimumDate:minDate maximumDate:maxDate doneBlock:^(ActionSheetDatePicker *picker, id selectedDate, id origin) {
        block(picker, selectedDate, origin);
    } cancelBlock:^(ActionSheetDatePicker *picker) {
        
    } origin:self.view];
    
    
}

-(void)showDatePickerWithSelectedDate:(NSDate*)selectedDate minDate:(NSDate*)minDate maxDate:(NSDate*)maxDate doneBlock:(ActionDateDoneBlock)block
{
    [ActionSheetDatePicker showPickerWithTitle:@"Select Time" datePickerMode:UIDatePickerModeDateAndTime selectedDate:(selectedDate)?:[NSDate new] minimumDate:minDate maximumDate:maxDate doneBlock:^(ActionSheetDatePicker *picker, id selectedDate, id origin) {
        block(picker, selectedDate, origin);
    } cancelBlock:^(ActionSheetDatePicker *picker) {
        
    } origin:self.view];
    
    
}

-(void)showActionSheet:(NSArray*)options doneBlock:(void(^)(UIAlertController *sheet, NSInteger selectedIndex, id selectedValue))doneBlock
{
    UIAlertController * controller = [UIAlertController actionSheetWithTitle:@"Choose One" message:@"" cancelButton:@"Cancel" otherButtons:options handler:^(UIAlertAction *action)
                                      {
                                          if (action.style != UIAlertActionStyleCancel)
                                          {
                                              doneBlock(controller,[options indexOfObject:action.title],action.title);
                                          }
                                      }];
    
    [self presentViewController:controller animated:YES completion:nil];;
}

//-(void)showDateOnlyPicker:(ActionDateDoneBlock)block
//{
//    [ActionSheetDatePicker showPickerWithTitle:@"Select Time" datePickerMode:UIDatePickerModeDate selectedDate:[NSDate new] minimumDate:nil maximumDate:nil doneBlock:^(ActionSheetDatePicker *picker, id selectedDate, id origin) {
//        block(picker, selectedDate, origin);
//    } cancelBlock:^(ActionSheetDatePicker *picker) {
//        
//    } origin:self.view];
//}

-(void)alertTryAgain:(NSError*) error retrySelector:(SEL)selector
{
    dispatch_async(dispatch_get_main_queue(), ^{
        UIAlertController * controller = [UIAlertController alertWithTitle:@"Error!" message:error.localizedDescription cancelButton:@"Cancel" otherButtons:@[@"Try Again"] handler:^(UIAlertAction *action) {
            dispatch_async(dispatch_get_main_queue(), ^{
                
                if (action.style == UIAlertActionStyleDefault)
                {
                    if ([self respondsToSelector:selector])
                    {
                        [self performSelector:selector];
                    }
                }
            });
        }];
        [self presentViewController:controller animated:YES completion:nil];
    });
}

//-(void)downloadImage:(NSString *)url completion:(void (^)(bool success, NSError * error, UIImage * image ))success
//{
//    AFHTTPRequestOperation *requestOperation = [[AFHTTPRequestOperation alloc] initWithRequest:[NSURLRequest requestWithURL:[NSURL URLWithString:url]]];
//    requestOperation.responseSerializer = [AFImageResponseSerializer serializer];
//    [requestOperation setCompletionBlockWithSuccess:^(AFHTTPRequestOperation *operation, id responseObject) {
//        success(YES, nil, responseObject);
//    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
//        success(NO, error, nil);
//    }];
//    [requestOperation start];
//}

//-(void)showTopNotification:(UIImage *)image title:(NSString *)title message:(NSString *)message
//{
//    [HDNotificationView showNotificationViewWithImage:image title:title message:message];
//}
//
//-(void)showTopNotification:(UIImage *)image title:(NSString *)title message:(NSString *)message onTouch:(void (^)())onTouch
//{
//    [HDNotificationView showNotificationViewWithImage:image title:title message:message isAutoHide:YES onTouch:^{
//        [self hideTopNotification];
//        if(onTouch)onTouch();
//    }];
//}
//
//-(void)hideTopNotification
//{
//    [HDNotificationView hideNotificationView];
//}

-(void)saveUserDetails:(NSDictionary *)details {
    userDefaults_setObject(details, @"user.details");
}

-(NSDictionary *)userDetails {
    return userDefaults_getObject(@"user.details");
}

-(void)removeUserDetails {
    userDefaults_removeObject(@"user.details");
}

-(BOOL)isValidPasswrod:(NSString *)password {
    
    BOOL upperCaseLetter = false;
    int digitCounts = 0;
    
    for (int i = 0; i < [password length]; i++)
    {
        unichar c = [password characterAtIndex:i];
        
        if(!upperCaseLetter)
        {
            upperCaseLetter = [[NSCharacterSet uppercaseLetterCharacterSet] characterIsMember:c];
        }
        
        if([[NSCharacterSet decimalDigitCharacterSet] characterIsMember:c])
        {
            digitCounts++;
        }
        
    }
    
    if (password.length >= 5 && upperCaseLetter && digitCounts >= 2) {
        return true;
    }
    
    return false;
}

-(NSString *)deviceToken {
    return userDefaults_getObject(@"deviceToken")?:@"";
}

-(void)updateSavedUserDetailsValue:(id)value forKey:(NSString *)key {
    
    NSMutableDictionary * details = [[self userDetails] mutableCopy];
    [details setObject:value forKey:key];
    [self saveUserDetails:details];
}

@end

@implementation UIColor(Hexadecimal)

+ (UIColor *)colorWithHexString:(NSString *)hexString
{
    unsigned rgbValue = 0;
    NSScanner *scanner = [NSScanner scannerWithString:hexString];
    
    if ([hexString containsString:@"#"]) {
        [scanner setScanLocation:1]; // bypass '#' character
    }
    
    [scanner scanHexInt:&rgbValue];
    
    return [UIColor colorWithRed:((rgbValue & 0xFF0000) >> 16)/255.0 green:((rgbValue & 0xFF00) >> 8)/255.0 blue:(rgbValue & 0xFF)/255.0 alpha:1.0];
}

@end

@implementation UIImage (additions)

-(UIImage *)renderingModeImage
{
    return [self imageWithRenderingMode:UIImageRenderingModeAlwaysTemplate];
}

@end

@implementation UIImageView (additions)

-(void)setImageColor:(UIColor *)color
{
    self.image = [self.image renderingModeImage];
    self.tintColor = color;
}

@end

@implementation NSObject (Additions)


@end
