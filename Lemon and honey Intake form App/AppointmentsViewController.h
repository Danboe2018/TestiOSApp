//
//  AppointmentsViewController.h
//  Lemon and honey Intake form App
//
//  Created by Gurie on 21/03/17.
//  Copyright © 2017 Gurie. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface AppointmentsViewController : UIViewController
@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property (strong, nonatomic) NSMutableArray* _searchAppointments;
@property (strong, nonatomic) NSMutableArray* _OLDsearchAppointments;
@property (strong, nonatomic) NSMutableArray* filteredTableData;
@property (strong, nonatomic) UIRefreshControl* refreshControl;

@property (weak, nonatomic) IBOutlet UISearchBar *searchBar;
@property (nonatomic, assign) bool isFiltered;

@end
