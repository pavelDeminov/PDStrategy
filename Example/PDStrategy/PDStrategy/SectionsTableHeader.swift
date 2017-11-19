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
        weak var wSelf = self
        TitleBuilder.addTitle(to: contentView, with: { (titleLabel) in
            wSelf?.titleLabel = titleLabel;
        })
    }
    
    override func updateUI() {
        titleLabel.text = sectionInfo?.title
    }
}
