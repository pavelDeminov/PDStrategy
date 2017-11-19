//
//  PDItem.m
//  PDStrategy
//
//  Created by Pavel Deminov on 19/11/2017.
//  Copyright © 2017 Pavel Deminov. All rights reserved.
//

#import "PDItem.h"

@implementation PDItem

+ (nonnull PDItem *)instantiate {
    PDItem *item = [PDItem new];
    return item;
}

- (instancetype)init {
    self = [super init];
    if (self) {
        [self setup];
    }
    return self;
}

- (void)setup {
    
}

- (void)validate {
    [self invalidate];
    ValidationState state = ValidationStateValid;
    
    for (PDRule *rule in self.rules) {
        BOOL valid = [rule validate:self.value];
        if (!valid) {
            self.errorRule = rule;
            state = ValidationStateInvalid;
            break;
        }
    }
    self.state = state;
}

- (void)invalidate {
    self.state = ValidationStateNone;
    self.errorRule = nil;
}

@end
