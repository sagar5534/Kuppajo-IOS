//
//  SelectionCell.swift
//  Kuppajo
//
//  Created by Sagar on 2020-02-02.
//  Copyright © 2020 Sagar. All rights reserved.
//

import UIKit

protocol SelectionCellDelegate: AnyObject {
    
    func changeText(for youtuber: String)
    
}

class SelectionCell: UITableViewCell {
    
    @IBOutlet weak var Name: UILabel!
    @IBOutlet weak var option: UITextField!
    
    let pickerView = UIPickerView()
    
    weak var delegate : SelectionCellDelegate?

    override func awakeFromNib() {
        super.awakeFromNib()

        option.inputView = pickerView

        let toolBar = UIToolbar()
        toolBar.sizeToFit()
        let button = UIBarButtonItem(title: "Done", style: .plain, target: self, action: #selector(finishedEditing))
        toolBar.setItems([button], animated: true)
        toolBar.isUserInteractionEnabled = true
        option.inputAccessoryView = toolBar
        
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
    
    func setPickerViewDataSourceDelegate(dataSourceDelegate: UIPickerViewDataSource & UIPickerViewDelegate, forRow row: Int) {
        pickerView.delegate = dataSourceDelegate
        pickerView.dataSource = dataSourceDelegate
        pickerView.tag = row
    }
    
    @objc func finishedEditing() {
        option.endEditing(true)
    }

}
