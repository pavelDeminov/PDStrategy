//
//  ScrollCell.swift
//  PDStrategy
//
//  Created by Pavel Deminov on 07/01/2018.
//  Copyright © 2018 Pavel Deminov. All rights reserved.
//

import UIKit

class ScrollCell: PDScrollViewCell {

    @IBOutlet private(set) var titleLabel: UILabel!
    
    override func setup() {
        weak var wSelf = self
        self.backgroundColor = UIColor.white
        TitleBuilder.addTitle(to: self, with: { (titleLabel) in
            wSelf?.titleLabel = titleLabel;
        })
    }
    
    override func updateUI() {
        titleLabel.text = itemInfo?.title
    }

}
