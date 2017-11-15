//
//  PDTableViewController.swift
//  PDStrategy
//
//  Created by Pavel Deminov on 04/11/2017.
//  Copyright © 2017 Pavel Deminov. All rights reserved.
//

import UIKit

class PDTableViewController: UIViewController {
    
    var controller: PDController?
    
    class var segueIdentifier: String {
        get {
            var classString: String = NSStringFromClass(self)
            classString = (NSStringFromClass(self).components(separatedBy: ".").last) ?? ""
            classString = classString.replacingOccurrences(of: "ViewController", with: "")
            let identifier = "\(classString)Segue"
            return identifier
        }
    }
    
    @IBOutlet weak var tableView: UITableView!
    
    var refreshControl: PDRefreshControl?
    var isRefreshEnabled = false {
        didSet {
            if #available(iOS 10.0, *) {
                if isRefreshEnabled {
                    tableView.refreshControl = refreshControl
                }
                else {
                    tableView.refreshControl = nil
                }
            } else {
                if isRefreshEnabled {
                    tableView.addSubview(refreshControl ?? UIView())
                }
                else {
                    refreshControl?.removeFromSuperview()
                }
            }
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.dataSource = self
        tableView.delegate = self
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillBeHidden(_:)), name: .UIKeyboardWillHide, object: nil)
        refreshControl = PDRefreshControl()
        refreshControl?.addTarget(self, action: #selector(refresh), for: .valueChanged)
        setupController()
    }
    
    deinit {
        NotificationCenter.default.removeObserver(self)
    }
    
    @objc func refresh() {
        let refreshControl: UIRefreshControl? = self.refreshControl
        DispatchQueue.main.asyncAfter(deadline: DispatchTime.now() + Double(2 * Double(NSEC_PER_SEC)) / Double(NSEC_PER_SEC), execute: {() -> Void in
            refreshControl?.endRefreshing()
        })
    }
    
    @objc func keyboardWillBeHidden(_ aNotification: Notification) {
        /*
        if let indexPath = tableView.indexPathForSelectedRow, let cell = tableView.cellForRow(at: indexPath) as? PDTableViewCell {
            tableView.deselectRow(at: (tableView.indexPathForSelectedRow)!, animated: true)
            cell.updateUI()
        }
         */
    }
 
    func setupController() {
        var classString: String = NSStringFromClass(type(of: self))
        //classString = (NSStringFromClass(type(of: self)).components(separatedBy: ".").last) ?? ""
        classString = classString.replacingOccurrences(of: "ViewController", with: "")
        let className = "\(classString)Controller"
        if let type = NSClassFromString(className) as? PDController.Type {
            controller = type.init()
        }
    }
    
    func sections() -> [Any]? {
        let controller = self.controller
        return controller?.sections
    }
    
    func sectionInfo(forSection section: Int) -> PDSectionInfo? {
        guard let sections = self.sections() as? [PDSectionInfo] else {
            return nil
        }
        return sections[section]
    }
    
    func item(for indexPath: IndexPath) -> PDItemInfo? {
        let sectionInfo = self.sectionInfo(forSection: indexPath.section)
        if let count = sectionInfo?.items?.count, indexPath.row < count, let item = sectionInfo?.items?[indexPath.row] {
            return item
        }
        return nil
    }
    
    func cellIdentifier(for indexPath: IndexPath) -> String {
        var classString: String = NSStringFromClass(type(of: self))
        classString = (NSStringFromClass(type(of: self)).components(separatedBy: ".").last) ?? ""
        classString = classString.replacingOccurrences(of: "ViewController", with: "")
        let identifier = "\(classString)Cell"
        return identifier
    }
    
    func sectionIdentifier(forSection section: Int) -> String {
        var classString: String = NSStringFromClass(type(of: self))
        classString = (NSStringFromClass(type(of: self)).components(separatedBy: ".").last) ?? ""
        classString = classString.replacingOccurrences(of: "ViewController", with: "")
        let identifier = "\(classString)Header"
        return identifier
    }
    
    func cellClassForRowAt(indexPath: IndexPath) -> AnyClass? {
        let identifier = cellIdentifier(for: indexPath)
        return classForIdentifier(identifier: identifier)
    }
    
    func headerFooterClassForSection(section: Int) -> AnyClass? {
        let identifier = sectionIdentifier(forSection: section)
        
        return classForIdentifier(identifier: identifier)
    }
    
    func classForIdentifier(identifier: String) -> AnyClass? {
        var identifier = identifier
        var cellClass: AnyClass? = NSClassFromString(identifier)
        if cellClass == nil {
            if let moduleName = NSStringFromClass(type(of: self)).components(separatedBy: ".").first {
                identifier = "\(moduleName).\(identifier)"
                cellClass = NSClassFromString(identifier)
            }
        }
        
        return cellClass
    }
    
    func prepareCell(cell: UITableViewCell, for indexPath: IndexPath) {
        //override
    }
    
}

