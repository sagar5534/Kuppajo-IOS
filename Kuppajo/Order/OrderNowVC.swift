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
    var DrinkCategory = [MenuCateogry]()
    var FoodCategory = [MenuCateogry]()
    var HomeCategory = [MenuCateogry]()

    override func viewDidLoad() {
        super.viewDidLoad()
        
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        DrinkCategory = appDelegate.DrinksCategory
        FoodCategory = appDelegate.FoodCategory
        HomeCategory = appDelegate.HomeCategory
        
        tableView.delegate = self
        tableView.dataSource = self
        
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        performSegue(withIdentifier: "toMenu", sender: self.tableView.cellForRow(at: indexPath))
    }
    
    let sectionTitle = ["Drinks", "Food", "At Home Coffee"]
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return sectionTitle.count
    }
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return sectionTitle[section]
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        if section == 0{
            return DrinkCategory.count
        }
        else if section == 1{
            return FoodCategory.count
        }else{
            return HomeCategory.count
        }
        
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell:MenuTVC = self.tableView.dequeueReusableCell(withIdentifier: "MenuCell") as! MenuTVC
        if indexPath.section == 0{
            cell.cellTitle.text = DrinkCategory[indexPath.row].name
            
            let url = URL(string: DrinkCategory[indexPath.row].image)
            cell.cellImage.kf.setImage(with: url)
        }
        else if indexPath.section == 1{
            cell.cellTitle.text = FoodCategory[indexPath.row].name
            
            let url = URL(string: FoodCategory[indexPath.row].image)
            cell.cellImage.kf.setImage(with: url)
        }
        else{
            cell.cellTitle.text = HomeCategory[indexPath.row].name
            
            let url = URL(string: HomeCategory[indexPath.row].image)
            cell.cellImage.kf.setImage(with: url)
        }
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return CGFloat(80)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        super.prepare(for: segue, sender: sender)
        
        if segue.identifier == "toMenu"{
            
            guard let DestinationView = segue.destination as? MenuVC else {
                fatalError("Unexpected destination: \(segue.destination)")
            }
            guard let cell = sender as? MenuTVC else {
                fatalError("Unexpected sender: \(String(describing: sender))")
            }
            guard let indexPath = tableView.indexPath(for: cell) else {
                fatalError("The selected cell is not being displayed by the table")
            }
            
            print(indexPath.section)
            
            let selectedMeal = DrinkCategory[indexPath.row]
//            mealDetailViewController. = selectedMeal
//
        }
    }
    
}
