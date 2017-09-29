//
//  StrategyContextTableViewCell.h
//  Commerce
//
//  Created by Pavel Deminov on 29/09/2017.
//  Copyright © 2017 Minimal Cafe. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "PDItemModel.h"

@class PDStrategyContextTableViewCell;

@protocol PDStrategyContextTableViewCellDelegate <NSObject>

- (void)cellDidBeginEdit:(PDStrategyContextTableViewCell*)cell;

@end

@interface PDStrategyContextTableViewCell : UITableViewCell

@property (nonatomic, weak) IBOutlet UILabel *titleLabel;
@property (nonatomic, weak) IBOutlet UILabel *valueLabel;
@property (nonatomic, weak) IBOutlet UILabel *errorLabel;
@property (nonatomic, weak) IBOutlet UITextField *textField;
@property (nonatomic, weak) IBOutlet UIImageView *iconImageView;
@property (nonatomic, strong) PDItemModel *model;
@property (nonatomic, weak) id <PDStrategyContextTableViewCellDelegate> delegate;

+ (BOOL)dynamicHeight;
+ (CGFloat)defaultHeight;
- (void)updateUI;
- (void)valueChanged;


@end
