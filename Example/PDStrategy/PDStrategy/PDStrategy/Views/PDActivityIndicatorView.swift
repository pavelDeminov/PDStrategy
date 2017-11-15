//
//  PDActivityIndicatorView.swift
//  PDStrategy
//
//  Created by Pavel Deminov on 05/11/2017.
//  Copyright © 2017 Pavel Deminov. All rights reserved.
//

import UIKit

class PDActivityIndicatorView: UIActivityIndicatorView {

    var x: NSLayoutConstraint?
    var y: NSLayoutConstraint?
    
    required init(coder: NSCoder) {
        super.init(coder: coder)
        self.setup()
    }
    
    override init(activityIndicatorStyle style: UIActivityIndicatorViewStyle) {
        super.init(activityIndicatorStyle: style)
        self.setup()
    }
    
    func setup() {
        translatesAutoresizingMaskIntoConstraints = false
        hidesWhenStopped = true
    }
}
