//
//  AppointmentsTableViewCell.h
//  Lemon and honey Intake form App
//
//  Created by Gurie on 21/03/17.
//  Copyright © 2017 Gurie. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface AppointmentsTableViewCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UILabel *labelName;
@property (weak, nonatomic) IBOutlet UILabel *labelEmployeeName;
@property (weak, nonatomic) IBOutlet UILabel *labelServiceName;
@property (weak, nonatomic) IBOutlet UILabel *labelTime;

@end
