//
//  FRCTableViewController.swift
//  PDStrategy
//
//  Created by Pavel Deminov on 08/11/2017.
//  Copyright © 2017 Pavel Deminov. All rights reserved.
//

import UIKit
import MagicalRecord

class FRCTableViewController: PDFRCTableViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        checkAndFillDataBase()
        // Do any additional setup after loading the view.
    }

    override func setupFRC() {
        frc = Animal.mr_fetchAllSorted(by: "title", ascending: false, with: nil, groupBy:nil, delegate: self, in: NSManagedObjectContext.mr_default())
        try! frc?.performFetch()
    }
    
    func checkAndFillDataBase() {
        if let animals = Animal.mr_findAll(), animals.count > 0 {
            return
        }
        
        MagicalRecord.save ({ (context) in
            for index in 1...10 {
                let duck = Animal.mr_createEntity(in: context)
                duck?.title = "Duck" + String(index)
            }
        })
        
    }

}
