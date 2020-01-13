//
//  MenuVC.swift
//  Kuppajo
//
//  Created by Sagar on 2020-01-06.
//  Copyright © 2020 Sagar. All rights reserved.
//

import UIKit
import Firebase
import Kingfisher

class OrderNowVC: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    @IBOutlet weak var tableView: UITableView!
    
    var menu: [MenuCateogry] = []
    var sectionTitle = [String]()

    override func viewDidLoad() {
        super.viewDidLoad()
        
        getMenuFromFirebase()
        
        tableView.delegate = self
        tableView.dataSource = self
        
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)

        let selectedRow: IndexPath? = tableView.indexPathForSelectedRow
        if let selectedRowNotNill = selectedRow {
            tableView.deselectRow(at: selectedRowNotNill, animated: true)
        }
        
    }
    
    func getMenuFromFirebase(){
        
        let docRef = db.collection("app_details").document("menu")
        docRef.getDocument { (document, error) in
            if let document = document, document.exists {
                     
                for data in document.data()!{
                    
                    //Section Titles
                    self.sectionTitle.append(data.key)
                    
                    //Inner Data
                    let arrayData = data.value as! NSArray
                    
                    var subCategory: [Category] = []
                    for item in arrayData{

                        let innerData = item as! NSDictionary
                        let name = innerData["Name"] as! String
                        let image = innerData["Image"] as! String
                        
                        // Inner Items
                        let innerItem = innerData["Item"] as! NSDictionary
                        
                        var menuItems: [MenuItem] = []

                        for i in innerItem{
                            
                            let x = i.value as! NSArray
                            var items: [Item] = []
                            for y in x{
                                let innerData = y as! NSDictionary
                                let name = innerData["Name"] as! String
                                let image = innerData["Image"] as! String
                                
                                items.append(.init(name: name, image: image))
                            }
                            
                            menuItems.append(.init(type: i.key as! String, item: items))

                        }
                        
                        subCategory.append(.init(category_name: name, category_image: image, items: menuItems))
                    }
                    self.menu.append(.init(parent: data.key, categories: subCategory))
                }
                
                //Sorting Section Titles
                self.sectionTitle = self.sectionTitle.sorted(by: { $0 < $1 })

                self.tableView.reloadData()
                
            } else {}
            
        }
        
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        performSegue(withIdentifier: "toMenu", sender: self.tableView.cellForRow(at: indexPath))
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return sectionTitle.count
    }
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return sectionTitle[section]
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return menu[section].category.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell:OrderNowTableViewCell = self.tableView.dequeueReusableCell(withIdentifier: "MenuCell") as! OrderNowTableViewCell
        
        cell.cellTitle.text = menu[indexPath.section].category[indexPath.row].category_name
        
        let url = URL(string: menu[indexPath.section].category[indexPath.row].category_image)
        cell.cellImage.kf.setImage(with: url)
        
        cell.separatorInset = UIEdgeInsets.zero;

        return cell
    }
    
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 100
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        super.prepare(for: segue, sender: sender)
        
        if segue.identifier == "toMenu"{
            
            guard let DestinationView = segue.destination as? MenuTableViewController else {
                fatalError("Unexpected destination: \(segue.destination)")
            }
            guard let cell = sender as? OrderNowTableViewCell else {
                fatalError("Unexpected sender: \(String(describing: sender))")
            }
            guard let indexPath = tableView.indexPath(for: cell) else {
                fatalError("The selected cell is not being displayed by the table")
            }
                        
            let selectedItem = menu[indexPath.section].category[indexPath.row]
            DestinationView.category = selectedItem
            DestinationView.parentName = menu[indexPath.section].category[indexPath.row].category_name
            
        }
    }
    
}
