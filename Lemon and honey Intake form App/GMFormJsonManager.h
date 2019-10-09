//
//  GMFormJsonManager.h
//  Lemon and honey Intake form App
//
//  Created by Gurpreet Singh on 23/02/17.
//  Copyright © 2017 Gurie. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "GMForm.h"

@interface GMFormJsonManager : NSObject

+(GMForm *)electronicGuestIntakeForm:(BOOL)isStylist;
+(GMForm *)membershipAgreement:(BOOL)isStylist;
+(GMForm *)SpaRemedeasePrograms:(BOOL)isStylist;
+(GMForm *)clientConsultationForm:(BOOL)isStylist;
@end

