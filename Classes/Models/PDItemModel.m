//
//  PDDataModel.m
//  Commerce
//
//  Created by Pavel Deminov on 29/09/2017.
//  Copyright © 2017 Minimal Cafe. All rights reserved.
//

#import "PDItemModel.h"

@implementation PDItemModel

- (instancetype)init {
    self = [super init];
    if (self) {
        self.apiRequred = true;
        [self setup];
    }
    
    return self;
}

- (void)setup {
    
}

- (void)validate {
    [self invalidate];
    ValidState state = ValidStateTrue;
    
    for (PDValidationRule *rule in self.rules) {
        BOOL valid = [rule validate:self.object];
        if (!valid) {
            self.errorRule = rule;
            state = ValidStateFalse;
            break;
        }
    }
    self.state = state;
}

- (void)invalidate {
    self.state = ValidStateNone;
    self.errorRule = nil;
}

@end
