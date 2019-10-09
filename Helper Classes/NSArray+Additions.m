//
//  NSArray+Additions.m
//  IntakeForm
//
//  Created by Gurpreet Singh on 28/12/16.
//  Copyright © 2016 WebAppClouds. All rights reserved.
//

#import "NSArray+Additions.h"

@implementation NSArray (Additions)

-(NSString*)jsonString{
    NSError *error;
    NSData *jsonData = [NSJSONSerialization dataWithJSONObject:self
                                                       options:NSJSONWritingPrettyPrinted
                                                         error:&error];
    
    if (! jsonData) {
        NSLog(@"json string: error: %@", error.localizedDescription);
        return @"[]";
    } else {
        return [[NSString alloc] initWithData:jsonData encoding:NSUTF8StringEncoding];
    }
}

@end
