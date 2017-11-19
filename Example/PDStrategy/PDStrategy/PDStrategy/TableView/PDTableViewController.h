//
//  PDTableViewController.h
//  PDStrategy
//
//  Created by Pavel Deminov on 19/11/2017.
//  Copyright © 2017 Pavel Deminov. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "PDController.h"

@interface PDTableViewController : UIViewController <UITableViewDelegate, UITableViewDataSource>

@property (nullable, nonatomic, strong) PDController *controller;
@property (null_unspecified, nonatomic, weak) IBOutlet UITableView *tableView;
@property (nullable, nonatomic, strong) UIRefreshControl *refreshControl;
@property (nonatomic) BOOL refreshEnabled;

+ (nonnull NSString*)segueIdentifier;

- (nullable NSArray *)sections;
- (nullable id <PDSectionInfo>)sectionInfoForSection:(NSInteger)section;
- (nullable id <PDItemInfo> )itemInfoForIndexPath:(nonnull NSIndexPath *)indexPath;
- (nonnull NSString *)cellIdentifierForIndexPath:(nonnull NSIndexPath *)indexPath;

- (void)prepareCell:(nonnull UITableViewCell *)cell forIndexPath:(nonnull NSIndexPath *)IndexPath;

- (NSInteger)tableView:(nonnull UITableView *)tableView numberOfRowsInSection:(NSInteger)section;
- (CGFloat)tableView:(nonnull UITableView *)tableView heightForRowAtIndexPath:(nonnull NSIndexPath *)indexPath;
- (CGFloat)tableView:(nonnull UITableView *)tableView heightForHeaderInSection:(NSInteger)section;
- (CGFloat)tableView:(nonnull UITableView *)tableView estimatedHeightForHeaderInSection:(NSInteger)section;

- (void)refresh;

@end
