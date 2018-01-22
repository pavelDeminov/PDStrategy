//
//  ActivityIndicatorBuilder.swift
//  PDStrategy
//
//  Created by Pavel Deminov on 05/11/2017.
//  Copyright © 2017 Pavel Deminov. All rights reserved.
//

import UIKit

class ActivityIndicatorBuilder: NSObject {
    
    class func addActivityIndicator(to view: UIView) -> PDActivityIndicatorView {
        let activityIndicator =  PDActivityIndicatorView(activityIndicatorStyle: .gray)
        view.addSubview(activityIndicator)
        
        activityIndicator.x = NSLayoutConstraint(item: activityIndicator, attribute: .centerX, relatedBy: .equal, toItem: activityIndicator.superview, attribute: .centerX, multiplier: 1, constant: 0)
        
        activityIndicator.y = NSLayoutConstraint(item: activityIndicator, attribute: .centerY, relatedBy: .equal, toItem: activityIndicator.superview, attribute: .centerY, multiplier: 1, constant: 0)
        
        NSLayoutConstraint.activate([
            activityIndicator.x!, activityIndicator.y!
            ])
        
        return activityIndicator
    }
}
