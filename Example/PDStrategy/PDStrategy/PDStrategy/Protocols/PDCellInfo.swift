//
//  PDCellInfo.swift
//  PDStrategy
//
//  Created by Pavel Deminov on 04/11/2017.
//  Copyright © 2017 Pavel Deminov. All rights reserved.
//

import UIKit

typealias ReloadCellBlock = () -> Void

protocol PDCellInfo {
    
    var item: PDItemInfo? {get set}
    var reloadCellBlock: ReloadCellBlock? {get set}
}

