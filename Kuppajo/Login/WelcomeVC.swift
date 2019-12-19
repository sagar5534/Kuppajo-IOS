//
//  WelcomeVC.swift
//  
//
//  Created by Luna on 2019-09-27.
//


import UIKit
import Firebase


class WelcomeVC: UIViewController {
    
    let user = Auth.auth().currentUser
    let db = Firestore.firestore()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
    }
    
    
    @IBAction func Continue(_ sender: Any) {
        performSegue(withIdentifier: "ToApp", sender: sender)
    }
    
}
