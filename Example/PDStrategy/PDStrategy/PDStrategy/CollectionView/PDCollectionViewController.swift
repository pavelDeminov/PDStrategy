//
//  PDCollectionViewController.swift
//  PDStrategy
//
//  Created by Pavel Deminov on 12/11/2017.
//  Copyright © 2017 Pavel Deminov. All rights reserved.
//

import UIKit

class PDCollectionViewController: UIViewController {

    var controller: PDController?
    var stretchSpaceBetweenElements = false
    var registeredCells = [String]()
    var reusableCells = [IndexPath : UICollectionViewCell]()
    class var segueIdentifier: String {
        get {
            var classString: String = NSStringFromClass(self)
            classString = (NSStringFromClass(self).components(separatedBy: ".").last) ?? ""
            classString = classString.replacingOccurrences(of: "ViewController", with: "")
            let identifier = "\(classString)Segue"
            return identifier
        }
    }
    
    @IBOutlet weak var collectionView: UICollectionView!
    
    var refreshControl: PDRefreshControl?
    var isRefreshEnabled = false {
        didSet {
            if #available(iOS 10.0, *) {
                if isRefreshEnabled {
                    collectionView.refreshControl = refreshControl
                }
                else {
                    collectionView.refreshControl = nil
                }
            } else {
                if isRefreshEnabled {
                    collectionView.addSubview(refreshControl ?? UIView())
                }
                else {
                    collectionView?.removeFromSuperview()
                }
            }
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        collectionView.dataSource = self
        collectionView.delegate = self
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
    
    func prepareCell(cell: UICollectionViewCell, for indexPath: IndexPath) {
        //override
    }
    
    func cellSizeForItemAt(indexPath: IndexPath) -> CGSize {
        return defaultCellSize()
    }
    
    func dynamicCellSizeForItemAt(indexPath: IndexPath, for itemsCount:NSInteger) -> CGSize {
        
        let defaultSize = defaultCellSize()
        guard let flowLayout = collectionView.collectionViewLayout as? UICollectionViewFlowLayout, itemsCount > 0 else {
            return defaultSize
        }
        
        if flowLayout.scrollDirection == .vertical {
            let contentWidth = collectionView.frame.size.width - flowLayout.sectionInset.left - flowLayout.sectionInset.right
            
            let width = itemsCount > 1 ? contentWidth / CGFloat(itemsCount)  - contentWidth / (CGFloat(itemsCount - 1) * flowLayout.minimumInteritemSpacing) : contentWidth
            
            return CGSize(width: width, height: defaultSize.height)
        } else {
            let height = (collectionView.frame.size.height - flowLayout.sectionInset.top - flowLayout.sectionInset.bottom) / CGFloat(itemsCount - 1) * flowLayout.minimumLineSpacing
            
            return CGSize(width: defaultSize.width, height: height)
        }
        
    }
    
    func defaultCellSize() -> CGSize {
        return CGSize(width: 100, height: 100)
    }

}

extension PDCollectionViewController: UICollectionViewDataSource, UICollectionViewDelegate {
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        if let sections = sections() {
            return sections.count
        } else {
            return 0
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if let sectionInfo: PDSectionInfo = self.sectionInfo(forSection: section), let items = sectionInfo.items {
            return items.count
        } else {
            return 0
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let itemInfo =  self.item(for: indexPath)
        
        let cellIdentifier: String = self.cellIdentifier(for: indexPath)
        
        if !registeredCells.contains(cellIdentifier) {
            let cellClass: AnyClass? = cellClassForRowAt(indexPath: indexPath)
            if cellClass != nil {
                collectionView.register(cellClass, forCellWithReuseIdentifier: cellIdentifier)
                registeredCells.append(cellIdentifier)
            } else {
                assertionFailure("Cell with indentifier \(cellIdentifier) not found")
                return UICollectionViewCell()
            }
            
        }
        
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: cellIdentifier, for: indexPath)
        
        guard var cellInfo = cell as? PDCellInfo else {
            assertionFailure("Cell with indentifier \(cellIdentifier) not conforms PDCellInfo")
            return cell
        }
        
        cellInfo.item = itemInfo
        prepareCell(cell: cell, for: indexPath)
        
        cellInfo.reloadCellBlock = {
            //tableView.reloadRows(at: [indexPath], with: .automatic)
            //tableView.beginUpdates()
            //tableView.endUpdates()
            //tableView.scrollToRow(at: indexPath, at: .none, animated: true)
            
        }
        
        return cell
    }
    
}

extension PDCollectionViewController : UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        
        return cellSizeForItemAt(indexPath: indexPath)
    }
}
