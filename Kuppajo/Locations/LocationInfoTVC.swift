//
//  LocationInfoTVC.swift
//  Kuppajo
//
//  Created by Sagar Patel on 2019-10-14.
//  Copyright © 2019 Sagar. All rights reserved.
//

import UIKit
import MapKit

class LocationInfoTVC: UITableViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    @IBAction func CallButton(_ sender: Any) {
        
        let phonenumber = "TEL://7055861298"
        let url: NSURL = URL(string: phonenumber)! as NSURL
        UIApplication.shared.open(url as URL, options: [:], completionHandler: nil)
        
    }
    
    @IBAction func DirectionButton(_ sender: Any) {
        
        if (UIApplication.shared.canOpenURL(NSURL(string:"comgooglemaps://")! as URL)) {
            
            let cord = CLLocationCoordinate2D(latitude: 46.491192, longitude: -80.992836)
            
            
            //            UIApplication.shared.open(NSURL(string: "https://www.google.ca/maps/dir//KUPPAJO+ESPRESSO+BAR,+Larch+Street,+Sudbury,+ON/@46.4911529,-81.0628918,12z")! as URL, options: [:], completionHandler: nil)
            //
            
            UIApplication.shared.open(NSURL(string: "comgooglemaps://?q=KUPPAJO+ESPRESSO+BAR,+Larch,+Street,+Sudbury,+ON&center=46.491192,-80.992836&views=transit")! as URL, options: [:], completionHandler: nil)
            
        } else {
            
        }
        
        
    }
    
    
    
    
    
    
    
    
    
    //    // MARK: - Table view data source
    //
    //    override func numberOfSections(in tableView: UITableView) -> Int {
    //        // #warning Incomplete implementation, return the number of sections
    //        return 0
    //    }
    //
    //    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    //        // #warning Incomplete implementation, return the number of rows
    //        return 0
    //    }
    
    /*
     override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
     let cell = tableView.dequeueReusableCell(withIdentifier: "reuseIdentifier", for: indexPath)
     
     // Configure the cell...
     
     return cell
     }
     */
    
    /*
     // Override to support conditional editing of the table view.
     override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
     // Return false if you do not want the specified item to be editable.
     return true
     }
     */
    
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
