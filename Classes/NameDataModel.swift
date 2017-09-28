//
//  NameDataModel.swift
//  PositiveClub
//
//  Created by Pavel Deminov on 06/08/2017.
//  Copyright © 2017 Company. All rights reserved.
//

import UIKit

class NameDataModel: BaseDataModel {
        
    override func updateObjectFromTextFieldValue() {
        object = textFieldValue as AnyObject
    }
    
    override func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        return isNamePart(string: string)
    }
    
    override func updateApiValueFromObject() {
        apiValue = object as? String
    }
    
    func isNamePart(string: String) -> Bool {
        var charactersSet = CharacterSet.letters
        charactersSet.formUnion(CharacterSet(charactersIn: "- ") )
        if string.rangeOfCharacter(from: charactersSet.inverted) != nil {
            return false
        } else {
            return true
        }
    }

}


