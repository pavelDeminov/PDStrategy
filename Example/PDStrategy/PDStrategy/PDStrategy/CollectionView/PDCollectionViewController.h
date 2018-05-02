//
//  PDCollectionViewController.h
//  PDStrategy
//
//  Created by Pavel Deminov on 19/11/2017.
//  Copyright © 2017 Pavel Deminov. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "PDBaseViewController.h"
#import "PDItemInfo.h"
#import "PDDataSource.h"

@interface PDCollectionViewController : PDBaseViewController <UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout>

@property (null_unspecified, nonatomic, weak) IBOutlet UICollectionView *collectionView;
@property (nullable, nonatomic, strong) UIRefreshControl *refreshControl;
@property (nonatomic) BOOL refreshEnabled;
@property (nonnull, nonatomic, strong) NSMutableArray <NSString *> *registeredCells;
@property (nonnull, nonatomic, strong) NSMutableDictionary *registeredPrototypes;

- (void)prepareCell:(nonnull UICollectionViewCell *)cell forIndexPath:(nonnull NSIndexPath *)indexPath;

- (CGSize )cellSizeForItemAt:(nonnull NSIndexPath *)indexPath;
- (CGSize )dynamicCellSizeForItem:(nonnull NSIndexPath *)indexPath itemsCount:(NSInteger)itemsCount;

- (CGSize)defaultCellSize;
- (CGSize)fitingSizeForIndexPath:(nonnull NSIndexPath *)indexPath withSize:(CGSize)dynamicSize;

@end
