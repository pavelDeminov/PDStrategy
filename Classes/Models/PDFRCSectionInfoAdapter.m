//
//  PDFRCSectionInfoAdapter.m
//  PDStrategy
//
//  Created by Pavel Deminov on 22/10/2017.
//

#import "PDFRCSectionInfoAdapter.h"

@implementation PDFRCSectionInfoAdapter

+ (instancetype)adapterWith:(id <NSFetchedResultsSectionInfo>)sectionInfo {
    PDFRCSectionInfoAdapter *adapter = [[PDFRCSectionInfoAdapter alloc] initWithFRCSectionInfo:sectionInfo];
    return adapter;
}

- (instancetype)initWithFRCSectionInfo:(id <NSFetchedResultsSectionInfo>)sectionInfo {
    self = [super init];
    if (self) {
        self.frcSectionInfo = sectionInfo;
    }
    return self;
}

- (NSArray *)items {
    return self.frcSectionInfo.objects;
}

- (NSString *)title {
    return self.frcSectionInfo.name;
}

@end
