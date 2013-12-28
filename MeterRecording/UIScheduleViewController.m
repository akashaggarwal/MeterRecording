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
#import "UIScheduleDetailViewController.h"


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
    NSError *error;
	if (![[self fetchedResultsController] performFetch:&error]) {
		NSLog(@"An error occurred: %@", [error localizedDescription]);
	}

   
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

- (NSFetchedResultsController *) fetchedResultsController {
    
    if (_fetchedResultsController) {
        return _fetchedResultsController;
    }
    
    //DataStore *dataStore = [DataStore sharedDataStore];
    NSManagedObjectContext *context = [self.content managedObjectContext];
    
    NSFetchRequest *fetch = [NSFetchRequest fetchRequestWithEntityName:@"Schedule"];
    
    NSSortDescriptor *primarySort = [NSSortDescriptor sortDescriptorWithKey:@"city"
                                                                  ascending:YES];
//    NSSortDescriptor *secondarySort = [NSSortDescriptor sortDescriptorWithKey:@"itemName"
//                                                                    ascending:YES];
//    
    NSArray *sortArray = [NSArray arrayWithObjects:primarySort,  nil];
    
    [fetch setSortDescriptors:sortArray];
    
    NSDate *currentDate = [AppContent getCurrentDate];
    
    NSString *attributeName = @"installerID";
    NSString *attributeValue = [self.content installerID];
    NSPredicate *p = [NSPredicate predicateWithFormat:@"installerID == %@",
                      attributeValue, currentDate];
    
    [fetch setPredicate:p];
    
    NSFetchedResultsController *frc = [[NSFetchedResultsController alloc] initWithFetchRequest:fetch
                                                                          managedObjectContext:context
                                                                            sectionNameKeyPath:@"city"
                                                                                     cacheName:nil];
    
    [self setFetchedResultsController:frc];
    [[self fetchedResultsController] setDelegate:self];
    
    return _fetchedResultsController;
}


#pragma mark - NSFetchedResultsControllerDelegate methods

- (void)controllerWillChangeContent:(NSFetchedResultsController *)controller {
    
    [[self tableView] beginUpdates];
}

- (void)controller:(NSFetchedResultsController *)controller
  didChangeSection:(id<NSFetchedResultsSectionInfo>)sectionInfo
           atIndex:(NSUInteger)sectionIndex
     forChangeType:(NSFetchedResultsChangeType)type {
    
    switch(type) {
        case NSFetchedResultsChangeInsert:
            [[self tableView] insertSections:[NSIndexSet indexSetWithIndex:sectionIndex]
                            withRowAnimation:UITableViewRowAnimationFade];
            break;
            
        case NSFetchedResultsChangeDelete:
            [[self tableView] deleteSections:[NSIndexSet indexSetWithIndex:sectionIndex]
                            withRowAnimation:UITableViewRowAnimationFade];
            break;
    }
    
}

- (void)controller:(NSFetchedResultsController *)controller
   didChangeObject:(id)anObject
       atIndexPath:(NSIndexPath *)indexPath
     forChangeType:(NSFetchedResultsChangeType)type
      newIndexPath:(NSIndexPath *)newIndexPath {
    
    switch(type) {
            
        case NSFetchedResultsChangeInsert:
            [[self tableView] insertRowsAtIndexPaths:[NSArray arrayWithObject:newIndexPath]
                                    withRowAnimation:UITableViewRowAnimationFade];
            break;
            
        case NSFetchedResultsChangeDelete:
            [[self tableView] deleteRowsAtIndexPaths:[NSArray arrayWithObject:indexPath]
                                    withRowAnimation:UITableViewRowAnimationFade];
            break;
            
        case NSFetchedResultsChangeUpdate:
        {
            ScheduleCell *cell = [[self tableView] cellForRowAtIndexPath:indexPath];
            Schedule *sch = [[self fetchedResultsController] objectAtIndexPath:indexPath];
            NSLog(@"name is ->%@", sch.name);
             NSLog(@"id is ->%@", sch.scheduleID);
            cell.lblName.text = sch.name;
            cell.lblAddress.text = sch.address;
            cell.lblCity.text = sch.city;
            cell.lblScheduleDate.text =  sch.scheduleDate;
            cell.lblScheduleTime.text= sch.scheduleTime;
            break;
        }
            
        case NSFetchedResultsChangeMove:
            [[self tableView] deleteRowsAtIndexPaths:[NSArray arrayWithObject:indexPath]
                                    withRowAnimation:UITableViewRowAnimationFade];
            [[self tableView] insertRowsAtIndexPaths:[NSArray arrayWithObject:newIndexPath]
                                    withRowAnimation:UITableViewRowAnimationFade];
            break;
    }
    
}

- (NSString *)controller:(NSFetchedResultsController *)controller
sectionIndexTitleForSectionName:(NSString *)sectionName {
    
    return sectionName;
}

- (void)controllerDidChangeContent:(NSFetchedResultsController *)controller {
    
    [[self tableView] endUpdates];
}



