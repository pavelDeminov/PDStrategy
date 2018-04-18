//
//  PDItemInfo.h
//  PDStrategy
//
//  Created by Pavel Deminov on 19/11/2017.
//  Copyright © 2017 Pavel Deminov. All rights reserved.
//

@import UIKit;

typedef void (^UpdateBlock)(void);

@protocol PDItemInfo <NSObject>

@property (nullable, nonatomic, readwrite) NSString *title;
@property (nullable, nonatomic, readwrite) NSString *itemHash;
@property (nullable, nonatomic, readwrite) id value;
@property (nullable, nonatomic, readwrite) NSDate *date;
@property (nullable, nonatomic, readwrite) NSString *apiKey;
@property (nullable, nonatomic, readwrite) NSString *placeholder;
@property (nullable, nonatomic, readwrite) id type;
@property (nullable, nonatomic, readwrite) UIImage *image;
@property (nullable, nonatomic, readwrite) NSURL *imageUrl;
@property (nonatomic, readwrite) BOOL locked;

@optional

@property (nullable, nonatomic, readwrite) NSMutableArray <UpdateBlock> *updateBlocks;
- (nonnull UpdateBlock)addUpdateBlock:(nonnull UpdateBlock)updateBlock;
- (void)removeUpdateBlock:(nonnull UpdateBlock)updateBlock;

@end
