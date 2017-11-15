//
//  MainController.swift
//  PDStrategy
//
//  Created by Pavel Deminov on 04/11/2017.
//  Copyright © 2017 Pavel Deminov. All rights reserved.
//

import UIKit

enum MainItemType {
    case sections
    case pageAndRefresh
    case staticCellsTable
    case textDataTable
    case frcTableView
    case simpleCollection
}

class MainController: PDController {
    
    override func setup() {
        let section = PDSection.section()
        
        var items = [PDItem]()
        
        var item = PDItem.item()
        item.title = "Sections Table"
        item.type = MainItemType.sections
        items.append(item)
        
        item = PDItem.item()
        item.title = "Page And Refresh"
        item.type = MainItemType.pageAndRefresh
        items.append(item)
        
        item = PDItem.item()
        item.title = "Static Cells Table"
        item.type = MainItemType.staticCellsTable
        items.append(item)
        
        item = PDItem.item()
        item.title = "Text Data Table"
        item.type = MainItemType.textDataTable
        items.append(item)
        
        item = PDItem.item()
        item.title = "FRC Table View"
        item.type = MainItemType.frcTableView
        items.append(item)
        
        item = PDItem.item()
        item.title = "Simple Collection View"
        item.type = MainItemType.simpleCollection
        items.append(item)
        
        section.items = items
        
        sections = [section]
    }
}
