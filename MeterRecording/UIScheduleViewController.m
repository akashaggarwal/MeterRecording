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
    NSLog(@"inside view did load");
    
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
    [self.searchDisplayController.searchResultsTableView setRowHeight:self.tableView.rowHeight];
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
    
    NSFetchRequest *fetch = [NSFetchRequest fetchRequestWithEntityName:ENTITY_SCHEDULE];
    
    NSSortDescriptor *primarySort = [NSSortDescriptor sortDescriptorWithKey:@"localschedulestatus"
                                                                  ascending:NO];
    //NSSortDescriptor *secondarySort = [NSSortDescriptor sortDescriptorWithKey:@"name"
  //                                                                  ascending:YES];
//    
    NSArray *sortArray = [NSArray arrayWithObjects:primarySort ,nil];
    
    [fetch setSortDescriptors:sortArray];
    
    NSDate *currentDate = [AppContent getCurrentDate];
    
    NSString *attributeName = @"installerID";
    NSString *attributeValue = [self.content installerID];
    NSPredicate *p = [NSPredicate predicateWithFormat:@"installerID == %@",
                      attributeValue, currentDate];
    
    [fetch setPredicate:p];
    
    NSFetchedResultsController *frc = [[NSFetchedResultsController alloc] initWithFetchRequest:fetch
                                                                          managedObjectContext:context
                                                                            sectionNameKeyPath:@"localschedulestatus"
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
            ScheduleCell *cell = (ScheduleCell *)[[self tableView] cellForRowAtIndexPath:indexPath];
            Schedule *sch = [[self fetchedResultsController] objectAtIndexPath:indexPath];
            NSLog(@"name is ->%@", sch.name);
             NSLog(@"id is ->%@", sch.scheduleID);
            cell.lblName.text = sch.name;
            cell.lblAddress.text = sch.address;
            cell.lblCity.text = sch.city;
            cell.lblScheduleDate.text =  sch.scheduleDate;
            cell.lblScheduleTime.text= sch.scheduleTime;
            if ([sch.localschedulestatus isEqualToString:CLAIM_QUEUED])
                cell.imgstatus.image = [UIImage imageNamed:@"Queued"];
            if ([sch.localschedulestatus isEqualToString:CLAIM_COMPLETED])
                cell.imgstatus.image = [UIImage imageNamed:@"Completed"];
            if ([sch.localschedulestatus isEqualToString:CLAIM_INCOMPLETE])
                cell.imgstatus.image = nil;
            
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
        NSLog(@"inside numberofrowsinsection %d",[_filteredschedules count]);
         return [_filteredschedules count];
    }
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"ScheduleCell";
    ScheduleCell *cell ;
      if (tableView == self.tableView)
      {
          cell = [self.mytableView dequeueReusableCellWithIdentifier:CellIdentifier forIndexPath:indexPath];
      }
    else
    {
        cell = [self.mytableView dequeueReusableCellWithIdentifier:CellIdentifier ];

    }
    if ( cell == nil )
    {
         NSLog(@"cell is nil");
        cell = [[ScheduleCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier];
        //cell.backgroundColor = [UIColor blueColor];
    }
    Schedule *sch = nil ;
    if (tableView == self.tableView)
    {
      sch = [[self fetchedResultsController] objectAtIndexPath:indexPath];
    }
    else
    {
        sch = [_filteredschedules objectAtIndex:indexPath.row];
         NSLog(@" inside cellForRowAtIndexPath search controller is %d", [_filteredschedules count]);
    }
    //Schedule *sch = [[self fetchedResultsController] objectAtIndexPath:indexPath];
     NSLog(@"name is ->%@", sch.name);
    cell.lblName.text = sch.name;
    cell.lblAddress.text = sch.address;
    cell.lblCity.text = sch.city;
    cell.lblScheduleDate.text =  sch.scheduleDate;
    cell.lblScheduleTime.text= sch.scheduleTime;
    
    if ([sch.localschedulestatus isEqualToString:CLAIM_QUEUED])
        cell.imgstatus.image = [UIImage imageNamed:@"Queued"];
    if ([sch.localschedulestatus isEqualToString:CLAIM_COMPLETED])
        cell.imgstatus.image = [UIImage imageNamed:@"Completed"];
    if ([sch.localschedulestatus isEqualToString:CLAIM_INCOMPLETE])
        cell.imgstatus.image = nil;

    return cell;
}

- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section {
    
    NSArray *sections = [[self fetchedResultsController] sections];
    id<NSFetchedResultsSectionInfo> currentSection = [sections objectAtIndex:section];
    NSString *sectionName = [currentSection name];
    if ([sectionName isEqualToString:CLAIM_COMPLETED])
        return @"COMPLETED";
    if ([sectionName isEqualToString:CLAIM_QUEUED])
        return @"QUEUED";
    
    return @"INCOMPLETE";
    
}





#pragma mark - Table view data source






#pragma mark Content Filtering
-(void)filterContentForSearchText:(NSString*)searchText scope:(NSString*)scope {
    // Update the filtered array based on the search text and scope.
    // Remove all objects from the filtered search array
    NSLog(@"inside filtercontext %@",searchText);

    [self.filteredschedules removeAllObjects];
    // Filter the array using NSPredicate
    NSPredicate *predicate = [NSPredicate predicateWithFormat:@"address BEGINSWITH[cd] %@",searchText];
    NSArray *temp = [self.content.session.schedules array];
    NSLog(@"count is %d",[temp count]);
    _filteredschedules = [NSMutableArray arrayWithArray:[temp filteredArrayUsingPredicate:predicate]];
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
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    // Perform segue to candy detail
     NSLog(@"inside prepare for seque ->");
    [self performSegueWithIdentifier:@"searchDetail" sender:tableView];
}
//
#pragma mark - Segue
-(void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    
     NSLog(@"inside prepare for seque ->");
    if ([[segue identifier] isEqualToString:@"searchDetail"]) {
        Schedule *sch = nil ;
        NSLog(@"inside searchdetail  seque ->");

        UIScheduleDetailViewController  *searchDetailViewController = [segue destinationViewController];
        // In order to manipulate the destination view controller, another check on which table (search or normal) is displayed is needed
        if(sender == self.searchDisplayController.searchResultsTableView)
        {
            NSLog(@"search table results seque ->");
            NSIndexPath *indexPath = [self.searchDisplayController.searchResultsTableView indexPathForSelectedRow];
             NSLog(@"indexpath row is ->%d", indexPath.row);
            sch = [_filteredschedules objectAtIndex:indexPath.row];
           [self setClaimData:sch controller:searchDetailViewController];
            
        }
        else
        {
             NSLog(@"regular table results seque ->");
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
//    ScheduleClaim *s = [[ScheduleClaim alloc] init];
//    
//    [s setAccountNumber:sch.accountNumber];
//    s.address = sch.address;
//    s.altphone = sch.altphone;
//    s.city = sch.city;
//    s.installerID = sch.installerID;
//    s.latitude = sch.latitude;
//    s.longitude = sch.longitude;
//    s.name = sch.name;
//    s.note = sch.note;
//    s.oldSerial = sch.oldSerial;
//    s.oldSize = sch.oldSize;
//    s.orderType = sch.orderType;
//    s.phone = sch.phone;
//    s.prevRead = sch.prevRead;
//    s.route = sch.route;
//    s.scheduleDate = sch.scheduleDate;
//    s.scheduleID = sch.scheduleID;
//    s.scheduleTime = sch.scheduleTime;
    
    m.claim = sch;
    NSString *destinationTitle = sch.name ;//[NSString stringWithFormat:@"%@\n%@\n%@", sch.name ,sch.address,sch.city];
    [searchDetailViewController setTitle:destinationTitle];
    //[searchDetailViewController setCurrentclaim:m];
}

@end
