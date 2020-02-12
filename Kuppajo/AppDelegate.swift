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
import AuthenticationServices
import Promises


@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate, GIDSignInDelegate, LoginButtonDelegate {
    
    var window: UIWindow?
    var realtimeTask: ListenerRegistration?
    lazy var locations = [Locations]()
    var menuData: MenuStructure?
    
    
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
    
    func firebaseLogin( key credential: AuthCredential) {
        Auth.auth().signIn(with: credential) { (authResult, error) in
            
            if let error = error {
                print(error)
                return
            }
            // User is signed in
            let user = Auth.auth().currentUser
            self.firebaseProcessUserLogin(user: user)
            
        }
    }
    
    @available(iOS 13.0, *)
    func firebaseLoginViaApple( key credential: AuthCredential, appleUser: ASAuthorizationAppleIDCredential) {
        
        Auth.auth().signIn(with: credential) { (authResult, error) in
            if let error = error {
                print(error)
                return
            }
            let user = Auth.auth().currentUser
            
            // Add Name to user //GODDAMMIT APPLE
            let name = "\(appleUser.fullName?.givenName ?? "") \(appleUser.fullName?.familyName ?? "")"
            
            self.createProfileChangeRequest(name: name)
            self.firebaseProcessUserLogin(user: user)
        }
    }
    
    func firebaseProcessUserLogin(user: User?){
        
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
                    self.app_details()
                    let sb = UIStoryboard(name: "Main", bundle: nil)
                    self.setRootViewController(sb.instantiateViewController(withIdentifier: "AppTabBarController"))
            }
        }
        
    }
    
    func createProfileChangeRequest(name: String? = nil, _ callback: ((Error?) -> ())? = nil){
        if let request = Auth.auth().currentUser?.createProfileChangeRequest(){
            if let name = name{
                request.displayName = name
            }
             request.commitChanges(completion: { (error) in
                       callback?(error)
                   })
        }

    }
    
    
    func app_details(){
        
        //Add test data
        addTestData()
        
        //Location Call
        locations = [Locations]()
        var docRef = db.collection("app_details").document("location")
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
                Analytics.logEvent("App_detail Issue", parameters: [
                    "Page": "AppDelate",
                    "Issue": error!
                ])
            }
        }
        
        //Menu Call
        //docRef = db.collection("app_details").document("order_menu")
        docRef = db.collection("app_details").document("test_menu")
        docRef.getDocument { (document, error) in
            let result = Result {
                try document.flatMap {
                    try $0.data(as: MenuStructure.self)
                }
            }
            switch result {
            case .success(let menu):
                if let menu = menu {
                    print("Menu: \(menu)")
                    self.menuData = menu
                } else {
                    print("Document does not exist")
                }
            case .failure(let error):
                print("Error decoding Menu: \(error)")
            }
        }
            
        
    }
    
    func addTestData() {
        
        let size1 = Size(SizeCode: SizeCode(rawValue: "Short")!)
        let size2 = Size(SizeCode: SizeCode(rawValue: "Tall")!)
        let size3 = Size(SizeCode: SizeCode(rawValue: "Grande")!)
        let size4 = Size(SizeCode: SizeCode(rawValue: "Venti")!)
        let sizes = [size1, size2, size3, size4]
        
        
        let option1 = ProductOption(name: "Add Ins", products: [], children: [])
        let option2 = ProductOption(name: "Flavours", products: [], children: [
            
            ProductOption(name: "Syrups", products: [
                Option(name: "Caramel Syrup", type: "Stepper"),
                Option(name: "Vanilla Syrup", type: "Selection"),
                Option(name: "Pumpkin Syrup", type: "Selection"),
                Option(name: "Some Syrup", type: "Stepper"),
            ], children: []),
            
            ProductOption(name: "Sauces", products: [], children: [])
        ])
        
        let IrishCreamOptions = [option1, option2]
        
        let IrishCream = Product(name: "Irish Cream", desc: "A one-to-one combination of fresh-brewed coffee and steamed milk add up to one distinctly delicious coffee drink remarkably mixed.", displayOrder: 0, image: "https://globalassets.starbucks.com/assets/0079e05cbb2b4c5ebbd6332d12084c2e.jpg?impolicy=1by1_wide_1242", sizes: sizes, productOptions: IrishCreamOptions)
        
        let americano = Menu(displayOrder: 0, name: "Americano", products: [IrishCream], children: [], image: "https://globalassets.starbucks.com/assets/f12bc8af498d45ed92c5d6f1dac64062.jpg?impolicy=1by1_wide_1242")
        
        let coldCoffee = Menu(displayOrder: 0, name: "Cold Coffee", products: [], children: [americano], image: "https://globalassets.starbucks.com/assets/43d54469baa74cbaa3220c57e4ae909c.jpg")
        
        let Drink = Menu(displayOrder: 0, name: "Drink", products: [], children: [coldCoffee], image: "")
        
        let menuItems = MenuStructure(menus: [Drink])
        
    
        do {
            try db.collection("app_details").document("test_menu").setData(from: menuItems, merge: true)
        } catch let error {
            print("Error writing city to Firestore: \(error)")
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
    
    //---------------- Sign In With Facebook ------------------
    
    static func shared() -> AppDelegate {
        return UIApplication.shared.delegate as! AppDelegate
    }
    
    func loginButtonDidLogOut(_ loginButton: FBLoginButton) {
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
    
    
    //---------------- Sign In With Google ------------------
    
    func sign(_ signIn: GIDSignIn!, didDisconnectWith user: GIDGoogleUser!, withError error: Error!) {
        // Perform any operations when the user disconnects from app here.
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
