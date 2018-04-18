//
//  DateTextDataTableCell.swift
//  PDStrategy
//
//  Created by Pavel Deminov on 06/11/2017.
//  Copyright © 2017 Pavel Deminov. All rights reserved.
//

import UIKit

class DateTextDataTableCell: TextDataTableCell {

    internal var dateFormatter: DateFormatter = {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "dd.MM.YYYY"
        return dateFormatter
    }()
    
    override func setup() {
        super.setup()
        initDatePicker()
    }
    
    override func updateUI() {
        super.updateUI()
        
        if let date = itemInfo?.pdDate {
            self.textField?.text = dateFormatter.string(from: date)
            
            if let datePicker = textField?.inputView as? UIDatePicker {
                datePicker.date = date
            }
        }
    }
    
    internal func initDatePicker() {
        
        let datePicker = UIDatePicker()
        datePicker.datePickerMode = .date
        datePicker.addTarget(self, action: #selector(handleDatePicker(sender:)), for: .valueChanged)
        textField?.inputView = datePicker
    }
    
    @objc internal func handleDatePicker(sender: UIDatePicker) {
        textField?.text = dateFormatter.string(from: sender.date)
        if let pdItem = itemInfo as? PDItem {
            pdItem.date = sender.date
        }
        
    }

}
