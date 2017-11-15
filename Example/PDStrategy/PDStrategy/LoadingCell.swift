//
//  LoadingCell.swift
//  PDStrategy
//
//  Created by Pavel Deminov on 05/11/2017.
//  Copyright © 2017 Pavel Deminov. All rights reserved.
//

import UIKit

class LoadingCell: PDTableViewCell {

    var activityIndicator: PDActivityIndicatorView!
    
    override func setup() {
        activityIndicator = ActivityIndicatorBuilder.addActivityIndicator(to: contentView)
    }

}
