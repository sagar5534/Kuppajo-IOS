//
//  CardsVC.swift
//  Kuppajo
//
//  Created by Luna on 2019-09-24.
//  Copyright © 2019 Sagar. All rights reserved.
//

import UIKit
import Firebase

class CardsVC: UIViewController, CAAnimationDelegate {
    
    
    @IBOutlet weak var ScanPromptBar: UIView!
    var QRCode: String = ""
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupPrompt()
        setupQRData()
        
        
        
    }
    
    
    func setupPrompt(){
        //Set up Shadow and Design on Button
        ScanPromptBar.layer.shadowColor = UIColor.black.cgColor
        ScanPromptBar.layer.shadowOpacity = 0.3
        ScanPromptBar.layer.shadowOffset = .init(width: 0, height: 10)
        ScanPromptBar.layer.shadowRadius = 10
        ScanPromptBar.layer.shadowPath = UIBezierPath(rect: ScanPromptBar.bounds).cgPath
        ScanPromptBar.layer.shouldRasterize = true
        ScanPromptBar.layer.rasterizationScale = UIScreen.main.scale
        ScanPromptBar.layer.cornerRadius = 30
        ScanPromptBar.layer.maskedCorners = [.layerMaxXMinYCorner, .layerMinXMinYCorner]
        
        let tap = UITapGestureRecognizer(target: self, action: #selector(self.toQRScreen(_:)))
        ScanPromptBar.addGestureRecognizer(tap)
        
        
        let swipe = UISwipeGestureRecognizer(target: self, action: #selector(self.toQRScreen(_:)))
        swipe.direction = .up
        ScanPromptBar.addGestureRecognizer(swipe)
        
    }
    
    func setupQRData(){
        let user = Auth.auth().currentUser
        
        if user != nil{
            //user exists
            self.QRCode = user!.uid
            
        }else{
            //User does not exist
        }
    }
    
    @objc func toQRScreen(_ sender: UITapGestureRecognizer? = nil) {
        
        performSegue(withIdentifier: "PresentQRCode", sender: sender)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?){
        
        let destinationVC = segue.destination as! QRVC
        destinationVC.QRCode = QRCode
    }
    
}
