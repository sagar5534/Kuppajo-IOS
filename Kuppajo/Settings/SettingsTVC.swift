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
            
            let db = Firestore.firestore()
            let docRef = db.collection("users").document(user!.uid)
            docRef.getDocument(source: .default) { (document, error) in
              if let document = document {
                let dataDescription = document.data()
                //let name = dataDescription!["name"] as! String
                //self.UserName.text = name
                //print(name)
                
              } else {
                print("Document does not exist in cache")
              }
            }
            
            
            
            UserEmail.text = user?.email
            
            let photo = user?.photoURL
            if (photo == nil){
                UserIcon.image = #imageLiteral(resourceName: "genericuser")
            }
            else{
                UserIcon.kf.setImage(with: photo)
            }
            
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
}
