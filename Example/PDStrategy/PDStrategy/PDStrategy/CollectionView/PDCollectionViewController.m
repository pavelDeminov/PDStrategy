//
//  PDCollectionViewController.m
//  PDStrategy
//
//  Created by Pavel Deminov on 19/11/2017.
//  Copyright © 2017 Pavel Deminov. All rights reserved.
//

#import "PDCollectionViewController.h"
#import "PDCellInfo.h"

@interface PDCollectionViewController ()

@property (nonatomic, strong) NSMutableArray <NSString *> *registeredCells;

@end

@implementation PDCollectionViewController

+ (nonnull NSString*)segueIdentifier {
    NSString *classString = NSStringFromClass(self);
    classString = [[NSStringFromClass([self class]) componentsSeparatedByString:@"."] lastObject];
    classString = [classString stringByReplacingOccurrencesOfString:@"ViewController" withString:@""];
    NSString *identifier = [NSString stringWithFormat:@"%@Segue",classString];
    return identifier;
}

- (void)setRefreshEnabled:(BOOL)refreshEnabled {
    _refreshEnabled = refreshEnabled;
    
    if (@available(iOS 10.0, *)) {
        if (refreshEnabled) {
            [self.collectionView setRefreshControl:self.refreshControl];
        } else {
            [self.collectionView setRefreshControl:nil];
        }
    }
    else {
        if (refreshEnabled) {
            [self.collectionView addSubview:self.refreshControl];
        } else {
            [self.refreshControl removeFromSuperview];
        }
    }
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.collectionView.dataSource = self;
    self.collectionView.delegate = self;
    self.registeredCells = [NSMutableArray new];
    
    self.refreshControl = [UIRefreshControl new];
    [self.refreshControl addTarget:self action:@selector(refresh) forControlEvents:UIControlEventValueChanged];
    [self setupController];
}

- (void)refresh {
    
    UIRefreshControl *refreshControl = self.refreshControl;
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, 2 * NSEC_PER_SEC), dispatch_get_main_queue(), ^{
        [refreshControl endRefreshing];
    });
}

- (void)loadNextPage {
    
}

- (void)setupController {
    NSString *classString = NSStringFromClass([self class]);
    classString = [[NSStringFromClass([self class]) componentsSeparatedByString:@"."] lastObject];
    classString = [classString stringByReplacingOccurrencesOfString:@"ViewController" withString:@""];
    NSString *identifier = [NSString stringWithFormat:@"%@Controller",classString];
    Class class = NSClassFromString(identifier);
    
    if (!class) {
        //Not objc
        NSString *moduleName = [[NSStringFromClass([self class]) componentsSeparatedByString:@"."] firstObject];
        identifier = [NSString stringWithFormat:@"%@.%@",moduleName, identifier];
        class = NSClassFromString(identifier);
    }
    
    PDController *controller = [class new];
    self.controller = controller;
}

- (nullable NSArray *)sections {
    return self.controller.sections;
}

- (nullable id <PDSectionInfo>)sectionInfoForSection:(NSInteger)section {
    return self.sections[section];
}

- (nullable id <PDItemInfo> )itemInfoForIndexPath:(nonnull NSIndexPath *)indexPath {
    id <PDSectionInfo> sectionInfo = [self sectionInfoForSection:indexPath.section];
    if (indexPath.row < sectionInfo.items.count) {
        id <PDItemInfo> itemInfo = sectionInfo.items[indexPath.row];
        return itemInfo;
    } else {
        return nil;
    }
}

- (nonnull NSString *)cellIdentifierForIndexPath:(nonnull NSIndexPath *)indexPath {
    NSString *classString = NSStringFromClass([self class]);
    classString = [[NSStringFromClass([self class]) componentsSeparatedByString:@"."] lastObject];
    classString = [classString stringByReplacingOccurrencesOfString:@"ViewController" withString:@""];
    NSString *identifier = [NSString stringWithFormat:@"%@Cell",classString];
    return identifier;
}

