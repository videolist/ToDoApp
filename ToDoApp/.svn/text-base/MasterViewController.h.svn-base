//
//  MasterViewController.h
//  ToDoApp
//
//  Created by Vadim on 7/18/13.
//  Copyright (c) 2013 Vadim. All rights reserved.
//

#import <UIKit/UIKit.h>

#import <CoreData/CoreData.h>
#import "CustomCell.h"

@interface MasterViewController : UITableViewController <NSFetchedResultsControllerDelegate, CustomCellDelegate> {
    CustomCell* cellShowingPicker_;
}

@property (strong, nonatomic) IBOutlet UITapGestureRecognizer *tapGestureRecognizer;
@property (strong, nonatomic) NSFetchedResultsController *fetchedResultsController;
@property (strong, nonatomic) NSManagedObjectContext *managedObjectContext;
@property (weak, nonatomic) IBOutlet UISegmentedControl *segmentedControl;
- (IBAction)sortOrderChanged:(id)sender;
- (IBAction)tapAction:(id)sender;

@end
