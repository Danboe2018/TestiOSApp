//
//  GMForms.h
//  Lemon and honey Intake form App
//
//  Created by Gurpreet Singh on 23/02/17.
//  Copyright © 2017 Gurie. All rights reserved.
//
@import UIKit;
#import <Foundation/Foundation.h>

@interface GMForm : NSObject

@property (nonatomic, retain) NSString * name;
@property (nonatomic, retain) NSString * formName;
@property (nonatomic, retain) NSString * formId;
@property (nonatomic, retain) NSArray * formGroups;
@property (nonatomic, retain) NSArray * fieldsInfo;
@property (nonatomic, retain) NSArray * imageFields;
@end

//--

@interface MyDictionary : NSMutableDictionary
+(instancetype)newObject;
@end

//--

@interface GMFormJsonGroup : MyDictionary

+(instancetype)groupWithID:(NSString *)_id title:(NSString *)title sections:(NSArray *)sections;

@end

//--

@interface GMFormJsonSection : MyDictionary

+(instancetype)sectionWithID:(NSString *)_id fields:(NSArray *)fields;

@end

//--

@interface GMFormJsonSize : MyDictionary

+(instancetype)sizeWithWidth:(CGFloat)width height:(CGFloat)height;

@end

//--

@interface GMFormJsonValidation : MyDictionary

+(instancetype)withRequired:(BOOL)isRequired;
+(instancetype)withFormat:(NSString *)format required:(BOOL)isRequired;

@end

//--

@interface GMFormJsonValue : MyDictionary

+(instancetype)withId:(NSString *)_id title:(NSString *)title;

@end

//--

@interface GMFormJsonField : MyDictionary
+(instancetype)countFieldTextWithID:(NSString *)_id title:(NSString *)title maxValue:(int)maxValue;

+(instancetype)fieldWithID:(NSString *)_id title:(NSString *)title type:(NSString *)type size:(GMFormJsonSize *)size validation:(GMFormJsonValidation *)validation;

+(instancetype)fieldWithID:(NSString *)_id title:(NSString *)title type:(NSString *)type size:(GMFormJsonSize *)size validation:(GMFormJsonValidation *)validation values:(NSArray *)values;

//--
+(instancetype)textFieldWithID:(NSString *)_id title:(NSString *)title width:(CGFloat)width validation:(GMFormJsonValidation*)validate;
+(instancetype)dateFieldWithID:(NSString *)_id title:(NSString *)title width:(CGFloat)width validation:(GMFormJsonValidation*)validate;

+(instancetype)dateFieldWithID:(NSString *)_id title:(NSString *)title;

+(instancetype)labelFieldWithID:(NSString *)_id title:(NSString *)title height:(CGFloat)height;

+(instancetype)textFieldWithID:(NSString *)_id title:(NSString *)title;
+(instancetype)numberFieldWithID:(NSString *)_id title:(NSString *)title;
+(instancetype)emailFieldWithID:(NSString *)_id title:(NSString *)title;
+(instancetype)checkBoxFieldWithID:(NSString *)_id title:(NSString *)title values:(NSArray *)values;

+(instancetype)dateFieldWithID:(NSString *)_id title:(NSString *)title width:(CGFloat)width;
+(instancetype)textFieldWithID:(NSString *)_id title:(NSString *)title width:(CGFloat)width;
+(instancetype)textFieldLongTitleWithID:(NSString *)_id title:(NSString *)title height:(CGFloat)height;
+(instancetype)numberFieldWithID:(NSString *)_id title:(NSString *)title width:(CGFloat)width validation:(GMFormJsonValidation*)validate;
+(instancetype)numberFieldWithID:(NSString *)_id title:(NSString *)title width:(CGFloat)width;
+(instancetype)emailFieldWithID:(NSString *)_id title:(NSString *)title width:(CGFloat)width;
+(instancetype)checkBoxFieldWithID:(NSString *)_id title:(NSString *)title values:(NSArray *)values  height:(CGFloat)height validation:(GMFormJsonValidation*)validate;
+(instancetype)checkBoxFieldWithID:(NSString *)_id title:(NSString *)title values:(NSArray *)values width:(CGFloat)width;
+(instancetype)radioButtonFieldWithID:(NSString *)_id title:(NSString *)title values:(NSArray *)values height:(CGFloat)height;
+(instancetype)radioButtonFieldWithID:(NSString *)_id title:(NSString *)title values:(NSArray *)values width:(CGFloat)width;
+(instancetype)radioButtonFieldWithID:(NSString *)_id title:(NSString *)title values:(NSArray *)values width:(CGFloat)width height:(CGFloat)height validation:(GMFormJsonValidation*)validate;
+(instancetype)signatureFieldsWithID:(NSString *)_id title:(NSString *)title;
+(instancetype)ratingFieldsWithID:(NSString *)_id title:(NSString *)title;
@end
