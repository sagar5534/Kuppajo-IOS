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

    override func viewDidLoad() {
        super.viewDidLoad()
        
        getMenuFromFirebase()
        
        tableView.delegate = self
        tableView.dataSource = self
        
    }
    
    var sectionTitle = [String]()

    func getMenuFromFirebase(){
        
        let docRef = db.collection("app_details").document("menu")
        docRef.getDocument { (document, error) in
            if let document = document, document.exists {
                     
                for data in document.data()!{
                    
                    //Section Titles
                    self.sectionTitle.append(data.key)
                    
                    //Inner Data
                    let arrayData = data.value as! NSArray
                    
                    var items: [Category] = []
                    for item in arrayData{

                        let innerData = item as! NSDictionary
                        let name = innerData["Name"] as! String
                        let image = innerData["Image"] as! String
                        
                        items.append(.init(category_name: name, category_image: image))
                    }
                    self.menu.append(.init(parent: data.key, categories: items))
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
        
        let cell:MenuTVC = self.tableView.dequeueReusableCell(withIdentifier: "MenuCell") as! MenuTVC
        
        cell.cellTitle.text = menu[indexPath.section].category[indexPath.row].category_name
        
        let url = URL(string: menu[indexPath.section].category[indexPath.row].category_image)
        cell.cellImage.kf.setImage(with: url)
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return CGFloat(80)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        super.prepare(for: segue, sender: sender)
        
        if segue.identifier == "toMenu"{
            
            guard let DestinationView = segue.destination as? MenuTableViewController else {
                fatalError("Unexpected destination: \(segue.destination)")
            }
            guard let cell = sender as? MenuTVC else {
                fatalError("Unexpected sender: \(String(describing: sender))")
            }
            guard let indexPath = tableView.indexPath(for: cell) else {
                fatalError("The selected cell is not being displayed by the table")
            }
            
            print(indexPath.section)
            
            let selectedItem = menu[indexPath.section].category[indexPath.row]
            DestinationView.category = selectedItem
            DestinationView.parentName = menu[indexPath.section].category[indexPath.row].category_name
            

        }
    }
    
}
