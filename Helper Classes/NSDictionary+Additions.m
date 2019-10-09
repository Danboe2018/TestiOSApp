//
//  NSDictionary+Additions.m
//  IntakeForm
//
//  Created by Gurpreet Singh on 28/12/16.
//  Copyright © 2016 WebAppClouds. All rights reserved.
//

#import "NSDictionary+Additions.h"

@implementation NSDictionary (Additions)

-(NSString*)jsonString{
    NSError *error;
    NSData *jsonData = [NSJSONSerialization dataWithJSONObject:self
                                                       options:NSJSONWritingPrettyPrinted
                                                         error:&error];
    
    if (! jsonData) {
        NSLog(@"json string: error: %@", error.localizedDescription);
        return @"{}";
    } else {
        return [[NSString alloc] initWithData:jsonData encoding:NSUTF8StringEncoding];
    }
}

-(id)value:(NSString *)key
{
    if (self[key])
    {
        if ([self[key] isKindOfClass:[NSNumber class]])
        {
            return [NSString stringWithFormat:@"%@",self[key]];
        }
        
        if (![self[key] isKindOfClass:[NSNull class]])
        {
            return self[key];
        }
    }
    
    return @"";
}

-(id)value:(NSString *)key default:(id)d
{
    if (self[key])
    {
        if ([self[key] isKindOfClass:[NSNumber class]])
        {
            return [NSString stringWithFormat:@"%@",self[key]];
        }
        
        if (![self[key] isKindOfClass:[NSNull class]])
        {
            if ([self[key] isKindOfClass:[NSString class]])
            {
                if ([self[key] length] == 0)
                {
                    return d;
                }
                return self[key];
            }else
            {
                return self[key];
            }
        }
    }
    
    return d;
}

+(NSDictionary *)dicWithFieldId:(NSString *)formSalonFieldId fieldName:(NSString *)formSalonFieldName {
    return @{@"form_field_id":formSalonFieldId, @"form_field_value":formSalonFieldName};
}
+(NSDictionary *)dicWithFieldName:(NSString *)formSalonFieldId fieldName:(NSString *)formSalonFieldName {
    return @{@"form_salon_field_name":formSalonFieldId, @"form_field_value":formSalonFieldName};
}

@end
