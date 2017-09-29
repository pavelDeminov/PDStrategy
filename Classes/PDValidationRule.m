//
//  PDValidationRule.m
//  Commerce
//
//  Created by Pavel Deminov on 29/09/2017.
//  Copyright © 2017 Minimal Cafe. All rights reserved.
//

#import "PDValidationRule.h"

@implementation PDValidationRule

- (instancetype)init {
    self = [super init];
    if (self) {
        [self setup];
    }
    return self;
}

- (void)setup {
    
}

- (BOOL)validate:(id)value {
    if (self.validationBlock) {
        return self.validationBlock(value);
    } else {
        return nil;
    }
}
@end
