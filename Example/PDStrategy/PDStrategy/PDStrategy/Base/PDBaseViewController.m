//
//  PDBaseViewController.m
//  PDStrategy
//
//  Created by Pavel Deminov on 07/01/2018.
//  Copyright © 2018 Pavel Deminov. All rights reserved.
//

#import "PDBaseViewController.h"

@interface PDBaseViewController ()

@end

@implementation PDBaseViewController

+ (nonnull NSString*)segueIdentifier {
    NSString *classString = NSStringFromClass(self);
    classString = [[NSStringFromClass([self class]) componentsSeparatedByString:@"."] lastObject];
    classString = [classString stringByReplacingOccurrencesOfString:@"ViewController" withString:@""];
    NSString *identifier = [NSString stringWithFormat:@"%@Segue",classString];
    return identifier;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    //self.registeredCells = [NSMutableArray new];
    //self.registeredPrototypes = [NSMutableDictionary new];
    
    //self.refreshControl = [UIRefreshControl new];
    //[self.refreshControl addTarget:self action:@selector(refresh) forControlEvents:UIControlEventValueChanged];
    [self setupController];
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

- (nullable Class)classForIdentifier:(NSString *)identifier {
    
    Class cellClass = NSClassFromString(identifier);
    if (!cellClass) {
        //Not objc
        NSString *moduleName = [[NSStringFromClass([self class]) componentsSeparatedByString:@"."] firstObject];
        identifier = [NSString stringWithFormat:@"%@.%@",moduleName, identifier];
        cellClass = NSClassFromString(identifier);
    }
    
    return cellClass;
}

- (nullable Class)classForRowAtIndexPath:(nullable NSIndexPath *)indexPath {
    NSString *identifier = [self cellIdentifierForIndexPath:indexPath];
    return [self classForIdentifier:identifier];
}

- (nullable Class)headerFooterClassForSection:(NSInteger)section {
    NSString *identifier = [self sectionIdentifierForSection:section];
    return [self classForIdentifier:identifier];
}

@end
