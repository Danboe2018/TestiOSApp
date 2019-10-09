 //
//  NSObject+JsonParsing.m
//  DealOfTheTown
//
//  Created by Gurpreet Singh on 25/05/15.
//  Copyright (c) 2015 Gurpreet Singh. All rights reserved.
//

#import "NSObject+JsonParsing.h"

@implementation NSObject (JsonParsing)

- (NSDictionary *)JSONKeyTranslationDictionary
{
    return @{@"id" : @"objectId"
             };
}

-(void)updateFromDictionary:(NSDictionary*)dictionary
{
    for (NSString * key in dictionary)
    {
        NSString * mappedKey = key;
        NSDictionary* mappedDictionary = [self JSONKeyTranslationDictionary];

        if ([mappedDictionary objectForKey:key])
        {
            mappedKey = mappedDictionary[key];
        }
        
        NSString * value = dictionary[key];
        if ([self respondsToSelector:NSSelectorFromString(mappedKey)]) {
            [self setValue:value forKey:mappedKey];
        }
    }
}

@end
