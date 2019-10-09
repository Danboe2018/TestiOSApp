//
//  GMFormDisabledTextFieldCell.m
//  Intake form App
//
//  Created by Gurie on 20/12/17.
//  Copyright © 2017 Gurie. All rights reserved.
//

#import "GMFormDisabledTextFieldCell.h"

@implementation GMFormDisabledTextFieldCell

-(FORMTextField *)textField {
    FORMTextField * field = [super textField];
    field.enabled = false;
    return field;
}

@end
