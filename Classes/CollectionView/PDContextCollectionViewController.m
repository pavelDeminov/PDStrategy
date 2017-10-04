//
//  PDContextCollectionViewController.m
//  Pods
//
//  Created by Pavel Deminov on 01/10/2017.
//
//

#import "PDContextCollectionViewController.h"
#import "PDContextCell.h"

@interface PDContextCollectionViewController ()

@end

@implementation PDContextCollectionViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.collectionView.dataSource = self;
    self.collectionView.delegate = self;
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView {
    return self.model.sections.count;
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    PDStrategyModel *model = self.model;
    PDContainerModel *container = model.sections[section];
    return container.items.count;
}

// The cell that is returned must be retrieved from a call to -dequeueReusableCellWithReuseIdentifier:forIndexPath:
- (__kindof UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    PDStrategyModel *model = self.model;
    PDContainerModel *container = model.sections[indexPath.section];
    PDItemModel *item = container.items[indexPath.row];
    
    PDContextCell *cell = (PDContextCell*)[collectionView dequeueReusableCellWithReuseIdentifier:item.cellIdentifier forIndexPath:indexPath];
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
    PDStrategyModel *model = self.model;
    PDContainerModel *container = model.sections[indexPath.section];
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
    
    BOOL isPdClass = [cellClass isSubclassOfClass:[PDContextCell class]];
    if (!isPdClass) {
        NSAssert(isPdClass, @"Cell %@ not a PDContextCell subclass", cellClass);
    }
    
    return cellClass;
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
