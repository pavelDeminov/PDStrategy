//
//  StrategyContextViewController.h
//  Commerce
//
//  Created by Pavel Deminov on 29/09/2017.
//  Copyright © 2017 Minimal Cafe. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "PDTableViewCell.h"
#import "PDItemInfo.h"
#import "PDSectionInfo.h"
#import "PDRefreshControll.h"

@class PDControllerModel;

@interface PDTableViewController : UIViewController <UITableViewDelegate, UITableViewDataSource, PDTableViewCellDelegate>

@property (nonatomic, strong) PDControllerModel *model;
@property (nonatomic, weak) IBOutlet UITableView *tableView;
@property (nonatomic, strong) PDRefreshControll *refreshControl;
@property (nonatomic) BOOL refreshEnabled;


- (void)refresh;

- (NSArray *)sections;
- (id <PDSectionInfo>)sectionInfoForSection:(NSInteger)section;
- (id <PDItemInfo> )itemForIndexPath:(NSIndexPath *)indexPath;

- (NSString *)cellIdentifierForIndexPath:(NSIndexPath *)indexPath;
- (NSString *)sectionIdentifierForSection:(NSInteger)section;
@end
