//
//  PageAndRefreshController.swift
//  PDStrategy
//
//  Created by Pavel Deminov on 05/11/2017.
//  Copyright © 2017 Pavel Deminov. All rights reserved.
//

import UIKit

class PageAndRefreshDataSource: PDDataSource {
    
    override func setup() {
        let section = PDSection.instantiate()
        
        section.items = [PDItem]()
        sections = [section]
    }
    
        
    override func appendData(_ data: (Any)?) {
        guard let section = sections?.first as? PDSection else {
            return
        }
        
        guard var items = section.items else {
            return
        }
        
        guard  let array = data as? [PageAndResfreshModel] else {
            return
        }
        
        for model in array {
            let item = PDItem.instantiate()
            item.title = model.title
            item.value = model.value
            items.append(item)
        }
        section.items = items
        
    }
}
