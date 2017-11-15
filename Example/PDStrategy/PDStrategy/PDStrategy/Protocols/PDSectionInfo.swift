//
//  PDSectionInfo.swift
//  PDStrategy
//
//  Created by Pavel Deminov on 04/11/2017.
//  Copyright © 2017 Pavel Deminov. All rights reserved.
//

import UIKit

protocol PDSectionInfo {
    var title: String? {get}
    var items: [PDItemInfo]? {get}
    
    func setup()
    
}
