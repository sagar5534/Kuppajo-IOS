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
import AuthenticationServices
import CryptoKit


@available(iOS 13.0, *)
class LoginVC: UIViewController, ASAuthorizationControllerDelegate, ASAuthorizationControllerPresentationContextProviding {
    
    @IBOutlet weak var LoginPanel: UIView!
    
    @IBOutlet weak var GoogleView: UIView!
    @IBOutlet weak var FBView: UIView!
    
    @IBOutlet weak var GoogleBtnFake: GIDSignInButton!
    @IBOutlet weak var FBBtnFake: FBLoginButton!
    
    
    @IBOutlet weak var AppleSignInBtn: UIView!
    @IBOutlet weak var appleStack: UIStackView!
    
    
    
    
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupLoginPanel()
        SetupLoginBtns()
        
        GIDSignIn.sharedInstance()?.presentingViewController = self
        
        
        let appleLogInButton : ASAuthorizationAppleIDButton = {
            let button = ASAuthorizationAppleIDButton(authorizationButtonType: .continue, authorizationButtonStyle: .whiteOutline)
            
            button.addTarget(self, action: #selector(startSignInWithAppleFlow), for: .touchUpInside)
            button.cornerRadius = 5
            
            return button
        }()
        
        appleStack.addArrangedSubview(appleLogInButton)
        
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
        
        //Design
        AppleSignInBtn.layer.shadowColor = UIColor.black.cgColor
        AppleSignInBtn.layer.shadowOpacity = 0.1
        AppleSignInBtn.layer.shadowOffset = .init(width: 0, height: 0)
        AppleSignInBtn.layer.shadowRadius = 5
        AppleSignInBtn.layer.shadowPath = UIBezierPath(rect: AppleSignInBtn.bounds).cgPath
        AppleSignInBtn.layer.shouldRasterize = true
        AppleSignInBtn.layer.rasterizationScale = UIScreen.main.scale
        AppleSignInBtn.layer.cornerRadius = 5
        
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
    
    
    
    //------------ sign in with Apple ---------------
    
    
    // Adaptedfrom https://auth0.com/docs/api-auth/tutorials/nonce#generate-a-cryptographically-random-nonce
    private func randomNonceString(length: Int = 32) -> String {
        precondition(length > 0)
        let charset: Array<Character> =
            Array("0123456789ABCDEFGHIJKLMNOPQRSTUVXYZabcdefghijklmnopqrstuvwxyz-._")
        var result = ""
        var remainingLength = length
        
        while remainingLength > 0 {
            let randoms: [UInt8] = (0 ..< 16).map { _ in
                var random: UInt8 = 0
                let errorCode = SecRandomCopyBytes(kSecRandomDefault, 1, &random)
                if errorCode != errSecSuccess {
                    fatalError("Unable to generate nonce. SecRandomCopyBytes failed with OSStatus \(errorCode)")
                }
                return random
            }
            
            randoms.forEach { random in
                if length == 0 {
                    return
                }
                
                if random < charset.count {
                    result.append(charset[Int(random)])
                    remainingLength -= 1
                }
            }
        }
        
        return result
    }
    
    // Unhashed nonce.
    fileprivate var currentNonce: String?
    
    @available(iOS 13, *)
    @objc func startSignInWithAppleFlow() {
        let nonce = randomNonceString()
        currentNonce = nonce
        let appleIDProvider = ASAuthorizationAppleIDProvider()
        let request = appleIDProvider.createRequest()
        request.requestedScopes = [.fullName, .email]
        request.nonce = sha256(nonce)
        
        let authorizationController = ASAuthorizationController(authorizationRequests: [request])
        authorizationController.delegate = self
        authorizationController.presentationContextProvider = self
        authorizationController.performRequests()
    }
    
    @available(iOS 13, *)
    private func sha256(_ input: String) -> String {
        let inputData = Data(input.utf8)
        let hashedData = SHA256.hash(data: inputData)
        let hashString = hashedData.compactMap {
            return String(format: "%02x", $0)
        }.joined()
        
        return hashString
    }
    
    @available(iOS 13.0, *)
    func authorizationController(controller: ASAuthorizationController, didCompleteWithAuthorization authorization: ASAuthorization) {
        if let appleIDCredential = authorization.credential as? ASAuthorizationAppleIDCredential {
            
            guard let nonce = currentNonce else {
                fatalError("Invalid state: A login callback was received, but no login request was sent.")
            }
            guard let appleIDToken = appleIDCredential.identityToken else {
                print("Unable to fetch identity token")
                return
            }
            guard let idTokenString = String(data: appleIDToken, encoding: .utf8) else {
                print("Unable to serialize token string from data: \(appleIDToken.debugDescription)")
                return
            }
            // Initialize a Firebase credential.
            let credential = OAuthProvider.credential(withProviderID: "apple.com",
                                                      idToken: idTokenString,
                                                      rawNonce: nonce)
            
            
            
            // Sign in with Firebase.
            let appDelegate = UIApplication.shared.delegate as! AppDelegate
            appDelegate.firebaseLoginViaApple(key: credential, appleUser: appleIDCredential)
            
        }
    }
    
    @available(iOS 13.0, *)
    func authorizationController(controller: ASAuthorizationController, didCompleteWithError error: Error) {
        Analytics.logEvent("Apple Sign In Issue", parameters: [
            "Page": "LoginVC",
            "Issue": error
        ])
    }
    
    @available(iOS 13.0, *)
    func presentationAnchor(for controller: ASAuthorizationController) -> ASPresentationAnchor {
        return self.view.window!
    }
    
}
