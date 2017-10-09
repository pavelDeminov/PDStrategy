//
//  StrategyContextViewController.h
//  Commerce
//
//  Created by Pavel Deminov on 29/09/2017.
//  Copyright © 2017 Minimal Cafe. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "PDStrategyContextTableViewCell.h"

@class PDStrategyModel;

@interface PDStrategyContextViewController : UIViewController <UITableViewDelegate, UITableViewDataSource, PDStrategyContextTableViewCellDelegate>

@property (nonatomic, strong) PDStrategyModel *model;
@property (nonatomic, weak) IBOutlet UITableView *tableView;
@property (nonatomic, strong) UIRefreshControl *refreshControl;

- (void)refresh;

@end
