//
//  TitleBuilder.swift
//  PDStrategy
//
//  Created by Pavel Deminov on 05/11/2017.
//  Copyright © 2017 Pavel Deminov. All rights reserved.
//

import UIKit

class TitleBuilder: NSObject {
    
    class func addTitle(to view: UIView) -> PDTitleLabel {
        let titleLabel =  PDTitleLabel()
        view.addSubview(titleLabel)
        
        titleLabel.top = NSLayoutConstraint(item: titleLabel, attribute: .top, relatedBy: .equal, toItem: titleLabel.superview, attribute: .top, multiplier: 1, constant: 15)
        
        titleLabel.leading = NSLayoutConstraint(item: titleLabel, attribute: .leading, relatedBy: .equal, toItem: titleLabel.superview, attribute: .leading, multiplier: 1, constant: 15)
        
        titleLabel.trailing = NSLayoutConstraint(item: titleLabel, attribute: .trailing, relatedBy: .equal, toItem: titleLabel.superview, attribute: .trailing, multiplier: 1, constant: -15)
        
        titleLabel.bottom = NSLayoutConstraint(item: titleLabel, attribute: .bottom, relatedBy: .equal, toItem: titleLabel.superview, attribute: .bottom, multiplier: 1, constant: -15)
        
        NSLayoutConstraint.activate([
            titleLabel.top!, titleLabel.leading!, titleLabel.bottom!, titleLabel.trailing!
            ])
        
        return titleLabel
    }
}
