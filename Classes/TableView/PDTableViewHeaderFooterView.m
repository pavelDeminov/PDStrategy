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

- (void)setSection:(id<PDSectionInfo>)section {
    _section = section;
    [self updateUI];
}

- (void)setModel:(PDSectionModel *)model {
    self.section = model;
}

- (PDSectionModel *)model {
    if ([self.section isKindOfClass:[PDSectionModel class]]) {
        PDSectionModel *model = (PDSectionModel*)self.section;
        return model;
    } else {
        return nil;
    }
}

- (void)updateUI {
    self.titleLabel.text = self.section.title;

    PDSectionModel *model = self.model;
    if (model) {
        self.iconImageView.image = model.icon;
    }
    
}

@end
