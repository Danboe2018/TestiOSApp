//
//  ViewController.h
//  Lemon and honey Intake form App
//
//  Created by Gurie on 14/02/17.
//  Copyright © 2017 Gurie. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ACFloatingTextField.h"
#import "CheckBoxButton.h"
typedef enum FormType
{
    FormTypeCustomerIntake,
    FormTypeWellnessMembership,
    FormTypeWaxConsultations,
    FormTypeSearchClient,
    FormTypeSearchAppointments,
    FormTypeAddNewClient,
    FormTypeUpdateClient
}FormType;

@interface ViewController : UIViewController<CheckBoxButtonDelegate>

@property (weak, nonatomic) IBOutlet UITextField *textFieldEmail;
@property (weak, nonatomic) IBOutlet UITextField *textFieldPassword;
@property (weak, nonatomic) IBOutlet UITextField *textFieldSalonId;
@property (weak, nonatomic) IBOutlet UIView *viewLogin;
@property (weak, nonatomic) IBOutlet CheckBoxButton *buttonCheck;

@end

