//
//  ButtonTextDataTableCell.swift
//  PDStrategy
//
//  Created by Pavel Deminov on 11/11/2017.
//  Copyright © 2017 Pavel Deminov. All rights reserved.
//

import UIKit

class ButtonTextDataTableCell: PDTableViewCell {

    var confirmButton: PDConfirmButton!
    
    override func setup() {
        selectionStyle = .none
        confirmButton = ButtonBuilder.addConfirmButton(to: contentView)
    }
    
    override func updateUI() {
        confirmButton.setTitle(itemInfo?.title, for: .normal)
    }

}
