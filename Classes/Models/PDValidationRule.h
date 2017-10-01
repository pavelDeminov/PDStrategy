//
//  PDValidationRule.h
//  Commerce
//
//  Created by Pavel Deminov on 29/09/2017.
//  Copyright © 2017 Minimal Cafe. All rights reserved.
//

#import <Foundation/Foundation.h>

@class PDItemModel;

typedef BOOL (^ValidationBlock)(id value);

@interface PDValidationRule : NSObject

@property (nonatomic, strong) ValidationBlock validationBlock;
@property (nonatomic, strong) NSString *error;

- (BOOL)validate:(id)value;

@end
