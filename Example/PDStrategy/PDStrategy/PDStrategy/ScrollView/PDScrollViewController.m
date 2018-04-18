//
//  PDScrollViewController.m
//  PDStrategy
//
//  Created by Pavel Deminov on 07/01/2018.
//  Copyright © 2018 Pavel Deminov. All rights reserved.
//

#import "PDScrollViewController.h"
#import "PDScrollViewCell.h"
#import "PDCellInfo.h"

@interface PDScrollViewController ()

@end

@implementation PDScrollViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self reloadData];
    
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc]
                                   initWithTarget:self action:@selector(tap:)];
    [self.scrollView addGestureRecognizer:tap];
    
}

- (void)dealloc {
    
}

- (void)tap:(UITapGestureRecognizer *)gestureRecognizer
{
    CGPoint p = [gestureRecognizer locationInView:self.scrollView];
    
    UIView *subview = [self.scrollView hitTest:p withEvent:nil];
    UIView *parent = [self parentView:subview];
    if (parent) {
        UIView <PDCellInfo> *view = (UIView <PDCellInfo> *)parent;
        id <PDItemInfo> itemInfo = view.itemInfo;
        NSIndexPath *indexPath = [self.controller indexPathForItemInfo:itemInfo];
        [self scrollView:self.scrollView didSelectItemAtIndexPath:indexPath];
    }
}

- (UIView *)parentView:(UIView *)view {
    if ([view conformsToProtocol: @protocol(PDCellInfo)]) {
        return view;
    } else if (view.superview) {
        return [self parentView:view.superview];
    } else {
        return nil;
    }
}

- (void)scrollView:(nonnull UIScrollView *)scrollView didSelectItemAtIndexPath:(nonnull NSIndexPath *)indexPath {
    
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
            
            id <PDCellInfo> cellInfo  = (id <PDCellInfo>)cell;
            if (!cellInfo.reloadCellBlock) {
                cellInfo.reloadCellBlock = ^{
                    [cell updateUI];
                };
            }
            cell.itemInfo = itemInfo;
            
            [self prepareCell:cell forIndexPath:indexPath];
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

- (void)prepareCell:(nonnull PDScrollViewCell *)cell forIndexPath:(nonnull NSIndexPath *)IndexPath {
    
}

- (PDScrollViewCell *)cellForRowIndexPath:(NSIndexPath *)indexPath {
    
    NSInteger section = 0;
    NSInteger row = 0;
    NSInteger cellIndex = 0;
    for (id <PDSectionInfo> sectionInfo in self.controller.sections) {
        row = 0;
        for (id <PDItemInfo> itemInfo in sectionInfo.items) {
            NSIndexPath *ip = [NSIndexPath indexPathForRow:row inSection:section];
            if ([ip isEqual:indexPath]) {
                PDScrollViewCell *cell = [self.scrollView.subviews objectAtIndex:cellIndex];
                return cell;
            }
            row++;
            cellIndex++;
        }
        section++;
    }
    return nil;
}

- (void)itemUpdated:(nullable id <PDItemInfo>)item atIndexPath:(nullable NSIndexPath *)indexPath {
    [self reloadData];
}

- (void)itemRemoved:(nullable id <PDItemInfo>)item atIndexPath:(nullable NSIndexPath *)indexPath {
    [self reloadData];
}

- (void)itemInserted:(nullable id <PDItemInfo>)item atIndexPath:(nullable NSIndexPath *)indexPath {
    [self reloadData];
}

@end
