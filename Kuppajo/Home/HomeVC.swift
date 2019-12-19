//
//  HomeVC.swift
//  Kuppajo
//
//  Created by Luna on 2019-09-24.
//  Copyright © 2019 Sagar. All rights reserved.
//

import UIKit
import Firebase
import FBSDKLoginKit
import Kingfisher
import Promises
import UICircularProgressRing

var tabBarSize: CGFloat = 10

class HomeVC: UIViewController {
    
    // Enum for card states
    enum CardState {
        case collapsed
        case expanded
    }
    
    // Variable determines the next state of the card expressing that the card starts and collapased
    var nextState:CardState {
        return cardVisible ? .collapsed : .expanded
    }
    
    // Variable for card view controller
    var cardViewController:CardViewController!
    
    // Variable for effects visual effect view
    var visualEffectView:UIVisualEffectView!
    
    // Starting and end card heights will be determined later
    var endCardHeight:CGFloat = 0
    var startCardHeight:CGFloat = 0
    
    // Current visible state of the card
    var cardVisible = false
    
    // Empty property animator array
    var runningAnimations = [UIViewPropertyAnimator]()
    var animationProgressWhenInterrupted:CGFloat = 0
    var swipeGestureRecognizer = UISwipeGestureRecognizer()
    
    let delegate = UIApplication.shared.delegate as! AppDelegate
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupCard()
        
        let db = Firestore.firestore()
        let user = Auth.auth().currentUser
        
        print(user!.uid)
        delegate.realtimeTask = db.collection("users").document(user!.uid)
            .addSnapshotListener { documentSnapshot, error in
                
                guard let document = documentSnapshot else {
                    print("Error fetching document: \(error!)")
                    return
                }
                guard let data = document.data() else {
                    print("Document data was empty.")
                    return
                }
                let basic = data["basic_counter"] as! Int
                let premium = data["premium_counter"] as! Int
                
                self.cardViewController.CircBar.startProgress(to: CGFloat(basic), duration: 1.0) {
                    print("Done animating!")
                }
                
                self.cardViewController.CircBar2.startProgress(to: CGFloat(premium), duration: 1.0) {
                    print("Done animating!")
                }
                
                
                if basic == 9{
                    self.cardViewController.Circ1Label.text = "Claim a free Coffee/Tea!"
                }else if(basic == 8) {
                    self.cardViewController.Circ1Label.text = "\(9-basic) PURCHASE LEFT"
                }else{
                    self.cardViewController.Circ1Label.text = "\(9-basic) PURCHASES LEFT"
                }
                
                if premium == 9{
                    self.cardViewController.Circ2Label.text = "Claim a free Premium Drink!"
                }else if(premium == 8) {
                    self.cardViewController.Circ2Label.text = "\(9-premium) PURCHASE LEFT"
                }else{
                    self.cardViewController.Circ2Label.text = "\(9-premium) PURCHASES LEFT"
                }
        }
        
        
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
    }
    
    @IBAction func SettingsBtn(_ sender: Any) {}
    
    func setupCard() {
        // Setup starting and ending card height
        endCardHeight = self.view.frame.height * 0.8
        startCardHeight = self.view.frame.height * 0.34
        
        
        // Add Visual Effects View
        visualEffectView = UIVisualEffectView()
        visualEffectView.frame = self.view.frame
        self.view.addSubview(visualEffectView)
        
        // Add CardViewController xib to the bottom of the screen, clipping bounds so that the corners can be rounded
        
        tabBarSize = (self.tabBarController?.tabBar.bounds.size.height)!
        
        cardViewController = CardViewController(nibName:"CardViewController", bundle:nil)
        
        self.view.addSubview(cardViewController.view)
        
        cardViewController.view.frame = CGRect(x: 0, y: self.view.frame.height - startCardHeight, width: self.view.bounds.width, height: endCardHeight + tabBarSize)
        cardViewController.view.clipsToBounds = true
        
        // Add tap and pan recognizers
        let tapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(HomeVC.handleCardTap(recognzier:)))
        
        //let panGestureRecognizer = UIPanGestureRecognizer(target: self, action: #selector(HomeVC.handleCardPan(recognizer:)))
        
        swipeGestureRecognizer = UISwipeGestureRecognizer(target: self, action: #selector(HomeVC.handleCardSwipe(recognzier:)))
        swipeGestureRecognizer.direction = .up
        
        //Adding Gesture Recognizers
        cardViewController.handleArea.addGestureRecognizer(tapGestureRecognizer)
        cardViewController.handleArea.addGestureRecognizer(swipeGestureRecognizer)
        
        cardViewController.BannerView.addGestureRecognizer(tapGestureRecognizer)
        cardViewController.BannerView.addGestureRecognizer(swipeGestureRecognizer)
        
        
        //Set up Shadow and Radius
        cardViewController.view.layer.shadowColor = UIColor.black.cgColor
        cardViewController.view.layer.shadowOpacity = 0.3
        cardViewController.view.layer.shadowOffset = .init(width: 0, height: 10)
        cardViewController.view.layer.shadowRadius = 10
        cardViewController.view.layer.shadowPath = UIBezierPath(rect: cardViewController.view.bounds).cgPath
        cardViewController.view.layer.shouldRasterize = true
        cardViewController.view.layer.rasterizationScale = UIScreen.main.scale
        cardViewController.view.layer.cornerRadius = 30
        view.clipsToBounds = true
        cardViewController.view.layer.maskedCorners = [.layerMaxXMinYCorner, .layerMinXMinYCorner]
        
    }
    
    // Handle tap gesture recognizer
    @objc
    func handleCardTap(recognzier:UITapGestureRecognizer) {
        switch recognzier.state {
        // Animate card when tap finishes
        case .ended:
            animateTransitionIfNeeded(state: nextState, duration: 0.5)
            
        default:
            break
        }
    }
    
    
    
    @objc
    func handleCardSwipe(recognzier:UISwipeGestureRecognizer) {
        switch recognzier.state {
        // Animate card when tap finishes
        case .ended:
            animateTransitionIfNeeded(state: nextState, duration: 0.5)
        default:
            break
        }
    }
    
    
    
    // Animate transistion function
    func animateTransitionIfNeeded (state:CardState, duration:TimeInterval) {
        // Check if frame animator is empty
        if runningAnimations.isEmpty {
            // Create a UIViewPropertyAnimator depending on the state of the popover view
            let frameAnimator = UIViewPropertyAnimator(duration: duration, dampingRatio: 1) {
                switch state {
                case .expanded:
                    // If expanding set popover y to the ending height and blur background
                    self.cardViewController.view.frame.origin.y = self.view.frame.height - self.endCardHeight
                    self.visualEffectView.effect = UIBlurEffect(style: .dark)
                    
                case .collapsed:
                    // If collapsed set popover y to the starting height and remove background blur
                    let tabBarHeight = self.tabBarController?.tabBar.frame.size.height;
                    
                    self.cardViewController.view.frame.origin.y = self.view.frame.height - self.startCardHeight + tabBarHeight!
                    self.visualEffectView.effect = nil
                }
            }
            
            // Complete animation frame
            frameAnimator.addCompletion { _ in
                self.cardVisible = !self.cardVisible
                self.runningAnimations.removeAll()
                if self.swipeGestureRecognizer.direction == .up{
                    self.swipeGestureRecognizer.direction = .down
                }
                else{
                    self.swipeGestureRecognizer.direction = .up
                }
            }
            
            // Start animation
            frameAnimator.startAnimation()
            
            // Append animation to running animations
            runningAnimations.append(frameAnimator)
            
        }
    }
    
}
