//
//  PDManagedItemInfo.swift
//  PDStrategy
//
//  Created by Pavel Deminov on 08/11/2017.
//  Copyright © 2017 Pavel Deminov. All rights reserved.
//

import UIKit

protocol PDManagedItemInfo: PDItemInfo {
    var title: String? {get set}
    var value: Any? {get set}
    var date: Date? {get set}
    var apiKey: String? {get set}
    var placeholder: String? {get set}
    var type: Any? {get set}
    var image: UIImage? {get set}
    var imageUrl: URL? {get set}
}
