//
//  TitleValueDateBuilder.swift
//  PDStrategy
//
//  Created by Pavel Deminov on 05/11/2017.
//  Copyright © 2017 Pavel Deminov. All rights reserved.
//

import UIKit

class TitleValueDateBuilder: NSObject {
    
    /*
     ---------------------
     Title           Date
     Value
     ____________________
     */
    
    class func addTitleValueDate(to view: UIView) -> (titleLabel: PDTitleLabel, valueLabel: PDValueLabel, dateLabel: PDDateLabel) {
        let titleLabel =  PDTitleLabel()
        view.addSubview(titleLabel)

        let valueLabel =  PDValueLabel()
        view.addSubview(valueLabel)
        
        let dateLabel =  PDDateLabel()
        view.addSubview(dateLabel)

        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "dd.MM.YYYY"
        dateLabel.dateOutFormatter = dateFormatter
        dateLabel.dateInFormatter = dateFormatter
        
        dateLabel.setContentHuggingPriority(.required, for: .horizontal)
        
        titleLabel.top = NSLayoutConstraint(item: titleLabel, attribute: .top, relatedBy: .equal, toItem: titleLabel.superview, attribute: .top, multiplier: 1, constant: 15)
        
        titleLabel.leading = NSLayoutConstraint(item: titleLabel, attribute: .leading, relatedBy: .equal, toItem: titleLabel.superview, attribute: .leading, multiplier: 1, constant: 15)
        
        titleLabel.bottom = NSLayoutConstraint(item: titleLabel, attribute: .bottom, relatedBy: .lessThanOrEqual, toItem: titleLabel.superview, attribute: .bottom, multiplier: 1, constant: -15)
        
        dateLabel.top = NSLayoutConstraint(item: dateLabel, attribute: .top, relatedBy: .equal, toItem: dateLabel.superview, attribute: .top, multiplier: 1, constant: 17)
        
        dateLabel.leading = NSLayoutConstraint(item: dateLabel, attribute: .leading, relatedBy: .equal, toItem: titleLabel, attribute: .trailing, multiplier: 1, constant: 15)
        
        dateLabel.trailing = NSLayoutConstraint(item: dateLabel, attribute: .trailing, relatedBy: .equal, toItem: dateLabel.superview, attribute: .trailing, multiplier: 1, constant: -15)
        
        
        valueLabel.top = NSLayoutConstraint(item: valueLabel, attribute: .top, relatedBy: .equal, toItem: titleLabel, attribute: .bottom, multiplier: 1, constant: 10)
        
        valueLabel.leading = NSLayoutConstraint(item: valueLabel, attribute: .leading, relatedBy: .equal, toItem: valueLabel.superview, attribute: .leading, multiplier: 1, constant: 15)
        
        valueLabel.trailing = NSLayoutConstraint(item: valueLabel, attribute: .trailing, relatedBy: .equal, toItem: valueLabel.superview, attribute: .trailing, multiplier: 1, constant: -15)
        
        valueLabel.bottom = NSLayoutConstraint(item: valueLabel, attribute: .bottom, relatedBy: .lessThanOrEqual, toItem: valueLabel.superview, attribute: .bottom, multiplier: 1, constant: -15)
        
        NSLayoutConstraint.activate([
            titleLabel.top!,titleLabel.leading!, titleLabel.bottom!,
            dateLabel.top!, dateLabel.leading!,dateLabel.trailing!,
            valueLabel.top!, valueLabel.leading!, valueLabel.trailing!, valueLabel.bottom!
            ])
        
        return (titleLabel, valueLabel, dateLabel)
    }
    
    /*
     ---------------------
     Title
     Date
     Value
     ____________________
     */
    
    class func addTitleValueDate2(to view: UIView) -> (titleLabel: PDTitleLabel, valueLabel: PDValueLabel, dateLabel: PDDateLabel) {
        let titleLabel =  PDTitleLabel()
        view.addSubview(titleLabel)
        
        let valueLabel =  PDValueLabel()
        view.addSubview(valueLabel)
        
        let dateLabel =  PDDateLabel()
        view.addSubview(dateLabel)
        
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "dd.MM.YYYY"
        dateLabel.dateOutFormatter = dateFormatter
        dateLabel.dateInFormatter = dateFormatter
        
        dateLabel.setContentHuggingPriority(.required, for: .horizontal)
        
        titleLabel.top = NSLayoutConstraint(item: titleLabel, attribute: .top, relatedBy: .equal, toItem: titleLabel.superview, attribute: .top, multiplier: 1, constant: 15)
        
        titleLabel.leading = NSLayoutConstraint(item: titleLabel, attribute: .leading, relatedBy: .equal, toItem: titleLabel.superview, attribute: .leading, multiplier: 1, constant: 15)
        
        titleLabel.trailing = NSLayoutConstraint(item: titleLabel, attribute: .trailing, relatedBy: .lessThanOrEqual, toItem: titleLabel.superview, attribute: .trailing, multiplier: 1, constant: -15)
        
        dateLabel.top = NSLayoutConstraint(item: dateLabel, attribute: .top, relatedBy: .equal, toItem: titleLabel, attribute: .bottom, multiplier: 1, constant: 10)
        
