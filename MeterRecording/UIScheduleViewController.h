//
//  UIScheduleViewController.h
//  MeterRecording
//
//  Created by Akash Aggarwal on 11/3/13.
//  Copyright (c) 2013 Akash Aggarwal. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "AppContent.h"
@interface UIScheduleViewController : UITableViewController<UISearchBarDelegate, UISearchDisplayDelegate, NSFetchedResultsControllerDelegate>

@property (strong, nonatomic) AppContent *content;
@property (strong, nonatomic) IBOutlet UISearchBar *searchBar;
@property (strong, nonatomic) IBOutlet UISearchDisplayController *searchController;
@property(strong) NSMutableArray* filteredschedules;
@property (nonatomic, retain) NSFetchedResultsController *fetchedResultsController;

@end
