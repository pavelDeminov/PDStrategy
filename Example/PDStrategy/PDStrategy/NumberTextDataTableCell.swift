//
//  NumberTextDataTableCell.swift
//  PDStrategy
//
//  Created by Pavel Deminov on 07/11/2017.
//  Copyright © 2017 Pavel Deminov. All rights reserved.
//

import UIKit

class NumberTextDataTableCell: TextDataTableCell {

    override func setup() {
        super.setup()
        textField.keyboardType = .numberPad
    }
    
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        
        let characterSet = CharacterSet.decimalDigits
        let replacementString = string.trimmingCharacters(in: characterSet.inverted)
        return replacementString == string
        
    }
    
}