- (nonnull NSString *)sectionIdentifierForSection:(NSInteger)section {
    NSString *classString = NSStringFromClass([self class]);
    classString = [[NSStringFromClass([self class]) componentsSeparatedByString:@"."] lastObject];
    classString = [classString stringByReplacingOccurrencesOfString:@"ViewController" withString:@""];
    NSString *identifier = [NSString stringWithFormat:@"%@Header",classString];
    return identifier;
}

- (Class)classForIdentifier:(NSString *)identifier {
    
    Class cellClass = NSClassFromString(identifier);
    if (!cellClass) {
        //Not objc
        NSString *moduleName = [[NSStringFromClass([self class]) componentsSeparatedByString:@"."] firstObject];
        identifier = [NSString stringWithFormat:@"%@.%@",moduleName, identifier];
        cellClass = NSClassFromString(identifier);
    }
    
    return cellClass;
}

- (Class)classForRowAtIndexPath:(NSIndexPath *)indexPath {
    NSString *identifier = [self cellIdentifierForIndexPath:indexPath];
    return [self classForIdentifier:identifier];
}

- (Class)headerFooterClassForSection:(NSInteger)section {
    NSString *identifier = [self sectionIdentifierForSection:section];
    return [self classForIdentifier:identifier];
}

- (void)prepareCell:(UICollectionViewCell *)cell forIndexPath:(NSIndexPath *)indexPath {
    
}

- (CGSize )cellSizeForItemAt:(nonnull NSIndexPath *)indexPath {
    return [self defaultCellSize];
}

- (CGSize )dynamicCellSizeForItem:(nonnull NSIndexPath *)indexPath itemsCount:(NSInteger)itemsCount {
    CGSize defaultSize = [self defaultCellSize];
    UICollectionViewFlowLayout *flowLayout = (UICollectionViewFlowLayout *)self.collectionView.collectionViewLayout;
    if (itemsCount == 0) {
        return defaultSize;
    }
    
    if (flowLayout.scrollDirection == UICollectionViewScrollDirectionVertical) {
        CGFloat contentWidth = self.collectionView.frame.size.width - flowLayout.sectionInset.left - flowLayout.sectionInset.right;
        CGFloat width = itemsCount > 1 ? contentWidth / itemsCount  - contentWidth / ((itemsCount - 1) * flowLayout.minimumInteritemSpacing) : contentWidth;
        return CGSizeMake(width, defaultSize.height);
    } else {
        CGFloat contentHeight = self.collectionView.frame.size.height - flowLayout.sectionInset.top - flowLayout.sectionInset.bottom;
        CGFloat height = itemsCount > 1 ? contentHeight / itemsCount  - contentHeight / ((itemsCount - 1) * flowLayout.minimumLineSpacing) : contentHeight;
        return CGSizeMake(defaultSize.width, height);
    }
}

- (CGSize)defaultCellSize {
    return CGSizeMake(100, 100);
}

- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView {
    return self.sections.count;
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    id <PDSectionInfo> sectionInfo = [self sectionInfoForSection:section];
    return sectionInfo.items.count;
}

- (__kindof UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    
    id <PDItemInfo> itemInfo = [self itemInfoForIndexPath:indexPath];
    
    NSString *cellIdentifier = [self cellIdentifierForIndexPath:indexPath];
    NSPredicate *predicate = [NSPredicate predicateWithFormat:@"SELF == %@", cellIdentifier];
    NSArray <NSString *> *filtered = [self.registeredCells filteredArrayUsingPredicate:predicate];
    if (!filtered.count) {
        Class cellClass = [self classForRowAtIndexPath:indexPath];
        [collectionView registerClass:cellClass forCellWithReuseIdentifier:cellIdentifier];
        [self.registeredCells addObject:cellIdentifier];
    }
    
    UICollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:cellIdentifier forIndexPath:indexPath];
    
    id <PDCellInfo> cellInfo  = (id <PDCellInfo>)cell;
    cellInfo.itemInfo = itemInfo;
    [self prepareCell:cell forIndexPath:indexPath];
    
    return cell;
}

- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath {
    
    return [self cellSizeForItemAt:indexPath];
}

@end
