//
//  PDCollectionReusableView.h
//  Pods
//
//  Created by Pavel Deminov on 05/10/2017.
//
//

#import <UIKit/UIKit.h>
#import "PDSectionModel.h"

@interface PDCollectionReusableView : UICollectionReusableView

@property (nonatomic, strong) PDSectionModel *model;

+ (CGSize)defaultSize:(UICollectionViewLayout *)layout;

- (void)setup;
- (void)updateUI;

@end
