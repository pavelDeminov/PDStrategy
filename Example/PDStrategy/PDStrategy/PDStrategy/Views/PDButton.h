//
//  PDButton.h
//  PDStrategy
//
//  Created by Pavel Deminov on 19/11/2017.
//  Copyright © 2017 Pavel Deminov. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface PDButton : UIButton

@property (nonatomic, strong) NSLayoutConstraint *top;
@property (nonatomic, strong) NSLayoutConstraint *leading;
@property (nonatomic, strong) NSLayoutConstraint *trailing;
@property (nonatomic, strong) NSLayoutConstraint *bottom;

@property (nonatomic, strong) NSLayoutConstraint *width;
@property (nonatomic, strong) NSLayoutConstraint *height;
@property (nonatomic, strong) NSLayoutConstraint *x;
@property (nonatomic, strong) NSLayoutConstraint *y;

@property (nonatomic, strong) UIColor *highlightedColor;
@property (nonatomic, strong) UIColor *normalColor;

- (void)setup;
- (void)updateUI;

@end
