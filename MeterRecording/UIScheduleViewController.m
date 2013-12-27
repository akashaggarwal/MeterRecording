//
//  UIScheduleViewController.m
//  MeterRecording
//
//  Created by Akash Aggarwal on 11/3/13.
//  Copyright (c) 2013 Akash Aggarwal. All rights reserved.
//

#import "UIScheduleViewController.h"
#import "ScheduleCell.h"
#import "Schedule.h"
@interface UIScheduleViewController ()

@end

@implementation UIScheduleViewController

//- (id)initWithStyle:(UITableViewStyle)style
//{
//    self = [super initWithStyle:style];
//    if (self) {
//        // Custom initialization
//    }
//    return self;
//}

- (void)viewDidLoad
{
    [super viewDidLoad];
    //NSLog(@"inside view did load");
    
    self.content = [AppContent sharedContent];
   // NSLog(@"%d schedules",[self.content.session.schedules count]);
    
     self.filteredschedules = [NSMutableArray arrayWithCapacity:[self.content.session.schedules count]];
    
   
    // Uncomment the following line to preserve selection between presentations.
    // self.clearsSelectionOnViewWillAppear = NO;
 
    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    // self.navigationItem.rightBarButtonItem = self.editButtonItem;
    
    // Reload the table
   // [[self tableView] reloadData];
    [self setupSearchBar];
    [[self tableView] reloadData];
    
}



- (void)setupSearchBar {
    self.searchBar = [[UISearchBar alloc] initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, 44)];
    self.tableView.tableHeaderView = self.searchBar;
    
    // scroll just past the search bar initially
    CGPoint offset = CGPointMake(0, self.searchBar.frame.size.height);
    self.tableView.contentOffset = offset;
    
    
    
    // in setupSearchBar
    self.searchController = [[UISearchDisplayController alloc] initWithSearchBar:self.searchBar
                                                              contentsController:self];
    self.searchController.searchResultsDataSource = self;
    self.searchController.searchResultsDelegate = self;
    self.searchController.delegate = self;

}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
#warning Potentially incomplete method implementation.
    // Return the number of sections.
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
#warning Incomplete method implementation.
    // Return the number of rows in the section.
    if (tableView == self.tableView) {
        return [self.content.session.schedules count];
    }
    else
    {
         //NSLog(@" inside number of rows %d", [_filteredschedules count]);
         return [_filteredschedules count];
    }
    
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"ScheduleCell";
    ScheduleCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if ( cell == nil )
    {
        cell = [[ScheduleCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier];
        cell.backgroundColor = [UIColor blueColor];
    }
    Schedule *sch = nil ;
    if (tableView == self.tableView) {
         sch = [self.content.session.schedules  objectAtIndex:indexPath.row];
        //NSLog(@" inside cellForRowAtIndexPath regular controller is %d", indexPath.row);
       
    } else {
        sch = [_filteredschedules objectAtIndex:indexPath.row];
         // NSLog(@" inside cellForRowAtIndexPath search controller is %d", [_filteredschedules count]);
    }
    if (indexPath.row %2  == 0)
    {
        UIImage *selectedImage0 = [UIImage imageNamed:@"morework.png"];
        cell.imgstatus.image = selectedImage0;
        
    }
    //Schedule *sch = [self.content.schedules objectAtIndex:indexPath.row];
   // NSLog(@" name is %@", sch.name);
    cell.lblName.text = sch.name;
    cell.lblAddress.text = sch.address;
    cell.lblCity.text = sch.city;
    cell.lblScheduleDate.text =  sch.scheduleDate;
    cell.lblScheduleTime.text= sch.scheduleTime;
    // Configure the cell...
    
    return cell;
}

/*
// Override to support conditional editing of the table view.
- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath
{
    // Return NO if you do not want the specified item to be editable.
    return YES;
}
*/

/*
// Override to support editing the table view.
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        // Delete the row from the data source
        [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
    }   
    else if (editingStyle == UITableViewCellEditingStyleInsert) {
        // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
    }   
}
*/

/*
// Override to support rearranging the table view.
- (void)tableView:(UITableView *)tableView moveRowAtIndexPath:(NSIndexPath *)fromIndexPath toIndexPath:(NSIndexPath *)toIndexPath
{
}
*/

/*
// Override to support conditional rearranging of the table view.
- (BOOL)tableView:(UITableView *)tableView canMoveRowAtIndexPath:(NSIndexPath *)indexPath
{
    // Return NO if you do not want the item to be re-orderable.
    return YES;
}
*/








#pragma mark Content Filtering
-(void)filterContentForSearchText:(NSString*)searchText scope:(NSString*)scope {
    // Update the filtered array based on the search text and scope.
    // Remove all objects from the filtered search array
    NSLog(@"inside filtercontext");

    [self.filteredschedules removeAllObjects];
    // Filter the array using NSPredicate
    NSPredicate *predicate = [NSPredicate predicateWithFormat:@"SELF.address contains[c] %@",searchText];
   // NSArray *temp = [self.content.session.schedules
   // _filteredschedules = [NSMutableArray arrayWithArray:[self.content.session.schedules filteredArrayUsingPredicate:predicate]];
    NSLog(@"filtered array count is %d", [_filteredschedules count]);
}

#pragma mark - UISearchDisplayController Delegate Methods
-(BOOL)searchDisplayController:(UISearchDisplayController *)controller shouldReloadTableForSearchString:(NSString *)searchString {
    // Tells the table data source to reload when text changes
       NSLog(@"inside shouldreload");
    [self filterContentForSearchText:searchString scope:
     [[self.searchDisplayController.searchBar scopeButtonTitles] objectAtIndex:[self.searchDisplayController.searchBar selectedScopeButtonIndex]]];
    // Return YES to cause the search result table view to be reloaded.
    return YES;
}

-(BOOL)searchDisplayController:(UISearchDisplayController *)controller shouldReloadTableForSearchScope:(NSInteger)searchOption {
    // Tells the table data source to reload when scope bar selection changes
      NSLog(@"inside shouldreload for search sope");
    [self filterContentForSearchText:self.searchDisplayController.searchBar.text scope:
     [[self.searchDisplayController.searchBar scopeButtonTitles] objectAtIndex:searchOption]];
    // Return YES to cause the search result table view to be reloaded.
    return YES;
}

//
//
//#pragma mark - TableView Delegate
//-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
//    // Perform segue to candy detail
//    [self performSegueWithIdentifier:@"searchDetail" sender:tableView];
//}
//
//#pragma mark - Segue
//-(void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
//    if ([[segue identifier] isEqualToString:@"searchDetail"]) {
//        UIViewController *searchDetailViewController = [segue destinationViewController];
//        // In order to manipulate the destination view controller, another check on which table (search or normal) is displayed is needed
//        if(sender == self.searchDisplayController.searchResultsTableView) {
//            NSIndexPath *indexPath = [self.searchDisplayController.searchResultsTableView indexPathForSelectedRow];
//            NSString *destinationTitle = [[_filteredschedules objectAtIndex:[indexPath row]] name];
//            [searchDetailViewController setTitle:destinationTitle];
//        }
//        else {
//            NSIndexPath *indexPath = [self.tableView indexPathForSelectedRow];
//            NSString *destinationTitle = [[self.content.schedules objectAtIndex:[indexPath row]] name];
//            [searchDetailViewController setTitle:destinationTitle];
//        }
//        
//    }
//}

@end
