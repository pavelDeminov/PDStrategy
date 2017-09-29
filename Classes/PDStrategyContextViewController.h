//
//  StrategyContextViewController.h
//  Commerce
//
//  Created by Pavel Deminov on 29/09/2017.
//  Copyright © 2017 Minimal Cafe. All rights reserved.
//

#import <UIKit/UIKit.h>

@class PDStrategyModel;

@interface PDStrategyContextViewController : UIViewController

@property (nonatomic, strong) PDStrategyModel *model;
@property (nonatomic, weak) IBOutlet UITableView *tableView;

@end
