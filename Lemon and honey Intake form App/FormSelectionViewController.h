//
//  SearchClientViewController.h
//  Lemon and honey Intake form App
//
//  Created by Gurie on 14/02/17.
//  Copyright © 2017 Gurie. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface FormSelectionViewController : UIViewController<UIAlertViewDelegate>

@property (weak, nonatomic) IBOutlet UIView *viewLogout;
@property (weak, nonatomic) IBOutlet UILabel *labelClientName;
@property (weak, nonatomic) IBOutlet UIButton *guestButton,*clientSwitchButton;//ClientName;
@property (weak, nonatomic) IBOutlet UIButton *memebershipButton;//ClientName;
@property (weak, nonatomic) IBOutlet UIButton *programsButton;//ClientName;
@property (weak, nonatomic) IBOutlet UIButton *buttonGuestConsultation;

-(IBAction)actionSwitchClientButton:(id)sender;
@end
