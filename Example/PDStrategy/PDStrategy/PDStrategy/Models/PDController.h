//
//  PDController.h
//  PDStrategy
//
//  Created by Pavel Deminov on 19/11/2017.
//  Copyright © 2017 Pavel Deminov. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "PDItem.h"
#import "PDSectionInfo.h"

@interface PDController : NSObject

@property (nullable, nonatomic, strong) NSArray <PDSectionInfo> *sections;
@property (nullable, nonatomic, strong) id <PDSectionInfo> errorContainer;
@property (nonatomic) ValidationState state;

- (void)setup;
- (nullable NSDictionary *)dictionary;
- (void)validate;
- (void)invalidate;
- (void)appendData:(nullable id)data;
- (nullable NSIndexPath *)errorIndexPath;
- (nullable NSIndexPath *)indexPathForItemInfo:(nullable id <PDItemInfo>)itemInfo;

@end
