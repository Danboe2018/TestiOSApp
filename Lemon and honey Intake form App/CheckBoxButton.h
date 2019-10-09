

#import <UIKit/UIKit.h>

@protocol CheckBoxButtonDelegate;

@interface CheckBoxButton : UIButton
@property (nonatomic, retain) id<CheckBoxButtonDelegate> delegate;
-(void)toggle;
@end


@protocol CheckBoxButtonDelegate <NSObject>

-(void)checkBoxButton:(CheckBoxButton *)button selected:(BOOL)seleted;

@end
