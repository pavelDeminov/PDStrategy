//
//  TitleStaticCellsCell.swift
//  PDStrategy
//
//  Created by Pavel Deminov on 05/11/2017.
//  Copyright © 2017 Pavel Deminov. All rights reserved.
//

import UIKit

class TitleStaticCellsCell: PDTableViewCell {

    var titleLabel: PDTitleLabel!
    
    override func setup() {
        selectionStyle = .none
        titleLabel = TitleBuilder.addTitle(to: contentView)
    }
    
    override func updateUI() {
        titleLabel.text = itemInfo?.title
    }
}
