//
//  DateSimpleCollectionCell.swift
//  PDStrategy
//
//  Created by Pavel Deminov on 14/11/2017.
//  Copyright © 2017 Pavel Deminov. All rights reserved.
//

import UIKit

class DateSimpleCollectionCell: PDCollectionViewCell {
    var titleLabel: PDTitleLabel!
    var valueLabel: PDValueLabel!
    var dateLabel: PDDateLabel!
    
    override func setup() {
        let titleValueDate = TitleValueDateBuilder.addTitleValueDate(to: contentView)
        titleLabel = titleValueDate.titleLabel
        valueLabel = titleValueDate.valueLabel
        dateLabel = titleValueDate.dateLabel
    }
    
    override func updateUI() {
        titleLabel.text = itemInfo?.pdTitle
        valueLabel.text = itemInfo?.pdValue as? String
        dateLabel.date = itemInfo?.pdDate
    }
}