        dateLabel.leading = NSLayoutConstraint(item: dateLabel, attribute: .leading, relatedBy: .equal, toItem: dateLabel.superview, attribute: .leading, multiplier: 1, constant: 15)
        
        dateLabel.trailing = NSLayoutConstraint(item: dateLabel, attribute: .trailing, relatedBy: .equal, toItem: dateLabel.superview, attribute: .trailing, multiplier: 1, constant: -15)
        
        
        valueLabel.top = NSLayoutConstraint(item: valueLabel, attribute: .top, relatedBy: .equal, toItem: dateLabel, attribute: .bottom, multiplier: 1, constant: 10)
        
        valueLabel.leading = NSLayoutConstraint(item: valueLabel, attribute: .leading, relatedBy: .equal, toItem: valueLabel.superview, attribute: .leading, multiplier: 1, constant: 15)
        
        valueLabel.trailing = NSLayoutConstraint(item: valueLabel, attribute: .trailing, relatedBy: .equal, toItem: valueLabel.superview, attribute: .trailing, multiplier: 1, constant: -15)
        
        valueLabel.bottom = NSLayoutConstraint(item: valueLabel, attribute: .bottom, relatedBy: .lessThanOrEqual, toItem: valueLabel.superview, attribute: .bottom, multiplier: 1, constant: -15)
        
        NSLayoutConstraint.activate([
            titleLabel.top!,titleLabel.leading!, titleLabel.trailing!,
            dateLabel.top!, dateLabel.leading!,dateLabel.trailing!,
            valueLabel.top!, valueLabel.leading!, valueLabel.trailing!, valueLabel.bottom!
            ])
        
        return (titleLabel, valueLabel, dateLabel)
    }
    
    /*
     ---------------------
     Date
     Title
     Value
     ____________________
     */
    
    class func addTitleValueDate3(to view: UIView) -> (titleLabel: PDTitleLabel, valueLabel: PDValueLabel, dateLabel: PDDateLabel) {
        let titleLabel =  PDTitleLabel()
        view.addSubview(titleLabel)
        
        let valueLabel =  PDValueLabel()
        view.addSubview(valueLabel)
        
        let dateLabel =  PDDateLabel()
        view.addSubview(dateLabel)
        
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "dd.MM.YYYY"
        dateLabel.dateOutFormatter = dateFormatter
        dateLabel.dateInFormatter = dateFormatter
        
        dateLabel.setContentHuggingPriority(.required, for: .horizontal)
        
        dateLabel.top = NSLayoutConstraint(item: dateLabel, attribute: .top, relatedBy: .equal, toItem: dateLabel.superview, attribute: .top, multiplier: 1, constant: 15)
        
        dateLabel.leading = NSLayoutConstraint(item: dateLabel, attribute: .leading, relatedBy: .equal, toItem: dateLabel.superview, attribute: .leading, multiplier: 1, constant: 15)
        
        dateLabel.trailing = NSLayoutConstraint(item: dateLabel, attribute: .trailing, relatedBy: .lessThanOrEqual, toItem: dateLabel.superview, attribute: .trailing, multiplier: 1, constant: -15)
        
        titleLabel.top = NSLayoutConstraint(item: titleLabel, attribute: .top, relatedBy: .equal, toItem: dateLabel, attribute: .bottom, multiplier: 1, constant: 10)
        
        titleLabel.leading = NSLayoutConstraint(item: titleLabel, attribute: .leading, relatedBy: .equal, toItem: titleLabel.superview, attribute: .leading, multiplier: 1, constant: 15)
        
        titleLabel.trailing = NSLayoutConstraint(item: titleLabel, attribute: .trailing, relatedBy: .equal, toItem: titleLabel.superview, attribute: .trailing, multiplier: 1, constant: -15)
        
        
        valueLabel.top = NSLayoutConstraint(item: valueLabel, attribute: .top, relatedBy: .equal, toItem: titleLabel, attribute: .bottom, multiplier: 1, constant: 10)
        
        valueLabel.leading = NSLayoutConstraint(item: valueLabel, attribute: .leading, relatedBy: .equal, toItem: valueLabel.superview, attribute: .leading, multiplier: 1, constant: 15)
        
        valueLabel.trailing = NSLayoutConstraint(item: valueLabel, attribute: .trailing, relatedBy: .equal, toItem: valueLabel.superview, attribute: .trailing, multiplier: 1, constant: -15)
        
        valueLabel.bottom = NSLayoutConstraint(item: valueLabel, attribute: .bottom, relatedBy: .lessThanOrEqual, toItem: valueLabel.superview, attribute: .bottom, multiplier: 1, constant: -15)
        
        NSLayoutConstraint.activate([
            titleLabel.top!,titleLabel.leading!, titleLabel.trailing!,
            dateLabel.top!, dateLabel.leading!,dateLabel.trailing!,
            valueLabel.top!, valueLabel.leading!, valueLabel.trailing!, valueLabel.bottom!
            ])
        
        return (titleLabel, valueLabel, dateLabel)
    }
}
