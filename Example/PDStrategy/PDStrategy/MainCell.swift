//
//  MainCell.swift
//  PDStrategy
//
//  Created by Pavel Deminov on 04/11/2017.
//  Copyright © 2017 Pavel Deminov. All rights reserved.
//

import UIKit

class MainCell: PDTableViewCell {
    var titleLabel: PDTitleLabel!
    
    override func setup() {
        selectionStyle = .none
        weak var wSelf = self
        TitleBuilder.addTitle(to: contentView, with: { (titleLabel) in
            wSelf?.titleLabel = titleLabel;
        })
    }
    
    override func updateUI() {
        titleLabel.text = itemInfo?.pdTitle
    }
}
