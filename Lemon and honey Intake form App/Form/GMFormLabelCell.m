//
//  GMFormTextFieldCell.m
//  Lemon and honey Intake form App
//
//  Created by Gurpreet Singh on 24/02/17.
//  Copyright © 2017 Gurie. All rights reserved.
//

#import "GMFormLabelCell.h"

@implementation GMFormLabelCell

-(UILabel *)headingLabel {
    UILabel * label = [super headingLabel];
    label.numberOfLines = 0;
    label.font = [UIFont systemFontOfSize:24];
    return label;
}

- (CGRect)headingLabelFrame {
    
    CGFloat marginX = 15;
    CGFloat marginTop = 10;
    
    CGFloat width = CGRectGetWidth(self.frame) - (marginX * 2);
    CGFloat height = self.bounds.size.height - (marginTop * 2);
    CGRect frame = CGRectMake(marginX, marginTop, width, height);
    
    return frame;
}

@end
