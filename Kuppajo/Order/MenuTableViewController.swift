//
//  MenuTableViewController.swift
//  
//
//  Created by Sagar on 2020-01-08.
//

import UIKit
import Firebase

class MenuTableViewController: UITableViewController {

    let db = Firestore.firestore()
    var category: Category!
    
    var menuItems = [Category]()
    var parentName: String = ""
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        title = parentName
        
        //getMenuItems(category: category)
    }

//    func getMenuItems(category: MenuCateogry){
//
//        let docRef = db.collection("app_details").document("menu").collection(category.type).document("Hot Coffee")
//        docRef.getDocument { (document, error) in
//            if let document = document, document.exists {
//                for data in document.data()!{
//                    print(data)
//                    let innerData = data.value as! [String:Any]
//                    let name = innerData["Name"] as! String
//                    let type = innerData["Type"] as! String
//                    let image = innerData["Image"] as! String
//                    self.menuItems.append(.init(name: name, image: image, type: type))
//                }
//
//                self.tableView.reloadData()
//
//            } else {}
//        }
//    }
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
//        let distinctSections = Set(menuItems.map{$0.type})
//        print(distinctSections)
//
//        return distinctSections.count
        return 1
    }

    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "MenuTableViewCell", for: indexPath) as! MenuTableViewCell

//        let distinctSections = Set(menuItems.map{$0.type})
//        //var tradeSet: Set<String> = distinctSections
//        let stringArray = Array(distinctSections)
//
//        cell.MenuTitle.text = stringArray[indexPath.section]
//
//        //let result = menuItems.filter{ $0.type == "Drinks" }.count
//
//
        
        return cell
    }
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        
        return 70
        
    }

    /*
    // Override to support editing the table view.
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            // Delete the row from the data source
            tableView.deleteRows(at: [indexPath], with: .fade)
        } else if editingStyle == .insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
        }    
    }
    */

    /*
    // Override to support rearranging the table view.
    override func tableView(_ tableView: UITableView, moveRowAt fromIndexPath: IndexPath, to: IndexPath) {

    }
    */

    /*
    // Override to support conditional rearranging of the table view.
    override func tableView(_ tableView: UITableView, canMoveRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the item to be re-orderable.
        return true
    }
    */

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
