//
//  GMFormJsonManager.m
//  Lemon and honey Intake form App
//
//  Created by Gurpreet Singh on 23/02/17.
//  Copyright © 2017 Gurie. All rights reserved.
//

#import "GMFormJsonManager.h"
#import "Constants.h"
#import "AppDelegate.h"
@implementation GMFormJsonManager

+(GMForm *)SpaRemedeasePrograms:(BOOL)isStylist{
    GMForm * form = [GMForm new];
    form.name = @"Spa Remedease Programs";
    form.formName = FNSpaRemedeForm;
    BOOL isHistory = ([KappDelegate.stringClass isEqualToString:@"history"]);

    NSMutableArray * groups = [NSMutableArray new];
    NSMutableArray * sections = [NSMutableArray new];
    NSMutableArray * fields = [NSMutableArray new];
    
    
    [fields addObject:[GMFormJsonField labelFieldWithID:@"Spa Remedease" title:@"Spa Remedease has prepared several programs to help you with nagging skin and body conditions. The programs are designed to be more frequent visits accompanied by home care program to help you with any inflammatory skin conditions, again of your skin or chronic pain.(insert drop down box with the following options: Clear Skin, Radian Skin, Pain Free; after guest selects their program they want the text below corresponding to each program comes up)"
                                                 height:3.2]];
    
    
    [fields addObject:[GMFormJsonField labelFieldWithID:@"CLEAR SKIN" title:@"CLEAR SKIN (inflammatory skin conditions)\n\nHolistic program that addresses causes of inflammatory skin conditions inside and out. You will experience dramatic improvement in the clarity of your skin. While participating in the program, you will learn how to care for it at home as well as how diet and stress impact it.\nProgram consists of:\nmedi facials\nLED sessions\nbefore and after digital skin analysis\ncustomized home skin care routine\nTotal Value: $1,270 \n payments of $359"
                                                 height:5.2]];
    
    [fields addObject:[GMFormJsonField labelFieldWithID:@"RADIANT SKIN" title:@"RADIANT SKIN (graceful aging skin care program)\n\nAging is inevitable however you have more control over how you age than you probably realize. This program is focused specifically on helping you manage the aging process of your skin with gentle yet effective techniques. Skin analysis with printed reports at the beginning and end of the program will help you see your progress.\nProgram consists of:\ndermal infusions treatments\nrevitalize micro needling pen treatments\nled sessions\nbefore and after digital skin analysis\ncustomized home skin care routine\nTotal Value: $1,052\npayments of $299"
                                                 height:5.3]];
    
    
    [fields addObject:[GMFormJsonField labelFieldWithID:@"RADIANT SKIN" title:@"PAIN FREE (pain management, improved mobility)\nWhether you are suffering from chronic pain or regular aches and pains, our cocktail of life affirming treatments are designed with one thing in mind - decreasing your pain.\nProgram consists of:\narnica massage sessions with infrared heat\ncustomized take home pain relief products\nTotal Value: $1,010\npayments of $279"
                                                 height:4.0]];
    
    
    
    
    
    [fields addObject:[GMFormJsonField labelFieldWithID:@"Can I let someone else use it" title:@"Can I let someone else use it?\n\nNo, programs are design to help you with a specific concern and are not meant to be shared. In case of unforeseen circumstances, the monetary value paid for a program can be redeemed for other services."
                                                 height:2.4]];
    [fields addObject:[GMFormJsonField labelFieldWithID:@"How do I pay?"  title:@"How do I pay?\n\nFor a hassle-free experience, we set up automated credit card or bank account deduction for your three payments" height:1.7]];
    
    (isHistory)?[fields addObject:[GMFormJsonField textFieldWithID:@"Program Start Date" title:@"Program Start Date:"width:50]]:[fields addObject:[GMFormJsonField dateFieldWithID:@"Program Start Date" title:@"Program Start Date:" width:50]];

    (isHistory)?[fields addObject:[GMFormJsonField textFieldWithID:@"1st Payment Date" title:@"1st Payment Date:"width:50]]:[fields addObject:[GMFormJsonField dateFieldWithID:@"1st Payment Date" title:@"1st Payment Date:" width:50]];

    (isHistory)?[fields addObject:[GMFormJsonField textFieldWithID:@"2nd Payment Date" title:@"2nd Payment Date:"width:50]]:[fields addObject:[GMFormJsonField dateFieldWithID:@"2nd Payment Date" title:@"2nd Payment Date:" width:50]];

    (isHistory)?[fields addObject:[GMFormJsonField textFieldWithID:@"3rd Payment Date" title:@"3rd Payment Date:"width:50]]:[fields addObject:[GMFormJsonField dateFieldWithID:@"3rd Payment Date" title:@"3rd Payment Date:" width:50]];

    
    
    [fields addObject:[GMFormJsonField textFieldWithID:@"Processed by" title:@"Processed by:"]];
    [fields addObject:[GMFormJsonField textFieldWithID:@"Name" title:@"Name:"]];
    [fields addObject:[GMFormJsonField textFieldWithID:@"Address" title:@"Address:"]];
    [fields addObject:[GMFormJsonField textFieldWithID:@"City" title:@"City:"]];
    [fields addObject:[GMFormJsonField textFieldWithID:@"State" title:@"State:"]];
    (isHistory)?[fields addObject:[GMFormJsonField textFieldWithID:@"Zip" title:@"Zip:"width:50]]:[fields addObject:[GMFormJsonField textFieldWithID:@"Zip" title:@"Zip:"]];

    [fields addObject:[GMFormJsonField textFieldWithID:@"Email address" title:@"Email address:"]];
    (isHistory)?[fields addObject:[GMFormJsonField textFieldWithID:@"Date of Birth" title:@"Date of Birth:"width:50]]:[fields addObject:[GMFormJsonField dateFieldWithID:@"Date of Birth" title:@"Date of Birth:" width:50]];

    (isHistory)?[fields addObject:[GMFormJsonField textFieldWithID:@"Cell Phone" title:@"Cell Phone:"width:50]]:[fields addObject:[GMFormJsonField numberFieldWithID:@"Cell Phone" title:@"Cell Phone:"]];

    [fields addObject:[GMFormJsonField textFieldWithID:@"Emergency Contact" title:@"Emergency Contact's Name:"]];
    [fields addObject:[GMFormJsonField textFieldWithID:@"Relationship" title:@"Relationship:"]];
    (isHistory)?[fields addObject:[GMFormJsonField textFieldWithID:@"Phone" title:@"Emergency Contact Number:"width:50]]:[fields addObject:[GMFormJsonField numberFieldWithID:@"Phone" title:@"Emergency Contact Number:"]];

    [fields addObject:[GMFormJsonField textFieldWithID:@"Referred by" title:@"Referred by:"]];
    
    
    NSMutableArray * values = [NSMutableArray new];
    [values addObject:[GMFormJsonValue withId:@"0" title:@"1. Payment. Program participant shall be responsible for payments specified above on the billing date of each month and for any other products and services s/he may purchase on the date of purchase. Participant shall provide authorization for such payment. Any outstanding payments or debts that are delinquent for more than 15 days shall result in suspension of program services until account is made current. Delinquent accounts are automatically subject to $25 monthly late fee."]];
    [fields addObject:[GMFormJsonField checkBoxFieldWithID:@"terms_payment" title:@"Terms Payment" values:values height:3.7 validation:[GMFormJsonValidation withRequired:YES]]];
    
    
    
     values = [NSMutableArray new];
    [values addObject:[GMFormJsonValue withId:@"0" title:@"2. Refunds: All program purchases are non-refundable. In case on unforeseen circumstances when a guest cannot redeem payment credit for program services, guest may keep monetary amount on their account and use it against other services or products offered at Spa Remedease. Account credit will remain valid for 60 days."]];
    [fields addObject:[GMFormJsonField checkBoxFieldWithID:@"terms_refunds" title:@"Terms Refunds" values:values height:2.6 validation:[GMFormJsonValidation withRequired:YES]]];
    
    
    
    
     values = [NSMutableArray new];
    [values addObject:[GMFormJsonValue withId:@"0" title:@"3. Session Cancellations. All session appointments may be rescheduled without penalty with 24-hour notice to Spa Remedease front desk. Cancellations or appointments rescheduled with less than 24-hour notice or no-shows are responsible for the full session fee."]];
    [fields addObject:[GMFormJsonField checkBoxFieldWithID:@"terms_session" title:@"Terms Session" values:values height:2.4 validation:[GMFormJsonValidation withRequired:YES]]];
    
    
    
    
     values = [NSMutableArray new];
    [values addObject:[GMFormJsonValue withId:@"0" title:@"4. Waiver of Liability. Program participant accepts services and all facilities on an as-is basis. Program participant's engagement or participation in any activity at or use of any Spa Remedease facility is assuming all risk of injury or contraction of any illness or medical condition that might result there from or any damage, loss, or theft of any personal property. Participant hereby releases and discharges Spa Remedease and its employees, agents, representatives, officers, and shareholders from any and all claims or causes of action that arise from use or occupancy of a Spa Remedease facility."]];
    [fields addObject:[GMFormJsonField checkBoxFieldWithID:@"terms_wavier" title:@"Terms Wavier" values:values height:4.5 validation:[GMFormJsonValidation withRequired:YES]]];
    
    
    
    
     values = [NSMutableArray new];
    [values addObject:[GMFormJsonValue withId:@"0" title:@"5. Revoking and Operational Closures. Spa Remedease may at its discretion close a Participant's account and revoke all privileges on 30-days written notice without cause and on immediate notice with cause, if reasonably warranted. In the event we temporarily close the facility for any reason, including repair or enhancement, we will post advance notice of such closure at the facility when possible."]];
    [fields addObject:[GMFormJsonField checkBoxFieldWithID:@"terms_revoking" title:@"Terms Revoking" values:values height:3.0 validation:[GMFormJsonValidation withRequired:YES]]];
    
    
    
    values = [NSMutableArray new];
    [values addObject:[GMFormJsonValue withId:@"0" title:@"6. Disputes. In the event of a dispute concerning this agreement or Spa Remedease Policies, the parties agree to submit such dispute to arbitration in accordance with the rules of the American Arbitration Association, and the parties hereto agree to be bound by the decision of such arbitration. This agreement shall be governed by the laws of the State of Oregon. The prevailing party in any dispute shall be entitled to all fees and cost incurred in such proceedings, including, but not limited to, reasonable attorney fees and the costs of the proceedings."]];
    [fields addObject:[GMFormJsonField checkBoxFieldWithID:@"terms_disputes" title:@"Terms Disputes" values:values height:3.7 validation:[GMFormJsonValidation withRequired:YES]]];
    
    [fields addObject:[GMFormJsonField textFieldWithID:@"PROGRAM PARTICIPANT - Printed Name" title:@"Printed Name:"]];
    (isHistory)?[fields addObject:[GMFormJsonField textFieldWithID:@"date1" title:@"Date:"width:50]]:[fields addObject:[GMFormJsonField dateFieldWithID:@"date1" title:@"Date:" width:50]];

    
    
    [fields addObject:[GMFormJsonField textFieldWithID:@"PROGRAM PARTICIPANT - Printed Name1" title:@"Printed Name:"]];
    (isHistory)?[fields addObject:[GMFormJsonField textFieldWithID:@"date2" title:@"Date:"width:50]]:[fields addObject:[GMFormJsonField dateFieldWithID:@"date2" title:@"Date:" width:50]];
    
    
    [fields addObject:[GMFormJsonField textFieldWithID:@"TEAM MEMBER -  Printed Name" title:@"Printed Name:"]];
    (isHistory)?[fields addObject:[GMFormJsonField textFieldWithID:@"Date3" title:@"Date:"width:50]]:[fields addObject:[GMFormJsonField dateFieldWithID:@"Date3" title:@"Date:" width:50]];

    
    [fields addObject:[GMFormJsonField signatureFieldsWithID:@"Signature" title:@"Signature"]];
    (isHistory)?[fields addObject:[GMFormJsonField textFieldWithID:@"Date4" title:@"Date:"width:50]]:[fields addObject:[GMFormJsonField dateFieldWithID:@"Date4" title:@"Date:" width:50]];

    
    [sections addObject:[GMFormJsonSection sectionWithID:@"section-2" fields:fields]];
    
    id group = [GMFormJsonGroup groupWithID:@"group-0" title:@"Spa Remedease Programs" sections:sections];
    
    [groups addObject:group];
    
    form.formGroups = groups;
    
    return form;
}

