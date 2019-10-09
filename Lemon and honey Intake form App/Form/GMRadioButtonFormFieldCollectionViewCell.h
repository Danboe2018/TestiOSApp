//
//  GMRadioButtonFormFieldCollectionViewCell.h
//  Intake form App
//
//  Created by Gurpreet Singh on 05/12/17.
//  Copyright © 2017 Gurie. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "RadioButton.h"
#import "FORMFieldValue.h"

@protocol GMRadioButtonFormFieldCollectionViewCellDelegate;

@interface GMRadioButtonFormFieldCollectionViewCell : UICollectionViewCell <RadioButtonDelegate>

@property (weak, nonatomic) IBOutlet RadioButton *radioButton;
@property (weak, nonatomic) IBOutlet UILabel *label;
@property (retain, nonatomic) FORMFieldValue *value;
@property (retain, nonatomic) id<GMRadioButtonFormFieldCollectionViewCellDelegate> delegate;

- (IBAction)buttonClickAction:(id)sender;
@end

@protocol GMRadioButtonFormFieldCollectionViewCellDelegate <NSObject>

-(void)fieldValue:(FORMFieldValue *)value selected:(BOOL)seleted;

@end

