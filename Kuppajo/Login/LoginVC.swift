//
//  LoginVC.swift
//  Kuppajo
//
//  Created by Luna on 2019-09-24.
//  Copyright © 2019 Sagar. All rights reserved.
//

import UIKit
import Firebase
import GoogleSignIn
import FBSDKCoreKit
import FBSDKLoginKit

class LoginVC: UIViewController{
    
    @IBOutlet weak var LoginPanel: UIView!
    
    @IBOutlet weak var GoogleView: UIView!
    @IBOutlet weak var FBView: UIView!
    
    @IBOutlet weak var GoogleBtnFake: GIDSignInButton!
    @IBOutlet weak var FBBtnFake: FBLoginButton!
    
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupLoginPanel()
        SetupLoginBtns()
        
        if #available(iOS 13.0, *) {
            overrideUserInterfaceStyle = .light
        }
        
        GIDSignIn.sharedInstance()?.presentingViewController = self
        
    }
    
    override func viewDidLayoutSubviews() {
        //Design
        GoogleView.layer.shadowColor = UIColor.black.cgColor
        GoogleView.layer.shadowOpacity = 0.1
        GoogleView.layer.shadowOffset = .init(width: 0, height: 0)
        GoogleView.layer.shadowRadius = 5
        GoogleView.layer.shadowPath = UIBezierPath(rect: GoogleView.bounds).cgPath
        GoogleView.layer.shouldRasterize = true
        GoogleView.layer.rasterizationScale = UIScreen.main.scale
        GoogleView.layer.cornerRadius = 5
        
        //Design
        FBView.layer.shadowColor = UIColor.black.cgColor
        FBView.layer.shadowOpacity = 0.1
        FBView.layer.shadowOffset = .init(width: 0, height: 0)
        FBView.layer.shadowRadius = 5
        FBView.layer.shadowPath = UIBezierPath(rect: FBView.bounds).cgPath
        FBView.layer.shouldRasterize = true
        FBView.layer.rasterizationScale = UIScreen.main.scale
        FBView.layer.cornerRadius = 5
        
    }
    
    func setupLoginPanel(){
        LoginPanel.layer.shadowColor = UIColor.black.cgColor
        LoginPanel.layer.shadowOpacity = 0.3
        LoginPanel.layer.shadowOffset = .init(width: 0, height: 10)
        LoginPanel.layer.shadowRadius = 10
        LoginPanel.layer.shadowPath = UIBezierPath(rect: LoginPanel.bounds).cgPath
        LoginPanel.layer.shouldRasterize = true
        LoginPanel.layer.rasterizationScale = UIScreen.main.scale
        LoginPanel.layer.cornerRadius = 30
        view.clipsToBounds = true
        LoginPanel.layer.maskedCorners = [.layerMaxXMinYCorner, .layerMinXMinYCorner]
    }
    
    func SetupLoginBtns(){
        
        let GTap = UITapGestureRecognizer(target: self, action: #selector(self.handleTapGoogle(_:)))
        GoogleView.addGestureRecognizer(GTap)
        
        let fbTap = UITapGestureRecognizer(target: self, action: #selector(self.handleTapFB(_:)))
        FBView.addGestureRecognizer(fbTap)
        
        FBBtnFake.delegate = UIApplication.shared.delegate as! AppDelegate
        FBBtnFake.permissions = ["public_profile", "email"]
        
    }
    
    
    @objc func handleTapGoogle(_ sender: UITapGestureRecognizer? = nil) {
        GoogleBtnFake.sendActions(for: .touchUpInside)
    }
    
    @objc func handleTapFB(_ sender: UITapGestureRecognizer? = nil) {
        FBBtnFake.sendActions(for: .touchUpInside)
    }
    
    
    @IBAction func SignInGoogle(_ sender: GIDSignInButton) {}
    
    @IBAction func SignInFacebook(_ sender: FBLoginButton) {}
    
    
}
