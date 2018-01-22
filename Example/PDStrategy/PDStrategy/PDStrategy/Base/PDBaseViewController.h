//
//  PDBaseViewController.h
//  PDStrategy
//
//  Created by Pavel Deminov on 07/01/2018.
//  Copyright © 2018 Pavel Deminov. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "PDController.h"

@interface PDBaseViewController : UIViewController

@property (nullable, nonatomic, strong) PDController *controller;

+ (nonnull NSString*)segueIdentifier;

- (void)setupController;
- (nullable NSArray *)sections;
- (nullable id <PDSectionInfo>)sectionInfoForSection:(NSInteger)section;
- (nullable id <PDItemInfo> )itemInfoForIndexPath:(nonnull NSIndexPath *)indexPath;
- (nonnull NSString *)cellIdentifierForIndexPath:(nonnull NSIndexPath *)indexPath;
- (nullable Class)classForRowAtIndexPath:(nullable NSIndexPath *)indexPath;
- (nullable Class)headerFooterClassForSection:(NSInteger)section;

@end
