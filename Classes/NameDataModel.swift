//
//  NameDataModel.swift
//  PositiveClub
//
//  Created by Pavel Deminov on 06/08/2017.
//  Copyright © 2017 Company. All rights reserved.
//

import UIKit

class NameDataModel: BaseDataModel {
    
    override func validate() {
        if let text = object as? String {
            isValid = text.characters.count > 0 ? .valid : .invalid(error: "Имя, Фамилия или Отчество должны содержать как минимум 1 символ")
            if isValid == .valid
            {
                isValid = text.isNamePart ? .valid : .invalid(error: "Допускается использование букв и символов \"-\" и \" \" ")
            }
        }
        
    }
    
    override func updateObjectFromTextFieldValue() {
        object = textFieldValue as AnyObject
    }
    
    override func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        return string.isNamePart
    }
    
    override func updateApiValueFromObject() {
        apiValue = object as? String
    }

}
