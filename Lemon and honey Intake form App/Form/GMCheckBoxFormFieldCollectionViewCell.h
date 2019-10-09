#import <UIKit/UIKit.h>
#import "CheckBoxButton.h"
#import "FORMFieldValue.h"

@protocol GMCheckBoxFormFieldCollectionViewCellDelegate;

@interface GMCheckBoxFormFieldCollectionViewCell : UICollectionViewCell <CheckBoxButtonDelegate>

@property (weak, nonatomic) IBOutlet CheckBoxButton *checkBox;
@property (weak, nonatomic) IBOutlet UILabel *label;
@property (retain, nonatomic) FORMFieldValue *value;
@property (retain, nonatomic) id<GMCheckBoxFormFieldCollectionViewCellDelegate> delegate;

- (IBAction)buttonClickAction:(id)sender;

@end

@protocol GMCheckBoxFormFieldCollectionViewCellDelegate <NSObject>

-(void)fieldValue:(FORMFieldValue *)value selected:(BOOL)seleted;

@end
