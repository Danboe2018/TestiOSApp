//
//  AWSManager.h
//  IntakeForm
//
//  Created by Gurpreet Singh on 16/01/17.
//  Copyright © 2017 WebAppClouds. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <AWSS3/AWSS3.h>

@interface AWSManager : NSObject

@property (nonatomic, copy) void (^finishBlock)(NSArray * uploaded, NSArray *failed);
@property (nonatomic, copy) void (^progressBlock)(NSInteger uploaded, NSInteger failed, NSInteger total);

+(instancetype)sharedManager;

-(void)queueImages:(NSArray *)images;
-(void)uploadImages:(NSArray *)images;
-(void)startUploading;

@end

@interface AWSImageObject : NSObject

@property (nonatomic,retain)NSString *identifier;
@property (nonatomic,retain)UIImage *image;
@property (nonatomic,retain)NSString *imageUrl;
@property (nonatomic,assign)BOOL completed;
@property (nonatomic,retain)NSError *uploadError;
@property (nonatomic,assign)NSInteger retries;

+(instancetype)withImage:(UIImage *)image identifier:(NSString *)identifier;

@end
