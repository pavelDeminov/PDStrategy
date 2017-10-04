//
//  PDContextCell.m
//  Pods
//
//  Created by Pavel Deminov on 01/10/2017.
//
//

#import "PDContextCell.h"

@implementation PDContextCell

+ (CGSize)defaultSize:(UICollectionViewLayout *)layout{
    return CGSizeMake(50, 50);
}

- (instancetype)initWithCoder:(NSCoder *)aDecoder {
    self = [super initWithCoder:aDecoder];
    if (self) {
        [self setup];
    }
    return self;
}

- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        [self setup];
    }
    return self;
}

- (void)setup {
    
}

- (void)setModel:(PDItemModel *)model {
    _model = model;
    [self updateUI];
}

- (void)setImageIsLoading:(BOOL)imageIsLoading {
    _imageIsLoading = imageIsLoading;
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
    
    if (self.imageIsLoading) {
        [self.activityIndicator startAnimating];
    } else {
        [self.activityIndicator stopAnimating];
    }
}

@end
