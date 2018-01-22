//
//  TextFieldScrolCell.swift
//  PDStrategy
//
//  Created by Pavel Deminov on 09/01/2018.
//  Copyright © 2018 Pavel Deminov. All rights reserved.
//

import UIKit

class TextFieldScrollCell: PDScrollViewCell {

    var titleLabel: PDTitleLabel!
    var textField: PDTextField!
    var errorLabel: PDErrorLabel!
    
    override func setup() {
        
        weak var wSelf = self
        TitleTextFieldErrorBuilder.addTitle(to: self) { (titleLabel, textField, errorLabel) in
            wSelf?.titleLabel = titleLabel
            wSelf?.textField = textField
            wSelf?.errorLabel = errorLabel
        }
        
        textField.delegate = self
        textField?.addTarget(self, action: #selector(valueChanged), for: .editingChanged)
    }
    
    override func updateUI() {
        titleLabel.text = itemInfo?.title
        textField.text = itemInfo?.value as? String
        textField.placeholder = itemInfo?.placeholder
        
        textField.layer.borderColor = textField.isFirstResponder ? UIColor.green.cgColor : nil
        textField.layer.borderWidth = textField.isFirstResponder ? 3 / UIScreen.main.scale : 0
        textField.layer.cornerRadius = 6 / UIScreen.main.scale
        
        if let pdItem = itemInfo as? PDItem {
            errorLabel?.text = pdItem.errorRule?.error;
        }
        
    }
    /*
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        if selected {
            textField.becomeFirstResponder()
        }
    }
    */
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
    
    func textFieldDidBeginEditing(_ textField: UITextField) {
        if let pdItem = itemInfo as? PDItem {
            pdItem.invalidate()
        }
        updateUI()
        reloadCellBlock?()
    }
    
    func textFieldDidEndEditing(_ textField: UITextField) {
        updateUI()
    }
    
    @objc func valueChanged() {
        if let pdItem = itemInfo as? PDItem {
            pdItem.value = textField?.text;
        }
        
    }

}
