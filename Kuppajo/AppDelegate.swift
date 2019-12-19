//
//  AppDelegate.swift
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


@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate, GIDSignInDelegate, LoginButtonDelegate {
    
    var window: UIWindow?
    var realtimeTask: ListenerRegistration?
    lazy var locations = [Locations]()
    
    func firebaseLogin( key credential: AuthCredential ) {
        Auth.auth().signIn(with: credential) { (authResult, error) in
            
            if let error = error {
                print(error)
                return
            }
            
            let db = Firestore.firestore()
            
            // User is signed in
            let user = Auth.auth().currentUser
            
            if let user = user {
                //Check for Existing user document in Firestore
                let docRef = db.collection("users").document(user.uid)
                
                promiseDocExists(DocumentRef: docRef)
                    .then {
                        if $0{
                            //Normal Login - User Exist
                        }else{
                            newUser(FirebaseUser: user)
                        }
                        let sb = UIStoryboard(name: "Main", bundle: nil)
                        self.setRootViewController(sb.instantiateViewController(withIdentifier: "AppTabBarController"))
                }
            }
            
        }
    }
    
    
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        FirebaseApp.configure()
        ApplicationDelegate.shared.application(application, didFinishLaunchingWithOptions: launchOptions)
        GIDSignIn.sharedInstance().clientID = FirebaseApp.app()?.options.clientID
        GIDSignIn.sharedInstance().delegate = self
        
        let user = Auth.auth().currentUser
        let sb = UIStoryboard(name: "Main", bundle: nil)
        
        if user != nil {
            //Get app_detail
            app_details()
            
            //Show App
            self.setRootViewController(sb.instantiateViewController(withIdentifier: "AppTabBarController"))
        } else {
            //Show Login
            self.setRootViewController(sb.instantiateViewController(withIdentifier: "LoginVC"))
        }
        
        return true
    }
    
    
    func applicationWillResignActive(_ application: UIApplication) {
        // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
        // Use this method to pause ongoing tasks, disable timers, and invalidate graphics rendering callbacks. Games should use this method to pause the game.
    }
    
    func applicationDidEnterBackground(_ application: UIApplication) {
        // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
        // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
    }
    
    func applicationWillEnterForeground(_ application: UIApplication) {
        // Called as part of the transition from the background to the active state; here you can undo many of the changes made on entering the background.
    }
    
    func applicationDidBecomeActive(_ application: UIApplication) {
        // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
    }
    
    func applicationWillTerminate(_ application: UIApplication) {
        // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
        realtimeTask?.remove()
    }
    
    
    
    //------------------------------------------ Login Code ------------------------------------------
    
    func app_details(){
        let docRef = db.collection("app_details").document("location")
        docRef.getDocument { (document, error) in
            if let document = document, document.exists {
                
                for data in document.data()!{
                    let innerData = data.value as! [String:Any]
                    let name = innerData["Name"] as! String
                    let address1 = innerData["Address1"] as! String
                    let address2 = innerData["Address2"] as! String
                    let phone = innerData["Phone"] as! String
                    let googleMap = innerData["googleMap"] as! String
                    
                    let x = innerData["Hours"] as! NSArray
                    self.locations.append(Locations(name: name, address1: address1, address2: address2, phone: phone, hours: Hours(x as! [String]), googleMap: googleMap))
                }
            } else {
                print("Document does not exist")
            }
        }
        
    }
    
    //Animating Any Root View Controller Changes
    func setRootViewController(_ vc: UIViewController, animated: Bool = true) {
        guard animated, let window = self.window else {
            self.window?.rootViewController = vc
            self.window?.makeKeyAndVisible()
            return
        }
        
        window.rootViewController = vc
        window.makeKeyAndVisible()
        UIView.transition(with: window,duration: 0.3,options: .transitionCrossDissolve,animations: nil,completion: nil)
    }
    
    
    static func shared() -> AppDelegate {
        return UIApplication.shared.delegate as! AppDelegate
    }
    
    func sign(_ signIn: GIDSignIn!, didDisconnectWith user: GIDGoogleUser!, withError error: Error!) {
        // Perform any operations when the user disconnects from app here.
    }
    func loginButtonDidLogOut(_ loginButton: FBLoginButton) {
        print("Logout")
    }
    
    func application(_ application: UIApplication, open url: URL, options: [UIApplication.OpenURLOptionsKey : Any] = [:]) -> Bool {
        
        return ApplicationDelegate.shared.application(application, open: url, sourceApplication: options[UIApplication.OpenURLOptionsKey.sourceApplication] as? String, annotation: options[UIApplication.OpenURLOptionsKey.annotation])
        
    }
    
    func loginButton(_ loginButton: FBLoginButton, didCompleteWith result: LoginManagerLoginResult?, error: Error?) {
        
        if let error = error {
            print(error.localizedDescription)
            return
        }
        
        guard result?.isCancelled == false else { return }
        let credential = FacebookAuthProvider.credential(withAccessToken: AccessToken.current!.tokenString)
        firebaseLogin(key: credential)
        
    }
    
    
    func sign(_ signIn: GIDSignIn!, didSignInFor user: GIDGoogleUser!, withError error: Error?) {
        
        if let error = error {
            print(error)
            return
        }
        guard let authentication = user.authentication else { return }
        let credential = GoogleAuthProvider.credential(withIDToken: authentication.idToken, accessToken: authentication.accessToken)
        firebaseLogin(key: credential)
        
    }
    
}
