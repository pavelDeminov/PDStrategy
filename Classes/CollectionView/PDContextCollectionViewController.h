//
//  PDContextCollectionViewController.h
//  Pods
//
//  Created by Pavel Deminov on 01/10/2017.
//
//

#import <UIKit/UIKit.h>
#import "PDStrategyModel.h"

@interface PDContextCollectionViewController : UIViewController <UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout>

@property (nonatomic, weak) IBOutlet UICollectionView *collectionView;
@property (nonatomic, strong) PDStrategyModel *model;
@property (nonatomic, strong) UIRefreshControl *refreshControl;
@property (nonatomic) BOOL refreshEnabled;

- (void)refresh;
@end
