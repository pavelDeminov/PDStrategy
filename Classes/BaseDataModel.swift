//
//  BaseDataModel.swift
//  PositiveClub
//
//  Created by Pavel Deminov on 06/08/2017.
//  Copyright © 2017 Company. All rights reserved.
//

import UIKit

public enum ValidationState {
    case none
    case valid
    case invalid(error: String)
}

public func ==(lhs: ValidationState, rhs: ValidationState) -> Bool {
    return String(stringInterpolationSegment: lhs) == String(stringInterpolationSegment: rhs)
}

public func !=(lhs: ValidationState, rhs: ValidationState) -> Bool {
    return String(stringInterpolationSegment: lhs) != String(stringInterpolationSegment: rhs)
}

open class BaseDataModel: NSObject {
    
    open var object: Any? {
        didSet {
            updateApiValueFromObject()
        }
    }
    open var apiKey: String?
    open var cellIdentifier: String?
    open var placeholder: String?
    open var icon: UIImage?
    open var title: String?
    
    open var textFieldValue: String? {
        didSet {
            updateObjectFromTextFieldValue()
        }
    }
    open var apiValue: String?
    open var isValid = ValidationState.none
    open var validationError: String?
    open var validationsRules: [ValidationRule]?
    
    open func validate() {
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
    
    open func invalidate() {
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
    
    override public init() {
        super.init()
    }
    convenience public init(title:String?, object: AnyObject?, apiKey: String?, cellIdentifier: String?, placeholder: String?) {
        self.init(title: title, object: object, apiKey: apiKey, cellIdentifier: cellIdentifier, placeholder: placeholder, icon: nil)
    }
    
    public init(title:String?, object: AnyObject?, apiKey: String?, cellIdentifier: String?, placeholder: String?, icon: UIImage?) {
        //super.init()
        self.title = title;
        self.object = object
        self.apiKey = apiKey
        self.cellIdentifier = cellIdentifier
        self.placeholder = placeholder
        self.icon = icon
    }
}
