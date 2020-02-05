//
//  ProductDetailVC.swift
//  Kuppajo
//
//  Created by Sagar on 2020-02-02.
//  Copyright © 2020 Sagar. All rights reserved.
//

import UIKit

class ProductDetailVC: UITableViewController, UIPickerViewDataSource, UIPickerViewDelegate{
    
    var option: ProductOption!
    
    var toolBar = UIToolbar()
    var picker  = UIPickerView()
    
    @IBOutlet weak var btn: UIButton!
    
    var selected: String?
    var data = ["cat", "bird", "frog"]
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    
    @IBAction func btnTap(_ sender: Any) {
        picker = UIPickerView.init()
        picker.delegate = self
        picker.backgroundColor = UIColor.white
        picker.setValue(UIColor.black, forKey: "textColor")
        picker.autoresizingMask = .flexibleWidth
        picker.contentMode = .center
        picker.frame = CGRect.init(x: 0.0, y: UIScreen.main.bounds.size.height - 300, width: UIScreen.main.bounds.size.width, height: 300)
        self.view.addSubview(picker)

        toolBar = UIToolbar.init(frame: CGRect.init(x: 0.0, y: UIScreen.main.bounds.size.height - 300, width: UIScreen.main.bounds.size.width, height: 50))
        toolBar.items = [UIBarButtonItem.init(title: "Done", style: .done, target: self, action: #selector(onDoneButtonTapped))]
        self.view.addSubview(toolBar)
    }
    
    @objc func onDoneButtonTapped() {
        toolBar.removeFromSuperview()
        picker.removeFromSuperview()
    }
    
    
    // MARK: - Table view data source
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return option.children.count
    }
    
    override func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        
        return option.children[section].name
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return option.children[section].products.count
    }
    
    override func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        
        guard let tableViewCell = cell as? SelectionCell else { return }
        
        tableViewCell.setPickerViewDataSourceDelegate(dataSourceDelegate: self, forRow: indexPath.row)
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        
        switch option.children[indexPath.section].products[indexPath.row].type {
        case "Stepper":
            
            let cell = tableView.dequeueReusableCell(withIdentifier: "StepperCell", for: indexPath) as! StepperCell
            cell.Name.text = option.children[indexPath.section].products[indexPath.row].name
            return cell
            
        case "Selection":
            
            let cell = tableView.dequeueReusableCell(withIdentifier: "SelectionCell", for: indexPath) as! SelectionCell
            
            cell.Name.text = option.children[indexPath.section].products[indexPath.row].name
            
            return cell
            
            
        case "Switch":
            
            let cell = tableView.dequeueReusableCell(withIdentifier: "SwitchCell", for: indexPath) as! SwitchCell
            cell.Name.text = option.children[indexPath.section].products[indexPath.row].name
            return cell
            
        default:
            break;
        }
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "StepperCell", for: indexPath) as! StepperCell
        cell.Name.text = option.children[indexPath.section].products[indexPath.row].name
        return cell
        
    }
    
}

//Collection View Functions
extension ProductDetailVC {
    
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return data.count
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return data[row]
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        
        //changeText(for: "HEY")
        
    }
    
}


extension ProductDetailVC : SelectionCellDelegate {
    
    func changeText(for youtuber: String) {
        
        let alert = UIAlertController(title: "Subscribed!", message: "Subscribed to \(youtuber)", preferredStyle: .alert)
        let okAction = UIAlertAction(title: "OK", style: .default, handler: nil)
        alert.addAction(okAction)
        
        self.present(alert, animated: true, completion: nil)
    }
        
}
