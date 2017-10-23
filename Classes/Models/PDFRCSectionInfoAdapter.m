//
//  PDFRCSectionInfoAdapter.m
//  PDStrategy
//
//  Created by Pavel Deminov on 22/10/2017.
//

#import "PDFRCSectionInfoAdapter.h"

@implementation PDFRCSectionInfoAdapter

+ (instancetype)adapterWith:(id <NSFetchedResultsSectionInfo>)sectionInfo sectionIdentifier:(NSString *)sectionIdentifier {
    PDFRCSectionInfoAdapter *adapter = [[PDFRCSectionInfoAdapter alloc] initWithFRCSectionInfo:sectionInfo sectionIdentifier:sectionIdentifier];
    return adapter;
}

- (instancetype)initWithFRCSectionInfo:(id <NSFetchedResultsSectionInfo>)sectionInfo sectionIdentifier:(NSString *)sectionIdentifier {
    self = [super init];
    if (self) {
        self.frcSectionInfo = sectionInfo;
        self.sectionIdentifier = sectionIdentifier;
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
