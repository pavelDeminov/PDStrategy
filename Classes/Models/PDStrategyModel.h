//
//  PDSectionModel.h
//  Commerce
//
//  Created by Pavel Deminov on 29/09/2017.
//  Copyright © 2017 Minimal Cafe. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "PDContainerModel.h"

@interface PDStrategyModel : NSObject

@property (nonatomic, strong) NSArray <PDContainerModel *> *sections;
@property (nonatomic, strong) PDContainerModel *errorContainer;
@property (nonatomic) ValidState state;

- (void)setup;
- (NSDictionary *)dictionary;
- (void)validate;
- (void)invalidate;

@end
