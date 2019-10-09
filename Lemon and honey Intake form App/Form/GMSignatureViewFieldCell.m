#import "GMSignatureViewFieldCell.h"
#import "FormHeader.h"
#import "PPSSignatureView.h"
#import "UIViewController+BasicFunctions.h"
#import <SDWebImage/UIImageView+WebCache.h>
#import "AppDelegate.h"
static const CGFloat HYPImageFormFieldTopMargin = 20.0f;

@interface GMSignatureViewFieldCell ()<GMFormSignatureViewDelegate>

@property (nonatomic, retain) UIImageView *container;
@property (nonatomic, retain) UILabel *labelName;

@end

@implementation GMSignatureViewFieldCell

#pragma mark - Initializers

- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (!self) return nil;
    
    self.contentView.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight;
    
    [self.contentView addSubview:[self container]];
    
    return self;
}

- (UIImageView *)container {
    
    if (!_container) {
        
        _container = [[UIImageView alloc] initWithFrame:CGRectZero];
        _container.autoresizingMask = UIViewAutoresizingFlexibleLeftMargin | UIViewAutoresizingFlexibleRightMargin;
        _container.userInteractionEnabled = true;
        _container.contentMode = UIViewContentModeScaleAspectFit;
        CGPoint center = self.contentView.center;
        center.y -= (HYPImageFormFieldTopMargin / 2.0f);
        
        _container.center = center;

        _labelName = [[UILabel alloc]initWithFrame:CGRectMake(10, 5, 150, 40)];
        _labelName.text = @"Click here to Sign";
        _labelName.textColor = [UIColor colorWithRed:69/255 green:92/255 blue:115/255 alpha:1 ];
        _labelName.font = [UIFont fontWithName:@"AvenirNext-Regular" size:15];
        [_container addSubview:_labelName];
        
        [self configureContainer];
        [self addTapGasture];
    }
    
    return _container;
}

-(void)addTapGasture {
    UITapGestureRecognizer * gesture = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(showSignatureViewController)];
    [self.container addGestureRecognizer:gesture];
}


-(void)configureContainer {
    _container.layer.cornerRadius = 5.0f;
    _container.layer.borderWidth = 1.0f;
    [self configureContainerWithValidation:YES];
}

-(void)configureContainerWithValidation:(BOOL)_valid
{
    [self configureContainerWithBackgroundColor:[[UIColor alloc] initWithHex:(_valid)?@"E1F5FF":@"FFD7D7"] borderColor:[[UIColor alloc] initWithHex:(_valid)?@"3DAFEB":@"EC3031"]];
}

-(void)configureContainerWithBackgroundColor:(UIColor *)_bgColor borderColor:(UIColor *)_bcColor {
    _container.backgroundColor = (self.field.value)?[UIColor whiteColor]:_bgColor;
    _container.layer.borderColor = _bcColor.CGColor;
}

- (void)updateWithField:(FORMField *)field {
    [super updateWithField:field];
    self.headingLabel.text = field.title;
    
}

- (void)updateFieldWithDisabled:(BOOL)disabled {
    [self configureContainerWithBackgroundColor:[[UIColor alloc] initWithHex:(!disabled)?@"E1F5FF":@"DEDEDE"] borderColor:(!disabled)?[[UIColor alloc] initWithHex:@"3DAFEB"]:[UIColor grayColor]];
}

- (void)validate {
    BOOL validation = (self.field.value);
    [self configureContainerWithValidation:validation];
}

-(void)setField:(FORMField *)field {
    [super setField:field];
    
    if (field.value && !self.container.image) {
        if ([field.value isKindOfClass:[UIImage class]]) {
            self.container.image = field.value;
        }else
        {
            //self.container.image = field.value;
//            NSString *imageUrl = field.value;
//            [NSURLConnection sendAsynchronousRequest:[NSURLRequest requestWithURL:[NSURL URLWithString:imageUrl]] queue:[NSOperationQueue mainQueue] completionHandler:^(NSURLResponse *response, NSData *data, NSError *error) {
//                self.container.image = [UIImage imageWithData:data];
//            }];
            //self.container.image = [UIImage imageWithContentsOfURL:[NSURL URLWithString:field.value]];
            //NSData * data = [[NSData alloc]initWithContentsOfURL:[NSURL URLWithString:field.value]];
            //self.container.image = [UIImage imageWithData:data];
            
           // [self.container sd_setImageWithURL:[NSURL URLWithString:field.value]
             //        placeholderImage:[UIImage imageNamed:@"Final-Lemon-and-honey-Logo.jpg"]];
        }
    }
}


#pragma mark - Layout

