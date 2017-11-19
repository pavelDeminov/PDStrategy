//
//  FRCTableCell.swift
//  PDStrategy
//
//  Created by Pavel Deminov on 08/11/2017.
//  Copyright © 2017 Pavel Deminov. All rights reserved.
//

import UIKit

class FRCTableCell: PDTableViewCell {
    var titleLabel: PDTitleLabel!
    
    override func setup() {
        selectionStyle = .none
        titleLabel = TitleBuilder.addTitle(to: contentView)
    }
    
    override func updateUI() {
        let item = self.itemInfo
        if let managed = item as? PDItemInfo {
            titleLabel.text = managed.title
        }
    }

}
