//
//  DateDataModel.swift
//  PositiveClub
//
//  Created by Pavel Deminov on 07/08/2017.
//  Copyright © 2017 Company. All rights reserved.
//

import UIKit

open class DateDataModel: BaseDataModel {
    
    open var apiDateFormat: String = "yyyy-MM-dd'T'hh:mm:ss"
    open var uiDateFormat: String = "dd.MM.yyyy"
    open let dateformatter = DateFormatter()
    
    override open func updateObjectFromTextFieldValue() {
        dateformatter.dateFormat = uiDateFormat
        object = textFieldValue != nil ? dateformatter.date(from: textFieldValue!) : nil
    }
    
    override open func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        return true
    }
    
    override open func updateApiValueFromObject() {
        apiValue = object as? String
        dateformatter.dateFormat = apiDateFormat
        if let date = object as? Date {
             apiValue = textFieldValue != nil ? dateformatter.string(from: date) : nil
        }
       
    }
}
