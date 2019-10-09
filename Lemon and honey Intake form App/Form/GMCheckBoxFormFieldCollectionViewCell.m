#import "GMCheckBoxFormFieldCollectionViewCell.h"
#import "AppDelegate.h"
@implementation GMCheckBoxFormFieldCollectionViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
    self.backgroundColor = [UIColor clearColor];
    self.checkBox.delegate = self;
}

-(void)setValue:(FORMFieldValue *)value {
    _value = value;
    self.label.text = value.title;
}

-(void)checkBoxButton:(CheckBoxButton *)button selected:(BOOL)seleted {
    if (self.delegate) {
        [self.delegate fieldValue:self.value selected:seleted];
    }
}

- (IBAction)buttonClickAction:(id)sender {
    if ([kApppDelegate.stringClass isEqualToString:@"history"]) {
        return;
    }
    [self.checkBox toggle];
}

@end
