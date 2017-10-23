//
//  StrategyContextTableViewCell.h
//  Commerce
//
//  Created by Pavel Deminov on 29/09/2017.
//  Copyright © 2017 Minimal Cafe. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "PDItemModel.h"
#import "PDItemInfo.h"

@class PDTableViewCell;

@protocol PDTableViewCellDelegate <NSObject>

- (void)cellDidBeginEdit:(PDTableViewCell*)cell;

@end

@interface PDTableViewCell : UITableViewCell <UITextFieldDelegate>

@property (nonatomic, weak) IBOutlet UILabel *titleLabel;
@property (nonatomic, weak) IBOutlet UILabel *valueLabel;
@property (nonatomic, weak) IBOutlet UILabel *errorLabel;
@property (nonatomic, weak) IBOutlet UITextField *textField;
@property (nonatomic, weak) IBOutlet UIImageView *iconImageView;
@property (nonatomic, weak) IBOutlet UIActivityIndicatorView *activityIndicator;
@property (nonatomic, strong) id <PDItemInfo> item;
@property (nonatomic, readwrite) PDItemModel *model;

@property (nonatomic, weak) id <PDTableViewCellDelegate> delegate;

+ (BOOL)dynamicHeight;
+ (CGFloat)defaultHeight;
- (void)updateUI;
- (void)valueChanged;


@end
