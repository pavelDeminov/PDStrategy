//
//  TextDataTableCell.swift
//  PDStrategy
//
//  Created by Pavel Deminov on 06/11/2017.
//  Copyright © 2017 Pavel Deminov. All rights reserved.
//

import UIKit

class TextDataTableCell: PDTableViewCell, UITextFieldDelegate {

    var titleLabel: PDTitleLabel!
    var textField: PDTextField!
    var errorLabel: PDErrorLabel!
    
    override func setup() {
        selectionStyle = .none
        let builder = TitleTextFieldErrorBuilder.addTitleTextFieldError(to: contentView)
        let titleLabel = builder.titleLabel
        self.titleLabel = titleLabel
        textField = builder.textField
        errorLabel = builder.errorLabel
        
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
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        if selected {
            textField.becomeFirstResponder()
        }
    }
    
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
        //itemInfo?.value = textField?.text;
    }
}
