//
//  TitleValue2StaticCellsCell.swift
//  PDStrategy
//
//  Created by Pavel Deminov on 05/11/2017.
//  Copyright © 2017 Pavel Deminov. All rights reserved.
//

import UIKit

class TitleValue2StaticCellsCell: PDTableViewCell {

    var titleLabel: PDTitleLabel!
    var valueLabel: PDValueLabel!
    
    override func setup() {
        selectionStyle = .none
        let titleValue = TitleValueBuilder.addTitleValue2(to: contentView)
        titleLabel = titleValue.titleLabel
        valueLabel = titleValue.valueLabel
    }
    
    override func updateUI() {
        titleLabel.text = item?.title
        valueLabel.text = item?.value as? String
    }

}
