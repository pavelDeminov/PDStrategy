//
//  PDItemInfo.swift
//  PDStrategy
//
//  Created by Pavel Deminov on 04/11/2017.
//  Copyright © 2017 Pavel Deminov. All rights reserved.
//

import UIKit

protocol PDItemInfo {
    var itemHash: String? {get}
    var title: String? {get set}
    var value: Any? {get set}
    var date: Date? {get set}
    var apiKey: String? {get set}
    var placeholder: String? {get set}
    var type: Any? {get set}
    var image: UIImage? {get set}
    var imageUrl: URL? {get set}
    
    func setup()
}

func == <T: PDItemInfo>(lhs: T, rhs: T) -> Bool {
    return lhs.itemHash == rhs.itemHash
}

func != <T: PDItemInfo>(lhs: T, rhs: T) -> Bool {
    return lhs.itemHash != rhs.itemHash
}

extension PDItemInfo {
    
    var title: String? {
        get {return "123"} set {}
    }
    
    var value: Any? {
        get {return nil} set {}
    }
    
    var date: Date? {
        get {return nil} set {}
    }
    
    var apiKey: String? {
        get {return nil} set {}
    }
    
    var placeholder: String? {
        get {return nil} set {}
    }
    
    var type: Any? {
        get {return nil} set {}
    }
    
    var image: UIImage? {
        get {return nil} set {}
    }
    
    var imageUrl: URL? {
        get {return nil} set {}
    }
    
    func setup() {
        
    }
}
