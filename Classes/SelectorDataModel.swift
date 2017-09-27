//
//  SelectorDataModel.swift
//  PositiveClub
//
//  Created by Pavel Deminov on 07/08/2017.
//  Copyright © 2017 Company. All rights reserved.
//

import UIKit

class SelectorDataModel: BaseDataModel {
    
    var selectorArray:[(uiValue: String , apiValue: String)]?
    var selectedIndex: Int? {
        didSet {
            updateValueFromArray()
        }
    }
    
    override func validate() {
        
        guard let selectedIndex = selectedIndex, let count = selectorArray?.count, count > selectedIndex  else {
            isValid = .invalid(error: "Ошибка в базе значений")
            return
        }
        isValid = .valid

    }
    
    override func updateObjectFromTextFieldValue() {
        guard let selectedIndex = selectedIndex, let count = selectorArray?.count, count > selectedIndex  else {
            return
        }
        object = selectorArray![selectedIndex]
    }
    
    override func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        return false
    }
    
    override func updateApiValueFromObject() {
        guard let selectedIndex = selectedIndex, let count = selectorArray?.count, count > selectedIndex  else {
            return
        }
        apiValue = selectorArray![selectedIndex].apiValue
    }
    
    private func updateValueFromArray() {
        guard let selectedIndex = selectedIndex, let count = selectorArray?.count, count > selectedIndex  else {
            return
        }
        textFieldValue = selectorArray![selectedIndex].uiValue
    }
}
