//
//  PDTableViewHeaderFooterView.m
//  Pods
//
//  Created by Pavel Deminov on 30/09/2017.
//
//

#import "PDTableViewHeaderFooterView.h"

@implementation PDTableViewHeaderFooterView

+ (BOOL)dynamicHeight {
    return YES;
}

+ (CGFloat)defaultHeight {
    return 28;
}

- (void)setModel:(PDContainerModel *)model {
    _model = model;
    [self updateUI];
}

- (void)updateUI {
    PDContainerModel *model = self.model;
    self.titleLabel.text = model.title;
    self.iconImageView.image = model.icon;
}

@end
