//
//  GMForms.m
//  Lemon and honey Intake form App
//
//  Created by Gurpreet Singh on 23/02/17.
//  Copyright © 2017 Gurie. All rights reserved.
//

#import "GMForm.h"

@implementation GMForm

@end

//-
@implementation MyDictionary

+(instancetype)newObject
{
    return (MyDictionary *)[[NSMutableDictionary alloc] init];
}

@end
///---

@implementation GMFormJsonGroup

+(instancetype)groupWithID:(NSString *)_id title:(NSString *)title sections:(NSArray *)sections {
    
    GMFormJsonGroup *group = [GMFormJsonGroup newObject];
    
    [group setObject:_id forKey:@"id"];
    [group setObject:title forKey:@"title"];
    [group setObject:sections forKey:@"sections"];
    
    return group;
}

@end

//--

@implementation GMFormJsonSection

+(instancetype)sectionWithID:(NSString *)_id fields:(NSArray *)fields {
    
    GMFormJsonSection *section = [GMFormJsonSection newObject];
    
    [section setObject:_id forKey:@"id"];
    [section setObject:fields forKey:@"fields"];
    
    return section;
}

@end

//--

@implementation GMFormJsonSize

+(instancetype)sizeWithWidth:(CGFloat)width height:(CGFloat)height {
    
    GMFormJsonSize * size = [GMFormJsonSize newObject];
    [size setObject:@(width) forKey:@"width"];
    [size setObject:@(height) forKey:@"height"];
    
    return size;
}

@end

//--

@implementation GMFormJsonValidation

+(instancetype)withRequired_maxValue:(BOOL)isRequired maxValue:(int)maxValue {
    
    return [self withFormat:nil required:isRequired maxValue:maxValue];
}


+(instancetype)withRequired:(BOOL)isRequired {
    
    return [self withFormat:nil required:isRequired];
}

+(instancetype)withFormat:(NSString *)format required:(BOOL)isRequired {
    
    GMFormJsonValidation * validation = [GMFormJsonValidation newObject];
    [validation setObject:@(isRequired) forKey:@"required"];
    
    if (format)
        [validation setObject:format forKey:@"format"];
    
    return validation;
}
+(instancetype)withFormat:(NSString *)format required:(BOOL)isRequired maxValue:(int)maxValue
{
    
    GMFormJsonValidation * validation = [GMFormJsonValidation newObject];
    [validation setObject:@(isRequired) forKey:@"required"];
    [validation setObject:@(maxValue) forKey:@"max_length"];
    
    if (format)
        [validation setObject:format forKey:@"format"];
    
    return validation;
}
@end

//--

@implementation GMFormJsonValue

+(instancetype)withId:(NSString *)_id title:(NSString *)title {
    
    GMFormJsonValue * value = [GMFormJsonValue newObject];
    [value setObject:_id forKey:@"id"];
    [value setObject:title forKey:@"title"];
    
    return value;
}

@end

//--

@implementation GMFormJsonField


+(instancetype)fieldWithID:(NSString *)_id title:(NSString *)title type:(NSString *)type size:(GMFormJsonSize *)size validation:(GMFormJsonValidation *)validation {
    return [self fieldWithID:_id title:title type:type size:size validation:validation values:@[]];
}
+(instancetype)fieldWithID:(NSString *)_id title:(NSString *)title type:(NSString *)type size:(GMFormJsonSize *)size validation:(GMFormJsonValidation *)validation values:(NSArray *)values {
    
    GMFormJsonField *field = [GMFormJsonField newObject];
   // [field setObject:@{@"font_size":@"44.0"} forKey:@"styles"];
    [field setObject:_id forKey:@"id"];
    [field setObject:title forKey:@"title"];
    [field setObject:type forKey:@"type"];
    [field setObject:size forKey:@"size"];
    [field setObject:values forKey:@"values"];
    [field setObject:validation forKey:@"validations"];
    
    return field;
}

//--
+(instancetype)countFieldTextWithID:(NSString *)_id title:(NSString *)title maxValue:(int)maxValue
{
    return [GMFormJsonField fieldWithID:_id title:title type:@"name" size:[GMFormJsonSize sizeWithWidth:50 height:1] validation:[GMFormJsonValidation withRequired_maxValue:true maxValue:maxValue]];
}


+(instancetype)labelFieldWithID:(NSString *)_id title:(NSString *)title height:(CGFloat)height {
    return [GMFormJsonField fieldWithID:_id title:title type:@"label" size:[GMFormJsonSize sizeWithWidth:100 height:height] validation:[GMFormJsonValidation withRequired:NO]];
}

+(instancetype)dateFieldWithID:(NSString *)_id title:(NSString *)title width:(CGFloat)width {
    return [GMFormJsonField fieldWithID:_id title:title type:@"date" size:[GMFormJsonSize sizeWithWidth:width height:1] validation:[GMFormJsonValidation withRequired:YES]];
}

+(instancetype)dateFieldWithID:(NSString *)_id title:(NSString *)title width:(CGFloat)width validation:(GMFormJsonValidation*)validate
{
    return [GMFormJsonField fieldWithID:_id title:title type:@"date" size:[GMFormJsonSize sizeWithWidth:width height:1] validation:validate];
}


+(instancetype)dateFieldWithID:(NSString *)_id title:(NSString *)title {
    return [self dateFieldWithID:_id title:title width:50];
}

