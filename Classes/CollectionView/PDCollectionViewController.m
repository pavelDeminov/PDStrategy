//
//  PDCollectionViewController.m
//  Pods
//
//  Created by Pavel Deminov on 01/10/2017.
//
//

#import "PDCollectionViewController.h"
#import "PDCollectionViewCell.h"
#import "PDCollectionReusableView.h"

@interface PDCollectionViewController ()

@end

@implementation PDCollectionViewController

- (void)setRefreshEnabled:(BOOL)refreshEnabled {
    _refreshEnabled = refreshEnabled;
    
    if ([self.collectionView respondsToSelector:@selector(setRefreshControl:)]) {
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
    
    self.refreshControl = [PDRefreshControll new];
    [self.refreshControl addTarget:self action:@selector(refresh) forControlEvents:UIControlEventValueChanged];
}

- (void)dealloc {
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}

- (void)refresh {
    
    UIRefreshControl *refreshControl = self.refreshControl;
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, 2 * NSEC_PER_SEC), dispatch_get_main_queue(), ^{
        [refreshControl endRefreshing];
    });
}

- (NSArray <id <PDSectionInfo>> *)sections {
    return self.model.sections;
}

- (id <PDSectionInfo>)sectionInfoForSection:(NSInteger)section {
    return self.sections[section];
}

- (id <PDItemInfo> )itemForIndexPath:(NSIndexPath *)indexPath {
    id <PDSectionInfo> sectionInfo = [self sectionInfoForSection:indexPath.section];
    PDItemModel *item = sectionInfo.items[indexPath.row];
    return item;
}

- (NSString *)cellIdentifierForIndexPath:(NSIndexPath *)indexPath {
    NSString *classString = NSStringFromClass([self class]);
    classString = [[NSStringFromClass([self class]) componentsSeparatedByString:@"."] lastObject];
    classString = [classString stringByReplacingOccurrencesOfString:@"ViewController" withString:@""];
    NSString *identifier = [NSString stringWithFormat:@"%@Cell",classString];
    return identifier;
}

- (NSString *)sectionIdentifierForSection:(NSInteger)section {
    NSString *classString = NSStringFromClass([self class]);
    classString = [[NSStringFromClass([self class]) componentsSeparatedByString:@"."] lastObject];
    classString = [classString stringByReplacingOccurrencesOfString:@"ViewController" withString:@""];
    NSString *identifier = [NSString stringWithFormat:@"%@Header",classString];
    return identifier;
}

- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView {
    return self.sections.count;
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    id <PDSectionInfo> sectionInfo = [self sectionInfoForSection:section];
    return sectionInfo.items.count;
}

- (__kindof UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    
    id <PDItemInfo> item = [self itemForIndexPath:indexPath];
    
    if (![item conformsToProtocol:@protocol(PDItemInfo)]) {
        NSAssert(false, @"Item not conforms to protocol PDItemInfo %@", [item class]);
        return nil;
    }
    
    NSString *cellIdentifier = [self cellIdentifierForIndexPath:indexPath];
    PDCollectionViewCell *cell = (PDCollectionViewCell*)[collectionView dequeueReusableCellWithReuseIdentifier:cellIdentifier forIndexPath:indexPath];
    if (cell == nil) {
        Class cellClass = [self collectionView:collectionView cellClassForRowAtIndexPath:indexPath];
        if (cellClass != nil) {
            [collectionView registerClass:cellClass forCellWithReuseIdentifier:cellIdentifier];
            cell = (PDCollectionViewCell*)[collectionView dequeueReusableCellWithReuseIdentifier:cellIdentifier forIndexPath:indexPath];
        }
    }
    
    NSAssert(cell != nil, @"Cell %@ not found in %@", cellIdentifier, [self class]);
    cell.item = item;
    //cell.delegate = self;
    return cell;
}

- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath {
    
    Class cellClass = [self collectionView:collectionView cellClassForRowAtIndexPath:indexPath];
    return [cellClass defaultSize:collectionViewLayout];    
}

- (Class)collectionView:(UICollectionView *)collectionView cellClassForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    NSString *identifier = [self cellIdentifierForIndexPath:indexPath];
    
    Class cellClass = NSClassFromString(identifier);
    if (!cellClass) {
        //Not objc
        NSString *moduleName = [[NSStringFromClass([self class]) componentsSeparatedByString:@"."] firstObject];
        identifier = [NSString stringWithFormat:@"%@.%@",moduleName, identifier];
        cellClass = NSClassFromString(identifier);
    }
    if ( cellClass == nil ) {
        return nil;
    }
    
    BOOL isPdClass = [cellClass isSubclassOfClass:[PDCollectionViewCell class]];
    if (!isPdClass) {
        NSAssert(isPdClass, @"Cell %@ not a PDCollectionViewCell subclass", cellClass);
    }
    
    return cellClass;
}

- (UICollectionReusableView *)collectionView:(UICollectionView *)collectionView viewForSupplementaryElementOfKind:(NSString *)kind atIndexPath:(NSIndexPath *)indexPath {
    
    id <PDSectionInfo> sectionInfo = [self sectionInfoForSection:indexPath.section];
    NSString *sectionIdentifier = [self sectionIdentifierForSection:indexPath.section];
    
    if ([kind isEqualToString:UICollectionElementKindSectionHeader]) {
        
        PDCollectionReusableView *header = [collectionView dequeueReusableSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:sectionIdentifier forIndexPath:indexPath];
        if (header == nil) {
            Class class = [self collectionView:collectionView headerClassForSection:indexPath.section];
            if (class != nil) {
                [collectionView registerClass:class forSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:sectionIdentifier];
                class = [self collectionView:collectionView headerClassForSection:indexPath.section];
            }
        }
        NSAssert(header != nil, @"Header %@ not found in %@", sectionIdentifier, [self class]);
        header.model = sectionInfo;
        return header;
    } else {
        return nil;
    }
}

- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout referenceSizeForHeaderInSection:(NSInteger)section {
    Class headerClass = [self collectionView:collectionView headerClassForSection:section];
    return [headerClass defaultSize:collectionViewLayout];
}

- (Class)collectionView:(UICollectionView *)collectionView headerClassForSection:(NSUInteger)section {
   
    NSString *sectionIdentifier = [self sectionIdentifierForSection:section];
    
    if (sectionIdentifier == nil) {
        return nil;
    }
    
    Class cellClass = NSClassFromString(sectionIdentifier);
    if (!cellClass) {
        //Not objc
        NSString *moduleName = [[NSStringFromClass([self class]) componentsSeparatedByString:@"."] firstObject];
        sectionIdentifier = [NSString stringWithFormat:@"%@.%@",moduleName, sectionIdentifier];
        cellClass = NSClassFromString(sectionIdentifier);
    }
    
    if ( cellClass == nil ) {
        return nil;
    }
    
    BOOL isPdClass = [cellClass isSubclassOfClass:[PDCollectionReusableView class]];
    if (!isPdClass) {
        NSAssert(isPdClass, @"Header %@ not a PDCollectionReusableView subclass", cellClass);
    }
    
    return cellClass;
}

- (void) scrollViewWillBeginDragging:(UIScrollView *)scrollView {
    self.refreshControl.drag = true;
}

- (void) scrollViewDidEndDragging:(UIScrollView *)scrollView willDecelerate:(BOOL)decelerate {
    self.refreshControl.drag = false;
}

@end
