//
//  PopViewController.h
//  Popovers
//
//  Created by Jay Versluis on 17/10/2015.
//  Copyright © 2015 Pinkstone Pictures LLC. All rights reserved.
//

#import <UIKit/UIKit.h>
@protocol PopViewDelegate;

@interface PopViewController : UIViewController
@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property (nonatomic, retain) id<PopViewDelegate> delegate;

@end
@interface PopTableViewCell : UITableViewCell

@end

@protocol PopViewDelegate <NSObject>

-(void)viewController:(PopViewController*)vc didSelectHistory:(NSMutableDictionary*)obj;

@end
