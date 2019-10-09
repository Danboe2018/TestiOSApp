//
//  HelperFunctions.h
//  Familien Jul
//
//  Created by Gurpreet Singh on 23/06/14.
//  Copyright (c) 2014 Gurpreet Singh. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreGraphics/CoreGraphics.h>
#import "NSArray+Additions.h"
#import "NSDictionary+Additions.h"


@import UIKit;
@import CoreGraphics;

@interface HelperFunctions : NSObject

void        alert(NSString* Title, NSString* Message);

NSString*   DocumentDirectoty();

NSString*   xibName(NSString* name);

NSArray *   listOfFilesAtPath(NSString *path);

UIImage*    imageFromView(UIView* view) ;

UIImage*    drawImageOverImage(UIImage* fgImage, UIImage* bgImage, CGPoint point);

BOOL        saveImageAtPath(UIImage* image, NSString* path);

BOOL        isValidEmail(NSString* email);

BOOL        isInternetAvaliable();

BOOL        isFileExistAtPath(NSString* path);

BOOL        deleteFileAtPath(NSString* path);

BOOL        isImage(NSString *file);

BOOL        isSound(NSString *file);

float       scale (CGSize size, BOOL landscape);

float       scaleMIN (CGSize size, BOOL landscape);

float       scaleMAX (CGSize size, BOOL landscape);

float       scaleX (CGSize size, BOOL landscape);

float       scaleY (CGSize size, BOOL landscape);

UIColor*    RgbToUIColor(float r,float g,float b);

NSString*   getUniqueIdentifier();

void        userDefaults_setObject(id object, NSString* key);

id          userDefaults_getObject(NSString* key);

void        userDefaults_removeObject(NSString* key);

NSString*   getFileNameFromPath(NSString* path);

BOOL        isBothStringEqual(NSString* first, NSString* second);

NSString * appentString(NSString * s1, NSString * s2);

NSString * appentStrings(NSArray * strs);

#pragma mark- date functions

NSString* getCurrentTimeString();

NSString* stringFromDateString(NSString * dateStr, NSString* dateStrFormat, NSString* targetFormat);

NSString* stringFromDate(NSDate * date, NSString* format);

NSString* stringFromCurrentDate(NSString* format);

NSDate* dateFromString(NSString * date, NSString* format);

NSString * getNumberWithSuffix(int number);

NSUserDefaults* userDefaults();

NSString* yearFromDate(NSDate * date);

NSString* getCurrentYear();

NSInteger monthNumberFromDate(NSDate * date);

NSString * monthNameFromDate(NSDate * date);

NSInteger getCurrentMonthNumber();

NSString * getCurrentMonth ();

void HFAddShadowToViewWithOffset(UIView* aView, CGSize offset);

void HFAddShadowToView(UIView* aView);

void HFApplyTextColorToAllSubViews(UIColor* color, UIView* view);

UIImage * decodeBase64ToImage(NSString * strEncodeData) ;

NSString * encodeToBase64String(UIImage *image) ;

@end

#pragma mark- customFontCategory 
@interface UIFont (customFont)
+ (instancetype)GPHennyPennyFontWithSize:(CGFloat)size;
@end


//-- This category is used to fix orientation problen after clicking.
#pragma mark- UIImage Category
@interface UIImage (fixOrientation)
- (UIImage *)fixOrientation;
- (UIImage*)scaleToSize:(CGSize)size;
@end
