//
//  PageAndRefreshCell.swift
//  PDStrategy
//
//  Created by Pavel Deminov on 05/11/2017.
//  Copyright © 2017 Pavel Deminov. All rights reserved.
//

import UIKit

class PageAndRefreshCell: PDTableViewCell {
    var titleLabel: PDTitleLabel!
    var valueLabel: PDValueLabel!
    
    override func setup() {
        selectionStyle = .none
        let titleValue = TitleValueBuilder.addTitleValue(to: contentView)
        titleLabel = titleValue.titleLabel
        valueLabel = titleValue.valueLabel
    }
    
    override func updateUI() {
        titleLabel.text = itemInfo?.title
        valueLabel.text = itemInfo?.value as? String
    }
}
