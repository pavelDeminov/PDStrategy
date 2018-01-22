//
//  PDScrollViewController.m
//  PDStrategy
//
//  Created by Pavel Deminov on 07/01/2018.
//  Copyright © 2018 Pavel Deminov. All rights reserved.
//

#import "PDScrollViewController.h"
#import "PDScrollViewCell.h"

@interface PDScrollViewController ()

@end

@implementation PDScrollViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self reloadData];
}

- (void)reloadData {
    
    for (UIView *view in self.scrollView.subviews) {
        [view removeFromSuperview];
    }
    
    NSInteger section = 0;
    NSInteger row = 0;
    UIView *previousView;
    NSMutableArray <NSLayoutConstraint *> *constraints = [NSMutableArray new];
    
    for (id <PDSectionInfo> sectionInfo in self.controller.sections) {
        if (sectionInfo.title) {
            
        }
        row = 0;
        for (id <PDItemInfo> itemInfo in sectionInfo.items) {
            NSIndexPath *indexPath = [NSIndexPath indexPathForRow:row inSection:section];
            NSString *cellIdentifier = [self cellIdentifierForIndexPath:indexPath];
            
            PDScrollViewCell *cell;
            NSBundle *mainBundle = [NSBundle mainBundle];
            NSArray *objects;
            @try {
                objects = [mainBundle loadNibNamed:cellIdentifier owner:nil options:nil];
            }
            @catch (NSException * e) {
                
            }
            @finally {
               cell =[objects objectAtIndex:0];
            }
            
            
            if (!cell) {
                Class cellClass = [self classForRowAtIndexPath:indexPath];
                cell = [cellClass new];
                
                if (!cell) {
                    NSLog(@"scroll view cell not found: %@", cellIdentifier);
                    continue;
                }
            }
            [self.scrollView addSubview:cell];
            cell.translatesAutoresizingMaskIntoConstraints = NO;
            
            if (previousView) {
                NSLayoutConstraint *top = [NSLayoutConstraint constraintWithItem:cell attribute:(NSLayoutAttributeTop) relatedBy:(NSLayoutRelationEqual) toItem:previousView attribute:NSLayoutAttributeBottom multiplier:1 constant:0];
                [constraints addObject:top];
            } else {
                NSLayoutConstraint *top = [NSLayoutConstraint constraintWithItem:cell attribute:(NSLayoutAttributeTop) relatedBy:(NSLayoutRelationEqual) toItem:self.scrollView attribute:NSLayoutAttributeTop multiplier:1 constant:0];
                [constraints addObject:top];
            }
            
//            NSLayoutConstraint *leading = [NSLayoutConstraint constraintWithItem:cell attribute:(NSLayoutAttributeLeading) relatedBy:(NSLayoutRelationEqual) toItem:self.scrollView attribute:NSLayoutAttributeLeading multiplier:1 constant:0];
//            [constraints addObject:leading];
//
//            NSLayoutConstraint *trailing = [NSLayoutConstraint constraintWithItem:cell attribute:(NSLayoutAttributeTrailing) relatedBy:(NSLayoutRelationEqual) toItem:self.scrollView attribute:NSLayoutAttributeTrailing multiplier:1 constant:0];
//            [constraints addObject:trailing];
            
            NSLayoutConstraint *alignX = [NSLayoutConstraint constraintWithItem:cell attribute:(NSLayoutAttributeCenterX) relatedBy:(NSLayoutRelationEqual) toItem:self.scrollView attribute:NSLayoutAttributeCenterX multiplier:1 constant:0];
            [constraints addObject:alignX];
            
            NSLayoutConstraint *width = [NSLayoutConstraint constraintWithItem:cell attribute:(NSLayoutAttributeWidth) relatedBy:(NSLayoutRelationEqual) toItem:self.scrollView attribute:NSLayoutAttributeWidth multiplier:1 constant:0];
            [constraints addObject:width];
            
            cell.itemInfo = itemInfo;
            row++;
            previousView = cell;
        }
        section++;
    }
    
    if (previousView) {
        NSLayoutConstraint *bottom = [NSLayoutConstraint constraintWithItem:previousView attribute:(NSLayoutAttributeBottom) relatedBy:(NSLayoutRelationEqual) toItem:self.scrollView attribute:NSLayoutAttributeBottom multiplier:1 constant:0];
        [constraints addObject:bottom];
    }
    
    if (constraints.count) {
        [NSLayoutConstraint activateConstraints:constraints];
    }
    
}

@end
