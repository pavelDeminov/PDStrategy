//
//  PDCollectionReusableView.h
//  Pods
//
//  Created by Pavel Deminov on 05/10/2017.
//
//

#import <UIKit/UIKit.h>
#import "PDContainerModel.h"

@interface PDCollectionReusableView : UICollectionReusableView

@property (nonatomic, strong) PDContainerModel *model;

+ (CGSize)defaultSize:(UICollectionViewLayout *)layout;

- (void)setup;
- (void)updateUI;

@end
