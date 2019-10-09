#import "GMRadioButtonFormFieldCell.h"

#import "FormHeader.h"
#import "GMRadioButtonFormFieldDataModel.h"

static const CGFloat HYPImageFormFieldTopMargin = 20.0f;
static const CGFloat HYPImageFormFieldHorizontalMargin = 10.0f;

static const CGFloat HYPImageFormFieldLabelY = 25.0f;
static const CGFloat HYPImageFormFieldLabelHeight = 25.0f;

static const CGFloat HYPImageFormFieldContainerWidth = 360.0f;

@interface GMRadioButtonFormFieldCell ()<GMRadioButtonFormFieldDataModelDelegate>

@property (nonatomic, retain) GMRadioButtonFormFieldDataModel * model;
@property (nonatomic, retain) UIView *container;
@property (nonatomic, retain) UICollectionView *collectionView;

@end

@implementation GMRadioButtonFormFieldCell

#pragma mark - Initializers

- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (!self) return nil;

    self.contentView.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight;

    [self.contentView addSubview:[self container]];

    return self;
}
-(UICollectionView *)collectionView {
    
    if (!_collectionView) {
        CGRect frame = CGRectMake(HYPImageFormFieldHorizontalMargin, HYPImageFormFieldLabelY + HYPImageFormFieldLabelHeight + HYPImageFormFieldTopMargin, HYPImageFormFieldContainerWidth - (HYPImageFormFieldHorizontalMargin * 2),  self.frame.size.height - (HYPImageFormFieldTopMargin * 2));
        UICollectionView * collectionView = [[UICollectionView alloc] initWithFrame:frame collectionViewLayout:[[UICollectionViewFlowLayout alloc]init]];
        collectionView.backgroundColor = [UIColor clearColor];
        _collectionView = collectionView;
        _collectionView.scrollEnabled = false;
        _collectionView.allowsSelection = false;
        
        self.model = [GMRadioButtonFormFieldDataModel modelFor:_collectionView];
        self.model.delegate = self;
    }
    
    return _collectionView;
}

-(void)dataUpdatesDoneFor:(GMRadioButtonFormFieldDataModel *)model {
    [self validate];
    
    if ([self.delegate respondsToSelector:@selector(fieldCell:updatedWithField:)]) {
        [self.delegate fieldCell:self
                updatedWithField:self.field];
    }
}

- (UIView *)container {
    
    if (!_container) {
        _container = [[UIView alloc] initWithFrame:CGRectZero];
        _container.autoresizingMask = UIViewAutoresizingFlexibleLeftMargin | UIViewAutoresizingFlexibleRightMargin;
        
        CGPoint center = self.contentView.center;
        center.y -= (HYPImageFormFieldTopMargin / 2.0f);
        
        _container.center = center;
        
        [_container addSubview:self.collectionView];
        
        [self configureContainer];
    }

    return _container;
}

-(void)configureContainer {
    _container.layer.cornerRadius = 5.0f;
    _container.layer.borderWidth = 1.0f;
    [self configureContainerWithValidation:YES];
}

-(void)configureContainerWithValidation:(BOOL)_valid {
    [self configureContainerWithBackgroundColor:[UIColor clearColor]
                                    borderColor:[UIColor clearColor]];
}

-(void)configureContainerWithBackgroundColor:(UIColor *)_bgColor borderColor:(UIColor *)_bcColor {
    _container.backgroundColor = _bgColor;
    _container.layer.borderColor = _bcColor.CGColor;
}

- (void)updateWithField:(FORMField *)field {
    [super updateWithField:field];
    self.headingLabel.text = field.title;
    self.model.field = field;
    
}

- (void)updateFieldWithDisabled:(BOOL)disabled {
    [self configureContainerWithBackgroundColor:[UIColor clearColor]
                                    borderColor:[UIColor clearColor]];
}

- (void)validate {
    BOOL validation = ([self.field validate] == FORMValidationResultTypeValid);
    [self configureContainerWithValidation:validation];
}
-(UILabel *)headingLabel {
    UILabel * label = [super headingLabel];
    label.numberOfLines = 0;
    return label;
}
#pragma mark - Layout

- (void)layoutSubviews {
    [super layoutSubviews];

    self.container.frame = [self containerFrame];
    self.collectionView.frame = self.container.bounds;
}
- (CGRect)headingLabelFrame {
    
    CGFloat marginX = 15;
    CGFloat marginTop = 10;
    
    CGFloat width = CGRectGetWidth(self.frame) - (marginX * 2);
    CGFloat height = [self heightForText:self.field.title maxWidth:width - 30];
    CGRect frame = CGRectMake(marginX, marginTop, width, 40);
    
    return frame;
}

- (CGRect)containerFrame {
    CGFloat marginX = FORMTextFieldCellMarginX;
    CGFloat marginTop = [self headingLabelFrame].origin.y + [self headingLabelFrame].size.height;
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
@end
