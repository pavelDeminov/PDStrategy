//
//  PDTableViewHeaderFooter.swift
//  PDStrategy
//
//  Created by Pavel Deminov on 04/11/2017.
//  Copyright © 2017 Pavel Deminov. All rights reserved.
//

import UIKit

class PDTableViewHeaderFooter: UITableViewHeaderFooterView, PDHeaderFooterInfo {

    var section: PDSectionInfo? {
        didSet {
            updateUI()
        }
    }
        
    override init(reuseIdentifier: String?) {
        super.init(reuseIdentifier: reuseIdentifier)
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
