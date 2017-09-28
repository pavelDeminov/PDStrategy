//
//  SelectorDataModel.swift
//  PositiveClub
//
//  Created by Pavel Deminov on 07/08/2017.
//  Copyright © 2017 Company. All rights reserved.
//

import UIKit

open class SelectorDataModel: BaseDataModel {
    
    open var selectorArray:[(uiValue: String , apiValue: String)]?
    open var selectedIndex: Int? {
        didSet {
            updateValueFromArray()
        }
    }
    
    override open func updateObjectFromTextFieldValue() {
        guard let selectedIndex = selectedIndex, let count = selectorArray?.count, count > selectedIndex  else {
            return
        }
        object = selectorArray![selectedIndex]
    }
    
    override open func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        return false
    }
    
    override open func updateApiValueFromObject() {
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
