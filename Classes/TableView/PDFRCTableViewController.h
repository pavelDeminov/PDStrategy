//
//  PDFRCTableViewController.h
//  PDStrategy
//
//  Created by Pavel Deminov on 22/10/2017.
//

#import "PDTableViewController.h"
@import CoreData;

@interface PDFRCTableViewController : PDTableViewController <NSFetchedResultsControllerDelegate>

@property (nonatomic, strong) NSFetchedResultsController *frc;

- (void)setupFRC;
@end
