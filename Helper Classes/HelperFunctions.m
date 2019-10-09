//
//  HelperFunctions.m
//  Familien Jul
//
//  Created by Gurpreet Singh on 23/06/14.
//  Copyright (c) 2014 Gurpreet Singh. All rights reserved.
//

#import "HelperFunctions.h"
//#import "Reachability.h"

@implementation HelperFunctions

#pragma mark- Create Image From View
UIImage* imageFromView(UIView* view) {
    
    UIGraphicsBeginImageContext(view.frame.size);
    CGContextRef currentContext = UIGraphicsGetCurrentContext();
    CGContextTranslateCTM(currentContext, 0, 0.0);
    // passing negative values to flip the image
    CGContextScaleCTM(currentContext, 1.0, 1.0);
    [[view layer] renderInContext:currentContext];
    UIImage *screenshot = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return screenshot;
}

UIImage* drawImageOverImage(UIImage* fgImage, UIImage* bgImage, CGPoint point)
{
    UIGraphicsBeginImageContextWithOptions(bgImage.size, FALSE, 0.0);
    [bgImage drawInRect:CGRectMake( 0, 0, bgImage.size.width, bgImage.size.height)];
    [fgImage drawInRect:CGRectMake( point.x, point.y, fgImage.size.width, fgImage.size.height)];
    UIImage *newImage = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    
    return newImage;
}
float scale (CGSize size, BOOL landscape){
    return scaleMIN(size, landscape);
}
float scaleMIN (CGSize size, BOOL landscape){
    return MIN(scaleX(size, landscape), scaleY(size, landscape));
}
float scaleMAX (CGSize size, BOOL landscape){
    return MAX(scaleX(size, landscape), scaleY(size, landscape));
}
float scaleX (CGSize size, BOOL landscape){
    return size.width/((landscape)?1024.0:796.0);
}
float scaleY (CGSize size, BOOL landscape){
    return size.height/((landscape)?768.0:1024.0);
}
#pragma mark- # Helper Methods & Functions
NSString* DocumentDirectoty()
{
    NSArray *searchPaths =NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    NSString *documentPath_ = [searchPaths objectAtIndex: 0];
    return documentPath_;
}
void alert(NSString* Title, NSString* Message){
    UIAlertView * alert = [[UIAlertView alloc] initWithTitle:Title message:Message delegate:nil cancelButtonTitle:@"Ok" otherButtonTitles:nil];
    [alert show];
}
NSArray * listOfFilesAtPath(NSString *path)
{
    return [[NSFileManager defaultManager] contentsOfDirectoryAtPath:path error:NULL];
}

BOOL saveImageAtPath(UIImage* image, NSString* path)
{
    NSData *imageData = UIImagePNGRepresentation(image);
    return [imageData writeToFile:path atomically:YES];
}

BOOL isValidEmail(NSString* email)
{
    NSString *emailRegex = @"[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,4}";
    NSPredicate *emailTest = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", emailRegex];
    return [emailTest evaluateWithObject:email];
}
BOOL isInternetAvaliable()
{
    return YES;//[[Reachability reachabilityForInternetConnection] isReachable];
}

BOOL isFileExistAtPath(NSString* path)
{
    return [[NSFileManager defaultManager] fileExistsAtPath:path];
}

BOOL deleteFileAtPath(NSString* path)
{
    if(![path isKindOfClass:[NSNull class]])
        if(path.length != 0)
            return [[NSFileManager defaultManager] removeItemAtPath:path error:nil];
    return NO;
}
BOOL isImage(NSString *file)
{
    return ([file hasSuffix:@"jpg"] || [file hasSuffix:@"png"]);
}

BOOL isSound(NSString *file)
{
    return ([file hasSuffix:@"mp3"] || [file hasSuffix:@"wav"]);
}

NSString* xibName(NSString* name)
{
//    if(IS_IPHONE) name = [name stringByAppendingString:@"-iPhone"];
    return name;
}

NSString * getUniqueIdentifier()
{
    return [[[UIDevice currentDevice] identifierForVendor] UUIDString];
}

UIColor* RgbToUIColor(float r,float g,float b)
{
    return [UIColor colorWithRed:((r) / 255.0) green:((g) / 255.0) blue:((b) / 255.0) alpha:1.0];
}

NSUserDefaults* userDefaults() {
   return [NSUserDefaults standardUserDefaults];
}
void userDefaults_setObject(id object, NSString* key) {
    [userDefaults() setObject:object forKey:key];
    [userDefaults() synchronize];
}
id userDefaults_getObject(NSString* key) {
    return [userDefaults() objectForKey:key];
}

