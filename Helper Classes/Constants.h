//
//  Constants.h
//  IntakeForm
//
//  Created by Gurpreet Singh on 01/02/16.
//  Copyright © 2016 WebAppClouds. All rights reserved.
//

#ifndef Constants_h
#define Constants_h

#pragma mark - DEVICE RELATED

#define IS_WIDESCREEN   ( fabs( ( double )[ [ UIScreen mainScreen ] bounds ].size.height - ( double )568 ) < DBL_EPSILON )
#define IS_IPHONE       ( [ [ [ UIDevice currentDevice ] model ] isEqualToString: @"iPhone" ] )
#define IS_IPOD         ( [ [ [ UIDevice currentDevice ] model ] isEqualToString: @"iPod touch" ] )

#define IS_IPHONE_5         ( IS_IPHONE && IS_WIDESCREEN )
#define IS_IPHONE_4         ( [ [ UIScreen mainScreen ] bounds ].size.height == 480 )
#define IS_IPHONE_4_OR_5    ( [ [ UIScreen mainScreen ] bounds ].size.height <= 568 )
#define IS_IPHONE_5s        ( [ [ UIScreen mainScreen ] bounds ].size.height == 568 )
#define IS_IPHONE_6         ( [ [ UIScreen mainScreen ] bounds ].size.height == 667 )
#define IS_IPHONE_6PLUS     ( [ [ UIScreen mainScreen ] bounds ].size.height == 736 )

#define IS_iPAD_PRO ([[UIDevice currentDevice] userInterfaceIdiom] == UIUserInterfaceIdiomPad && [UIScreen mainScreen].bounds.size.height == 1366)

#define WINDOW_SIZE     [UIApplication sharedApplication].keyWindow.bounds.size
#define WINDOW_HEIGHT   WINDOW_SIZE.height

#define KappDelegate ((AppDelegate *)[[UIApplication sharedApplication] delegate])

#define WS_GetClientSuggestions      @"https://saloncloudsplus.com/wsputclient/getNameSuggestions"
#define WS_GetAppointmentSuggestions @"https://saloncloudsplus.com/wsprovider/appointments"
#define WS_GetClientDetails          @"https://saloncloudsplus.com/wsIntakeForms/getClientDetails"

#define WS_AddNewDetails                    @"https://saloncloudsplus.com/wsIntakeForms_new/putClientDetailsAdd"
#define WS_UpdateDetails                    @"https://saloncloudsplus.com/wsIntakeForms_new/putClientDetailsUpdate_clone"


#define WS_Login                        @"https://saloncloudsplus.com/wsprovider/stafflogin_intake"

#define WS_form_fields_information      @"https://saloncloudsplus.com/wsforms/form_fields_information"

#define WS_get_last_submitted_form_data  @"https://saloncloudsplus.com/wsforms/get_last_submitted_form_data"


#define WS_save_form_fields_data    @"https://saloncloudsplus.com/wsforms/save_form_fields_data"
#define WS_validate_pin    @"https://saloncloudsplus.com/wsprovider/staff_login_by_passcode"

#define S3BucketName    @"forms-module/forms"
#define S3AccessKey     @"AKIAIGDQGOUQXAEPL52A"
#define S3SecretKey     @"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"
#define ServerBaseUrl   @"http://forms-module.s3.amazonaws.com/forms/"

#define GAITrackingID   @"UA-76250716-1"


//-- Static contents
#define SalonID  @"785" // lemon + honey salon id
#define ModuleID @"9543" // get this from backend. it will be different for each salon.

#define FNClientIntakeForm              @"Electronic_Guest_Intake"
#define FNSpaRemedeForm           @"spa_remedease_programs"
#define FNMembershipAgreement @"spa_remedease_membership"
#define FNClientConsultationForm @"eyelash_extensions_guest_consultation_consent_form"

#define F_Name   @"Guest First Name"
#define L_Name   @"Guest Last Name "
#define Address   @"Address"
#define City   @"City"
#define State   @"State"
#define Zip   @"Zip"
#define Email_address   @"Email"
#define Cell_Phone @"Cell Phone"
#define Date_of_Birth   @"Birth Date"
#endif /* Constants_h */
