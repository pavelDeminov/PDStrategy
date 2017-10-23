//
//  PDSectionModel.h
//  Commerce
//
//  Created by Pavel Deminov on 29/09/2017.
//  Copyright © 2017 Minimal Cafe. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "PDItemModel.h"
#import "PDSectionInfo.h"

@interface PDSectionModel : NSObject <PDSectionInfo>

@property (nonatomic, strong) NSString *title;
@property (nonatomic, strong) id object;
@property (nonatomic, strong) UIImage *icon;
@property (nonatomic, strong) NSArray <PDItemModel *> *items;
@property (nonatomic) ValidState state;
@property (nonatomic, strong) PDItemModel *errorItem;
@property (nonatomic, strong) NSDateFormatter *apiDateForamater;
@property (nonatomic, strong) id modelType;

- (void)validate;
- (void)invalidate;
- (NSDictionary *)dictionary;

@end