#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
     if (tableView == self.tableView)
     {
         NSArray *sections = [[self fetchedResultsController] sections];
         return [sections count];
     }
    else
    {
        return 1;
    }
    
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if (tableView == self.tableView)
    {
        NSArray *sections = [[self fetchedResultsController] sections];
        id<NSFetchedResultsSectionInfo> currentSection = [sections objectAtIndex:section];
        return [currentSection numberOfObjects];
    }
    else
    {
         return [_filteredschedules count];
    }
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"ScheduleCell";
    ScheduleCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier forIndexPath:indexPath];
    
    if ( cell == nil )
    {
        cell = [[ScheduleCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier];
        cell.backgroundColor = [UIColor blueColor];
    }
    Schedule *sch = nil ;
    if (tableView == self.tableView)
    {
      sch = [[self fetchedResultsController] objectAtIndexPath:indexPath];
    }
    else
    {
        sch = [_filteredschedules objectAtIndex:indexPath.row];
             // NSLog(@" inside cellForRowAtIndexPath search controller is %d", [_filteredschedules count]);
    }
    //Schedule *sch = [[self fetchedResultsController] objectAtIndexPath:indexPath];
     NSLog(@"name is ->%@", sch.name);
    cell.lblName.text = sch.name;
    cell.lblAddress.text = sch.address;
    cell.lblCity.text = sch.city;
    cell.lblScheduleDate.text =  sch.scheduleDate;
    cell.lblScheduleTime.text= sch.scheduleTime;
    
    return cell;
}

- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section {
    
    NSArray *sections = [[self fetchedResultsController] sections];
    id<NSFetchedResultsSectionInfo> currentSection = [sections objectAtIndex:section];
    return [currentSection name];
    
}





#pragma mark - Table view data source

//- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
//{
//#warning Potentially incomplete method implementation.
//    // Return the number of sections.
//    return 1;
//}

//- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
//{
//#warning Incomplete method implementation.
//    // Return the number of rows in the section.
//    if (tableView == self.tableView) {
//        return [self.content.session.schedules count];
//    }
//    else
//    {
//         //NSLog(@" inside number of rows %d", [_filteredschedules count]);
//         return [_filteredschedules count];
//    }
//    
//}

//- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
//{
//    static NSString *CellIdentifier = @"ScheduleCell";
//    ScheduleCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
//    if ( cell == nil )
//    {
//        cell = [[ScheduleCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier];
//        cell.backgroundColor = [UIColor blueColor];
//    }
//    Schedule *sch = nil ;
//    if (tableView == self.tableView) {
//         sch = [self.content.session.schedules  objectAtIndex:indexPath.row];
//        //NSLog(@" inside cellForRowAtIndexPath regular controller is %d", indexPath.row);
//       
//    } else {
//        sch = [_filteredschedules objectAtIndex:indexPath.row];
//         // NSLog(@" inside cellForRowAtIndexPath search controller is %d", [_filteredschedules count]);
//    }
//    if (indexPath.row %2  == 0)
//    {
//        UIImage *selectedImage0 = [UIImage imageNamed:@"morework.png"];
//        cell.imgstatus.image = selectedImage0;
//        
//    }
//    //Schedule *sch = [self.content.schedules objectAtIndex:indexPath.row];
//   // NSLog(@" name is %@", sch.name);
//    cell.lblName.text = sch.name;
//    cell.lblAddress.text = sch.address;
//    cell.lblCity.text = sch.city;
//    cell.lblScheduleDate.text =  sch.scheduleDate;
//    cell.lblScheduleTime.text= sch.scheduleTime;
//    // Configure the cell...
//    
//    return cell;
//}

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
#pragma mark - Segue
-(void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    if ([[segue identifier] isEqualToString:@"searchDetail"]) {
        Schedule *sch = nil ;
       
        UIScheduleDetailViewController  *searchDetailViewController = [segue destinationViewController];
        // In order to manipulate the destination view controller, another check on which table (search or normal) is displayed is needed
        if(sender == self.searchDisplayController.searchResultsTableView)
        {
            NSIndexPath *indexPath = [self.searchDisplayController.searchResultsTableView indexPathForSelectedRow];
            sch = [_filteredschedules objectAtIndex:indexPath.row];
           [self setClaimData:sch controller:searchDetailViewController];
            
        }
        else
        {
            NSIndexPath *indexPath = [self.tableView indexPathForSelectedRow];
            sch = [self.fetchedResultsController objectAtIndexPath:indexPath];
           [self setClaimData:sch controller:searchDetailViewController];
        }
        
    }
}

-(void) setClaimData:(Schedule *) sch controller: (UIScheduleDetailViewController *) searchDetailViewController
{
    
    MyClaim *m = [MyClaim sharedContent];
   // [m resetClaim];
    m.claim = sch;
    NSString *destinationTitle = sch.name;
    [searchDetailViewController setTitle:destinationTitle];
    //[searchDetailViewController setCurrentclaim:m];
}

@end
