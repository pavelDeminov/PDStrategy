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
        weak var wSelf = self
        TitleValueBuilder.addTitle2(to: contentView) { (titleLabel, valueLabel) in
            wSelf?.titleLabel = titleLabel
            wSelf?.valueLabel = valueLabel
        }
    }
    
    override func updateUI() {
        titleLabel.text = itemInfo?.pdTitle
        valueLabel.text = itemInfo?.pdValue as? String
    }

}
