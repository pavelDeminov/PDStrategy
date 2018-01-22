//
//  TitleValueScrollCell.swift
//  PDStrategy
//
//  Created by Pavel Deminov on 09/01/2018.
//  Copyright © 2018 Pavel Deminov. All rights reserved.
//

import UIKit

class TitleValueScrollCell: PDScrollViewCell {

    private(set) var titleLabel: UILabel!
    private(set) var valueLabel: UILabel!
    
    override func setup() {
        weak var wSelf = self
        self.backgroundColor = UIColor.white
        
        TitleValueBuilder.addTitle(to: self) { (titleLabel, valueLabel) in
             wSelf?.titleLabel = titleLabel;
             wSelf?.valueLabel = valueLabel;
        }
        
    }
    
    override func updateUI() {
        titleLabel.text = itemInfo?.title
        valueLabel.text = itemInfo?.value as? String
    }

}
