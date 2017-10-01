//
//  PDContextCell.m
//  Pods
//
//  Created by Pavel Deminov on 01/10/2017.
//
//

#import "PDContextCell.h"

@implementation PDContextCell

+ (BOOL)dynamicHeight {
    return YES;
}

+ (CGFloat)defaultHeight {
    return 44;
}

- (void)setModel:(PDItemModel *)model {
    _model = model;
    [self updateUI];
}

- (void)setSelected:(BOOL)selected {
    [super setSelected:selected];
}

- (void)updateUI {
    PDItemModel *model = self.model;
    
    if (!self.model.object || [self.model.object isKindOfClass:[NSString class]]) {
        self.valueLabel.text = model.object;
    }
    self.iconImageView.image = model.icon;
    self.titleLabel.text = model.title;
    self.errorLabel.text = self.model.errorRule.error;
}

@end
