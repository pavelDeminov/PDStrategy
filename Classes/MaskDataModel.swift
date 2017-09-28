//
//  MaskDataModel.swift
//  ExpertService
//
//  Created by Pavel Deminov on 27/09/2017.
//  Copyright © 2017 Pavel Deminov. All rights reserved.
//

import UIKit

open class MaskDataModel: BaseDataModel {
    
    open var mask: String?
   
    override open func updateObjectFromTextFieldValue() {
        //object = textFieldValue as AnyObject
    }
    
    override open  func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        return self.isNumberString(string: string)
    }
    
    override open func updateApiValueFromObject() {
        apiValue = object as? String
    }
    
    private func isNumberString(string: String) -> Bool {
        let charactersSet = CharacterSet.decimalDigits
        if string.rangeOfCharacter(from: charactersSet.inverted) != nil {
            return false
        } else {
            return true
        }
    }

}
