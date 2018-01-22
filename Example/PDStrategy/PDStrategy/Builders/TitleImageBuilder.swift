//
//  TitleImageBuilder.swift
//  PDStrategy
//
//  Created by Pavel Deminov on 05/11/2017.
//  Copyright © 2017 Pavel Deminov. All rights reserved.
//

import UIKit

class TitleImageBuilder: NSObject {
    
    class func addTitleImage(to view: UIView) -> (titleLabel: PDTitleLabel, imageView: PDImageView) {
        let titleLabel =  PDTitleLabel()
        view.addSubview(titleLabel)
        
        let imageView =  PDImageView()
        view.addSubview(imageView)
        
        imageView.setContentHuggingPriority(.required, for: .horizontal)
        imageView.contentMode = .scaleAspectFit
        
        imageView.top = NSLayoutConstraint(item: imageView, attribute: .top, relatedBy: .equal, toItem: imageView.superview, attribute: .top, multiplier: 1, constant: 5)
        
        imageView.leading = NSLayoutConstraint(item: imageView, attribute: .leading, relatedBy: .equal, toItem: imageView.superview, attribute: .leading, multiplier: 1, constant: 15)
        
        imageView.bottom = NSLayoutConstraint(item: imageView, attribute: .bottom, relatedBy: .equal, toItem: imageView.superview, attribute: .bottom, multiplier: 1, constant: -5)
        
        titleLabel.top = NSLayoutConstraint(item: titleLabel, attribute: .top, relatedBy: .equal, toItem: titleLabel.superview, attribute: .top, multiplier: 1, constant: 16)
        
        titleLabel.leading = NSLayoutConstraint(item: titleLabel, attribute: .leading, relatedBy: .equal, toItem: imageView, attribute: .trailing, multiplier: 1, constant: 10)
        
        titleLabel.trailing = NSLayoutConstraint(item: titleLabel, attribute: .trailing, relatedBy: .equal, toItem: titleLabel.superview, attribute: .trailing, multiplier: 1, constant: -15)
        
        titleLabel.bottom = NSLayoutConstraint(item: titleLabel, attribute: .bottom, relatedBy: .lessThanOrEqual, toItem: titleLabel.superview, attribute: .bottom, multiplier: 1, constant: -15)
        
        NSLayoutConstraint.activate([
            imageView.top!, imageView.leading!, imageView.bottom!,
            titleLabel.top!, titleLabel.leading!, titleLabel.trailing!, titleLabel.bottom!
            ])
        
        return (titleLabel, imageView)
    }
}
