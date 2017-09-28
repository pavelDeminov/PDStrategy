//
//  MaskDataModel.swift
//  ExpertService
//
//  Created by Pavel Deminov on 27/09/2017.
//  Copyright © 2017 Pavel Deminov. All rights reserved.
//

import UIKit

class MaskDataModel: BaseDataModel {
    
    var mask: String?
   
    override func updateObjectFromTextFieldValue() {
        //object = textFieldValue as AnyObject
    }
    
    override func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        return self.isNumberString(string: string)
    }
    
    override func updateApiValueFromObject() {
        apiValue = object as? String
    }
    
    func isNumberString(string: String) -> Bool {
        let charactersSet = CharacterSet.decimalDigits
        if string.rangeOfCharacter(from: charactersSet.inverted) != nil {
            return false
        } else {
            return true
        }
    }

}
