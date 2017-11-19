//
//  Date2StaticCellsCell.swift
//  PDStrategy
//
//  Created by Pavel Deminov on 05/11/2017.
//  Copyright © 2017 Pavel Deminov. All rights reserved.
//

import UIKit

class Date2StaticCellsCell: PDTableViewCell {

    var titleLabel: PDTitleLabel!
    var valueLabel: PDValueLabel!
    var dateLabel: PDDateLabel!
    
    override func setup() {
        selectionStyle = .none
        let titleValueDate = TitleValueDateBuilder.addTitleValueDate2(to: contentView)
        titleLabel = titleValueDate.titleLabel
        valueLabel = titleValueDate.valueLabel
        dateLabel = titleValueDate.dateLabel
    }
    
    override func updateUI() {
        titleLabel.text = itemInfo?.title
        valueLabel.text = itemInfo?.value as? String
        dateLabel.date = itemInfo?.date
    }

}
