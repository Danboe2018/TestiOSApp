//
//  AWSManager.m
//  IntakeForm
//
//  Created by Gurpreet Singh on 16/01/17.
//  Copyright © 2017 WebAppClouds. All rights reserved.
//

#import "AWSManager.h"
#import "Constants.h"

@interface AWSManager()

@property (nonatomic, retain) NSMutableArray * imagesToUpload;
@property (nonatomic, retain) NSMutableArray * imagesUploaded;
@property (nonatomic, retain) NSMutableArray * imagesFailed;
@property (nonatomic, retain) AWSImageObject * currentUploading;
@property (nonatomic, readonly) BOOL isUploadingFiles;

@end

@implementation AWSManager

//--

+(instancetype)sharedManager {
    static AWSManager * manager = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        manager = [AWSManager new];
    });
    return manager;
}

//--

-(BOOL)isIsUploadingFiles {
    return (self.currentUploading);
}

-(NSMutableArray *)imagesToUpload {
    if (!_imagesToUpload) {
        _imagesToUpload = [NSMutableArray new];
    }
    return _imagesToUpload;
}
-(NSMutableArray *)imagesUploaded {
    if (!_imagesUploaded) {
        _imagesUploaded = [NSMutableArray new];
    }
    return _imagesUploaded;
}
-(NSMutableArray *)imagesFailed {
    if (!_imagesFailed) {
        _imagesFailed = [NSMutableArray new];
    }
    return _imagesFailed;
}

//--

-(void)queueImages:(NSArray *)images {
    [self.imagesToUpload addObjectsFromArray:images];
}

-(void)uploadImages:(NSArray *)images {
    if (_imagesUploaded) {
        _imagesUploaded = [NSMutableArray new];
    }

    [self.imagesToUpload addObjectsFromArray:images];
    [self startUploading];
}

-(void)uploadcompleted:(AWSImageObject *)imageObj {
    if (!_imagesUploaded) {
        _imagesUploaded = [NSMutableArray new];
    }

    [self.imagesUploaded addObject:imageObj];
    [self.imagesToUpload removeObject:imageObj];
}

-(void)uploadFailed:(AWSImageObject *)imageObj {
    [self.imagesFailed addObject:imageObj];
    [self.imagesToUpload removeObject:imageObj];
}

-(void)startUploading {
    if (self.imagesToUpload.count) {
        [self uploadImage:self.imagesToUpload.firstObject];
    }else {
        [self finishUploading];
    }
}

-(void)continueUploading {
    
    if (self.currentUploading.completed) {
        [self uploadcompleted:self.currentUploading];
    }else if (self.currentUploading.retries < 5) {
        self.currentUploading.retries += 1;
    }else {
        [self uploadFailed:self.currentUploading];
    }
    
    //--
    
    if (self.progressBlock) {
        self.progressBlock(self.imagesUploaded.count, self.imagesFailed.count, self.imagesUploaded.count + self.imagesFailed.count);
    }
    
    //--
    
    if (self.imagesToUpload.count) {
        self.currentUploading = self.imagesToUpload.firstObject;
        [self uploadImage:self.currentUploading];
    }else {
        [self finishUploading];
    }
}

-(void)finishUploading {
    self.currentUploading = nil;
    
    if (self.finishBlock) {
     self.finishBlock(self.imagesUploaded, self.imagesFailed);
    }
}

-(void)uploadImage:(AWSImageObject *)imageObj {
    
    self.currentUploading = imageObj;
    
    NSString *fileName = [[[NSProcessInfo processInfo] globallyUniqueString] stringByAppendingString:@".png"];
    NSString *filePath = [NSTemporaryDirectory() stringByAppendingPathComponent:fileName];
    NSData * imageData = UIImagePNGRepresentation(imageObj.image);
    
    [imageData writeToFile:filePath atomically:YES];
    
    AWSS3TransferManagerUploadRequest *uploadRequest = [AWSS3TransferManagerUploadRequest new];
    uploadRequest.body = [NSURL fileURLWithPath:filePath];
    uploadRequest.key = fileName;
    uploadRequest.bucket = S3BucketName;
    uploadRequest.ACL = AWSS3BucketCannedACLPublicRead;
    
    AWSS3TransferManager *transferManager = [AWSS3TransferManager defaultS3TransferManager];
    
    [[transferManager upload:uploadRequest] continueWithBlock:^id(AWSTask *task) {
        
        if (task.error) {
            imageObj.uploadError = task.error;
            imageObj.completed = false;
        }
        
        if (task.result) {
            dispatch_async(dispatch_get_main_queue(), ^{
                NSLog(@"Upload Done: %@%@", ServerBaseUrl, uploadRequest.key);
                imageObj.completed = true;
                imageObj.imageUrl = [ServerBaseUrl stringByAppendingString:uploadRequest.key];
            });
        }
        
        [self continueUploading];
        
        return nil;
    }];
}


-(void)uploadImageToAWWS:(UIImage *)image block:(void(^)(BOOL success, NSString * serverUrl))handler {
    
    NSString *fileName = [[[NSProcessInfo processInfo] globallyUniqueString] stringByAppendingString:@".png"];
    NSString *filePath = [NSTemporaryDirectory() stringByAppendingPathComponent:fileName];
    NSData * imageData = UIImagePNGRepresentation(image);
    
    [imageData writeToFile:filePath atomically:YES];
    
    AWSS3TransferManagerUploadRequest *uploadRequest = [AWSS3TransferManagerUploadRequest new];
    uploadRequest.body = [NSURL fileURLWithPath:filePath];
    uploadRequest.key = fileName;
    uploadRequest.bucket = S3BucketName;
    uploadRequest.ACL = AWSS3BucketCannedACLPublicRead;
    
    AWSS3TransferManager *transferManager = [AWSS3TransferManager defaultS3TransferManager];
    
    [[transferManager upload:uploadRequest] continueWithBlock:^id(AWSTask *task) {
        
        if (task.error) {
            if ([task.error.domain isEqualToString:AWSS3TransferManagerErrorDomain]) {
                switch (task.error.code) {
                    case AWSS3TransferManagerErrorCancelled:
                    case AWSS3TransferManagerErrorPaused:
                    {
                        dispatch_async(dispatch_get_main_queue(), ^{
                            
                        });
                    }
                        break;
                        
                    default:
                        NSLog(@"Upload failed: [%@]", task.error);
                        break;
                }
            } else {
                NSLog(@"Upload failed: [%@]", task.error);
            }
            
            handler(false,nil);
        }
        
        if (task.result) {
            dispatch_async(dispatch_get_main_queue(), ^{
                
                NSLog(@"Upload Done: %@%@", ServerBaseUrl, uploadRequest.key);
                handler(true,[ServerBaseUrl stringByAppendingString:uploadRequest.key]);
            });
        }
        
        return nil;
    }];
}


@end

@implementation AWSImageObject

+(instancetype)withImage:(UIImage *)image identifier:(NSString *)identifier {
    AWSImageObject * obj = [AWSImageObject new];
    obj.image = image;
    obj.identifier = identifier;
    return obj;
}

@end