+(GMForm *)clientConsultationForm:(BOOL)isStylist{
    GMForm * form = [GMForm new];
    form.name = @"Eyelash Extensions Guest Consultation & Consent Form";
    form.formName = FNClientConsultationForm;
    BOOL isHistory = ([KappDelegate.stringClass isEqualToString:@"history"]);
    
    NSMutableArray * groups = [NSMutableArray new];
    NSMutableArray * sections = [NSMutableArray new];
    NSMutableArray * fields = [NSMutableArray new];
    
    
    
    
     [fields addObject:[GMFormJsonField textFieldWithID:@"NAME" title:@"NAME:" width:50]];
    (isHistory)?[fields addObject:[GMFormJsonField textFieldWithID:@"CONTACT NUMBER" title:@"CONTACT NUMBER:"width:50]]:[fields addObject:[GMFormJsonField numberFieldWithID:@"CONTACT NUMBER" title:@"CONTACT NUMBER:"]];
    [fields addObject:[GMFormJsonField emailFieldWithID:@"EMAIL" title:@"EMAIL:" width:50]];
    [fields addObject:[GMFormJsonField textFieldWithID:@"WHERE DID YOU HEAR ABOUT US?" title:@"WHERE DID YOU HEAR ABOUT US?:" width:100]];
     [fields addObject:[GMFormJsonField textFieldWithID:@"HAVE YOU WORN EYELASH EXTENSIONS BEFORE?" title:@"HAVE YOU WORN EYELASH EXTENSIONS BEFORE?:" width:100]];

   
    
    
    NSMutableArray * values = [NSMutableArray new];
    values = [NSMutableArray new];
    [values addObject:[GMFormJsonValue withId:@"1" title:@"Yes"]];
    [values addObject:[GMFormJsonValue withId:@"0" title:@"No"]];
    
    [fields addObject:[GMFormJsonField radioButtonFieldWithID:@"Allergies to latex, plasters, collagen, fish, acry" title:@"Allergies to latex, plasters, collagen, fish, acrylic nails" values:values width:100 height:1.6 validation:[GMFormJsonValidation withRequired:NO]]];
    
    values = [NSMutableArray new];
    [values addObject:[GMFormJsonValue withId:@"1" title:@"Yes"]];
    [values addObject:[GMFormJsonValue withId:@"0" title:@"No"]];
    
    [fields addObject:[GMFormJsonField radioButtonFieldWithID:@"Any other known allergies - Asthma, Hay fever " title:@"Any other known allergies - Asthma, Hay fever" values:values width:100 height:1.6 validation:[GMFormJsonValidation withRequired:NO]]];
    
    values = [NSMutableArray new];
    [values addObject:[GMFormJsonValue withId:@"1" title:@"Yes"]];
    [values addObject:[GMFormJsonValue withId:@"0" title:@"No"]];
    
    [fields addObject:[GMFormJsonField radioButtonFieldWithID:@"Are you claustrophobic? " title:@"Are you claustrophobic?" values:values width:100 height:1.6 validation:[GMFormJsonValidation withRequired:NO]]];
    
    values = [NSMutableArray new];
    [values addObject:[GMFormJsonValue withId:@"1" title:@"Yes"]];
    [values addObject:[GMFormJsonValue withId:@"0" title:@"No"]];
    
    [fields addObject:[GMFormJsonField radioButtonFieldWithID:@"Are you light sensitive? " title:@"Are you light sensitive?" values:values width:100 height:1.6 validation:[GMFormJsonValidation withRequired:NO]]];
    
    values = [NSMutableArray new];
    [values addObject:[GMFormJsonValue withId:@"1" title:@"Yes"]];
    [values addObject:[GMFormJsonValue withId:@"0" title:@"No"]];
    
    [fields addObject:[GMFormJsonField radioButtonFieldWithID:@"Do you smoke?" title:@"Do you smoke?" values:values width:100 height:1.6 validation:[GMFormJsonValidation withRequired:NO]]];
    
    values = [NSMutableArray new];
    [values addObject:[GMFormJsonValue withId:@"1" title:@"Yes"]];
    [values addObject:[GMFormJsonValue withId:@"0" title:@"No"]];
    
    [fields addObject:[GMFormJsonField radioButtonFieldWithID:@"Do you suffer from any eye disorders - Glaucoma, B" title:@"Do you suffer from any eye disorders - Glaucoma, Blepharitis, Conjunctivitis, Sty?" values:values width:100 height:1.6 validation:[GMFormJsonValidation withRequired:NO]]];
    
    values = [NSMutableArray new];
    [values addObject:[GMFormJsonValue withId:@"1" title:@"Yes"]];
    [values addObject:[GMFormJsonValue withId:@"0" title:@"No"]];
    
    [fields addObject:[GMFormJsonField radioButtonFieldWithID:@"Have you had eye surgery in the last 4 weeks? Plea" title:@"Have you had eye surgery in the last 4 weeks? Please give details to therapist." values:values width:100 height:1.6 validation:[GMFormJsonValidation withRequired:NO]]];
    
//      [fields addObject:[GMFormJsonField textFieldWithID:@"If Yes, Please give details to therapist." title:@"Please give details to therapist. If Yes" width:100 validation:[GMFormJsonValidation withRequired:NO]]];
    
    values = [NSMutableArray new];
    [values addObject:[GMFormJsonValue withId:@"1" title:@"Yes"]];
    [values addObject:[GMFormJsonValue withId:@"0" title:@"No"]];
    
    [fields addObject:[GMFormJsonField radioButtonFieldWithID:@"Have you had any tattooing recently to eyes or eye" title:@"Have you had any tattooing recently to eyes or eyebrows?" values:values width:100 height:1.6 validation:[GMFormJsonValidation withRequired:NO]]];
    
     [fields addObject:[GMFormJsonField textFieldWithID:@" If so when?" title:@"If Yes,so when?" width:100 validation:[GMFormJsonValidation withRequired:NO]]];
    
    values = [NSMutableArray new];
    [values addObject:[GMFormJsonValue withId:@"1" title:@"Yes"]];
    [values addObject:[GMFormJsonValue withId:@"0" title:@"No"]];
    
    [fields addObject:[GMFormJsonField radioButtonFieldWithID:@"Do you wear contact lenses?" title:@"Do you wear contact lenses?" values:values width:100 height:1.6 validation:[GMFormJsonValidation withRequired:NO]]];
    
    values = [NSMutableArray new];
    [values addObject:[GMFormJsonValue withId:@"1" title:@"Yes"]];
    [values addObject:[GMFormJsonValue withId:@"0" title:@"No"]];
    
    [fields addObject:[GMFormJsonField radioButtonFieldWithID:@"Do you take HRT, Steroids, Thyroid medication or a" title:@"Do you take HRT, Steroids, Thyroid medication or any other regular meds?" values:values width:100 height:1.6 validation:[GMFormJsonValidation withRequired:NO]]];
    
    values = [NSMutableArray new];
    [values addObject:[GMFormJsonValue withId:@"1" title:@"Yes"]];
    [values addObject:[GMFormJsonValue withId:@"0" title:@"No"]];
    
    [fields addObject:[GMFormJsonField radioButtonFieldWithID:@"Are you pregnant or is there a chance you could be" title:@"Are you pregnant or is there a chance you could be?" values:values width:100 height:1.6 validation:[GMFormJsonValidation withRequired:NO]]];
    
    [fields addObject:[GMFormJsonField textFieldWithID:@"If yes, how many weeks?" title:@"If yes, how many weeks?" width:100 validation:[GMFormJsonValidation withRequired:NO]]];
    
    values = [NSMutableArray new];
    [values addObject:[GMFormJsonValue withId:@"1" title:@"Yes"]];
    [values addObject:[GMFormJsonValue withId:@"0" title:@"No"]];
    
    [fields addObject:[GMFormJsonField radioButtonFieldWithID:@"Would you say you have oily skin/hair?" title:@"Would you say you have oily skin/hair?" values:values width:100 height:1.6 validation:[GMFormJsonValidation withRequired:NO]]];
    
    values = [NSMutableArray new];
    [values addObject:[GMFormJsonValue withId:@"1" title:@"Yes"]];
    [values addObject:[GMFormJsonValue withId:@"0" title:@"No"]];
    
    [fields addObject:[GMFormJsonField radioButtonFieldWithID:@"Have you had Chemotherapy in the last 6 months?" title:@"Have you had Chemotherapy in the last 6 months?" values:values width:100 height:1.6 validation:[GMFormJsonValidation withRequired:NO]]];
    
    values = [NSMutableArray new];
    [values addObject:[GMFormJsonValue withId:@"1" title:@"Yes"]];
    [values addObject:[GMFormJsonValue withId:@"0" title:@"No"]];
    
    [fields addObject:[GMFormJsonField radioButtonFieldWithID:@"Are you able to lay flat for long periods of time?" title:@"Are you able to lay flat for long periods of time?" values:values width:100 height:1.6 validation:[GMFormJsonValidation withRequired:NO]]];
    
    values = [NSMutableArray new];
    [values addObject:[GMFormJsonValue withId:@"1" title:@"Yes"]];
    [values addObject:[GMFormJsonValue withId:@"0" title:@"No"]];
    
    [fields addObject:[GMFormJsonField radioButtonFieldWithID:@"Any back problems?" title:@"Any back problems?" values:values width:100 height:1.6 validation:[GMFormJsonValidation withRequired:NO]]];
    
    [fields addObject:[GMFormJsonField labelFieldWithID:@"I confirm that the information I have provided is true. I understand that the therapist will take every precaution to minimize any negative reactions that may occur as a result of the" title:@"I confirm that the information I have provided is true. I understand that the therapist will take every precaution to minimize any negative reactions that may occur as a result of the treatment. I understand that I may still react to a full set of eyelash extensions. On the rare occasion this happens and I will not hold my therapist responsible and I will inform them immediately. My therapist will arrange a review and perform an assessment of my lashes and will advise accordingly. I also understand that should anything change with regards to my health, medical conditions or allergies then I will inform my therapist immediately as this could impact being able to have the treatment. Seeing average of 2-3 lashes per day fall off is normal. If you notice more than normal number of lost lashes within the first 3 days, Spa Remedease will provide one complimentary fill within 7 days after the service however no refunds will be issued for the original service.\n\nBy signing this document, I agree to all of the above." height:6.0]];
    
    [fields addObject:[GMFormJsonField signatureFieldsWithID:@"Guest Signature" title:@"Guest Signature:"]];
    (isHistory)?[fields addObject:[GMFormJsonField textFieldWithID:@"Date & Time" title:@"Date:"width:50]]:[fields addObject:[GMFormJsonField dateFieldWithID:@"Date & Time" title:@"Date:" width:50]];
    
    [sections addObject:[GMFormJsonSection sectionWithID:@"section-0" fields:fields]];
    
    id group = [GMFormJsonGroup groupWithID:@"group-0" title:@"" sections:sections];
    [groups addObject:group];
    
    
    sections = [NSMutableArray new];
    fields = [NSMutableArray new];
    
    [fields addObject:[GMFormJsonField labelFieldWithID:@"I agree to follow the aftercare advice given to me by my therapist. I understand that failure to do so will cause premature loss of my" title:@"I agree to follow the aftercare advice given to me by my therapist. I understand that failure to do so will cause premature loss of my extensions and I agree that I will not hold my therapist responsible. I agree to inform my therapist immediately if I have any issues with my extensions, I understand that delaying any notification of an issue could mean that my therapist will not offer to rectify the problem if it falls outside of the guaranteed time post application. I understand that refunds are not offered on eyelash extension treatments. I agree to return within the designated time to have my infill treatment and if I come outside of this time I agree to pay for the extra work needed or indeed a new full set." height:4.0]];
    
    [fields addObject:[GMFormJsonField labelFieldWithID:@"I understand that any cancellations of less than 24 hours, or not attending my appointments will result in full charges to cover the loss of" title:@"I understand that any cancellations of less than 24 hours, or not attending my appointments will result in full charges to cover the loss of earnings to my therapist as I understand that it is impossible to fill that lost time at such short notice. I respect this policy and agree to the terms and conditions. I agree to arrive on time, if I am running late I agree to inform my therapist ASAP. I understand that if I am late I can only have the remaining time allocated for my treatment at full cost. By signing this document, I agree to all of the above." height:4.0]];
    
    [fields addObject:[GMFormJsonField signatureFieldsWithID:@"Guest Signature" title:@"Guest Signature:"]];
    (isHistory)?[fields addObject:[GMFormJsonField textFieldWithID:@"Date & Time" title:@"Date:"width:50]]:[fields addObject:[GMFormJsonField dateFieldWithID:@"Date & Time" title:@"Date:" width:50]];
    
    [sections addObject:[GMFormJsonSection sectionWithID:@"section-0" fields:fields]];
    
    id group1 = [GMFormJsonGroup groupWithID:@"group-0" title:@"Client Aftercare Policy & Cancellation Policy" sections:sections];
    [groups addObject:group1];
    
    
    //--
    form.formGroups = groups;
    
    
    return form;
}

