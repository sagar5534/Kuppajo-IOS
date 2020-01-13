//
//  MenuTableViewController.swift
//  
//
//  Created by Sagar on 2020-01-08.
//

import UIKit
import Firebase
import Kingfisher

class MenuTableViewController: UITableViewController {

    let db = Firestore.firestore()
    var category: Category!
    var menuItems = [Category]()
    var parentName: String = ""
    var sendItem: Item!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        title = parentName
        
        self.tableView.estimatedRowHeight = 250
        self.tableView.rowHeight = UITableView.automaticDimension
    }
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return category.items.count
    }

    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "MenuTableViewCell", for: indexPath) as! MenuTableViewCell

        cell.MenuTitle.text = category.items[indexPath.row].item_type
        
        cell.layoutIfNeeded()
        cell.separatorInset = UIEdgeInsets.zero;


        return cell
    }
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {

        return 250
    }

    override func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        
        guard let tableViewCell = cell as? MenuTableViewCell else { return }

        tableViewCell.setCollectionViewDataSourceDelegate(dataSourceDelegate: self, forRow: indexPath.row)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        super.prepare(for: segue, sender: sender)
        
        if segue.identifier == "toMenuItem"{
            
            guard let DestinationView = segue.destination as? MenuItemVC else {
                fatalError("Unexpected destination: \(segue.destination)")
            }
                        
            DestinationView.item = self.sendItem
        }
    }
    
}

extension MenuTableViewController: UICollectionViewDelegate, UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "MenuCollectionCell",
                                                      for: indexPath) as! MenuCollectionCell

        cell.CellTitle.text = category.items[collectionView.tag].item[indexPath.row].item_name

        let url = URL(string: category.items[collectionView.tag].item[indexPath.row].item_image)
        cell.CellImage.kf.setImage(with: url)
    
        return cell
    }
    
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {

        return category.items[collectionView.tag].item.count
        
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
                
        let selectedItem = category.items[collectionView.tag].item[indexPath.row]
        self.sendItem = selectedItem
        
        performSegue(withIdentifier: "toMenuItem", sender: self)
        
    }

}
