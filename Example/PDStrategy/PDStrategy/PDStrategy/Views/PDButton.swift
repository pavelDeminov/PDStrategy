//
//  PDButton.swift
//  PDStrategy
//
//  Created by Pavel Deminov on 11/11/2017.
//  Copyright © 2017 Pavel Deminov. All rights reserved.
//

import UIKit

class PDButton: UIButton {

    var top: NSLayoutConstraint?
    var leading: NSLayoutConstraint?
    var trailing: NSLayoutConstraint?
    var bottom: NSLayoutConstraint?
    
    var width: NSLayoutConstraint?
    var height: NSLayoutConstraint?
    
    var x: NSLayoutConstraint?
    var y: NSLayoutConstraint?
    
    var highlightedColor = UIColor.gray
    var normalColor = UIColor.white
    
    override var isHighlighted:Bool {
        didSet{
            updateUI()
        }
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    init() {
        super.init(frame: CGRect())
        self.setup()
    }
    
    func setup() {
        translatesAutoresizingMaskIntoConstraints = false
        layer.borderColor = UIColor.lightGray.cgColor
        layer.borderWidth = 1 / UIScreen.main.scale
        layer.cornerRadius = 6 / UIScreen.main.scale
        setTitleColor(UIColor.gray, for: .normal)
        setTitleColor(UIColor.white, for: .highlighted)
        updateUI()
    }
    
    func updateUI() {
        self.backgroundColor = isHighlighted ? highlightedColor : normalColor
        
    }

}