extension PDTableViewController: UITableViewDelegate, UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        if let sections = sections() {
            return sections.count
        } else {
            return 0
        }
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if let sectionInfo: PDSectionInfo = self.sectionInfo(forSection: section), let items = sectionInfo.items {
            return items.count
        } else {
            return 0
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let itemInfo =  self.item(for: indexPath)
        
        let cellIdentifier: String = self.cellIdentifier(for: indexPath)
        
        var cell = tableView.dequeueReusableCell(withIdentifier: cellIdentifier)
        
        if cell == nil {
            let cellClass: AnyClass? = cellClassForRowAt(indexPath: indexPath)
            if cellClass != nil {
                tableView.register(cellClass, forCellReuseIdentifier: cellIdentifier)
                cell = tableView.dequeueReusableCell(withIdentifier: cellIdentifier)
            }
        }
        
        guard let tableCell = cell else {
            assertionFailure("Cell with indentifier \(cellIdentifier) not found")
            return UITableViewCell()
        }
        
        guard var cellInfo = tableCell as? PDCellInfo else {
            assertionFailure("Cell with indentifier \(cellIdentifier) not conforms PDCellInfo")
            return tableCell;
        }
        
        cellInfo.item = itemInfo
        prepareCell(cell: tableCell, for: indexPath)
        
        cellInfo.reloadCellBlock = {
            //tableView.reloadRows(at: [indexPath], with: .automatic)
            tableView.beginUpdates()
            tableView.endUpdates()
            //tableView.scrollToRow(at: indexPath, at: .none, animated: true)
            
        }
        
        return tableCell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 44
    }
    
    func tableView(_ tableView: UITableView, estimatedHeightForRowAt indexPath: IndexPath) -> CGFloat {
        return 44
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let sectionInfo =  self.sectionInfo(forSection: section)
        
        guard sectionInfo?.title != nil else {
            return nil
        }
        
        let sectionIdentifier = self.sectionIdentifier(forSection: section)
        
        var header = tableView.dequeueReusableHeaderFooterView(withIdentifier: sectionIdentifier)
        
        if header == nil {
            let headerClass: AnyClass? = headerFooterClassForSection(section: section)
            if headerClass != nil {
                tableView.register(headerClass, forHeaderFooterViewReuseIdentifier: sectionIdentifier)
                header = tableView.dequeueReusableHeaderFooterView(withIdentifier: sectionIdentifier)
            }
        }
        
        guard let tableHeader = header else {
            assertionFailure("Header with indentifier \(sectionIdentifier) not found")
            return nil
        }
        
        guard var headerInfo = header as? PDHeaderFooterInfo else {
            assertionFailure("Header with indentifier \(sectionIdentifier) not conforms PDHeaderFooterInfo")
            return tableHeader;
        }
        
        headerInfo.section = sectionInfo
        
        return tableHeader
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 0
    }
    
    func tableView(_ tableView: UITableView, estimatedHeightForHeaderInSection section: Int) -> CGFloat {
        return 22
    }
    /*
    func scrollViewWillBeginDragging(_ scrollView: UIScrollView) {
        refreshControl?.isDrag = true
    }
    
    func scrollViewDidEndDragging(_ scrollView: UIScrollView, willDecelerate decelerate: Bool) {
        refreshControl?.isDrag = false
    }
     */
}
