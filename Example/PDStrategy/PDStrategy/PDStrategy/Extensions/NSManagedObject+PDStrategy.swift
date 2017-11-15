//
//  NSManagedObject+PDStrategy.swift
//  PDStrategy
//
//  Created by Pavel Deminov on 08/11/2017.
//  Copyright © 2017 Pavel Deminov. All rights reserved.
//

import UIKit
import CoreData

extension NSManagedObject: PDItemInfo {
    var itemHash: String? {
        get {
            return String(hash)
        }
    }
}
