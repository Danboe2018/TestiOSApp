

#import "RadioButton.h"

@implementation RadioButton

-(void)awakeFromNib {
    
    [super awakeFromNib];
    
    [self setTintColor:[UIColor clearColor]];
    [self setBackgroundColor:[UIColor clearColor]];
    [self setBackgroundImage:[UIImage imageNamed:@"radioButtonUnSelected.png"] forState:UIControlStateNormal];
    [self setBackgroundImage:[UIImage imageNamed:@"radioButtonSelected.png"] forState:UIControlStateSelected];
    [self addTarget:self action:@selector(actionCheckBox) forControlEvents:UIControlEventTouchUpInside];
}

-(void)actionCheckBox {
    
    self.selected = !self.selected;
    if (self.delegate) {
     [self.delegate radioButton:self selected:self.selected];
    }
}

-(void)toggle {
    [self actionCheckBox];
}

@end
