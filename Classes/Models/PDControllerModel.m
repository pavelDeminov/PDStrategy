//
//  PDSectionModel.m
//  Commerce
//
//  Created by Pavel Deminov on 29/09/2017.
//  Copyright © 2017 Minimal Cafe. All rights reserved.
//

#import "PDControllerModel.h"

@interface PDControllerModel ()

@property (nonatomic, strong) NSMutableArray <PDSectionModel *> *newwSections;

@end

@implementation PDControllerModel

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
    for (PDSectionModel *section in self.sections) {
        [section validate];
        state = section.state;
        if (state == ValidStateFalse) {
            self.errorContainer = section;
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
    for (PDSectionModel *container in self.sections) {
        NSDictionary *containerDict = [container dictionary];
        [dict addEntriesFromDictionary:containerDict];
    }
    return dict;
}

@end
