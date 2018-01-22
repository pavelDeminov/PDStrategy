//
//  SimpleCollectionViewController.swift
//  PDStrategy
//
//  Created by Pavel Deminov on 12/11/2017.
//  Copyright © 2017 Pavel Deminov. All rights reserved.
//

import UIKit

class SimpleCollectionViewController: PDCollectionViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    override func cellSizeForItem(at indexPath: (IndexPath!)) -> CGSize {
        return dynamicCellSize(forItem: indexPath, itemsCount: 1)
    }
    
    
    override func cellIdentifier(for indexPath: IndexPath) -> String {
        guard let item = itemInfo(for: indexPath), let type = item.type as? StaticCellsTableType else {
            return super.cellIdentifier(for: indexPath)
        }
        
        switch type {
        case .titleValueDate:
            return DateSimpleCollectionCell.reuseIdentifier()
        default:
            return super.cellIdentifier(for: indexPath)
        }
    }
        
    override func defaultCellSize() -> CGSize {
        return CGSize(width: 50, height: 50)
    }

}
