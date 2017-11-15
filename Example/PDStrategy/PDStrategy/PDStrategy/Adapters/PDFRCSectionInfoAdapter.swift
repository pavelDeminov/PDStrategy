//
//  PDFRCSectionInfoAdapter.swift
//  PDStrategy
//
//  Created by Pavel Deminov on 08/11/2017.
//  Copyright © 2017 Pavel Deminov. All rights reserved.
//

import UIKit
import CoreData

class PDFRCSectionInfoAdapter: NSObject, PDSectionInfo {
    var frcSectionInfo: NSFetchedResultsSectionInfo?
    var title: String? {
        get {
            return frcSectionInfo?.name
        }
    }
    var items: [PDItemInfo]? {
        get {
            return frcSectionInfo?.objects as? [PDItemInfo]
        }
    }
    
    init(frcSectionInfo sectionInfo: NSFetchedResultsSectionInfo) {
        super.init()
        self.frcSectionInfo = sectionInfo
        setup()
    }
    
    func setup() {
        
    }
    
}
