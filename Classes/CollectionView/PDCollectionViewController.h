//
//  PDCollectionViewController.h
//  Pods
//
//  Created by Pavel Deminov on 01/10/2017.
//
//

#import <UIKit/UIKit.h>
#import "PDControllerModel.h"
#import "PDRefreshControll.h"

@interface PDCollectionViewController : UIViewController <UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout>

@property (nonatomic, weak) IBOutlet UICollectionView *collectionView;
@property (nonatomic, strong) PDControllerModel *model;
@property (nonatomic, strong) PDRefreshControll *refreshControl;
@property (nonatomic) BOOL refreshEnabled;

- (void)refresh;

- (NSArray *)sections;
- (id <PDSectionInfo>)sectionInfoForSection:(NSInteger)section;
- (id <PDItemInfo> )itemForIndexPath:(NSIndexPath *)indexPath;

- (NSString *)cellIdentifierForIndexPath:(NSIndexPath *)indexPath;
- (NSString *)sectionIdentifierForSection:(NSInteger)section;

@end
