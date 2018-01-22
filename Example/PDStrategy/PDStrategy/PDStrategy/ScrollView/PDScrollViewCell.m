//
//  PDScrollViewCell.m
//  PDStrategy
//
//  Created by Pavel Deminov on 07/01/2018.
//  Copyright © 2018 Pavel Deminov. All rights reserved.
//

#import "PDScrollViewCell.h"

@implementation PDScrollViewCell

+ (NSString*)reuseIdentifier {
    NSString *classString = NSStringFromClass(self);
    classString = [[NSStringFromClass([self class]) componentsSeparatedByString:@"."] lastObject];
    return classString;
}

- (void)setItemInfo:(id<PDItemInfo>)itemInfo {
    _itemInfo = itemInfo;
    [self updateUI];
}

- (instancetype)init {
    self = [super init];
    [self setup];
    return self;
}

- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    [self setup];
    return self;
}

- (void)updateUI {
    //override
}

- (void)setup {
    //override
}

- (void)setupForIB {
    //override
}

- (void)prepareForInterfaceBuilder {
    [self setup];
    [self setupForIB];
}

@end
