//
//  PDContainerModel.h
//  Commerce
//
//  Created by Pavel Deminov on 29/09/2017.
//  Copyright © 2017 Minimal Cafe. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "PDItemModel.h"

@interface PDContainerModel : NSObject

@property (nonatomic, strong) NSString *title;
@property (nonatomic, strong) NSString *cellIdentifier;
@property (nonatomic, strong) UIImage *icon;
@property (nonatomic, strong) NSArray <PDItemModel *> *items;
@property (nonatomic) ValidState state;
@property (nonatomic, strong) PDItemModel *errorItem;

- (void)validate;
- (void)invalidate;
- (NSDictionary *)dictionary;

@end