- (void)layoutSubviews {
    [super layoutSubviews];
    
    self.container.frame = [self containerFrame];
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


//--

-(void)showSignatureViewController  {
    
    if ([kApppDelegate.stringClass isEqualToString:@"history"]) {
        return;
    }
    
    //_signatureImage.image = self.field.value;
     [self.viewController.view endEditing:YES];
    GMFormSignatureViewController * signatureVC = [GMFormSignatureViewController new];
   
    signatureVC.delegate = self;
//    signatureVC.signatureView.signatureImage = self.container.image;
//    self.signatureImage = self.container.image;
       UINavigationController *navigationController = [[UINavigationController alloc] initWithRootViewController:signatureVC];
    
    if ([[UIDevice currentDevice] userInterfaceIdiom] == UIUserInterfaceIdiomPad)
    {
        UIPopoverController *popoverController = [[UIPopoverController alloc] initWithContentViewController:navigationController];
        popoverController.popoverContentSize = CGSizeMake(644, 425);
        [popoverController presentPopoverFromRect: self.contentView.frame
                                           inView: self.viewController.view
                         permittedArrowDirections: UIPopoverArrowDirectionAny
                                         animated: YES];
    } else {
        [self.viewController presentViewController: navigationController
                                              animated: YES
                                            completion: nil];
    }
}

-(void)signatureViewController:(GMFormSignatureViewController *)signVC signatureCompleted:(UIImage *)signImage {
    
    self.signatureImage = signImage;
    self.field.value = signImage;
    self.container.image = signImage;
    [self validate];
    
    if ([self.delegate respondsToSelector:@selector(fieldCell:updatedWithField:)]) {
        [self.delegate fieldCell:self
                updatedWithField:self.field];
    }
    
    [signVC.navigationController dismissViewControllerAnimated:YES completion:nil];
}

-(void)didCancelSignatureViewController:(GMFormSignatureViewController *)signVC {
    [signVC.navigationController dismissViewControllerAnimated:YES completion:nil];
}

-(UILabel *)headingLabel {
    UILabel * label = [super headingLabel];
    label.numberOfLines = 0;
    return label;
}
@end

@interface GMFormSignatureViewController ()

@property (nonatomic, retain) UIBarButtonItem * doneButton;
@property (nonatomic, retain) UIBarButtonItem * cancelButton;
@property (nonatomic, retain) UIBarButtonItem * resetButton;

@end

@implementation GMFormSignatureViewController

-(PPSSignatureView *)signatureView {
    if (!_signatureView) {
        _signatureView = [[PPSSignatureView alloc] initWithFrame:CGRectZero context:[EAGLContext currentContext]];
               _signatureView.strokeColor = [UIColor blackColor];
    }
    return _signatureView;
}

-(UIBarButtonItem *)doneButton {
    
    if (!_doneButton) {
        _doneButton = [[UIBarButtonItem alloc] initWithTitle:@"Done" style:UIBarButtonItemStyleDone target:self action:@selector(doneButtonAction:)];
    }
    return _doneButton;
}

-(UIBarButtonItem *)cancelButton {
    if (!_cancelButton) {
        _cancelButton = [[UIBarButtonItem alloc] initWithTitle:@"Cancel" style:UIBarButtonItemStylePlain target:self action:@selector(cancelButtonAction:)];
    }
    return _cancelButton;
}

-(UIBarButtonItem *)resetButton {
    if (!_resetButton) {
        _resetButton = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemTrash target:self action:@selector(resetAction:)];
    }
    return _resetButton;
}

-(void)resetAction:(id)sender {
    [self.signatureView erase];
}

-(void)doneButtonAction:(id)sender {
    
    if (self.delegate) {
        [self.delegate signatureViewController:self signatureCompleted:self.signatureView.signatureImage];
    }
}

-(void)cancelButtonAction:(id)sender {
    
    if (self.delegate) {
        [self.delegate didCancelSignatureViewController:self];
    }
}

-(void)viewDidLoad {
    
    [super viewDidLoad];
    
    self.title = @"Sign Here";
    
    self.view.backgroundColor = [UIColor grayColor];
   
   
   
    self.view = self.signatureView;
    
    
    
    self.navigationItem.rightBarButtonItem = self.doneButton;
    self.navigationItem.leftBarButtonItems = @[self.cancelButton, self.resetButton];
}

-(void)viewDidLayoutSubviews {
    [super viewDidLayoutSubviews];
  

    self.signatureView.frame = self.view.bounds;
}

-(void)viewDidAppear:(BOOL)animated {
    [super viewDidAppear:animated];
    self.signatureView.frame = self.view.bounds;
   
    NSLog(@"%@",NSStringFromCGRect(self.signatureView.frame));
}

@end
