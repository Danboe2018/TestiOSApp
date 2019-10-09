//
//  FormField.m
//
//  Created by Gurpreet Mundi on 16/12/16
//  Copyright (c) 2016 Soft Scouts, Phase 8b, Mohali. All rights reserved.
//

#import "FormFieldObject.h"
#import "NSDictionary+Additions.h"
#import "HelperFunctions.h"

NSString *const kFormFieldFormSalonFieldLabel = @"form_salon_field_label";
NSString *const kFormFieldFormSalonFieldId = @"form_salon_field_id";
NSString *const kFormFieldSalonFormId = @"salon_form_id";
NSString *const kFormFieldFormSalonFieldName = @"form_salon_field_name";
NSString *const kFormFieldFormSalonFieldParentId = @"form_salon_field_parent_id";


@interface FormFieldObject ()

- (id)objectOrNilForKey:(id)aKey fromDictionary:(NSDictionary *)dict;

@end

@implementation FormFieldObject

@synthesize formSalonFieldLabel = _formSalonFieldLabel;
@synthesize formSalonFieldId = _formSalonFieldId;
@synthesize salonFormId = _salonFormId;
@synthesize formSalonFieldName = _formSalonFieldName;
@synthesize formSalonFieldParentId = _formSalonFieldParentId;


+ (instancetype)modelObjectWithDictionary:(NSDictionary *)dict
{
    return [[self alloc] initWithDictionary:dict];
}

- (instancetype)initWithDictionary:(NSDictionary *)dict
{
    self = [super init];
    
    // This check serves to make sure that a non-NSDictionary object
    // passed into the model class doesn't break the parsing.
    if(self && [dict isKindOfClass:[NSDictionary class]]) {
            self.formSalonFieldLabel = [self objectOrNilForKey:kFormFieldFormSalonFieldLabel fromDictionary:dict];
            self.formSalonFieldId = [self objectOrNilForKey:kFormFieldFormSalonFieldId fromDictionary:dict];
            self.salonFormId = [self objectOrNilForKey:kFormFieldSalonFormId fromDictionary:dict];
            self.formSalonFieldName = [self objectOrNilForKey:kFormFieldFormSalonFieldName fromDictionary:dict];
            self.formSalonFieldParentId = [self objectOrNilForKey:kFormFieldFormSalonFieldParentId fromDictionary:dict];

    }
    
    return self;
    
}

- (NSDictionary *)dictionaryRepresentation
{
    NSMutableDictionary *mutableDict = [NSMutableDictionary dictionary];
    [mutableDict setValue:self.formSalonFieldLabel forKey:kFormFieldFormSalonFieldLabel];
    [mutableDict setValue:self.formSalonFieldId forKey:kFormFieldFormSalonFieldId];
    [mutableDict setValue:self.salonFormId forKey:kFormFieldSalonFormId];
    [mutableDict setValue:self.formSalonFieldName forKey:kFormFieldFormSalonFieldName];
    [mutableDict setValue:self.formSalonFieldParentId forKey:kFormFieldFormSalonFieldParentId];

    return [NSDictionary dictionaryWithDictionary:mutableDict];
}

- (NSString *)description 
{
    return [NSString stringWithFormat:@"%@", [self dictionaryRepresentation]];
}

#pragma mark - Helper Method
- (id)objectOrNilForKey:(id)aKey fromDictionary:(NSDictionary *)dict
{
    id object = [dict objectForKey:aKey];
    return [object isEqual:[NSNull null]] ? nil : object;
}


#pragma mark - NSCoding Methods

- (id)initWithCoder:(NSCoder *)aDecoder
{
    self = [super init];

    self.formSalonFieldLabel = [aDecoder decodeObjectForKey:kFormFieldFormSalonFieldLabel];
    self.formSalonFieldId = [aDecoder decodeObjectForKey:kFormFieldFormSalonFieldId];
    self.salonFormId = [aDecoder decodeObjectForKey:kFormFieldSalonFormId];
    self.formSalonFieldName = [aDecoder decodeObjectForKey:kFormFieldFormSalonFieldName];
    self.formSalonFieldParentId = [aDecoder decodeObjectForKey:kFormFieldFormSalonFieldParentId];
    return self;
}

- (void)encodeWithCoder:(NSCoder *)aCoder
{

    [aCoder encodeObject:_formSalonFieldLabel forKey:kFormFieldFormSalonFieldLabel];
    [aCoder encodeObject:_formSalonFieldId forKey:kFormFieldFormSalonFieldId];
    [aCoder encodeObject:_salonFormId forKey:kFormFieldSalonFormId];
    [aCoder encodeObject:_formSalonFieldName forKey:kFormFieldFormSalonFieldName];
    [aCoder encodeObject:_formSalonFieldParentId forKey:kFormFieldFormSalonFieldParentId];
}

- (id)copyWithZone:(NSZone *)zone
{
    FormFieldObject *copy = [[FormFieldObject alloc] init];
    
    if (copy) {

        copy.formSalonFieldLabel = [self.formSalonFieldLabel copyWithZone:zone];
        copy.formSalonFieldId = [self.formSalonFieldId copyWithZone:zone];
        copy.salonFormId = [self.salonFormId copyWithZone:zone];
        copy.formSalonFieldName = [self.formSalonFieldName copyWithZone:zone];
        copy.formSalonFieldParentId = [self.formSalonFieldParentId copyWithZone:zone];
    }
    
    return copy;
}

-(NSDictionary *)parseWith:(NSDictionary *)dic {
    if ([dic objectForKey:self.formSalonFieldName]) {

        id value = [dic objectForKey:self.formSalonFieldName];
        
        if ([value isKindOfClass:[NSArray class]]) {
            value = [(NSArray *)value componentsJoinedByString:@","];
        }
        
        if ([value isKindOfClass:[NSDate class]]) {
            value = stringFromDate(value, @"yyyy-MM-dd");
        }
        
        return [NSDictionary dicWithFieldId:self.formSalonFieldId fieldName:value];
    }
    return [NSDictionary dicWithFieldId:self.formSalonFieldId fieldName:@""];
}

-(NSDictionary *)parseWithName:(NSDictionary *)dic {
    if ([dic objectForKey:@"form_field_value"]) {
        
        id value = [dic objectForKey:@"form_field_value"];
        
        if ([value isKindOfClass:[NSArray class]]) {
            value = [(NSArray *)value componentsJoinedByString:@","];
        }
        
        if ([self.formSalonFieldName isEqualToString:@"date"])
        {
            value = dateFromString(value, @"yyyy-MM-dd");
        }
        
        return [NSDictionary dicWithFieldName:self.formSalonFieldName fieldName:value];
    }
    return [NSDictionary dicWithFieldName:self.formSalonFieldName fieldName:@""];
}


@end
