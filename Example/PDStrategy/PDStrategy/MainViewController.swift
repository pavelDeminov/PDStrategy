//
//  ViewController.swift
//  PDStrategy
//
//  Created by Pavel Deminov on 04/11/2017.
//  Copyright © 2017 Pavel Deminov. All rights reserved.
//

import UIKit

class MainViewController: PDTableViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableViewAutomaticDimension
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        guard let item = item(for: indexPath), let type = item.type as? MainItemType else {
            return
        }
        
        switch type {
        case .sections:
            performSegue(withIdentifier: SectionsTableViewController.segueIdentifier, sender: self)
        case .pageAndRefresh:
            performSegue(withIdentifier: PageAndRefreshViewController.segueIdentifier, sender: self)
        case .staticCellsTable:
            performSegue(withIdentifier: StaticCellsTableViewController.segueIdentifier, sender: self)
        case .textDataTable :
            performSegue(withIdentifier: TextDataTableViewController.segueIdentifier, sender: self)
        case .frcTableView :
            performSegue(withIdentifier: FRCTableViewController.segueIdentifier, sender: self)
        case .simpleCollection :
            performSegue(withIdentifier: SimpleCollectionViewController.segueIdentifier, sender: self)
        }
    }
}

