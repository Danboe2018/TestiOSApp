@import UIKit;
@import Foundation;

#import "FORMViewController.h"
#import "GMForm.h"

@interface FormDisplayCollectionViewController : FORMViewController

@property (nonatomic, retain) NSDictionary* formValues;

-(instancetype)initWithForm:(GMForm *)form;
- (instancetype)initWithJSON:(NSArray *)JSON
            andInitialValues:(NSDictionary *)initialValues;

@end
