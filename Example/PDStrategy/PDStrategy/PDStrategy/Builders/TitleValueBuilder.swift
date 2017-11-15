//
//  TitleValueBuilder.swift
//  PDStrategy
//
//  Created by Pavel Deminov on 05/11/2017.
//  Copyright © 2017 Pavel Deminov. All rights reserved.
//

import UIKit

class TitleValueBuilder: NSObject {
    
    class func addTitleValue(to view: UIView) -> (titleLabel: PDTitleLabel, valueLabel: PDValueLabel) {
        let titleLabel =  PDTitleLabel()
        view.addSubview(titleLabel)
        
        let valueLabel =  PDValueLabel()
        view.addSubview(valueLabel)
        
        titleLabel.setContentHuggingPriority(.required, for: .horizontal)
        
        titleLabel.top = NSLayoutConstraint(item: titleLabel, attribute: .top, relatedBy: .equal, toItem: titleLabel.superview, attribute: .top, multiplier: 1, constant: 15)
        
        titleLabel.leading = NSLayoutConstraint(item: titleLabel, attribute: .leading, relatedBy: .equal, toItem: titleLabel.superview, attribute: .leading, multiplier: 1, constant: 15)
        
        titleLabel.bottom = NSLayoutConstraint(item: titleLabel, attribute: .bottom, relatedBy: .lessThanOrEqual, toItem: titleLabel.superview, attribute: .bottom, multiplier: 1, constant: -15)
        
        valueLabel.top = NSLayoutConstraint(item: valueLabel, attribute: .top, relatedBy: .equal, toItem: valueLabel.superview, attribute: .top, multiplier: 1, constant: 16)
        
        valueLabel.leading = NSLayoutConstraint(item: valueLabel, attribute: .leading, relatedBy: .equal, toItem: titleLabel, attribute: .trailing, multiplier: 1, constant: 10)
        
        valueLabel.trailing = NSLayoutConstraint(item: valueLabel, attribute: .trailing, relatedBy: .equal, toItem: valueLabel.superview, attribute: .trailing, multiplier: 1, constant: -15)
        
        valueLabel.bottom = NSLayoutConstraint(item: valueLabel, attribute: .bottom, relatedBy: .lessThanOrEqual, toItem: valueLabel.superview, attribute: .bottom, multiplier: 1, constant: -15)
        
        NSLayoutConstraint.activate([
            titleLabel.top!, titleLabel.leading!, titleLabel.bottom!,
            valueLabel.top!, valueLabel.leading!, valueLabel.trailing!, valueLabel.bottom!
            ])
        
        return (titleLabel, valueLabel)
    }
    
    class func addTitleValue2(to view: UIView) -> (titleLabel: PDTitleLabel, valueLabel: PDValueLabel) {
        let titleLabel =  PDTitleLabel()
        view.addSubview(titleLabel)
        
        let valueLabel =  PDValueLabel()
        view.addSubview(valueLabel)
        
        titleLabel.setContentHuggingPriority(.required, for: .vertical)
        
        titleLabel.top = NSLayoutConstraint(item: titleLabel, attribute: .top, relatedBy: .equal, toItem: titleLabel.superview, attribute: .top, multiplier: 1, constant: 15)
        
        titleLabel.leading = NSLayoutConstraint(item: titleLabel, attribute: .leading, relatedBy: .equal, toItem: titleLabel.superview, attribute: .leading, multiplier: 1, constant: 15)
        
        titleLabel.trailing = NSLayoutConstraint(item: titleLabel, attribute: .trailing, relatedBy: .equal, toItem: titleLabel.superview, attribute: .trailing, multiplier: 1, constant: -15)
        
        valueLabel.top = NSLayoutConstraint(item: valueLabel, attribute: .top, relatedBy: .equal, toItem: titleLabel, attribute: .bottom, multiplier: 1, constant: 10)
        
        valueLabel.leading = NSLayoutConstraint(item: valueLabel, attribute: .leading, relatedBy: .equal, toItem: valueLabel.superview, attribute: .leading, multiplier: 1, constant: 15)
        
        valueLabel.trailing = NSLayoutConstraint(item: valueLabel, attribute: .trailing, relatedBy: .equal, toItem: valueLabel.superview, attribute: .trailing, multiplier: 1, constant: -15)
        
        valueLabel.bottom = NSLayoutConstraint(item: valueLabel, attribute: .bottom, relatedBy: .equal, toItem: valueLabel.superview, attribute: .bottom, multiplier: 1, constant: -15)
        
        NSLayoutConstraint.activate([
            titleLabel.top!, titleLabel.leading!, titleLabel.trailing!,
            valueLabel.top!, valueLabel.leading!, valueLabel.trailing!, valueLabel.bottom!
            ])
        
        return (titleLabel, valueLabel)
    }
}
