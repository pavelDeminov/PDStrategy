//
//  PDTableViewCell.swift
//  PDStrategy
//
//  Created by Pavel Deminov on 04/11/2017.
//  Copyright © 2017 Pavel Deminov. All rights reserved.
//

import UIKit

class PDTableViewCell: UITableViewCell, PDCellInfo {
    
    var item: PDItemInfo? {
        didSet {
            updateUI()
        }
    }
    var reloadCellBlock: ReloadCellBlock?
    
    class var reuseIdentifier: String {
        get {
            var classString: String = NSStringFromClass(self)
            classString = (NSStringFromClass(self).components(separatedBy: ".").last) ?? "UITableViewCell"
            return classString
        }
    }
    
    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setup()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        setup()
    }
    
    override func prepareForInterfaceBuilder() {
        setup()
        setupForIB()
    }
    
    func setup() {
        //override
    }
    
    func setupForIB() {
        //override
    }
    
    func updateUI() {
        //override
    }
}
