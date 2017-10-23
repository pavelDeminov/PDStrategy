//
//  StrategyContextViewController.m
//  Commerce
//
//  Created by Pavel Deminov on 29/09/2017.
//  Copyright © 2017 Minimal Cafe. All rights reserved.
//

#import "PDTableViewController.h"
#import "PDControllerModel.h"
#import "PDSectionModel.h"
#import "PDItemModel.h"
#import "PDTableViewHeaderFooterView.h"

@interface PDTableViewController ()

@end

@implementation PDTableViewController

- (void)setRefreshEnabled:(BOOL)refreshEnabled {
    _refreshEnabled = refreshEnabled;
    
    if ([self.tableView respondsToSelector:@selector(setRefreshControl:)]) {
        if (refreshEnabled) {
            [self.tableView setRefreshControl:self.refreshControl];
        } else {
            [self.tableView setRefreshControl:nil];
        }
    }
    else {
        if (refreshEnabled) {
            [self.tableView addSubview:self.refreshControl];
        } else {
            [self.refreshControl removeFromSuperview];
        }
    }
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.tableView.dataSource = self;
    self.tableView.delegate = self;
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(keyboardWillBeHidden:)
                                                 name:UIKeyboardWillHideNotification object:nil];
    self.refreshControl = [PDRefreshControll new];
    [self.refreshControl addTarget:self action:@selector(refresh) forControlEvents:UIControlEventValueChanged];
}

- (void)dealloc {
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}

- (void)refresh {
    
    UIRefreshControl *refreshControl = self.refreshControl;
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, 2 * NSEC_PER_SEC), dispatch_get_main_queue(), ^{
        [refreshControl endRefreshing];
    });
}

- (void)loadNextPage {
    
}

- (void)keyboardWillBeHidden:(NSNotification*)aNotification
{
    NSIndexPath *indexPath = [self.tableView indexPathForSelectedRow];
    PDTableViewCell *cell = [self.tableView cellForRowAtIndexPath:indexPath];
    [self.tableView deselectRowAtIndexPath:[self.tableView indexPathForSelectedRow] animated:YES];
    [cell updateUI];
}

- (NSArray <id <PDSectionInfo>> *)sections {
    return self.model.sections;
}

- (id <PDSectionInfo>)sectionInfoForSection:(NSInteger)section {
    return self.sections[section];
}

- (id <PDItemInfo> )itemForIndexPath:(NSIndexPath *)indexPath {
    id <PDSectionInfo> sectionInfo = [self sectionInfoForSection:indexPath.section];
    PDItemModel *item = sectionInfo.items[indexPath.row];
    return item;
}

- (NSString *)cellIdentifierForIndexPath:(NSIndexPath *)indexPath {
    NSString *classString = NSStringFromClass([self class]);
    classString = [[NSStringFromClass([self class]) componentsSeparatedByString:@"."] lastObject];
    classString = [classString stringByReplacingOccurrencesOfString:@"ViewController" withString:@""];
    NSString *identifier = [NSString stringWithFormat:@"%@Cell",classString];
    return identifier;
}

- (NSString *)sectionIdentifierForSection:(NSInteger)section {
    NSString *classString = NSStringFromClass([self class]);
    classString = [[NSStringFromClass([self class]) componentsSeparatedByString:@"."] lastObject];
    classString = [classString stringByReplacingOccurrencesOfString:@"ViewController" withString:@""];
    NSString *identifier = [NSString stringWithFormat:@"%@Header",classString];
    return identifier;
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return self.sections.count;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    id <PDSectionInfo> sectionInfo = [self sectionInfoForSection:section];
    return sectionInfo.items.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    id <PDItemInfo> item = [self itemForIndexPath:indexPath];
    
    if (![item conformsToProtocol:@protocol(PDItemInfo)]) {
        NSAssert(false, @"Item not conforms to protocol PDItemInfo %@", [item class]);
        return nil;
    }
    
    NSString *cellIdentifier = [self cellIdentifierForIndexPath:indexPath];
    PDTableViewCell *cell = (PDTableViewCell*)[tableView dequeueReusableCellWithIdentifier:cellIdentifier];
    if (cell == nil) {
        Class cellClass = [self tableView:tableView cellClassForRowAtIndexPath:indexPath];
        if (cellClass != nil) {
            [tableView registerClass:cellClass forCellReuseIdentifier:cellIdentifier];
            cell = (PDTableViewCell*)[tableView dequeueReusableCellWithIdentifier:cellIdentifier];
        }
    }
    
    NSAssert(cell != nil, @"Cell %@ not found in %@", cellIdentifier, [self class]);
    cell.item = item;
    cell.delegate = self;
    return cell;
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
    NSString *identifier = [self cellIdentifierForIndexPath:indexPath];
    
    Class cellClass = NSClassFromString(identifier);
    if (!cellClass) {
        //Not objc
        NSString *moduleName = [[NSStringFromClass([self class]) componentsSeparatedByString:@"."] firstObject];
        identifier = [NSString stringWithFormat:@"%@.%@",moduleName, identifier];
        cellClass = NSClassFromString(identifier);
    }
    if ( cellClass == nil ) {
        return nil;
    }
    
    BOOL isPdClass = [cellClass isSubclassOfClass:[PDTableViewCell class]];
    if (!isPdClass) {
        NSAssert(isPdClass, @"Cell %@ not a PDTableViewCell subclass", cellClass);
    }
    
    return cellClass;
}


- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section {
    id <PDSectionInfo> sectionInfo = [self sectionInfoForSection:section];
    NSString *sectionIdentifier = [self sectionIdentifierForSection:section];
    
    PDTableViewHeaderFooterView *header = (PDTableViewHeaderFooterView*)[tableView dequeueReusableHeaderFooterViewWithIdentifier:sectionIdentifier];
    if (header == nil) {
        Class class = [self tableView:tableView headerFooterClassForSection:section];
        if (class != nil) {
            [tableView registerClass:class forHeaderFooterViewReuseIdentifier:sectionIdentifier];
            header = (PDTableViewHeaderFooterView*)[tableView dequeueReusableHeaderFooterViewWithIdentifier:sectionIdentifier];
        }
    }
    NSAssert(header != nil, @"Header %@ not found in %@", sectionIdentifier, [self class]);
    header.model = sectionInfo;
    return header;
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
    NSString *identifier = [self sectionIdentifierForSection:section];
    
    if (identifier == nil) {
        return nil;
    }
    
    Class class = NSClassFromString(identifier);
    if (!class) {
        //Not objc
        NSString *moduleName = [[NSStringFromClass([self class]) componentsSeparatedByString:@"."] firstObject];
        identifier = [NSString stringWithFormat:@"%@.%@",moduleName, identifier];
        class = NSClassFromString(identifier);
    }
    
    if (!class) {
        return nil;
    }
    
    BOOL isPdClass = [class isSubclassOfClass:[PDTableViewHeaderFooterView class]];
    if (!isPdClass) {
        NSAssert(isPdClass, @"HeaderFooter %@ not a PDTableViewHeaderFooterView subclass", class);
    }
    
    return class;
}

- (void)cellDidBeginEdit:(PDTableViewCell*)cell {
    PDItemModel *model = cell.model;
    if (model) {
        [model invalidate];
        NSIndexPath *indexPath = [self.tableView indexPathForCell:cell];
        NSIndexPath *selectedIndexPath = [self.tableView indexPathForSelectedRow];
        PDTableViewCell *selectedCell = [self.tableView cellForRowAtIndexPath:selectedIndexPath];
        [self.tableView beginUpdates];
        [self.tableView selectRowAtIndexPath:indexPath animated:YES scrollPosition:(UITableViewScrollPositionNone)];
        [self.tableView endUpdates];
        [cell updateUI];
        [selectedCell updateUI];
    }
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    PDTableViewCell *cell = [tableView cellForRowAtIndexPath:indexPath];
    PDItemModel *model = cell.model;
    if (model) {
        [model invalidate];
        [cell.textField becomeFirstResponder];
        [cell updateUI];
    }
}

- (void)tableView:(UITableView *)tableView didDeselectRowAtIndexPath:(NSIndexPath *)indexPath {
    PDTableViewCell *cell = [tableView cellForRowAtIndexPath:indexPath];
    [cell updateUI];
}

- (void) scrollViewWillBeginDragging:(UIScrollView *)scrollView {
    self.refreshControl.drag = true;
}

- (void) scrollViewDidEndDragging:(UIScrollView *)scrollView willDecelerate:(BOOL)decelerate {
    self.refreshControl.drag = false;
}

@end
