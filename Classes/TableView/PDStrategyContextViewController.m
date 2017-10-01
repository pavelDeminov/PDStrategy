//
//  StrategyContextViewController.m
//  Commerce
//
//  Created by Pavel Deminov on 29/09/2017.
//  Copyright © 2017 Minimal Cafe. All rights reserved.
//

#import "PDStrategyContextViewController.h"
#import "PDStrategyModel.h"
#import "PDContainerModel.h"
#import "PDStrategyContextTableViewCell.h"
#import "PDItemModel.h"
#import "PDTableViewHeaderFooterView.h"

@interface PDStrategyContextViewController () <PDStrategyContextTableViewCellDelegate>

@end

@implementation PDStrategyContextViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.tableView.dataSource = self;
    self.tableView.delegate = self;
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(keyboardWillBeHidden:)
                                                 name:UIKeyboardWillHideNotification object:nil];
}

- (void)dealloc {
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}

- (void)keyboardWillBeHidden:(NSNotification*)aNotification
{
    NSIndexPath *indexPath = [self.tableView indexPathForSelectedRow];
    PDStrategyContextTableViewCell *cell = [self.tableView cellForRowAtIndexPath:indexPath];
    [self.tableView deselectRowAtIndexPath:[self.tableView indexPathForSelectedRow] animated:YES];
    [cell updateUI];
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return self.model.sections.count;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    PDStrategyModel *model = self.model;
    PDContainerModel *container = model.sections[section];
    return container.items.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    PDStrategyModel *model = self.model;
    PDContainerModel *container = model.sections[indexPath.section];
    PDItemModel *item = container.items[indexPath.row];
    
    PDStrategyContextTableViewCell *cell = (PDStrategyContextTableViewCell*)[tableView dequeueReusableCellWithIdentifier:item.cellIdentifier];
    NSAssert(cell != nil, @"Cell not found");
    cell.model = item;
    cell.delegate = self;
    return cell;
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section {
    PDStrategyModel *model = self.model;
    PDContainerModel *container = model.sections[section];
    if (!container.cellIdentifier) {
        return nil;
    }
    PDTableViewHeaderFooterView *header = (PDTableViewHeaderFooterView*)[tableView dequeueReusableHeaderFooterViewWithIdentifier:container.cellIdentifier];
    NSAssert(header != nil, @"Header not found");
    header.model = container;
    return header;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    PDStrategyContextTableViewCell *cell = [tableView cellForRowAtIndexPath:indexPath];
    [cell.textField becomeFirstResponder];
    [cell updateUI];
}

- (void)tableView:(UITableView *)tableView didDeselectRowAtIndexPath:(NSIndexPath *)indexPath {
    PDStrategyContextTableViewCell *cell = [tableView cellForRowAtIndexPath:indexPath];
    [cell updateUI];
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath  {

    Class cellClass = [self tableView:tableView cellClassForRowAtIndexPath:indexPath];
    
    BOOL dynamicHeight = [cellClass dynamicHeight];
    CGFloat defaultHeight = [cellClass defaultHeight];
    if (dynamicHeight) {
        return UITableViewAutomaticDimension;
    } else {
        return defaultHeight;
    }
}

- (CGFloat)tableView:(UITableView *)tableView estimatedHeightForRowAtIndexPath:(NSIndexPath *)indexPath {
    Class cellClass = [self tableView:tableView cellClassForRowAtIndexPath:indexPath];
    return [cellClass defaultHeight];
}

- (Class)tableView:(UITableView *)tableView cellClassForRowAtIndexPath:(NSIndexPath *)indexPath {
    PDStrategyModel *model = self.model;
    PDContainerModel *container = model.sections[indexPath.section];
    PDItemModel *item = container.items[indexPath.row];
    
    NSString *classString = item.cellIdentifier;
    Class cellClass = NSClassFromString(classString);
    if (!cellClass) {
        //Not objc
        NSString *moduleName = [[NSStringFromClass([self class]) componentsSeparatedByString:@"."] firstObject];
        classString = [NSString stringWithFormat:@"%@.%@",moduleName, item.cellIdentifier];
        cellClass = NSClassFromString(classString);
    }
    
    NSAssert(cellClass != nil, @"Cell class not found,%@", item.cellIdentifier);
    
    BOOL isPdClass = [cellClass isSubclassOfClass:[PDStrategyContextTableViewCell class]];
    if (!isPdClass) {
        NSAssert(isPdClass, @"Cell %@ not a PDStrategyContextTableViewCell subclass", cellClass);
    }

    return cellClass;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    Class headerClass = [self tableView:tableView headerFooterClassForSection:section];
    
    if (!headerClass) {
        return 0;
    }
    
    BOOL dynamicHeight = [headerClass dynamicHeight];
    CGFloat defaultHeight = [headerClass defaultHeight];
    if (dynamicHeight) {
        return UITableViewAutomaticDimension;
    } else {
        return defaultHeight;
    }
}

- (CGFloat)tableView:(UITableView *)tableView estimatedHeightForHeaderInSection:(NSInteger)section {
    Class headerClass = [self tableView:tableView headerFooterClassForSection:section];
    if (!headerClass) {
        return 0;
    }
    return [headerClass defaultHeight];
}

- (Class)tableView:(UITableView *)tableView headerFooterClassForSection:(NSUInteger)section {
    PDStrategyModel *model = self.model;
    PDContainerModel *container = model.sections[section];
    
    if (!container.cellIdentifier) {
        return nil;
    }
    
    NSString *classString = container.cellIdentifier;
    Class class = NSClassFromString(classString);
    if (!class) {
        //Not objc
        NSString *moduleName = [[NSStringFromClass([self class]) componentsSeparatedByString:@"."] firstObject];
        classString = [NSString stringWithFormat:@"%@.%@",moduleName, container.cellIdentifier];
        class = NSClassFromString(classString);
    }
    
    NSAssert(class != nil, @"HeaderFooter class not found,%@", container.cellIdentifier);
    
    BOOL isPdClass = [class isSubclassOfClass:[PDTableViewHeaderFooterView class]];
    if (!isPdClass) {
        NSAssert(isPdClass, @"HeaderFooter %@ not a PDTableViewHeaderFooterView subclass", class);
    }
    
    return class;
}

- (void)cellDidBeginEdit:(PDStrategyContextTableViewCell*)cell {
    [cell.model invalidate];
    NSIndexPath *indexPath = [self.tableView indexPathForCell:cell];
    NSIndexPath *selectedIndexPath = [self.tableView indexPathForSelectedRow];
    PDStrategyContextTableViewCell *selectedCell = [self.tableView cellForRowAtIndexPath:selectedIndexPath];
    [self.tableView beginUpdates];
    [self.tableView selectRowAtIndexPath:indexPath animated:YES scrollPosition:(UITableViewScrollPositionNone)];
    [self.tableView endUpdates];
    [cell updateUI];
    [selectedCell updateUI];
}


@end
