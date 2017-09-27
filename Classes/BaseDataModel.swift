//
//  BaseDataModel.swift
//  PositiveClub
//
//  Created by Pavel Deminov on 06/08/2017.
//  Copyright © 2017 Company. All rights reserved.
//

import UIKit

enum ValidationState {
    case none
    case valid
    case invalid(error: String)
}

func ==(lhs: ValidationState, rhs: ValidationState) -> Bool {
    return String(stringInterpolationSegment: lhs) == String(stringInterpolationSegment: rhs)
}

func !=(lhs: ValidationState, rhs: ValidationState) -> Bool {
    return String(stringInterpolationSegment: lhs) != String(stringInterpolationSegment: rhs)
}

class BaseDataModel: BaseModel {
    
    var object: Any? {
        didSet {
            updateApiValueFromObject()
        }
    }
    var apiKey: String?
    var cellIdentifier: String?
    var placeholder: String?
    var icon: UIImage?
    var title: String?
    
    var textFieldValue: String? {
        didSet {
            updateObjectFromTextFieldValue()
        }
    }
    var apiValue: String?
    var isValid = ValidationState.none
    var validationError: String?
    var validationsRules: [ValidationRule]?
    
    func validate() {
        isValid = .valid
        guard let rules = validationsRules, let object = object else {
            return
        }
        
        for rule in rules {
            let result = rule.isValid(value: object)
            if !result.valid {
                let error = result.error != nil ? result.error! : "Unknown error"
                isValid = .invalid(error: error)
                break
            }
        }
    }
    
    func invalidate() {
        isValid = ValidationState.none
        validationError = nil
    }
    
    internal func updateObjectFromTextFieldValue() {
        
    }
    
    internal func updateApiValueFromObject() {
        
    }
    
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        return true
    }
    
    override init() {
        super.init()
    }
    convenience init(title:String?, object: AnyObject?, apiKey: String?, cellIdentifier: String?, placeholder: String?) {
        self.init(title: title, object: object, apiKey: apiKey, cellIdentifier: cellIdentifier, placeholder: placeholder, icon: nil)
    }
    
    init(title:String?, object: AnyObject?, apiKey: String?, cellIdentifier: String?, placeholder: String?, icon: UIImage?) {
        //super.init()
        self.title = title;
        self.object = object
        self.apiKey = apiKey
        self.cellIdentifier = cellIdentifier
        self.placeholder = placeholder
        self.icon = icon
    }
}
