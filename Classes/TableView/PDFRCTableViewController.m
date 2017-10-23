//
//  PDFRCTableViewController.m
//  PDStrategy
//
//  Created by Pavel Deminov on 22/10/2017.
//

#import "PDFRCTableViewController.h"
#import "PDItemInfo.h"
#import "PDFRCSectionInfoAdapter.h"

@interface PDFRCTableViewController ()

@end

@implementation PDFRCTableViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self setupFRC];
}

- (void)setupFRC {
    //override
}

- (NSArray *)sections {
    return self.frc.sections;
}

- (id <PDSectionInfo>)sectionInfoForSection:(NSInteger)section {
    id <NSFetchedResultsSectionInfo> frcSectionInfo = self.sections[section];
    PDFRCSectionInfoAdapter *adapter = [PDFRCSectionInfoAdapter adapterWith:frcSectionInfo];
    return adapter;
}

- (id <PDItemInfo> )itemForIndexPath:(NSIndexPath *)indexPath {
    id <PDItemInfo> item = [self.frc objectAtIndexPath:indexPath];
    return item;
}

- (void)controllerWillChangeContent:(NSFetchedResultsController *)controller {
     [self.tableView beginUpdates];
}

- (void)controller:(NSFetchedResultsController *)controller didChangeSection:(id <NSFetchedResultsSectionInfo>)sectionInfo atIndex:(NSUInteger)sectionIndex forChangeType:(NSFetchedResultsChangeType)type {
    switch(type) {
        case NSFetchedResultsChangeInsert: {
            [self.tableView insertSections:[NSIndexSet indexSetWithIndex:sectionIndex] withRowAnimation:(UITableViewRowAnimationAutomatic)];
            break;
        }
        case NSFetchedResultsChangeDelete: {
            [self.tableView deleteSections:[NSIndexSet indexSetWithIndex:sectionIndex] withRowAnimation:(UITableViewRowAnimationAutomatic)];
            
            break;
        }
        default: break;
    }
}

- (void)controller:(NSFetchedResultsController *)controller didChangeObject:(id)anObject atIndexPath:(nullable NSIndexPath *)indexPath forChangeType:(NSFetchedResultsChangeType)type newIndexPath:(nullable NSIndexPath *)newIndexPath {
    switch(type) {
        case NSFetchedResultsChangeInsert: {
            [self.tableView insertRowsAtIndexPaths:@[newIndexPath] withRowAnimation:(UITableViewRowAnimationAutomatic)];
            break;
        }
        case NSFetchedResultsChangeDelete: {
            [self.tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationAutomatic];
            break;
        }
        case NSFetchedResultsChangeMove: {
            [self.tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationAutomatic];
            [self.tableView insertRowsAtIndexPaths:@[newIndexPath] withRowAnimation:(UITableViewRowAnimationAutomatic)];
            break;
        }
        case NSFetchedResultsChangeUpdate: {
            [self.tableView reloadRowsAtIndexPaths:@[indexPath] withRowAnimation:(UITableViewRowAnimationNone)];
            break;
        }
        default:
            break;
    }
}

- (void)controllerDidChangeContent:(NSFetchedResultsController *)controller {
    [self.tableView endUpdates];
}

@end
