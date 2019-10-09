

#import <UIKit/UIKit.h>

@protocol RadioButtonDelegate;

@interface RadioButton : UIButton
@property (nonatomic, retain) id<RadioButtonDelegate> delegate;
-(void)toggle;
@end


@protocol RadioButtonDelegate <NSObject>

-(void)radioButton:(RadioButton *)button selected:(BOOL)seleted;

@end
