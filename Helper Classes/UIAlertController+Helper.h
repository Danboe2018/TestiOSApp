//
//  UIAlertController+Helper.h
//  omg
//
//  Created by Gurpreet Singh on 06/06/15.
//  Copyright (c) 2015 Gurpreet Singh. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIAlertController (Helper)

+ (instancetype)alertWithTitle:(NSString *)title message:(NSString *)message cancelButton:(NSString *)cancel otherButtons:(NSArray*)others handler:(void (^)(UIAlertAction *action))handler;
+ (instancetype)actionSheetWithTitle:(NSString *)title message:(NSString *)message cancelButton:(NSString *)cancel otherButtons:(NSArray*)others handler:(void (^)(UIAlertAction *action))handler;
@end
