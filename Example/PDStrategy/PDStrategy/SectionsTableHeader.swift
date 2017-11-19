//
//  MainHeader.swift
//  PDStrategy
//
//  Created by Pavel Deminov on 05/11/2017.
//  Copyright © 2017 Pavel Deminov. All rights reserved.
//

import UIKit

class SectionsTableHeader: PDTableViewHeaderFooter {
    var titleLabel: PDTitleLabel!
    
    override func setup() {
        titleLabel = TitleBuilder.addTitle(to: self)
    }
    
    override func updateUI() {
        titleLabel.text = sectionInfo?.title
    }
}
