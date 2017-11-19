//
//  PDItem.h
//  PDStrategy
//
//  Created by Pavel Deminov on 19/11/2017.
//  Copyright © 2017 Pavel Deminov. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "PDRule.h"
#import "PDItemInfo.h"

typedef NS_ENUM(NSUInteger, ValidationState) {
    ValidationStateNone,
    ValidationStateValid,
    ValidationStateInvalid,
};

@interface PDItem : NSObject <PDItemInfo>

@property (nullable, nonatomic, strong) NSString *title;
@property (nullable, nonatomic, strong) NSString *itemHash;
@property (nullable, nonatomic, strong) id value;
@property (nullable, nonatomic, strong) NSDate *date;
@property (nullable, nonatomic, strong) NSString *apiKey;
@property (nullable, nonatomic, strong) NSString *placeholder;
@property (nullable, nonatomic, strong) id type;
@property (nullable, nonatomic, strong) UIImage *image;
@property (nullable, nonatomic, strong) NSURL *imageUrl;

@property (nonatomic) ValidationState state;
@property (nullable, nonatomic, strong) PDRule *errorRule;
@property (nullable, nonatomic, strong) NSArray <PDRule *> *rules;
@property (nonatomic) BOOL apiRequred;

- (void)setup;
- (void)validate;
- (void)invalidate;
+ (nonnull PDItem *)instantiate;

@end