+(instancetype)textFieldWithID:(NSString *)_id title:(NSString *)title width:(CGFloat)width {
    return [GMFormJsonField fieldWithID:_id title:title type:@"text" size:[GMFormJsonSize sizeWithWidth:width height:1] validation:[GMFormJsonValidation withRequired:YES]];
}

+(instancetype)textFieldWithID:(NSString *)_id title:(NSString *)title width:(CGFloat)width validation:(GMFormJsonValidation*)validate {
    return [GMFormJsonField fieldWithID:_id title:title type:@"text" size:[GMFormJsonSize sizeWithWidth:width height:1] validation:validate];
}

+(instancetype)textFieldLongTitleWithID:(NSString *)_id title:(NSString *)title height:(CGFloat)height {
    return [GMFormJsonField fieldWithID:_id title:title type:@"textwithlongtitle" size:[GMFormJsonSize sizeWithWidth:100 height:height] validation:[GMFormJsonValidation withRequired:YES]];
}

+(instancetype)textFieldWithID:(NSString *)_id title:(NSString *)title {
    return [self textFieldWithID:_id title:title width:50];
}


+(instancetype)numberFieldWithID:(NSString *)_id title:(NSString *)title width:(CGFloat)width validation:(GMFormJsonValidation*)validate{
    return [GMFormJsonField fieldWithID:_id title:title type:@"number" size:[GMFormJsonSize sizeWithWidth:width height:1] validation:validate];
}


+(instancetype)numberFieldWithID:(NSString *)_id title:(NSString *)title width:(CGFloat)width {
    return [GMFormJsonField fieldWithID:_id title:title type:@"number" size:[GMFormJsonSize sizeWithWidth:width height:1] validation:[GMFormJsonValidation withRequired:YES]];
}

+(instancetype)numberFieldWithID:(NSString *)_id title:(NSString *)title {
    return [self numberFieldWithID:_id title:title width:50];
}

+(instancetype)emailFieldWithID:(NSString *)_id title:(NSString *)title width:(CGFloat)width {
    return [GMFormJsonField fieldWithID:_id title:title type:@"email" size:[GMFormJsonSize sizeWithWidth:width height:1] validation:[GMFormJsonValidation withFormat:@"[\\w._%+-]+@[\\w.-]+\\.\\w{2,}" required:NO]];
}

+(instancetype)emailFieldWithID:(NSString *)_id title:(NSString *)title {
    return [self emailFieldWithID:_id title:title width:50];
}

+(instancetype)checkBoxFieldWithID:(NSString *)_id title:(NSString *)title values:(NSArray *)values {
    return [self checkBoxFieldWithID:_id title:title values:values  height:1 validation:[GMFormJsonValidation withRequired:YES]];
}

+(instancetype)checkBoxFieldWithID:(NSString *)_id title:(NSString *)title values:(NSArray *)values height:(CGFloat)height {
    return [self checkBoxFieldWithID:_id title:title values:values  height:height validation:[GMFormJsonValidation withRequired:YES]];
}

+(instancetype)checkBoxFieldWithID:(NSString *)_id title:(NSString *)title values:(NSArray *)values width:(CGFloat)width {
    return [self checkBoxFieldWithID:_id title:title values:values  height:1 validation:[GMFormJsonValidation withRequired:YES]];
}

+(instancetype)checkBoxFieldWithID:(NSString *)_id title:(NSString *)title values:(NSArray *)values  height:(CGFloat)height validation:(GMFormJsonValidation*)validate {
   
         return [GMFormJsonField fieldWithID:_id title:title type:@"checkbox" size:[GMFormJsonSize sizeWithWidth:100 height:height] validation:validate values:values];
    
}

+(instancetype)radioButtonFieldWithID:(NSString *)_id title:(NSString *)title values:(NSArray *)values height:(CGFloat)height {
    return [self radioButtonFieldWithID:_id title:title values:values width:100 height:height validation:[GMFormJsonValidation withRequired:YES]];
}

+(instancetype)radioButtonFieldWithID:(NSString *)_id title:(NSString *)title values:(NSArray *)values width:(CGFloat)width {
    return [self radioButtonFieldWithID:_id title:title values:values width:width height:1.55 validation:[GMFormJsonValidation withRequired:YES]];
}

+(instancetype)radioButtonFieldWithID:(NSString *)_id title:(NSString *)title values:(NSArray *)values width:(CGFloat)width height:(CGFloat)height validation:(GMFormJsonValidation*)validate{
    return [GMFormJsonField fieldWithID:_id title:title type:@"radiobutton" size:[GMFormJsonSize sizeWithWidth:width height:height] validation:validate values:values];
}

+(instancetype)signatureFieldsWithID:(NSString *)_id title:(NSString *)title
{
    return [self signatureFieldsWithID:_id title:title height:3.0];

}
+(instancetype)ratingFieldsWithID:(NSString *)_id title:(NSString *)title;
{
     return [GMFormJsonField fieldWithID:_id title:title type:@"rating" size:[GMFormJsonSize sizeWithWidth:100 height:1.0] validation:[GMFormJsonValidation withRequired:NO]];
}
+(instancetype)signatureFieldsWithID:(NSString *)_id title:(NSString *)title height:(CGFloat)height
{
    return [GMFormJsonField fieldWithID:_id title:title type:@"signature" size:[GMFormJsonSize sizeWithWidth:100 height:height] validation:[GMFormJsonValidation withRequired:true ]];
    
}

@end
