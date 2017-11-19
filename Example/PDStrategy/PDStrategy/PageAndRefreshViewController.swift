//
//  PageAndRefreshViewController.swift
//  PDStrategy
//
//  Created by Pavel Deminov on 05/11/2017.
//  Copyright © 2017 Pavel Deminov. All rights reserved.
//

import UIKit

class PageAndRefreshViewController: PDTableViewController {
    
    var currentPage = 0
    var limit = 20
    var allDataLoaded = false
    var pageIsLoading = false
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        refreshEnabled = true
        refresh()
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func refresh() {
        allDataLoaded = false
        currentPage = 0
        loadNextPage()
    }
    
    func loadNextPage() {
        weak var wSelf = self
        pageIsLoading = true
        DispatchQueue.main.asyncAfter(deadline: DispatchTime.now() + Double(2 * Double(NSEC_PER_SEC)) / Double(NSEC_PER_SEC), execute: {() -> Void in
            guard let sSelf = wSelf else {
                return
            }
            
            if sSelf.currentPage == 0 {
                sSelf.controller?.setup()
            }
            
            guard let sectionInfo = sSelf.controller?.sections?.first as? PDSectionInfo else {
                return
            }
            
            var count = sectionInfo.items?.count
            if count == nil {
                count = 0
            }
            
            var array = [PageAndResfreshModel]()
            for _ in 0..<sSelf.limit {
                let model = PageAndResfreshModel()
                model.title = "title \(String(count!))"
                model.value = "value \(String(count!))"
                count = count! + 1
                array.append(model)
                
                // limit check
                if (count! > 64) {
                    break
                }
            }
            if array.count < sSelf.limit {
                sSelf.allDataLoaded = true
            }
            sSelf.controller?.appendData(array)
            sSelf.currentPage += 1
            sSelf.refreshControl?.endRefreshing()
            sSelf.pageIsLoading = false
            sSelf.tableView?.reloadData()
            
        })
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        var count = super.tableView(tableView, numberOfRowsInSection: section)
        if !allDataLoaded {
            count += 1
        }
        return count
    }
    
    override func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        guard !allDataLoaded && !pageIsLoading else {
            return
        }
        
        if let sectionInfo = self.sectionInfo(forSection: indexPath.section),
            controller?.sections?.count == indexPath.section + 1,
            sectionInfo.items?.count == indexPath.row {
            if let loadingCell = cell as? LoadingCell {
                loadingCell.activityIndicator.startAnimating()
            }
            loadNextPage()
        }
    }
    
    override func cellIdentifier(for indexPath: IndexPath) -> String {
        let cellIdentifier = super.cellIdentifier(for: indexPath)
        
        guard !allDataLoaded && !pageIsLoading else {
            return cellIdentifier
        }
        
        if let sectionInfo = self.sectionInfo(forSection: indexPath.section),
            controller?.sections?.count == indexPath.section + 1,
            sectionInfo.items?.count == indexPath.row {
            return LoadingCell.reuseIdentifier()
        }
        
        return cellIdentifier
    }
}
