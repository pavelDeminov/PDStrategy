//
//  PDSectionModel.h
//  Commerce
//
//  Created by Pavel Deminov on 29/09/2017.
//  Copyright © 2017 Minimal Cafe. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "PDSectionModel.h"

@interface PDControllerModel : NSObject

@property (nonatomic, strong) NSArray <PDSectionModel *> *sections;
@property (nonatomic, strong) PDSectionModel *errorContainer;
@property (nonatomic) ValidState state;

- (void)setup;
- (NSDictionary *)dictionary;
- (void)validate;
- (void)invalidate;

@end
