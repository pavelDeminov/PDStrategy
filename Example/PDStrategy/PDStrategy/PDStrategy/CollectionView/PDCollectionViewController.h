//
//  PDCollectionViewController.h
//  PDStrategy
//
//  Created by Pavel Deminov on 19/11/2017.
//  Copyright © 2017 Pavel Deminov. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "PDItemInfo.h"
#import "PDController.h"

@interface PDCollectionViewController : UIViewController <UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout>

@property (nullable, nonatomic, strong) PDController *controller;
@property (null_unspecified, nonatomic, weak) IBOutlet UICollectionView *collectionView;
@property (nullable, nonatomic, strong) UIRefreshControl *refreshControl;
@property (nonatomic) BOOL refreshEnabled;

+ (nonnull NSString*)segueIdentifier;

- (nullable NSArray *)sections;
- (nullable id <PDSectionInfo>)sectionInfoForSection:(NSInteger)section;
- (nullable id <PDItemInfo> )itemInfoForIndexPath:(nonnull NSIndexPath *)indexPath;
- (nonnull NSString *)cellIdentifierForIndexPath:(nonnull NSIndexPath *)indexPath;

- (void)prepareCell:(nonnull UICollectionViewCell *)cell forIndexPath:(nonnull NSIndexPath *)indexPath;

- (CGSize )cellSizeForItemAt:(nonnull NSIndexPath *)indexPath;
- (CGSize )dynamicCellSizeForItem:(nonnull NSIndexPath *)indexPath itemsCount:(NSInteger)itemsCount;

- (CGSize)defaultCellSize;

@end
