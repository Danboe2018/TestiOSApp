

#import "CheckBoxButton.h"

@implementation CheckBoxButton
-(void)awakeFromNib
{
    [super awakeFromNib];
    [self setTintColor:[UIColor clearColor]];
    [self setBackgroundColor:[UIColor clearColor]];
    [self setBackgroundImage:[UIImage imageNamed:@"uncheck-box.png"] forState:UIControlStateNormal];
    [self setBackgroundImage:[UIImage imageNamed:@"check-box.png"] forState:UIControlStateSelected];
    [self addTarget:self action:@selector(actionCheckBox) forControlEvents:UIControlEventTouchUpInside];
}

-(void)actionCheckBox
{
    self.selected = !self.selected;
    if (self.delegate) {
     [self.delegate checkBoxButton:self selected:self.selected];   
    }
}

-(void)toggle {
    [self actionCheckBox];
}

@end
