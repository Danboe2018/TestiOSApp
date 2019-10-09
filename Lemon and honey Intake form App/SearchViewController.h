//
//  SearchViewController.h
//  Lemon and honey Intake form App
//
//  Created by Gurie on 02/03/17.
//  Copyright © 2017 Gurie. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "XLForm.h"

@interface SearchViewController : XLFormViewController<XLFormValidatorProtocol, XLFormRowDescriptorViewController>

@property (nonatomic, strong) NSString * searchBy;
@end

typedef enum GMRuleActionType{
    ActionTypeShow
}GMRuleActionType;


@interface GMRule : NSObject

@property (nonatomic, retain) XLFormRowDescriptor * rowDepend;
@property (nonatomic, retain) id ifValueIs;
@property (nonatomic, assign) GMRuleActionType actionType;

+(instancetype)showRow:(XLFormRowDescriptor *)row ifValueIs:(id)value;

@end

@interface GMFormRowDescriptor : XLFormRowDescriptor

@property (nonatomic, retain) GMRule * rule;

-(void)applyRule;

@end
