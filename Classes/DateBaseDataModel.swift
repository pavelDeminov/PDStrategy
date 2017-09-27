//
//  DateDataModel.swift
//  PositiveClub
//
//  Created by Pavel Deminov on 07/08/2017.
//  Copyright © 2017 Company. All rights reserved.
//

import UIKit

class DateDataModel: BaseDataModel {
    
    var apiDateFormat: String = "yyyy-MM-dd'T'hh:mm:ss"
    var uiDateFormat: String = "dd.MM.yyyy"
    let dateformatter = DateFormatter()
    
    
    override func validate() {
        
        isValid = object as? Date != nil ? .valid : .invalid(error: "Неправильный формат даты")

    }
    
    override func updateObjectFromTextFieldValue() {
        dateformatter.dateFormat = uiDateFormat
        object = textFieldValue != nil ? dateformatter.date(from: textFieldValue!) : nil
    }
    
    override func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        return true
    }
    
    override func updateApiValueFromObject() {
        apiValue = object as? String
        dateformatter.dateFormat = apiDateFormat
        if let date = object as? Date {
             apiValue = textFieldValue != nil ? dateformatter.string(from: date) : nil
        }
       
    }
}
