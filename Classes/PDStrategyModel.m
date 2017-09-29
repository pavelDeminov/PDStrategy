//
//  PDSectionModel.m
//  Commerce
//
//  Created by Pavel Deminov on 29/09/2017.
//  Copyright © 2017 Minimal Cafe. All rights reserved.
//

#import "PDStrategyModel.h"

@implementation PDStrategyModel

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
    ValidState state = ValidStateNone;
    for (PDContainerModel *container in self.sections) {
        [container validate];
        state = container.state;
        if (state == ValidStateFalse) {
            self.errorContainer = container;
            break;
        }
    }
    self.state = state;
}

- (void)invalidate {
    self.state = ValidStateNone;
    self.errorContainer = nil;
}

- (NSDictionary *)dictionary {
    NSMutableDictionary *dict = [NSMutableDictionary new];
    for (PDContainerModel *container in self.sections) {
        NSDictionary *containerDict = [container dictionary];
        [dict addEntriesFromDictionary:containerDict];
    }
    return dict;
}

@end
