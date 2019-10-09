#import "GMRatingViewFieldCell.h"
#import "FormHeader.h"
#import "PPSSignatureView.h"
#import "UIViewController+BasicFunctions.h"
#import <SDWebImage/UIImageView+WebCache.h>



@interface GMRatingViewFieldCell ()<GMFormRatingViewDelegate,DYRateViewDelegate>

@property (nonatomic, retain) DYRateView *container;
@property (nonatomic, retain) UILabel *labelName;

@end

@implementation GMRatingViewFieldCell

#pragma mark - Initializers

- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (!self) return nil;
    
    self.contentView.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight;
    
    [self.contentView addSubview:[self container]];
    
    return self;
}

- (DYRateView *)container {
    
    if (!_container) {
        
        _container = [[DYRateView alloc] initWithFrame:CGRectMake(0, 12,100, 100) fullStar:[UIImage imageNamed:@"StarFullLarge@3x"] emptyStar:[UIImage imageNamed:@"StarEmptyLarge@3x"]];
        
        [_container setEditable:YES];
        // _container.backgroundColor = [UIColor redColor];
        [_container setAlignment:RateViewAlignmentLeft];
        [_container setPadding:18.0];
        [_container setDelegate:self];
        //[_container setRate:1];
        //[self configureContainer];

        
    }
    
    return _container;
}

-(void)configureContainer {
    _container.layer.cornerRadius = 5.0f;
    _container.layer.borderWidth = 1.0f;
   // [self configureContainerWithValidation:YES];
}

//-(void)configureContainerWithValidation:(BOOL)_valid
//{
//    [self configureContainerWithBackgroundColor:[[UIColor alloc] initWithHex:(_valid)?@"E1F5FF":@"FFD7D7"] borderColor:[[UIColor alloc] initWithHex:(_valid)?@"3DAFEB":@"EC3031"]];
//}

-(void)configureContainerWithBackgroundColor:(UIColor *)_bgColor borderColor:(UIColor *)_bcColor {
    _container.backgroundColor = (self.field.value)?[UIColor whiteColor]:_bgColor;
    _container.layer.borderColor = _bcColor.CGColor;
}

- (void)updateWithField:(FORMField *)field {
    [super updateWithField:field];
    self.headingLabel.text = field.title;
    //self.field.value = field.value;


    
}

- (void)updateFieldWithDisabled:(BOOL)disabled {
   // [self configureContainerWithBackgroundColor:[[UIColor alloc] initWithHex:(!disabled)?@"E1F5FF":@"DEDEDE"] borderColor:(!disabled)?[[UIColor alloc] initWithHex:@"3DAFEB"]:[UIColor grayColor]];
}

- (void)validate {
    BOOL validation = (self.field.value);
    //[self configureContainerWithValidation:validation];
}

-(void)setField:(FORMField *)field {
    [super setField:field];
    
        if (field.value) {
            self.container.rate = [field.value intValue];
        }
    
    
       }
- (void)rateView:(DYRateView *)rateView changedToNewRate:(NSNumber *)rate{
  NSString *ratestr = [rate stringValue];
    NSLog(@"Rate: %@ %@",ratestr,self.field.title);
  
    self.field.value = [NSString stringWithFormat:@"%@",ratestr];
    //self.container.rate = [ratestr intValue];
  // [self validate];

    //[self setField:self.field];
    
if ([self.delegate respondsToSelector:@selector(fieldCell:updatedWithField:)]) {
    [self.delegate fieldCell:self
            updatedWithField:self.field];
   
}
    
}
#pragma mark - Layout

- (void)layoutSubviews {
    [super layoutSubviews];
    
    self.container.frame = [self containerFrame];
    //self.container.backgroundColor = [UIColor yellowColor];
}

- (CGRect)headingLabelFrame {
    
    CGFloat marginX = 15;
    CGFloat marginTop = 10;
    
    CGFloat width = CGRectGetWidth(self.frame) - (marginX * 2);
    CGFloat height = [self heightForText:self.field.title maxWidth:width - 10];
    CGRect frame = CGRectMake(marginX, marginTop, width, height);
    
    return frame;
}

- (CGRect)containerFrame {
    
    CGFloat marginX = FORMTextFieldCellMarginX;
    CGFloat marginTop = [self headingLabelFrame].origin.y + [self headingLabelFrame].size.height+10;
    CGFloat marginBotton = FORMFieldCellMarginBottom;
    
    CGFloat width  = CGRectGetWidth(self.frame) - (marginX * 2);
    CGFloat height = CGRectGetHeight(self.frame) - marginTop - marginBotton;
    CGRect  frame  = CGRectMake(marginX, marginTop, width, height);
    
    return frame;
}

-(CGFloat)heightForText:(NSString *)text maxWidth:(CGFloat)width {
    
    CGSize constraint = CGSizeMake(width, 20000.0f);
    CGSize size = [text sizeWithFont:[UIFont systemFontOfSize:17] constrainedToSize:constraint lineBreakMode:UILineBreakModeWordWrap];
    return size.height;
}


//--

@end
