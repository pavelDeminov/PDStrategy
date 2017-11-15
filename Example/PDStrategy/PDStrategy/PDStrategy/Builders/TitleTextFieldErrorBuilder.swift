//
//  TitleTextFieldErrorBuilder.swift
//  PDStrategy
//
//  Created by Pavel Deminov on 06/11/2017.
//  Copyright © 2017 Pavel Deminov. All rights reserved.
//

import UIKit

class TitleTextFieldErrorBuilder: NSObject {
    
    class func addTitleTextFieldError(to view: UIView) -> (titleLabel: PDTitleLabel, textField: PDTextField, errorLabel: PDErrorLabel) {
        let titleLabel =  PDTitleLabel()
        view.addSubview(titleLabel)
        
        let textField =  PDTextField()
        view.addSubview(textField)
        
        let errorLabel =  PDErrorLabel()
        view.addSubview(errorLabel)
        
        titleLabel.top = NSLayoutConstraint(item: titleLabel, attribute: .top, relatedBy: .equal, toItem: titleLabel.superview, attribute: .top, multiplier: 1, constant: 15)
        
        titleLabel.leading = NSLayoutConstraint(item: titleLabel, attribute: .leading, relatedBy: .equal, toItem: titleLabel.superview, attribute: .leading, multiplier: 1, constant: 15)
        
        titleLabel.trailing = NSLayoutConstraint(item: titleLabel, attribute: .trailing, relatedBy: .lessThanOrEqual, toItem: titleLabel.superview, attribute: .trailing, multiplier: 1, constant: -15)
        
        textField.top = NSLayoutConstraint(item: textField, attribute: .top, relatedBy: .equal, toItem: titleLabel, attribute: .bottom, multiplier: 1, constant: 10)
        
        textField.leading = NSLayoutConstraint(item: textField, attribute: .leading, relatedBy: .equal, toItem: textField.superview, attribute: .leading, multiplier: 1, constant: 15)
        
        textField.trailing = NSLayoutConstraint(item: textField, attribute: .trailing, relatedBy: .equal, toItem: textField.superview, attribute: .trailing, multiplier: 1, constant: -15)
        
        
        errorLabel.top = NSLayoutConstraint(item: errorLabel, attribute: .top, relatedBy: .equal, toItem: textField, attribute: .bottom, multiplier: 1, constant: 10)
        
        errorLabel.leading = NSLayoutConstraint(item: errorLabel, attribute: .leading, relatedBy: .equal, toItem: errorLabel.superview, attribute: .leading, multiplier: 1, constant: 15)
        
        errorLabel.trailing = NSLayoutConstraint(item: errorLabel, attribute: .trailing, relatedBy: .equal, toItem: errorLabel.superview, attribute: .trailing, multiplier: 1, constant: -15)
        
        errorLabel.bottom = NSLayoutConstraint(item: errorLabel, attribute: .bottom, relatedBy: .lessThanOrEqual, toItem: errorLabel.superview, attribute: .bottom, multiplier: 1, constant: -15)
        
        NSLayoutConstraint.activate([
            titleLabel.top!,titleLabel.leading!, titleLabel.trailing!,
            textField.top!, textField.leading!,textField.trailing!,
            errorLabel.top!, errorLabel.leading!, errorLabel.trailing!, errorLabel.bottom!
            ])
        
        return (titleLabel, textField, errorLabel)
    }
    
}