void userDefaults_removeObject(NSString* key) {
    [userDefaults() removeObjectForKey:key];
}

NSString* getFileNameFromPath(NSString* path)
{
    if([path isKindOfClass:[NSNull class]] || !path || path.length == 0)
        return @"";
    return [path lastPathComponent];
}
BOOL isBothStringEqual(NSString* first, NSString* second)
{
    if([first isKindOfClass:[NSNull class]] ||
       [second isKindOfClass:[NSNull class]] ||
       !first || !second)
        return NO;
    return [first isEqualToString:second];
}

NSString * appentString(NSString * s1, NSString * s2)
{
    return appentStrings(@[s1,s2]);
}
NSString * appentStrings(NSArray * strs)
{
    if (strs.count) {
        NSString * str = strs[0];
        for (int i = 1; i < strs.count; i++) {
            NSString * s = strs[i];
            str = [str stringByAppendingString:s];
        }
        return str;
    }
    
    return nil;
}


NSString* stringFromDateString(NSString * dateStr, NSString* dateStrFormat, NSString* targetFormat)
{
    NSDate * date = dateFromString(dateStr, dateStrFormat);
    return stringFromDate(date, targetFormat);
}
NSString* stringFromDate(NSDate * date, NSString* format) {
    if (!date) return 0;
    NSDateFormatter *df = [[NSDateFormatter alloc] init];
    [df setDateFormat:format];
    [df setLocale:[NSLocale currentLocale]];
    return [df stringFromDate:date];
}

NSDate* dateFromString(NSString * date, NSString* format) {
    if (!date) return 0;
    NSDateFormatter *df = [[NSDateFormatter alloc] init];
    [df setDateFormat:format];
    [df setLocale:[NSLocale currentLocale]];
    return [df dateFromString:date];
}

NSString* getCurrentTimeString()
{
    return stringFromDate([NSDate date], @"hh:mm a");
}

NSString* stringFromCurrentDate(NSString* format) {
    return stringFromDate([NSDate date], format);
}
NSString* yearFromDate(NSDate * date) {
    return stringFromDate(date, @"YYYY");
}

NSInteger monthNumberFromDate(NSDate * date) {
    return [stringFromDate(date, @"MM") integerValue];
}

NSString * monthNameFromDate(NSDate * date) {
    return stringFromDate(date, @"MMMM");
}

NSString * weekDayNameFromDate(NSDate * date) {
    return stringFromDate(date, @"EEEE");
}

NSInteger getCurrentMonthNumber() {
    return monthNumberFromDate([NSDate date]);
}
NSString * getCurrentMonth () {
    return monthNameFromDate([NSDate date]);
}
NSString* getCurrentYear()
{
    return yearFromDate([NSDate date]);
}

NSString * getNumberWithSuffix(int number)
{
    NSString *suffix;
    int ones = number % 10;
    int tens = (number/10) % 10;
    
    if (tens ==1) {
        suffix = @"th";
    } else if (ones ==1){
        suffix = @"st";
    } else if (ones ==2){
        suffix = @"nd";
    } else if (ones ==3){
        suffix = @"rd";
    } else {
        suffix = @"th";
    }
    
    NSString *completeAsString = [NSString stringWithFormat:@"%d%@",number,suffix];
    return completeAsString;
}


NSString * encodeToBase64String(UIImage *image) {
    if (!image) {
        return @"";
    }
    return [UIImagePNGRepresentation(image) base64EncodedStringWithOptions:NSDataBase64EncodingEndLineWithCarriageReturn];
}

UIImage * decodeBase64ToImage(NSString * strEncodeData) {
    NSData *data = [[NSData alloc]initWithBase64EncodedString:strEncodeData options:NSDataBase64DecodingIgnoreUnknownCharacters];
    return [UIImage imageWithData:data];
}

@end

#pragma mark- customFontCategory
@implementation UIFont (customFont)
+ (instancetype)GPHennyPennyFontWithSize:(CGFloat)size {
    return [self fontWithName:@"" size:size];
}
@end



//-- This category is used to fix orientation problen after clicking.
#pragma mark- UIImage Category
@implementation UIImage (fixOrientation)

