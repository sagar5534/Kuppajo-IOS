//
//  ProductDetailVC.swift
//  Kuppajo
//
//  Created by Sagar on 2020-02-02.
//  Copyright © 2020 Sagar. All rights reserved.
//

import UIKit
import AUPickerCell

class ProductDetailVC: UITableViewController {
    
    var option: ProductOption!
    
    var datePickerIndexPath: IndexPath?
    var inputDates: [Date] = []
    var inputTexts: [String] = ["Start date", "End date", "Another date"]
    var values: [String] = ["Sagar", "Om", "Racha"]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        inputDates = Array(repeating: Date(), count: inputTexts.count)
        
        tableView.register(UINib(nibName: DateTableViewCell.nibName(), bundle: nil), forCellReuseIdentifier: DateTableViewCell.reuseIdentifier())
        tableView.register(UINib(nibName: DatePickerTableViewCell.nibName(), bundle: nil), forCellReuseIdentifier: DatePickerTableViewCell.reuseIdentifier())
        
    }
    
    func indexPathToInsertDatePicker(indexPath: IndexPath) -> IndexPath {
        if let datePickerIndexPath = datePickerIndexPath, datePickerIndexPath.row < indexPath.row {
            return indexPath
        } else {
            return IndexPath(row: indexPath.row + 1, section: indexPath.section)
        }
    }
    
}
    

//    override func numberOfSections(in tableView: UITableView) -> Int {
//        // #warning Incomplete implementation, return the number of sections
//
//        //return option.children.count
//
//        if datePickerIndexPath != nil {
//            return inputTexts.count + 1
//        } else {
//            return inputTexts.count
//        }
//
//    }
    
    
    
// MARK: - Table view data source
extension ProductDetailVC {

    override func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return option.children[section].name
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        
        if datePickerIndexPath != nil {
            return option.children[section].products.count + 1
        } else {
            return option.children[section].products.count
        }
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        if datePickerIndexPath == indexPath {
            let datePickerCell = tableView.dequeueReusableCell(withIdentifier: DatePickerTableViewCell.reuseIdentifier()) as! DatePickerTableViewCell
            //datePickerCell.updateCell(date: values[indexPath.row - 1], indexPath: indexPath)
            datePickerCell.setPickerViewDataSourceDelegate(dataSourceDelegate: self)
            
            return datePickerCell
            
        } else {
            
            switch option.children[indexPath.section].products[indexPath.row].type {
            case "Stepper":
                
                let cell = tableView.dequeueReusableCell(withIdentifier: "StepperCell", for: indexPath) as! StepperCell
                cell.Name.text = option.children[indexPath.section].products[indexPath.row].name
                
                cell.selectionStyle = UITableViewCell.SelectionStyle.none

                return cell
                
            case "Selection":
            
                    let dateCell = tableView.dequeueReusableCell(withIdentifier: DateTableViewCell.reuseIdentifier()) as! DateTableViewCell
                    dateCell.updateText(text: option.children[indexPath.section].products[indexPath.row].name, value: option.children[indexPath.section].products[indexPath.row].amount ?? "")
                    return dateCell
                
            case "Switch":
                let cell = tableView.dequeueReusableCell(withIdentifier: "SwitchCell", for: indexPath) as! SwitchCell
                cell.Name.text = option.children[indexPath.section].products[indexPath.row].name
                
                cell.selectionStyle = UITableViewCell.SelectionStyle.none

                return cell
            
            default:
                break
                
            }
        }
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "SwitchCell", for: indexPath) as! SwitchCell
        cell.Name.text = option.children[indexPath.section].products[indexPath.row].name
        return cell
        
    }
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        if datePickerIndexPath == indexPath {
            return DatePickerTableViewCell.cellHeight()
        } else {
            return DateTableViewCell.cellHeight()
        }
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        guard let cell = tableView.cellForRow(at: indexPath) as? DateTableViewCell else { return }
        
        
        tableView.beginUpdates()
        if let datePickerIndexPath = datePickerIndexPath, datePickerIndexPath.row - 1 == indexPath.row {
            tableView.deleteRows(at: [datePickerIndexPath], with: .fade)
            self.datePickerIndexPath = nil
        } else {
            if let datePickerIndexPath = datePickerIndexPath {
                tableView.deleteRows(at: [datePickerIndexPath], with: .fade)
            }
            datePickerIndexPath = indexPathToInsertDatePicker(indexPath: indexPath)
            tableView.insertRows(at: [datePickerIndexPath!], with: .fade)
            //tableView.deselectRow(at: indexPath, animated: true)
        }
        tableView.deselectRow(at: indexPath, animated: true)
        tableView.endUpdates()
        
    }
    
}


extension ProductDetailVC: PickerDelegate {
    
    func didChangeDate(value: String, indexPath: IndexPath) {
        
        var selectedRow = indexPath
        selectedRow.row = selectedRow.row - 1
        
        option.children[selectedRow.section].products[selectedRow.row].amount = value
        
        tableView.reloadRows(at: [selectedRow], with: .none)
    }
    
}

extension ProductDetailVC: UIPickerViewDelegate, UIPickerViewDataSource {
    
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return values.count
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return values[row]
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        
        if datePickerIndexPath != nil{
            print("didChange")
            
            didChangeDate(value: values[row], indexPath: datePickerIndexPath!)
        }

    }
    
}
