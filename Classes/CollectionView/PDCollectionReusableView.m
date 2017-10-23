//
//  PDCollectionReusableView.m
//  Pods
//
//  Created by Pavel Deminov on 05/10/2017.
//
//

#import "PDCollectionReusableView.h"

@implementation PDCollectionReusableView

+ (CGSize)defaultSize:(UICollectionViewLayout *)layout {
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

- (void)setModel:(PDSectionModel *)model {
    _model = model;
    [self updateUI];
}

- (void)setup {
    
}

- (void)updateUI {
    
}

@end
