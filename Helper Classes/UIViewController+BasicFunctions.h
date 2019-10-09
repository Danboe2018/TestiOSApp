//
//  UIViewController+BasicFunctions.h
//
//  Created by Gurpreet Singh on 08/04/15.
//  Copyright (c) 2015 Gurpreet Singh. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MBProgressHUD.h"
#import "HelperFunctions.h"
#import "Constants.h"
#import <MessageUI/MessageUI.h>
//#import "CLImageEditor.h"
//#import "ImagePreviewViewController.h"
#import "ActionSheetPicker.h"
#import "ActionSheetMultipleStringPicker.h"
//#import "AbstractActionSheetPicker.h"
//#import <Google/Analytics.h>

typedef enum WSTYPE {
    WSTYPEGET,
    WSTYPEPOST
}WSTYPE;

@class User;

@interface UIViewController (BasicFunctions) <MFMailComposeViewControllerDelegate, UINavigationControllerDelegate, UIImagePickerControllerDelegate>
//, CLImageEditorDelegate, ImagePreviewDelegate>

-(User *)user;

+ (UIStoryboard *)storyboard:(NSString *)name;
- (void)addBackground;
- (MBProgressHUD*)showHUD;
- (void)hideHUD;
- (void)configureTextField:(UIView*)field;
- (void)setBackgroundImage:(NSString*)image;

- (void)showLoginAlert;
- (void)removeBackButtonText;
- (void)setBackButtonText:(NSString *)text;
- (void)pushViewControllerWithIdentifier:(NSString*)identifier;
- (void)pushViewControllerWithIdentifier:(NSString*)identifier values:(NSDictionary*)values;
- (id)pushViewControllerWithIdentifier:(NSString*)identifier CustomBackButton:(id)btn;
- (id)pushViewController:(UIViewController *)vc CustomBackButton:(id)btn;
- (void)pushViewControllerWithIdentifier:(NSString*)identifier values:(NSDictionary*)values CustomBackButton:(id)btn;
- (void)presentViewControllerWithIdentifier:(NSString*)identifier;
- (void)presentViewControllerWithIdentifier:(NSString*)identifier animation:(BOOL)_animation;

- (void)previewImage:(UIImage*)image;
- (void)previewImage:(UIImage*)image text:(NSString *)text;
- (void)previewImage:(UIImage*)image text:(NSString *)text showDeleteButton:(BOOL)show;

- (void)addHideKeyboardGesture;
- (void)hideKeyboard;
- (void)addShareButton;
- (void)shareOnMail;
- (void)addTitleView:(NSString*)image;
- (void)addCambrianLogo;
- (void)addCamfistoLogo;
- (UIBarButtonItem*)addCartButton;
- (void)addLogoAtPosition:(CGPoint)position;
- (UIView*)emptyLeftViewForTextField;
- (UIView*)leftViewWithIcon:(NSString*)imageName;
- (UIView*)leftViewWithIcon:(NSString*)imageName width:(NSInteger)w;
- (void)Round:(UIView*)view corners:(UIRectCorner)corners radii:(float)r;
- (void)alertTryAgain:(NSError*) error retrySelector:(SEL)selector;

//-- Webservices

- (void)POSTHTTP:(NSString *)URLString
      parameters:(NSDictionary *)parameters
         handler:(void (^)(NSError *error, NSDictionary* responseObject))handler;
-(void)HIT:(WSTYPE)type url:(NSString *)URLString
parameters:(NSDictionary *)parameters
   handler:(void (^)(id data))handler;

- (void)GET:(NSString *)URLString
 parameters:(NSDictionary *)parameters
    handler:(void (^)(NSError *error, id responseObject))handler;

- (void)POST:(NSString *)URLString
  parameters:(NSDictionary *)parameters
     handler:(void (^)(NSError *error, id responseObject))handler;

- (void)POST:(NSString *)URLString
jsonDictionary:(id)parameters
     success:(void (^)(id responseObject))success
     failure:(void (^)(NSError *error))failure;

-(id)parse:(id)rawObjs ofClass:(Class)cls;

//--
- (void)cartAction:(id)sender;
- (void)activityViewAppear;
- (void)activityViewDisappear;

//--
- (void)showImagePicker;
- (void)showImagePicker:(UIImage*)image;
- (void)imageSelected:(UIImage*)image;

- (void)showVideoPicker;
- (void)videoSelected:(NSURL *)url;

-(void)showActionSheet:(NSArray*)options doneBlock:(void(^)(UIAlertController *sheet, NSInteger selectedIndex, id selectedValue))doneBlock;
-(void)downloadImage:(NSString *)url completion:(void (^)(bool success, NSError * error, UIImage * image ))success;

//--
-(void)showTimePicker:(ActionDateDoneBlock)block;


//--
-(void)postRefreshProfileDataNotification;
-(void)catchRefreshProfileNotification;
-(void)removeRefreshProfileNotification;
-(void)refreshRequired;

-(void)postDidRefreshProfileDataNotification;
-(void)catchDidRefreshProfileNotification;
-(void)removeDidRefreshProfileNotification;
-(void)refreshDone;

-(void)showTopNotification:(UIImage *)image title:(NSString *)title message:(NSString *)message;
-(void)showTopNotification:(UIImage *)image title:(NSString *)title message:(NSString *)message onTouch:(void (^)())onTouch;
-(void)hideTopNotification;

-(void)saveUserDetails:(NSDictionary *)details ;
-(NSDictionary *)userDetails ;
-(void)removeUserDetails;

-(BOOL)isValidPasswrod:(NSString *)password;
-(NSString *)deviceToken;
-(void)updateSavedUserDetailsValue:(id)value forKey:(NSString *)key;

@end

@interface UIColor(Hexadecimal)

+ (UIColor *)colorWithHexString:(NSString *)hexString;

@end

@interface UIImage (additions)

-(UIImage *)renderingModeImage;

@end

@interface UIImageView (additions)

-(void)setImageColor:(UIColor *)color;

@end


@interface NSObject (Additions)
+ (instancetype)modelObjectWithDictionary:(NSDictionary *)dict;
@end
