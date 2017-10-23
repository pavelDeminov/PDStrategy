//
//  PDSectionModel.m
//  Commerce
//
//  Created by Pavel Deminov on 29/09/2017.
//  Copyright © 2017 Minimal Cafe. All rights reserved.
//

#import "PDSectionModel.h"

@implementation PDSectionModel

- (void)validate {
    ValidState state = ValidStateNone;
    for (PDItemModel *item in self.items) {
        [item validate];
        state = item.state;
        if (state == ValidStateFalse) {
            self.errorItem = item;
            break;
        }
    }
    self.state = state;
}

- (void)invalidate {
    self.state = ValidStateNone;
    self.errorItem = nil;
}

- (NSDictionary *)dictionary {
    NSMutableDictionary *dict = [NSMutableDictionary new];
    for (PDItemModel *item in self.items) {
        if (item.apiKey) {
            id object = item.object;
            dict[item.apiKey] = object;

        } else if (item.apiRequred){
            NSLog(@"Requred apiKey not found %@ in %@",item.apiKey, item.title);
        }
    }
    return dict;
}

@end
