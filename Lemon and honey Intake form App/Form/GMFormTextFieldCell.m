//
//  GMFormTextFieldCell.m
//  Lemon and honey Intake form App
//
//  Created by Gurpreet Singh on 24/02/17.
//  Copyright © 2017 Gurie. All rights reserved.
//

#import "GMFormTextFieldCell.h"

@implementation GMFormTextFieldCell

-(UILabel *)headingLabel {
    UILabel * label = [super headingLabel];
    label.numberOfLines = 0;
    label.font = [UIFont systemFontOfSize:18];
    return label;
}
- (CGRect)headingLabelFrame {
    
    CGFloat marginX = 15;
    CGFloat marginTop = 10;
    
    CGFloat width = CGRectGetWidth(self.frame) - (marginX * 2);
    CGFloat height = [self heightForText:self.field.title maxWidth:width - 10];
    CGRect frame = CGRectMake(marginX, marginTop, width, height);
    
    return frame;
}

- (CGRect)textFieldFrame {
    
    CGFloat marginX = FORMTextFieldCellMarginX;
    CGFloat marginTop = [self headingLabelFrame].origin.y + [self headingLabelFrame].size.height;
    CGFloat marginBotton = FORMFieldCellMarginBottom;
    
    CGFloat width  = CGRectGetWidth(self.frame) - (marginX * 2);
    CGFloat height = CGRectGetHeight(self.frame) - marginTop - marginBotton;
    CGRect  frame  = CGRectMake(marginX, marginTop, width, height);
    
    return frame;
}

-(CGFloat)heightForText:(NSString *)text maxWidth:(CGFloat)width {
    
    CGSize constraint = CGSizeMake(width, 20000.0f);
    CGSize size = [text sizeWithFont:[UIFont systemFontOfSize:17] constrainedToSize:constraint lineBreakMode:UILineBreakModeWordWrap];
    return size.height;
}

@end
