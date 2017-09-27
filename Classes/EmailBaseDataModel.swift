//
//  EmailDataModel.swift
//  PositiveClub
//
//  Created by Pavel Deminov on 07/08/2017.
//  Copyright © 2017 Company. All rights reserved.
//

import UIKit

class EmailDataModel: BaseDataModel {
    override func validate() {
        if let text = object as? String {
            isValid = text.isEmail ? .valid : .invalid(error: "Неправильный формат email")
            
        }
        
    }
    
    override func updateObjectFromTextFieldValue() {
        object = textFieldValue as AnyObject
    }
    
    override func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        return true
    }
    
    override func updateApiValueFromObject() {
        apiValue = object as? String
    }
}
