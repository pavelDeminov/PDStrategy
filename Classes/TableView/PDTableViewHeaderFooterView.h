//
//  PDTableViewHeaderFooterView.h
//  Pods
//
//  Created by Pavel Deminov on 30/09/2017.
//
//

#import <UIKit/UIKit.h>
#import "PDSectionModel.h"

@interface PDTableViewHeaderFooterView : UITableViewHeaderFooterView

@property (nonatomic, weak) IBOutlet UILabel *titleLabel;
@property (nonatomic, weak) IBOutlet UIImageView *iconImageView;
@property (nonatomic, readwrite) PDSectionModel *model;
@property (nonatomic, strong) id <PDSectionInfo> section;

+ (BOOL)dynamicHeight;
+ (CGFloat)defaultHeight;
- (void)updateUI;

@end
