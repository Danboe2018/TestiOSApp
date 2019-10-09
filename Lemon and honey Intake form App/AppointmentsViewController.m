//
//  AppointmentsViewController.m
//  Lemon and honey Intake form App
//
//  Created by Gurie on 21/03/17.
//  Copyright © 2017 Gurie. All rights reserved.
//

#import "AppointmentsViewController.h"
#import "AppointmentsTableViewCell.h"
#import "MBProgressHUD.h"
#import "UIViewController+BasicFunctions.h"
#import "Appointments.h"
#import "AppDelegate.h"
@interface AppointmentsViewController ()
/*
 old
 new
 
 
 old - data
 new - data
 
 
 
 
 */
@end

@implementation AppointmentsViewController
@synthesize _searchAppointments;
@synthesize filteredTableData;
@synthesize searchBar;
@synthesize isFiltered;

- (void)viewDidLoad {
    [super viewDidLoad];
    searchBar.delegate = (id)self;
    self.title = @"Search Appointment";
    UIBarButtonItem * printValuesButton = [[UIBarButtonItem alloc] initWithTitle:@"Refresh"
                                                         style:UIBarButtonItemStyleDone
                                                        target:self
                                                        action:@selector(refreshButton)];
    self.navigationItem.rightBarButtonItem = printValuesButton;

    self.refreshControl = [[UIRefreshControl alloc]init];
    [self.tableView addSubview:self.refreshControl];
    [self.refreshControl addTarget:self action:@selector(refreshTable) forControlEvents:UIControlEventValueChanged];
    
    [self getAppointmentsSuggestions];
    // Do any additional setup after loading the view.
}

-(void)refreshButton
{
    [self getRefresh];

}

- (void)refreshTable {
    //TODO: refresh your data
    [self getRefresh];
    [self.refreshControl endRefreshing];
}


-(void)getRefresh
{
    if ([KappDelegate.ownerEmployee isEqualToString:@"frontDesk"]) {
        [self getAppointmentsSuggestions];
        
        return;
    }
    //http://ec2-34-233-15-97.compute-1.amazonaws.com/index.php/MillAppointmentsByStaff/getAppointments/223858308/10
    NSString * url = [NSString stringWithFormat:@"%@/%@/%@",@"http://ec2-34-233-15-97.compute-1.amazonaws.com/index.php/MillAppointmentsByStaff/getAppointments",[userDefaults() objectForKey:@"salonid"],[userDefaults() objectForKey:@"emp_iid"]];
    
    NSLog(@"%@",url);
    
    [self showHUD];
    [self POSTHTTP:url parameters:nil handler:^(NSError *error, id responseObject) {
        
        [self hideHUD];
        
        if (error) {
            [self alertTryAgain:error retrySelector:@selector(getRefresh)];
        }else {
            
            NSLog(@"%@",responseObject);
            NSDictionary * dictionary = responseObject[@"data"];
//            if ([dictionary[@"status"] boolValue])
//            {
//                [self getAppointmentsSuggestions];
//            }
//            else
//            {
                alert(@"Alert", dictionary[@"msg"]);
                
//            }
        }
    }];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)getAppointmentsSuggestions
{
    NSString * url = [NSString stringWithFormat:@"%@/%@",WS_GetAppointmentSuggestions,KappDelegate.stringStaff_id];
    NSLog(@"%@",url);

    [self showHUD];
    NSString * stringTodayDate = stringFromDate([NSDate date], @"yyyy/MM/dd");
    [self POSTHTTP:url parameters:@{@"salon_id":[self salonId],@"specific_date":stringTodayDate} handler:^(NSError *error, id responseObject) {
        
        [self hideHUD];
        
        if (error) {
            [self alertTryAgain:error retrySelector:@selector(getAppointmentsSuggestions)];
        }else {
            
            NSLog(@"%@",responseObject);
            
            if ([responseObject[@"status"] boolValue])
            {
                NSArray * countArray = responseObject[@"Appointments"];
                if (countArray.count == 0)
                {
                    alert(@"Alert", @"No Appointment available");
                }
                NSMutableArray * apps = [NSMutableArray array];
                int newApptCount = 0;
                for (NSDictionary *dict in responseObject[@"Appointments"])
                {
                    Appointments * app  = [Appointments new];
                    
                    app.name = [dict objectForKey:@"name"];
                    app.iempname = [dict objectForKey:@"iempname"];
                    app.service = [dict objectForKey:@"service"];
                    app.appointmentdate = [dict objectForKey:@"appointmentdate"];
                    app.clientid = [dict objectForKey:@"clientid"];
                    [apps addObject:app];
                }
                _searchAppointments = apps;
                for (int i = 0; i<_searchAppointments.count; i++) {
                    Appointments * new  = _searchAppointments[i];
                    Appointments * old  = __OLDsearchAppointments[i];
                    if (![new.name isEqualToString:old.name]) {
                        newApptCount ++;
                    }
                }
                if (!(newApptCount == 0)) {
                    alert(@"Alert", [NSString stringWithFormat:@"%d new Appointments",newApptCount]);
                }
                __OLDsearchAppointments = apps;
                [self.tableView reloadData];
            }
            else
            {
            }
        }
    }];
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    NSInteger rowCount;
    if(self.isFiltered)
        rowCount = filteredTableData.count;
    else
        rowCount = _searchAppointments.count;
    
    return rowCount;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"Cell";
    AppointmentsTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    
    if (cell == nil)
    {
        cell = [[AppointmentsTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier];
    }
    Appointments* app;
    if(isFiltered)
        app = [filteredTableData objectAtIndex:indexPath.row];
    else
        app = [_searchAppointments objectAtIndex:indexPath.row];
    // Configure the cell...
    cell.labelName.text             = app.name;
    cell.labelEmployeeName.text     = app.iempname;
    cell.labelServiceName.text      = app.service;
    NSString * string               = app.appointmentdate;
    cell.labelTime.text             = string;
    return cell;
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    Appointments* app;
    if(isFiltered)
        app = [filteredTableData objectAtIndex:indexPath.row];
    else
        app = [_searchAppointments objectAtIndex:indexPath.row];
    KappDelegate.clientValues = @{@"client_name":app.name,
                                  @"emailName"  :@"_",
                                  @"Id"         :app.clientid
                                  };
    NSUserDefaults * users = [NSUserDefaults standardUserDefaults];
    [users setValue:[NSString stringWithFormat:@"%@",KappDelegate.clientValues[@"client_name"]] forKey:@"Name"];

    KappDelegate.fromValidatePin =@"YES";

    [self.navigationController popViewControllerAnimated:YES];

}
#pragma mark - Table view delegate

-(void)searchBar:(UISearchBar*)searchBar textDidChange:(NSString*)text
{
    if(text.length <= 2)
    {
        isFiltered = FALSE;
    }
    else
    {
        isFiltered = true;
        filteredTableData = [[NSMutableArray alloc] init];
        
        for (Appointments * app in _searchAppointments)
        {
            NSRange nameRange = [app.name rangeOfString:text options:NSCaseInsensitiveSearch];
            NSRange descriptionRange = [app.iempname rangeOfString:text options:NSCaseInsensitiveSearch];
            if(nameRange.location != NSNotFound || descriptionRange.location != NSNotFound)
            {
                [filteredTableData addObject:app];
            }
        }
    }
    
    [self.tableView reloadData];
}


//--

-(NSString *)salonId {
    return SalonID;
}
-(NSString *)staffId {
    return [self userDetails][@"staff_id"];
}

-(NSString *)moduleId {
    return ModuleID;
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