- (UIImage *)fixOrientation {
    
    // No-op if the orientation is already correct
    if (self.imageOrientation == UIImageOrientationUp) return self;
    
    // We need to calculate the proper transformation to make the image upright.
    // We do it in 2 steps: Rotate if Left/Right/Down, and then flip if Mirrored.
    CGAffineTransform transform = CGAffineTransformIdentity;
    
    switch (self.imageOrientation) {
        case UIImageOrientationDown:
        case UIImageOrientationDownMirrored:
            transform = CGAffineTransformTranslate(transform, self.size.width, self.size.height);
            transform = CGAffineTransformRotate(transform, M_PI);
            break;
            
        case UIImageOrientationLeft:
        case UIImageOrientationLeftMirrored:
            transform = CGAffineTransformTranslate(transform, self.size.width, 0);
            transform = CGAffineTransformRotate(transform, M_PI_2);
            break;
            
        case UIImageOrientationRight:
        case UIImageOrientationRightMirrored:
            transform = CGAffineTransformTranslate(transform, 0, self.size.height);
            transform = CGAffineTransformRotate(transform, -M_PI_2);
            break;
        case UIImageOrientationUp:
        case UIImageOrientationUpMirrored:
            break;
    }
    
    switch (self.imageOrientation) {
        case UIImageOrientationUpMirrored:
        case UIImageOrientationDownMirrored:
            transform = CGAffineTransformTranslate(transform, self.size.width, 0);
            transform = CGAffineTransformScale(transform, -1, 1);
            break;
            
        case UIImageOrientationLeftMirrored:
        case UIImageOrientationRightMirrored:
            transform = CGAffineTransformTranslate(transform, self.size.height, 0);
            transform = CGAffineTransformScale(transform, -1, 1);
            break;
        case UIImageOrientationUp:
        case UIImageOrientationDown:
        case UIImageOrientationLeft:
        case UIImageOrientationRight:
            break;
    }
    
    // Now we draw the underlying CGImage into a new context, applying the transform
    // calculated above.
    CGContextRef ctx = CGBitmapContextCreate(NULL, self.size.width, self.size.height,
                                             CGImageGetBitsPerComponent(self.CGImage), 0,
                                             CGImageGetColorSpace(self.CGImage),
                                             CGImageGetBitmapInfo(self.CGImage));
    CGContextConcatCTM(ctx, transform);
    switch (self.imageOrientation) {
        case UIImageOrientationLeft:
        case UIImageOrientationLeftMirrored:
        case UIImageOrientationRight:
        case UIImageOrientationRightMirrored:
            // Grr...
            CGContextDrawImage(ctx, CGRectMake(0,0,self.size.height,self.size.width), self.CGImage);
            break;
            
        default:
            CGContextDrawImage(ctx, CGRectMake(0,0,self.size.width,self.size.height), self.CGImage);
            break;
    }
    
    // And now we just create a new UIImage from the drawing context
    CGImageRef cgimg = CGBitmapContextCreateImage(ctx);
    UIImage *img = [UIImage imageWithCGImage:cgimg];
    CGContextRelease(ctx);
    CGImageRelease(cgimg);
    return img;
}


-(UIImage*)scaleToSize:(CGSize)size
{
    // Create a bitmap graphics context
    // This will also set it as the current context
    UIGraphicsBeginImageContext(size);
    
    // Draw the scaled image in the current context
    [self drawInRect:CGRectMake(0, 0, size.width, size.height)];
    
    // Create a new image from current context
    UIImage* scaledImage = UIGraphicsGetImageFromCurrentImageContext();
    
    // Pop the current context from the stack
    UIGraphicsEndImageContext();
    
    // Return our new scaled image
    return scaledImage;
}


void HFAddShadowToViewWithOffset(UIView* aView, CGSize offset)
{
    UIBezierPath *shadowPath = [UIBezierPath bezierPathWithRect:aView.bounds];
    aView.layer.masksToBounds = NO;
    aView.layer.shadowColor = [UIColor blackColor].CGColor;
    aView.layer.shadowOffset = offset;
    aView.layer.shadowOpacity = 0.5f;
    aView.layer.shadowPath = shadowPath.CGPath;
}
void HFAddShadowToView(UIView* aView)
{
    HFAddShadowToViewWithOffset(aView, CGSizeMake(0.0f, 5.0f));
}

void HFApplyTextColorToAllSubViews(UIColor* color, UIView* view)
{
    for (UIView* subview in view.subviews)
          {
        if ([subview isKindOfClass:[UILabel class]])
              {
            UILabel* label = (UILabel*)subview;
            label.textColor = color;
        }
        if ([subview isKindOfClass:[UIButton class]])
              {
            UILabel* label = (UILabel*)([(UIButton*)subview titleLabel]);
            label.textColor = color;
        }
        
        if (subview.subviews.count)
              {
            HFApplyTextColorToAllSubViews(color, view);
        }
    }
}

@end


