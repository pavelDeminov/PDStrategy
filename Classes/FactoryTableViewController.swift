//
//  FactoryTableViewController.swift
//  ExpertService
//
//  Created by Pavel Deminov on 26/09/2017.
//  Copyright © 2017 Pavel Deminov. All rights reserved.
//

import UIKit

class FactoryTableViewController: UIViewController {
    
    internal var model: BaseSectionDataModel!
    @IBOutlet private(set) weak var tableView: UITableView!

}

extension FactoryTableViewController: UITableViewDelegate, UITableViewDataSource {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.tableView.dataSource = self
        self.tableView.delegate = self
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return model.sectionDataArray.count
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        let sectionDataArray = model.sectionDataArray[section]
        return sectionDataArray.data.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let sectionDataArray = model.sectionDataArray[indexPath.section]
        let elementModel = sectionDataArray.data[indexPath.row]
        guard let reusableIdentifier = elementModel.cellIdentifier else {
            assertionFailure("Element model must provide reusable identifier")
            return UITableViewCell()
        }
        
        guard let cell = tableView.dequeueReusableCell(withIdentifier: reusableIdentifier) else {
            assertionFailure("Cell not found")
            return UITableViewCell()
        }
        
        guard let factoryCell = cell as?  FactoryCell else {
            assertionFailure("Cell isn't FactoryCell")
            return cell
        }
        
        factoryCell.elementModel = elementModel
        return cell
        
    }
    
    func tableView(_ tableView: UITableView, estimatedHeightForRowAt indexPath: IndexPath) -> CGFloat {
        return 44
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableViewAutomaticDimension
    }
}