+(GMForm *)membershipAgreement:(BOOL)isStylist{
    GMForm * form = [GMForm new];
    form.name = @"Membership Agreement";
    form.formName = FNMembershipAgreement;
    BOOL isHistory = ([KappDelegate.stringClass isEqualToString:@"history"]);

    NSMutableArray * groups = [NSMutableArray new];
    NSMutableArray * sections = [NSMutableArray new];
    NSMutableArray * fields = [NSMutableArray new];
    
    [fields addObject:[GMFormJsonField labelFieldWithID:@"Open" title:@"Open your Spa Remedease membership account with an auto deposit of $125/month.\nCredit never expires and can be used however you like – services, retail or gratuity.\nAccount Holder privileges include:\nGet membership pricing – up to 20% savings – on all services and enjoy exclusive special offers" height:2.6]];
    
    
    [fields addObject:[GMFormJsonField labelFieldWithID:@"Can_I_let_someone_else_use_it" title:@"Can I let someone else use it?\nYes, if you are at the spa together. If you schedule a service with a friend or family member and come in for services at the same time, the membership prices will be extended to all the appointments you reserved. Another way you can redeem your credit for another person is to purchase a gift card for them using your account credit." height:3.1f]];
    
    [fields addObject:[GMFormJsonField labelFieldWithID:@"Can_I_accumulate_my_membership" title:@"Can I accumulate my membership?\nYes, just like cell phone minutes, your unused credit rolls over. You can accumulate up to $500 or 4 months’ worth of credit that can be used towards our programs, gift cards or a special R&R day. The credit is not eligible for cash refunds after it has posted to your account" height:2.9f]];
    
    [fields addObject:[GMFormJsonField labelFieldWithID:@"How_do_I_pay" title:@"How do I pay?\nFor a hassle free experience, we set up automated credit card or bank account deduction on the same day of each month." height:1.6f]];
    
    [fields addObject:[GMFormJsonField labelFieldWithID:@"Do_I_have_to_sign_a_contract" title:@"Do I have to sign a contract?\nNo long term contract needed (though we are confident that you are going to love it and stay with us forever). After your initial 6-month commitment is met, simply provide us with a 30 day notice and it will be stopped." height:2.2f]];
    
    //[fields addObject:[GMFormJsonField dateFieldWithID:@"printed_date" title:@"Date:"]];
    [sections addObject:[GMFormJsonSection sectionWithID:@"section-2" fields:fields]];
    
    id group = [GMFormJsonGroup groupWithID:@"group-0" title:@"Membership FAQs" sections:sections];
    [groups addObject:group];
    
    
    sections = [NSMutableArray new];
    fields = [NSMutableArray new];
    (isHistory)?[fields addObject:[GMFormJsonField textFieldWithID:@"Account Opening Date" title:@"Account Opening Date:"width:50]]:[fields addObject:[GMFormJsonField dateFieldWithID:@"Account Opening Date" title:@"Account Opening Date:" width:50]];
    (isHistory)?[fields addObject:[GMFormJsonField textFieldWithID:@"Auto-Deposit Date" title:@"Auto-Deposit Date:"width:50]]:[fields addObject:[GMFormJsonField dateFieldWithID:@"Auto-Deposit Date" title:@"Auto-Deposit Date:" width:50]];

    //[fields addObject:[GMFormJsonField textFieldWithID:@"processed_by" title:@"Processed by:"]];
    [fields addObject:[GMFormJsonField textFieldWithID:@"Name" title:@"Name:"]];
    [fields addObject:[GMFormJsonField textFieldWithID:@"Address" title:@"Address:"]];
    [fields addObject:[GMFormJsonField textFieldWithID:@"City" title:@"City:"]];
    [fields addObject:[GMFormJsonField textFieldWithID:@"State" title:@"State:"]];

    (isHistory)?[fields addObject:[GMFormJsonField textFieldWithID:@"Zip" title:@"Zip:"width:50]]:[fields addObject:[GMFormJsonField textFieldWithID:@"Zip" title:@"Zip:"]];
    
    
    [fields addObject:[GMFormJsonField textFieldWithID:@"Email address" title:@"Email address:"]];
    (isHistory)?[fields addObject:[GMFormJsonField textFieldWithID:@"Date of Birth" title:@"Date of Birth:"width:50]]:[fields addObject:[GMFormJsonField dateFieldWithID:@"Date of Birth" title:@"Date of Birth:" width:50]];
    (isHistory)?[fields addObject:[GMFormJsonField textFieldWithID:@"Cell Phone" title:@"Cell Phone:"width:50]]:[fields addObject:[GMFormJsonField numberFieldWithID:@"Cell Phone" title:@"Cell Phone:"]];

    [fields addObject:[GMFormJsonField textFieldWithID:@"Emergency Contact" title:@"Emergency Contact's Name:"]];
    [fields addObject:[GMFormJsonField textFieldWithID:@"Relationship" title:@"Relationship:"]];
    (isHistory)?[fields addObject:[GMFormJsonField textFieldWithID:@"Phone" title:@"Emergency Contact Number:"width:50]]:[fields addObject:[GMFormJsonField numberFieldWithID:@"Phone" title:@"Emergency Contact Number:"]];
    //[fields addObject:[GMFormJsonField textFieldWithID:@"Referred by" title:@"Referred by:"]];
    
    
    NSMutableArray * values = [NSMutableArray new];
    [values addObject:[GMFormJsonValue withId:@"0" title:@"1. Payment. Account holder shall be responsible for payments specified above on the billing date of each month and for any other products and services s/he may purchase on the date of purchase.  Account Holder shall provide authorization for such payment, and any other charges for which Account Holder chooses to auto-deposit into their account. Any payments deposited into account may be applied to any service or retail product.  Any outstanding payments or debts that are delinquent for more than 15 days shall result in suspension of Account Holder benefits until account is made current. Delinquent accounts are automatically subject to $25 monthly late fee."]];
    [fields addObject:[GMFormJsonField checkBoxFieldWithID:@"terms_payment" title:@"Terms & Conditions Remedease" values:values height:4.3 validation:[GMFormJsonValidation withRequired:YES]]];
         values = [NSMutableArray new];
    
    [values addObject:[GMFormJsonValue withId:@"1" title:@"2. Account Closure Policy: All accounts are subject to Account Holder’s right to close at each consecutive monthly renewal date with at least 30-days prior written notice. Renewal dates will occur every month from date of account opening unless written notice is received at least 30 days prior to the renewal date.   Account credit will remain valid until used, even after non-renewal."]];
    
    [fields addObject:[GMFormJsonField checkBoxFieldWithID:@"terms_account" title:@"Terms & Conditions Remedease" values:values height:2.9 validation:[GMFormJsonValidation withRequired:YES]]];
    
     values = [NSMutableArray new];
    [values addObject:[GMFormJsonValue withId:@"1" title:@"3. Session Cancellations. All session appointments may be rescheduled without penalty with 24-hour notice to Spa Remedease front desk. Cancellations or appointments rescheduled with less than 24-hour notice or no-shows are responsible for the full session fee."]];
    [fields addObject:[GMFormJsonField checkBoxFieldWithID:@"terms_session" title:@"Terms & Conditions Remedease" values:values height:2.4 validation:[GMFormJsonValidation withRequired:YES]]];
    
     values = [NSMutableArray new];
    [values addObject:[GMFormJsonValue withId:@"1" title:@"4. Waiver of Liability. Account Holder accepts services and all facilities on an “as-is” basis. Account Holder’s engagement or participation in any activity at or use of any Spa Remedease facility. Account Holder agrees they are voluntarily participating in use of such facilities and are assuming all risk of injury or contraction of any illness or medical condition that might result there from or any damage, loss, or theft of any personal property. Participant hereby releases and discharges Spa Remedease and its employees, agents, representatives, officers, and shareholders from any and all claims or causes of action that arise from use or occupancy of a Spa Remedease facility."]];
    [fields addObject:[GMFormJsonField checkBoxFieldWithID:@"terms_waiver" title:@"Terms & Conditions Remedease" values:values height:4.2 validation:[GMFormJsonValidation withRequired:YES]]];
    
    values = [NSMutableArray new];
    [values addObject:[GMFormJsonValue withId:@"1" title:@"5. Revoking & Operational Closures. Spa Remedease may at its discretion close an Account Holder’s account and revoke all privileges on 30-days written notice without cause and on immediate notice with cause, if reasonably warranted.  In the event we temporarily close the facility for any reason, including repair or enhancement, we will post advance notice of such closure at the facility when possible."]];
    [fields addObject:[GMFormJsonField checkBoxFieldWithID:@"terms_revoking" title:@"Terms & Conditions Remedease" values:values height:2.9 validation:[GMFormJsonValidation withRequired:YES]]];
    
      values = [NSMutableArray new];
    [values addObject:[GMFormJsonValue withId:@"1" title:@"6. Disputes. In the event of a dispute concerning this agreement or Spa Remedease Policies, the parties agree to submit such dispute to arbitration in accordance with the rules of the American Arbitration Association, and the parties hereto agree to be bound by the decision of such arbitration. This agreement shall be governed by the laws of the State of Oregon. The prevailing party in any dispute shall be entitled to all fees and cost incurred in such proceedings, including, but not limited to, reasonable attorney fees and the costs of the proceedings."]];
    [fields addObject:[GMFormJsonField checkBoxFieldWithID:@"terms_dsiputes" title:@"Terms & Conditions Remedease" values:values height:3.6 validation:[GMFormJsonValidation withRequired:YES]]];
   
    
    [sections addObject:[GMFormJsonSection sectionWithID:@"section-0" fields:fields]];
    
    group = [GMFormJsonGroup groupWithID:@"group-0" title:@"Membership Agreement" sections:sections];
    [groups addObject:group];
    
    
    sections = [NSMutableArray new];
    fields = [NSMutableArray new];
    
//    [fields addObject:[GMFormJsonField textFieldWithID:@"ACCOUNT HOLDER - Printed Name" title:@"Printed Name:" width:50]];
//    [fields addObject:[GMFormJsonField dateFieldWithID:@"Date" title:@"Date:"]];
//
//    [fields addObject:[GMFormJsonField textFieldWithID:@"ACCOUNT HOLDER - Printed Name1" title:@"Printed Name:" width:50]];
//    [fields addObject:[GMFormJsonField dateFieldWithID:@"Date1" title:@"Date:"]];
    
    (isHistory)?[fields addObject:[GMFormJsonField textFieldWithID:@"Date" title:@"Date:"width:50]]:[fields addObject:[GMFormJsonField dateFieldWithID:@"Date" title:@"Date:" width:50]];

    [fields addObject:[GMFormJsonField signatureFieldsWithID:@"ACCOUNT HOLDER - Signature" title:@"Signature:"]];

    
    [sections addObject:[GMFormJsonSection sectionWithID:@"section-2" fields:fields]];
    
    group = [GMFormJsonGroup groupWithID:@"group-0" title:@"Account Holder" sections:sections];
    [groups addObject:group];

    sections = [NSMutableArray new];
    fields = [NSMutableArray new];
    
    [fields addObject:[GMFormJsonField textFieldWithID:@"TEAM MEMBER - Printed Name" title:@"Printed Name:" width:50]];
    //[fields addObject:[GMFormJsonField dateFieldWithID:@"Date2" title:@"Date:"]];
    [fields addObject:[GMFormJsonField signatureFieldsWithID:@"Signature" title:@"Signature:"]];
    [fields addObject:[GMFormJsonField dateFieldWithID:@"Date3" title:@"Date:"]];
    (isHistory)?[fields addObject:[GMFormJsonField textFieldWithID:@"Date3" title:@"Date:"width:50]]:[fields addObject:[GMFormJsonField dateFieldWithID:@"Date3" title:@"Date:" width:50]];

    
    [sections addObject:[GMFormJsonSection sectionWithID:@"section-1" fields:fields]];
    
   
    group = [GMFormJsonGroup groupWithID:@"group-0" title:@"SPA REMEDEASE TEAM MEMBER" sections:sections];
    [groups addObject:group];
    
    //--
    form.formGroups = groups;
    
    
    return form;
}

