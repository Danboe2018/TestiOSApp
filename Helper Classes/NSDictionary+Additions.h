//
//  NSDictionary+Additions.h
//  IntakeForm
//
//  Created by Gurpreet Singh on 28/12/16.
//  Copyright © 2016 WebAppClouds. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSDictionary (Additions)

-(NSString*)jsonString;

-(id)value:(NSString *)key;
-(id)value:(NSString *)key default:(id)d;

+(NSDictionary *)dicWithFieldId:(NSString *)formSalonFieldId fieldName:(NSString *)formSalonFieldName;
+(NSDictionary *)dicWithFieldName:(NSString *)formSalonFieldId fieldName:(NSString *)formSalonFieldName;
@end
