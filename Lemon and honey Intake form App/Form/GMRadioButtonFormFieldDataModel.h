//
//  GMCheckBoxFormFieldDataModel.h
//  Lemon and honey Intake form App
//
//  Created by Gurpreet Singh on 23/02/17.
//  Copyright © 2017 Gurie. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
#import "FORMField.h"

@protocol GMRadioButtonFormFieldDataModelDelegate;

@interface GMRadioButtonFormFieldDataModel : NSObject <UICollectionViewDelegate, UICollectionViewDataSource>

@property (nonatomic, assign) id<GMRadioButtonFormFieldDataModelDelegate> delegate;
@property (nonatomic, assign) FORMField *field;
+(instancetype)modelFor:(UICollectionView *)collectionView;

@end

@protocol GMRadioButtonFormFieldDataModelDelegate <NSObject>

-(void)dataUpdatesDoneFor:(GMRadioButtonFormFieldDataModel *)model;

@end