+(GMForm *)electronicGuestIntakeForm:(BOOL)isStylist {
    GMForm * form = [GMForm new];
    form.name = @"Electronic Guest Intake";
    form.formName = FNClientIntakeForm;
    BOOL isHistory = ([KappDelegate.stringClass isEqualToString:@"history"]);

    NSMutableArray * groups = [NSMutableArray new];
    NSMutableArray * sections = [NSMutableArray new];
    NSMutableArray * fields = [NSMutableArray new];
    NSMutableArray *values = [NSMutableArray new];
    
    [fields addObject:[GMFormJsonField countFieldTextWithID:@"Guest First Name" title:@"First Name:" maxValue:20]];
    [fields addObject:[GMFormJsonField countFieldTextWithID:@"Guest Last Name " title:@"Last Name:" maxValue:20]];
    [fields addObject:[GMFormJsonField textFieldWithID:@"Address" title:@"Address:" width:50 validation:[GMFormJsonValidation withRequired:NO]]];
    [fields addObject:[GMFormJsonField textFieldWithID:@"City" title:@"City:" width:50 validation:[GMFormJsonValidation withRequired:NO]]];
    [fields addObject:[GMFormJsonField textFieldWithID:@"State" title:@"State:" width:50 validation:[GMFormJsonValidation withRequired:NO]]];
    
    (isHistory)?[fields addObject:[GMFormJsonField textFieldWithID:@"Zip" title:@"Zip:"width:50]]:[fields addObject:[GMFormJsonField textFieldWithID:@"Zip" title:@"Zip:"]];
    (isHistory)?[fields addObject:[GMFormJsonField textFieldWithID:@"Cell Phone" title:@"Cell Phone:"width:50]]:[fields addObject:[GMFormJsonField numberFieldWithID:@"Cell Phone" title:@"Cell Phone:"]];
    [fields addObject:[GMFormJsonField textFieldWithID:@"Email" title:@"Email:" width:50]];
    (isHistory)?[fields addObject:[GMFormJsonField textFieldWithID:@"Birth Date" title:@"Birth Date:"width:50]]:[fields addObject:[GMFormJsonField dateFieldWithID:@"Birth Date" title:@"Birth Date:" width:50]];

    values = [NSMutableArray new];
    [values addObject:[GMFormJsonValue withId:@"1" title:@"Male"]];
    [values addObject:[GMFormJsonValue withId:@"0" title:@"Female"]];
    
    [fields addObject:[GMFormJsonField radioButtonFieldWithID:@"Gender" title:@"Gender:" values:values width:50 height:1.6 validation:[GMFormJsonValidation withRequired:YES]]];
    
    
    [fields addObject:[GMFormJsonField labelFieldWithID:@"Welcome" title:@"Welcome!\nOur goal is to deliver the most pleasurable visit. Help us discover your needs and we will customize your experience." height:1.3]];
  
    
    [fields addObject:[GMFormJsonField labelFieldWithID:@"What are your concerns" title:@"What are your concerns? Select any that apply." height:0.6]];
    
    ///---- section two
    // fields = [NSMutableArray new];
    values = [NSMutableArray new];
    [values addObject:[GMFormJsonValue withId:@"0" title:@"Muscle Tension"]];
    [values addObject:[GMFormJsonValue withId:@"1" title:@"Dry Skin"]];
    [values addObject:[GMFormJsonValue withId:@"2" title:@"Stress"]];
    [values addObject:[GMFormJsonValue withId:@"3" title:@"Chronic Pain"]];
    [values addObject:[GMFormJsonValue withId:@"4" title:@"Arthritis"]];
    [values addObject:[GMFormJsonValue withId:@"5" title:@"Sunburn"]];
    [values addObject:[GMFormJsonValue withId:@"6" title:@"Neck or Back Pain"]];
    [values addObject:[GMFormJsonValue withId:@"7" title:@"Poor Circulation"]];
    [values addObject:[GMFormJsonValue withId:@"8" title:@"Cellulite"]];
    [values addObject:[GMFormJsonValue withId:@"9" title:@"Fibromyalgia"]];
    [values addObject:[GMFormJsonValue withId:@"10" title:@"Candida"]];
    [values addObject:[GMFormJsonValue withId:@"11" title:@"Trouble sleeping"]];
    [values addObject:[GMFormJsonValue withId:@"12" title:@"No Concerns"]];
    
    [fields addObject:[GMFormJsonField checkBoxFieldWithID:@"body_remedease" title:@"Body Remedease" values:values height:5.0 validation:[GMFormJsonValidation withRequired:NO]]];
    
    values = [NSMutableArray new];
    [values addObject:[GMFormJsonValue withId:@"0" title:@"Uneven Skin"]];
    [values addObject:[GMFormJsonValue withId:@"1" title:@"Dehydration"]];
    [values addObject:[GMFormJsonValue withId:@"2" title:@"Rosacea"]];
    [values addObject:[GMFormJsonValue withId:@"3" title:@"Loss of Elasticity"]];
    [values addObject:[GMFormJsonValue withId:@"4" title:@"Sun Damage"]];
    [values addObject:[GMFormJsonValue withId:@"5" title:@"Acne"]];
    [values addObject:[GMFormJsonValue withId:@"6" title:@"Clogged Pores"]];
    [values addObject:[GMFormJsonValue withId:@"7" title:@"Red Blood Vessels"]];
    [values addObject:[GMFormJsonValue withId:@"8" title:@"Scars"]];
    [values addObject:[GMFormJsonValue withId:@"9" title:@"Hyperpigmentation"]];
    [values addObject:[GMFormJsonValue withId:@"10" title:@"Sensitive"]];
    [values addObject:[GMFormJsonValue withId:@"11" title:@"Oily"]];
    [values addObject:[GMFormJsonValue withId:@"12" title:@"No Concerns"]];
   // [fields addObject:[GMFormJsonField chec]];
    
    [fields addObject:[GMFormJsonField checkBoxFieldWithID:@"Skin" title:@"Skin/Facial Remedease" values:values height:5.0 validation:[GMFormJsonValidation withRequired:NO]] ];
    
    values = [NSMutableArray new];
    [values addObject:[GMFormJsonValue withId:@"1" title:@"Yes"]];
    [values addObject:[GMFormJsonValue withId:@"0" title:@"No"]];
    
    [fields addObject:[GMFormJsonField radioButtonFieldWithID:@"Are you looking for guidance with your home skin c" title:@"Are you looking for guidance with your home skin care routine?" values:values width:100 height:1.9 validation:[GMFormJsonValidation withRequired:NO]]];

    ///---- section three
    //fields = [NSMutableArray new];
    values = [NSMutableArray new];
    [values addObject:[GMFormJsonValue withId:@"0" title:@"Age Spots"]];
    [values addObject:[GMFormJsonValue withId:@"1" title:@"Dry Cuticles"]];
    [values addObject:[GMFormJsonValue withId:@"2" title:@"Callouses"]];
    [values addObject:[GMFormJsonValue withId:@"3" title:@"Ingrown Nails"]];
    [values addObject:[GMFormJsonValue withId:@"4" title:@"Fragile & Brittle"]];
    [values addObject:[GMFormJsonValue withId:@"5" title:@"Cracking Nails"]];
    [values addObject:[GMFormJsonValue withId:@"6" title:@"No Concerns"]];
    [fields addObject:[GMFormJsonField checkBoxFieldWithID:@"hand_remedease" title:@"Hand and Feet Remedease" values:values height:3.0 validation:[GMFormJsonValidation withRequired:NO]]];
    
    
    
   /* ///---- section Four
    //fields = [NSMutableArray new];
    values = [NSMutableArray new];
    [values addObject:[GMFormJsonValue withId:@"0" title:@"Dry or Brittle"]];
    [values addObject:[GMFormJsonValue withId:@"1" title:@"Frizzy"]];
    [values addObject:[GMFormJsonValue withId:@"2" title:@"Damaged"]];
    [values addObject:[GMFormJsonValue withId:@"3" title:@"Oily"]];
    [values addObject:[GMFormJsonValue withId:@"4" title:@"Uncontrolled Curl"]];
    [values addObject:[GMFormJsonValue withId:@"5" title:@"Dandruf"]];
    [values addObject:[GMFormJsonValue withId:@"6" title:@"No Concerns"]];
    [fields addObject:[GMFormJsonField checkBoxFieldWithID:@"hair_remedease" title:@"Hair Remedease" values:values height:5.2 validation:[GMFormJsonValidation withRequired:NO]]];
    */
    
    
    /*values = [NSMutableArray new];
    [values addObject:[GMFormJsonValue withId:@"0" title:@"Well"]];
    [values addObject:[GMFormJsonValue withId:@"1" title:@"City"]];
    
    [fields addObject:[GMFormJsonField radioButtonFieldWithID:@"What type of water do you use to wash your hair in" title:@"What type of water do you use to wash your hair in?" values:values width:100 height:1.6 validation:[GMFormJsonValidation withRequired:NO]]];*/
    
    values = [NSMutableArray new];
    [values addObject:[GMFormJsonValue withId:@"1" title:@"Yes"]];
    [values addObject:[GMFormJsonValue withId:@"0" title:@"No"]];
    
    [fields addObject:[GMFormJsonField radioButtonFieldWithID:@"Any present injury or recent surgeries" title:@"Any present injury or recent surgery?" values:values width:100 height:1.6 validation:[GMFormJsonValidation withRequired:NO]]];
    
    [fields addObject:[GMFormJsonField textFieldWithID:@"If Yes, what type of injury/surgery?" title:@"What type of injury/surgery? If Yes" width:100 validation:[GMFormJsonValidation withRequired:NO]]];

    values = [NSMutableArray new];
    [values addObject:[GMFormJsonValue withId:@"1" title:@"Yes"]];
    [values addObject:[GMFormJsonValue withId:@"0" title:@"No"]];
    
    [fields addObject:[GMFormJsonField radioButtonFieldWithID:@"Are you currently Pregnant" title:@"Are you currently Pregnant?" values:values width:100 height:1.6 validation:[GMFormJsonValidation withRequired:NO]]];
    
    [fields addObject:[GMFormJsonField textFieldWithID:@"If Yes,How many weeks ? " title:@"How many weeks? If Yes" width:100 validation:[GMFormJsonValidation withRequired:NO]]];

    
    values = [NSMutableArray new];
    [values addObject:[GMFormJsonValue withId:@"0" title:@"Removal of lymph nodes"]];
    [values addObject:[GMFormJsonValue withId:@"1" title:@"Cancer"]];
    [values addObject:[GMFormJsonValue withId:@"2" title:@"Digestive disorders"]];
    [values addObject:[GMFormJsonValue withId:@"3" title:@"Autoimmune disease"]];
    [values addObject:[GMFormJsonValue withId:@"4" title:@"No Concerns"]];
    [values addObject:[GMFormJsonValue withId:@"5" title:@"Allergies"]];
    [fields addObject:[GMFormJsonField checkBoxFieldWithID:@"Do you currently suffer from or had in the past an" title:@"Do you currently suffer from or had in the past any of the following?" values:values height:3.0 validation:[GMFormJsonValidation withRequired:NO]]];
    
    [fields addObject:[GMFormJsonField labelFieldWithID:@"do_you_have_any_additional_health" title:@"Do you have any additional health and beauty concerns that we can help you address? Please describe" height:1.0]];
    
    values = [NSMutableArray new];
    [values addObject:[GMFormJsonValue withId:@"1" title:@"Yes"]];
    [values addObject:[GMFormJsonValue withId:@"0" title:@"No"]];
    [fields addObject:[GMFormJsonField radioButtonFieldWithID:@"do_you_have_any_additional_health" title:@"" values:values width:100 height:1.7 validation:[GMFormJsonValidation withRequired:NO]]];
    
    [fields addObject:[GMFormJsonField textFieldWithID:@"If Yes, Please Describe" title:@"If Yes, Please describe:" width:100 validation:[GMFormJsonValidation withRequired:NO]]];
    
    [fields addObject:[GMFormJsonField textFieldWithID:@"No Concern" title:@"No Concern" width:100 validation:[GMFormJsonValidation withRequired:NO]]];
   

    values = [NSMutableArray new];
    [values addObject:[GMFormJsonValue withId:@"1" title:@"Yes"]];
    [values addObject:[GMFormJsonValue withId:@"0" title:@"No"]];
    [fields addObject:[GMFormJsonField radioButtonFieldWithID:@"I am interested in a complimentary health and well" title:@"I am interested in a complimentary health and wellness consultation." values:values width:100 height:1.7 validation:[GMFormJsonValidation withRequired:NO]]];

   /* [fields addObject:[GMFormJsonField labelFieldWithID:@"On a scale 1-5, mark the following (1 Never, 5 Always)" title:@"On a scale 1-5, mark the following (1 Never, 5 Always)" height:0.7]];
    
    
    [fields addObject:[GMFormJsonField ratingFieldsWithID:@"I am active and exercise regularly" title:@"I am active and exercise regularly"]];
    [fields addObject:[GMFormJsonField ratingFieldsWithID:@"I sleep well every night " title:@"I sleep well every night"]];
    [fields addObject:[GMFormJsonField ratingFieldsWithID:@"I am happy with my weight" title:@"I am happy with my weight"]];
    [fields addObject:[GMFormJsonField ratingFieldsWithID:@"I cook most of my meals at home using whole ingred" title:@"I cook most of my meals at home using whole ingredients"]];
    
    [fields addObject:[GMFormJsonField ratingFieldsWithID:@"I live stress free" title:@"I live stress free"]];
    
    [fields addObject:[GMFormJsonField ratingFieldsWithID:@"My body feels well and I do not experience any pai" title:@"My body feels well and I do not experience any pain or muscle aches"]];
    
    [fields addObject:[GMFormJsonField ratingFieldsWithID:@"My hair is shiny, strong and love its color" title:@"My hair is shiny, strong and love its color"]];
    
    [fields addObject:[GMFormJsonField ratingFieldsWithID:@"I regularly care for my skin and I am happy with i" title:@"I regularly care for my skin and I am happy with its appearance"]];
    [fields addObject:[GMFormJsonField ratingFieldsWithID:@"My nails and cuticles are healthy and never dry" title:@"My nails and cuticles are healthy and never dry"]];
    [fields addObject:[GMFormJsonField ratingFieldsWithID:@"My feet feel great even after being on them all da" title:@"My feet feel great even after being on them all day"]];
    */
    
    
    [fields addObject:[GMFormJsonField labelFieldWithID:@"I agree that I do not have any medical conditions" title:@"It is not advisable to engage in certain treatments where specific medical conditions exist (heart disease, diabetes, thrombosis, cancer, recent surgery, contagious skin conditions, allergies, low or high blood pressure).\nI agree that I do not have any medical conditions that prevent me from receiving treatments and I have consulted my physician for approval and release the spa from any liability." height:2.9]];
    
    [fields addObject:[GMFormJsonField signatureFieldsWithID:@"Signature" title:@"Signature:"]];
    (isHistory)?[fields addObject:[GMFormJsonField textFieldWithID:@"Date" title:@"Date:"width:50]]:[fields addObject:[GMFormJsonField dateFieldWithID:@"Date" title:@"Date:" width:50]];

    [sections addObject:[GMFormJsonSection sectionWithID:@"section-0" fields:fields]];
    
    id group = [GMFormJsonGroup groupWithID:@"group-0" title:@"Electronic Guest Intake Form" sections:sections];
    [groups addObject:group];
    
    
    //--
    form.formGroups = groups;
    
    
    return form;
}



@end
