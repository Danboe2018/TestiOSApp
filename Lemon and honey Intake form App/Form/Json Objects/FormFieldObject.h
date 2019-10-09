//
//  FormField.h
//
//  Created by Gurpreet Mundi on 16/12/16
//  Copyright (c) 2016 Soft Scouts, Phase 8b, Mohali. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface FormFieldObject : NSObject <NSCoding, NSCopying>

@property (nonatomic, strong) NSString *formSalonFieldLabel;
@property (nonatomic, strong) NSString *formSalonFieldId;
@property (nonatomic, strong) NSString *salonFormId;
@property (nonatomic, strong) NSString *formSalonFieldName;
@property (nonatomic, strong) NSString *formSalonFieldParentId;

+ (instancetype)modelObjectWithDictionary:(NSDictionary *)dict;
- (instancetype)initWithDictionary:(NSDictionary *)dict;
- (NSDictionary *)dictionaryRepresentation;

//--
-(NSDictionary *)parseWith:(NSDictionary *)dic;
-(NSDictionary *)parseWithName:(NSDictionary *)dic;

@end
