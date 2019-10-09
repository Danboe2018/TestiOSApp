@import UIKit;
#import "FORMBaseFieldCell.h"
#import "PPSSignatureView.h"

static NSString * const GMSignatureViewFieldCellIdentifier = @"GMSignatureViewFieldCellIdentifier";

static const NSInteger GMSignatureViewFieldCellItemHeight = 140.0f;

@interface GMSignatureViewFieldCell : FORMBaseFieldCell
@property (nonatomic, retain) UIImage * signatureImage;
@property (nonatomic, assign) UIViewController * viewController;

@end

//--
#pragma mark -

@protocol GMFormSignatureViewDelegate;

@interface GMFormSignatureViewController : UIViewController

@property (nonatomic, retain) PPSSignatureView * signatureView;
@property (nonatomic, retain) id<GMFormSignatureViewDelegate> delegate;

@end

//--

@protocol GMFormSignatureViewDelegate <NSObject>

-(void)signatureViewController:(GMFormSignatureViewController *)signVC signatureCompleted:(UIImage *)signImage;
-(void)didCancelSignatureViewController:(GMFormSignatureViewController *)signVC;

@end
