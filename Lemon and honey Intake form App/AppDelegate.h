//
//  AppDelegate.h
//  Lemon and honey Intake form App
//
//  Created by Gurie on 14/02/17.
//  Copyright © 2017 Gurie. All rights reserved.
//

#import <UIKit/UIKit.h>
#define kApppDelegate ((AppDelegate*)[[UIApplication sharedApplication] delegate])

@interface AppDelegate : UIResponder <UIApplicationDelegate>

@property (strong, nonatomic) UIWindow *window;
@property (strong, nonatomic) NSDictionary *clientValues;
@property(nonatomic , strong) NSString * stringFormid;
@property(nonatomic , strong) NSString * ownerEmployee;
@property(nonatomic) BOOL isAllowedClientForm;

@property(nonatomic , strong) NSString * stringClass;

@property(nonatomic , strong) NSString * stringStaff_id,*fromValidatePin;
@end

