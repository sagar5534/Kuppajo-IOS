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
import FirebaseFirestoreSwift

class OrderNowVC: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    @IBOutlet weak var tableView: UITableView!
    
    var menuData: MenuStructure? = nil {
        didSet {
            self.tableView.reloadData()
        }
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        menuData = appDelegate.menuData
        
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
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        super.prepare(for: segue, sender: sender)
        
        if segue.identifier == "toCategory"{
            
            guard let DestinationView = segue.destination as? CategoryDetailVC else {
                fatalError("Unexpected destination: \(segue.destination)")
            }
            guard let cell = sender as? OrderNowCell else {
                fatalError("Unexpected sender: \(String(describing: sender))")
            }
            guard let indexPath = tableView.indexPath(for: cell) else {
                fatalError("The selected cell is not being displayed by the table")
            }
                        
            DestinationView.menuData = menuData?.menus[indexPath.section].children[indexPath.row]
            //DestinationView.parentName = menuData?.menus[indexPath.section].name ?? ""
            DestinationView.title =  menuData?.menus[indexPath.section].children[indexPath.row].name
            
        }
    }
    
}

//All Tableview Functions
extension OrderNowVC {
    
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        performSegue(withIdentifier: "toCategory", sender: self.tableView.cellForRow(at: indexPath))
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return menuData?.menus.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        
        for i in menuData!.menus{
            if i.displayOrder == section{
                return i.name
            }
        }
        return ""
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        for i in menuData!.menus{
            if i.displayOrder == section{
                return i.children.count
            }
        }
        
        return 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell:OrderNowCell = self.tableView.dequeueReusableCell(withIdentifier: "OrderNowCell") as! OrderNowCell
        
        cell.separatorInset = UIEdgeInsets.zero;

        for i in menuData!.menus{
            if i.displayOrder == indexPath.section{
                cell.cellTitle.text = i.children[indexPath.row].name
                cell.cellImage.kf.setImage(with: i.children[indexPath.row].toImageURL())
                break
            }
        }
        
        return cell
    }
    
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 100
    }
    
}

