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

- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView {
    return self.model.sections.count;
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    PDControllerModel *model = self.model;
    PDSectionModel *container = model.sections[section];
    return container.items.count;
}

// The cell that is returned must be retrieved from a call to -dequeueReusableCellWithReuseIdentifier:forIndexPath:
- (__kindof UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    PDControllerModel *model = self.model;
    PDSectionModel *container = model.sections[indexPath.section];
    PDItemModel *item = container.items[indexPath.row];
    
    PDCollectionViewCell *cell = (PDCollectionViewCell*)[collectionView dequeueReusableCellWithReuseIdentifier:item.cellIdentifier forIndexPath:indexPath];
    NSAssert(cell != nil, @"Cell not found");
    cell.model = item;
    //cell.delegate = self;
    return cell;
}

- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath {
    
    Class cellClass = [self collectionView:collectionView cellClassForRowAtIndexPath:indexPath];
    return [cellClass defaultSize:collectionViewLayout];    
}

- (Class)collectionView:(UICollectionView *)collectionView cellClassForRowAtIndexPath:(NSIndexPath *)indexPath {
    PDControllerModel *model = self.model;
    PDSectionModel *container = model.sections[indexPath.section];
    PDItemModel *item = container.items[indexPath.row];
    
    NSString *classString = item.cellIdentifier;
    Class cellClass = NSClassFromString(classString);
    if (!cellClass) {
        //Not objc
        NSString *moduleName = [[NSStringFromClass([self class]) componentsSeparatedByString:@"."] firstObject];
        classString = [NSString stringWithFormat:@"%@.%@",moduleName, item.cellIdentifier];
        cellClass = NSClassFromString(classString);
    }
    
    NSAssert(cellClass != nil, @"Cell class not found,%@", item.cellIdentifier);
    
    BOOL isPdClass = [cellClass isSubclassOfClass:[PDCollectionViewCell class]];
    if (!isPdClass) {
        NSAssert(isPdClass, @"Cell %@ not a PDCollectionViewCell subclass", cellClass);
    }
    
    return cellClass;
}

- (UICollectionReusableView *)collectionView:(UICollectionView *)collectionView viewForSupplementaryElementOfKind:(NSString *)kind atIndexPath:(NSIndexPath *)indexPath {
    
    PDControllerModel *model = self.model;
    PDSectionModel *container = model.sections[indexPath.section];
    
    if ([kind isEqualToString:UICollectionElementKindSectionHeader]) {
        PDCollectionReusableView *header = [collectionView dequeueReusableSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:container.sectionIdentifier forIndexPath:indexPath];
        header.model = container;
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
    PDControllerModel *model = self.model;
    PDSectionModel *container = model.sections[section];
    
    NSString *classString = container.sectionIdentifier;
    
    if (classString == nil) {
        return nil;
    }
    
    Class cellClass = NSClassFromString(classString);
    if (!cellClass) {
        //Not objc
        NSString *moduleName = [[NSStringFromClass([self class]) componentsSeparatedByString:@"."] firstObject];
        classString = [NSString stringWithFormat:@"%@.%@",moduleName, container.sectionIdentifier];
        cellClass = NSClassFromString(classString);
    }
    
    NSAssert(cellClass != nil, @"Header class not found,%@", container.sectionIdentifier);
    
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
