//
//  GMRadioButtonFormFieldCollectionViewCell.m
//  Intake form App
//
//  Created by Gurpreet Singh on 05/12/17.
//  Copyright © 2017 Gurie. All rights reserved.
//

#import "GMRadioButtonFormFieldCollectionViewCell.h"
#import "AppDelegate.h"
@implementation GMRadioButtonFormFieldCollectionViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
    self.backgroundColor = [UIColor clearColor];
    self.radioButton.delegate = self;
}

-(void)setValue:(FORMFieldValue *)value {
    _value = value;
    
    self.label.text = value.title;
    self.label.numberOfLines = 0;
}
-(void)radioButton:(RadioButton *)button selected:(BOOL)seleted {
    if (self.delegate) {
        [self.delegate fieldValue:self.value selected:seleted];
    }
}

- (IBAction)buttonClickAction:(id)sender {
    if ([kApppDelegate.stringClass isEqualToString:@"history"]) {
        return;
    }
    [self.radioButton toggle];
}

@end

