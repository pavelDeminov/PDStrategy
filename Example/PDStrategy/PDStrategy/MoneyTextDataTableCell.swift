//
//  MoneyTextDataTableCell.swift
//  PDStrategy
//
//  Created by Pavel Deminov on 07/11/2017.
//  Copyright © 2017 Pavel Deminov. All rights reserved.
//

import UIKit

class MoneyTextDataTableCell: TextDataTableCell {

    let moneyFormatter: TextFieldFormatter = {
        let textFieldFormatter = TextFieldFormatter()
        textFieldFormatter.format = "0.00 $"
        textFieldFormatter.dynamicSymbol = "0"
        textFieldFormatter.characterSet = CharacterSet.decimalDigits
        textFieldFormatter.staticAttributes = [
            NSAttributedStringKey.foregroundColor: UIColor.gray,
            NSAttributedStringKey.font: UIFont.systemFont(ofSize: 14),
        ]
        textFieldFormatter.dynamicAttributes = [
            NSAttributedStringKey.foregroundColor:UIColor.black,
            NSAttributedStringKey.font: UIFont.systemFont(ofSize: 16),
        ]
        return textFieldFormatter
    }()
    
    override func setup() {
        super.setup()
        textField.keyboardType = .decimalPad
        moneyFormatter.valueChangedBlock = valueChanged
    }
    
    override func updateUI() {
        super.updateUI()
        if let value = itemInfo?.value as? String {
            moneyFormatter.applyText(text: value, textField: textField)
        } else {
            moneyFormatter.applyText(text: "", textField: textField)
        }
        
    }
    
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        return moneyFormatter.textField(textField, shouldChangeCharactersIn: range, replacementString:string)
    }
    
    override func textFieldDidBeginEditing(_ textField: UITextField) {
        super.textFieldDidBeginEditing(textField)
        
    }
    
    @objc override func valueChanged() {
        let raw = moneyFormatter.rawFromText(text: textField.text)
        //item?.value = raw
    }

}
