//
//  MenuTableViewController.swift
//  
//
//  Created by Sagar on 2020-01-08.
//

import UIKit
import Firebase
import Kingfisher

class CategoryDetailVC: UITableViewController {
    
    var menuData: Menu? = nil {
        didSet {
            self.tableView.reloadData()
        }
    }
    
    var sendItem: Product!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        navigationController?.navigationBar.prefersLargeTitles = true

    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        super.prepare(for: segue, sender: sender)
        
        if segue.identifier == "toProduct"{
            
            guard let DestinationView = segue.destination as? ProductVC else {
                fatalError("Unexpected destination: \(segue.destination)")
            }
            DestinationView.product = self.sendItem
        }
    }
    
}


//Table View Functions
extension CategoryDetailVC {
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return menuData?.children.count ?? 0
    }
    
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "CategoryCell", for: indexPath) as! CategoryCell
        
        for i in menuData!.children{
            if i.displayOrder == indexPath.row{
                cell.MenuTitle.text = i.name
                break
            }
        }
        
        cell.layoutIfNeeded()
        cell.separatorInset = UIEdgeInsets.zero;
        
        return cell
    }
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 250
    }
    
    override func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        
        guard let tableViewCell = cell as? CategoryCell else { return }
        
        tableViewCell.setCollectionViewDataSourceDelegate(dataSourceDelegate: self, forRow: indexPath.row)
    }
    
}



//Collection View Functions
extension CategoryDetailVC: UICollectionViewDelegate, UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "CategoryCollectionCell",
                                                      for: indexPath) as! CategoryCollectionCell
        
        cell.CellTitle.text = menuData?.children[collectionView.tag].products[indexPath.row].name
        cell.CellImage.kf.setImage(with: menuData?.children[collectionView.tag].products[indexPath.row].toImageURL())
        
        return cell
    }
    
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return menuData?.children[collectionView.tag].products.count ?? 0
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
        self.sendItem = menuData?.children[collectionView.tag].products[indexPath.row]
        performSegue(withIdentifier: "toProduct", sender: self)
        
    }
    
}
