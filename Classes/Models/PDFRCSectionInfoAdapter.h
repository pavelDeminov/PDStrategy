//
//  PDFRCSectionInfoAdapter.h
//  PDStrategy
//
//  Created by Pavel Deminov on 22/10/2017.
//

#import <Foundation/Foundation.h>
#import "PDSectionInfo.h"
@import CoreData;

@interface PDFRCSectionInfoAdapter : NSObject <PDSectionInfo>

@property (nonatomic, strong) id <NSFetchedResultsSectionInfo> frcSectionInfo;

+ (instancetype)adapterWith:(id <NSFetchedResultsSectionInfo>)sectionInfo;
- (instancetype)initWithFRCSectionInfo:(id <NSFetchedResultsSectionInfo>)sectionInfo;

@end
