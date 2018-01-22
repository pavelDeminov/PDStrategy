//
//  ButtonBuilder.swift
//  PDStrategy
//
//  Created by Pavel Deminov on 11/11/2017.
//  Copyright © 2017 Pavel Deminov. All rights reserved.
//

import UIKit

class ButtonBuilder: NSObject {
    class func addButton(to view: UIView) -> PDButton {
        let button =  PDButton()
        view.addSubview(button)
        
        button.top = NSLayoutConstraint(item: button, attribute: .top, relatedBy: .greaterThanOrEqual, toItem: button.superview, attribute: .top, multiplier: 1, constant: 15)
        
        button.leading = NSLayoutConstraint(item: button, attribute: .leading, relatedBy: .greaterThanOrEqual, toItem: button.superview, attribute: .leading, multiplier: 1, constant: 15)
        
        button.trailing = NSLayoutConstraint(item: button, attribute: .trailing, relatedBy: .greaterThanOrEqual, toItem: button.superview, attribute: .trailing, multiplier: 1, constant: -15)
        
        button.bottom = NSLayoutConstraint(item: button, attribute: .bottom, relatedBy: .greaterThanOrEqual, toItem: button.superview, attribute: .bottom, multiplier: 1, constant: -15)
        
        button.height = NSLayoutConstraint(item: button, attribute: .height, relatedBy: .equal, toItem: nil, attribute: .height, multiplier: 1, constant: 30)
        
        button.width = NSLayoutConstraint(item: button, attribute: .width, relatedBy: .equal, toItem: nil, attribute: .width, multiplier: 1, constant: 100)
        
        button.x = NSLayoutConstraint(item: button, attribute: .centerX , relatedBy: .equal, toItem: button.superview, attribute: .centerX, multiplier: 1, constant: 0)
        
        button.y = NSLayoutConstraint(item: button, attribute: .centerY , relatedBy: .equal, toItem: button.superview, attribute: .centerY, multiplier: 1, constant: 0)
        
        NSLayoutConstraint.activate([
            button.top!, button.leading!, button.bottom!, button.trailing!,button.height!, button.width!, button.x!, button.y!
            ])
        
        return button
    }
    
    class func addConfirmButton(to view: UIView) -> PDConfirmButton {
        let button =  PDConfirmButton()
        view.addSubview(button)
        
        button.top = NSLayoutConstraint(item: button, attribute: .top, relatedBy: .greaterThanOrEqual, toItem: button.superview, attribute: .top, multiplier: 1, constant: 15)
        
        button.leading = NSLayoutConstraint(item: button, attribute: .leading, relatedBy: .greaterThanOrEqual, toItem: button.superview, attribute: .leading, multiplier: 1, constant: 15)
        
        button.trailing = NSLayoutConstraint(item: button, attribute: .trailing, relatedBy: .lessThanOrEqual, toItem: button.superview, attribute: .trailing, multiplier: 1, constant: -15)
        
        button.bottom = NSLayoutConstraint(item: button, attribute: .bottom, relatedBy: .lessThanOrEqual, toItem: button.superview, attribute: .bottom, multiplier: 1, constant: -15)
        
        button.height = NSLayoutConstraint(item: button, attribute: .height, relatedBy: .equal, toItem: nil, attribute: .height, multiplier: 1, constant: 30)
        
        button.width = NSLayoutConstraint(item: button, attribute: .width, relatedBy: .equal, toItem: nil, attribute: .width, multiplier: 1, constant: 200)
        
        button.x = NSLayoutConstraint(item: button, attribute: .centerX , relatedBy: .equal, toItem: button.superview, attribute: .centerX, multiplier: 1, constant: 0)
        
        button.y = NSLayoutConstraint(item: button, attribute: .centerY , relatedBy: .equal, toItem: button.superview, attribute: .centerY, multiplier: 1, constant: 0)
        
        NSLayoutConstraint.activate([
            button.top!, button.leading!, button.bottom!, button.trailing!,button.height!, button.width!, button.x!, button.y!
            ])
        
        return button
    }
}
