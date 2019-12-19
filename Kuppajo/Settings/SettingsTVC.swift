//
//  SettingsTVC.swift
//  Kuppajo
//
//  Created by Sagar Patel on 2019-10-09.
//  Copyright © 2019 Sagar. All rights reserved.
//

import UIKit
import Firebase
import FBSDKLoginKit
import MessageUI

class SettingsTVC: UITableViewController, MFMailComposeViewControllerDelegate {
    
    @IBOutlet weak var UserName: UILabel!
    @IBOutlet weak var UserEmail: UILabel!
    @IBOutlet weak var UserIcon: UIImageView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.UserIcon.layer.cornerRadius = self.UserIcon.frame.size.width / 2;
        self.UserIcon.clipsToBounds = true;
        
        let user = Auth.auth().currentUser
        if user != nil{
            UserName.text = user?.displayName
            UserEmail.text = user?.email
            UserIcon.kf.setImage(with: user?.photoURL)
        }
        
    }
    
    func SignOut(_ sender: Any) {
        
        let firebaseAuth = Auth.auth()
        do {
            try firebaseAuth.signOut()
            LoginManager.init().logOut()
            
            //Show Login
            if let storyboard = self.storyboard {
                let vc = storyboard.instantiateViewController(withIdentifier: "LoginVC")
                vc.modalPresentationStyle = .fullScreen
                self.present(vc, animated: true, completion: nil)
            }
            
        } catch let signOutError as NSError {
            print ("Error signing out: %@", signOutError)
        }
        
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        //Sign Out
        if indexPath.section == 1 && indexPath.row == 0  {
            SignOut(self)
        }
            //Terms
        else if indexPath.section == 0 && indexPath.row == 0  {
            performSegue(withIdentifier: "ToTerms", sender: self)
        }
            //Privacy
        else if indexPath.section == 0 && indexPath.row == 1  {
            performSegue(withIdentifier: "ToPrivacy", sender: self)
        }
            //Developers
        else if indexPath.section == 0 && indexPath.row == 2  {
            //performSegue(withIdentifier: "ToDevelopers", sender: self)
            guard let url = URL(string: "http://thrivemg.ca") else { return }
            UIApplication.shared.open(url)
        }
            //Help
        else if indexPath.section == 0 && indexPath.row == 3  {
            //Send to Email
            sendEmail()
        }
        
        tableView.deselectRow(at: indexPath, animated: true)
        
    }
    
    private func sendEmail() {
        if MFMailComposeViewController.canSendMail() {
            let mail = MFMailComposeViewController()
            mail.mailComposeDelegate = self
            mail.setToRecipients(["thrivemedia1@google.com"])
            mail.setSubject("Kuppajo: IOS Help")
            present(mail, animated: true)
        } else {
            // show failure alert
            
        }
    }

    func mailComposeController(_ controller: MFMailComposeViewController, didFinishWith result: MFMailComposeResult, error: Error?) {
        controller.dismiss(animated: true)
    }
    
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?)  {
        
        if segue.identifier == "ToTerms"{
            
            let title = "Our Terms"
            let url = "https://kuppajo.appspot.com/terms"
            
            let destinationVC = segue.destination as! TermsVC
            destinationVC.viewurl = url
            destinationVC.viewtitle = title
            
        }
            
        else if segue.identifier == "ToPrivacy"{
            
            let title = "Our Privacy Policy"
            let url = "https://kuppajo.appspot.com/privacy"
            
            let destinationVC = segue.destination as! TermsVC
            destinationVC.viewurl = url
            destinationVC.viewtitle = title
            
        }
            
        else if segue.identifier == "ToDevelopers"{
            
            let title = "The Developers"
            let url = "http://thrivemg.ca/?reqp=1&reqr="
            
            let destinationVC = segue.destination as! TermsVC
            destinationVC.viewurl = url
            destinationVC.viewtitle = title
            
        }
        
        
        
    }
    
    
    
    // MARK: - Table view data source
    
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
