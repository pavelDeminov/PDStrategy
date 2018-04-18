//
//  TextDataTableViewController.swift
//  PDStrategy
//
//  Created by Pavel Deminov on 06/11/2017.
//  Copyright © 2017 Pavel Deminov. All rights reserved.
//

import UIKit

class TextDataTableViewController: PDTableViewController {
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableViewAutomaticDimension
    }
    
    override func cellIdentifier(for indexPath: IndexPath) -> String {
        guard let item = itemInfo(for: indexPath), let type = item.pdType as? TextDataTableType else {
            return super.cellIdentifier(for: indexPath)
        }
        
        switch type {
        case .text:
            return TextDataTableCell.reuseIdentifier()
        case .date:
            return DateTextDataTableCell.reuseIdentifier()
        case .phone:
            return PhoneTextDataTableCell.reuseIdentifier()
        case .money:
            return MoneyTextDataTableCell.reuseIdentifier()
        case .number:
            return NumberTextDataTableCell.reuseIdentifier()
        case .validate:
            return ButtonTextDataTableCell.reuseIdentifier()
        default:
            return TitleStaticCellsCell.reuseIdentifier()
        }
    }
    
    
    override func prepare(_ cell: UITableViewCell, for IndexPath: IndexPath) {
        if let buttonCell = cell as? ButtonTextDataTableCell {
            buttonCell.confirmButton.addTarget(self, action: #selector(validate(button:)), for: .touchUpInside)
        }
    }
    
    @objc func validate(button: UIButton) {
        
        controller?.validate()
        if controller?.state != ValidationState.valid {
            if let indexpath = controller?.errorIndexPath() {
                tableView?.reloadRows(at: [indexpath], with: .automatic)
                return
            }
        }
        
        //let params = controller?.dictionary()
        //print(params)

    }
}
