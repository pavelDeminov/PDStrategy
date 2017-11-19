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

/*
class PDController: NSObject {
    
    func errorIndexPath() -> IndexPath? {
        
        weak var wSelf = self
        guard let  sectionIndex = sections?.index(where: { (section) -> Bool in
            return section == wSelf?.errorSection
        }) else {
            return nil
        }
        
        guard let  rowIndex = errorSection?.items?.index(where: { (item) -> Bool in
            return item.itemHash == wSelf?.errorSection?.errorItem?.itemHash
        }) else {
            return nil
        }
        
        return IndexPath(row: rowIndex, section: sectionIndex)
    }
    
}
*/
@end
