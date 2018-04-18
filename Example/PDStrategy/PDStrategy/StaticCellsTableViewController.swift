//
//  StaticCellsTableViewController.swift
//  PDStrategy
//
//  Created by Pavel Deminov on 05/11/2017.
//  Copyright © 2017 Pavel Deminov. All rights reserved.
//

import UIKit

class StaticCellsTableViewController: PDTableViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableViewAutomaticDimension
    }
    
    override func cellIdentifier(for indexPath: IndexPath) -> String {
        guard let item = itemInfo(for: indexPath), let type = item.pdType as? StaticCellsTableType else {
            return super.cellIdentifier(for: indexPath)
        }
        
        switch type {
        case .title:
            return TitleStaticCellsCell.reuseIdentifier()
        case .titleValue:
            return TitleValueStaticCellsCell.reuseIdentifier()
        case .titleValue2:
            return TitleValue2StaticCellsCell.reuseIdentifier()
        case .titleValueDate:
            return DateStaticCellsCell.reuseIdentifier()
        case .titleValueDate2:
            return Date2StaticCellsCell.reuseIdentifier()
        case .titleValueDate3:
            return Date3StaticCellsCell.reuseIdentifier()
        case .titleImage:
            return ImageStaticCellsCell.reuseIdentifier()
            
//        default:
//            return TitleStaticCellsCell.reuseIdentifier
        }
    }
}
