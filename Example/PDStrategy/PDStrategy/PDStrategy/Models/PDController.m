//
//  PDController.m
//  PDStrategy
//
//  Created by Pavel Deminov on 19/11/2017.
//  Copyright © 2017 Pavel Deminov. All rights reserved.
//

#import "PDController.h"
#import "PDSection.h"

@implementation PDController

- (instancetype)init {
    self = [super init];
    if (self) {
        [self setup];
    }
    return self;
}

- (void)setup {
    
}

- (void)appendData:(nullable id)data {
    
}

- (void)validate {
    ValidationState state = ValidationStateNone;
    for (PDSection *section in self.sections) {
        [section validate];
        state = section.state;
        if (state == ValidationStateInvalid) {
            self.errorContainer = section;
            break;
        }
    }
    self.state = state;
}

- (void)invalidate {
    self.state = ValidationStateNone;
    self.errorContainer = nil;
}

- (NSDictionary *)dictionary {
    NSMutableDictionary *dict = [NSMutableDictionary new];
    for (PDSection *container in self.sections) {
        NSDictionary *containerDict = [container dictionary];
        [dict addEntriesFromDictionary:containerDict];
    }
    return dict;
}

- (nullable NSIndexPath *)errorIndexPath {
    if (!self.errorContainer) {
        return nil;
    }
    
    NSInteger sectionIndex = [self.sections indexOfObject:self.errorContainer];
    PDSection *section = self.errorContainer;
    NSInteger rowindex = [self.errorContainer.items indexOfObject:section.errorItem];
    
    return [NSIndexPath indexPathForRow:rowindex inSection:sectionIndex];
}

- (nullable NSIndexPath *)indexPathForItemInfo:(id <PDItemInfo>)itemInfo {
    
    for (id <PDSectionInfo> sectionInfo in self.sections) {
        for (id <PDItemInfo> item in sectionInfo.items) {
            if (itemInfo == item) {
                NSInteger section = [self.sections indexOfObject:sectionInfo];
                NSInteger row = [sectionInfo.items indexOfObject:item];
                return [NSIndexPath indexPathForRow:row inSection:section];
            }
        }
    }
    
    return nil;
}

@end
