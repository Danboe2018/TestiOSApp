@import UIKit;
#import "FORMBaseFieldCell.h"
#import "GMRatingViewFieldCell.h"
#import <DYRateView/DYRateView.h>

static NSString * const GMRatingViewFieldCellIdentifier = @"GMRatingViewFieldCellIdentifier";

static const NSInteger GMRatingViewFieldCellItemHeight = 140.0f;

@interface GMRatingViewFieldCell : FORMBaseFieldCell
@property (nonatomic, retain) UIImage * signatureImage;
@property (nonatomic, assign) UIViewController * viewController;

@end

//--
#pragma mark -

@protocol GMFormRatingViewDelegate;

@interface GMFormRatingViewController : UIViewController

@property (nonatomic, retain) DYRateView * signatureView;
@property (nonatomic, retain) id<GMFormRatingViewDelegate> delegate;

@end

//--

@protocol GMFormRatingViewDelegate <NSObject>


@end
