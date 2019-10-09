//
//  NSObject+JsonParsing.h
//  DealOfTheTown
//
//  Created by Gurpreet Singh on 25/05/15.
//  Copyright (c) 2015 Gurpreet Singh. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSObject (JsonParsing)

- (NSDictionary *)JSONKeyTranslationDictionary;
- (void)updateFromDictionary:(NSDictionary*)dictionary;

@end
