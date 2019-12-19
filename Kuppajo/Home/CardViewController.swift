//
//  CardViewController.swift
//  Card-popover

import UIKit
import UICircularProgressRing
import Firebase

class CardViewController: UIViewController, UIScrollViewDelegate {
    
    @IBOutlet weak var BannerView: UIView!
    @IBOutlet weak var InstaView: UIView!
    @IBOutlet weak var InstagramScroll: UIScrollView!
    @IBOutlet weak var InstagramPageControl: UIPageControl!
    @IBOutlet weak var CircBar: UICircularProgressRing!
    @IBOutlet weak var CircBar2: UICircularProgressRing!
    @IBOutlet weak var handleArea: UIView!
    @IBOutlet weak var InstaLabel: UIImageView!
    @IBOutlet weak var Circ1Label: UILabel!
    @IBOutlet weak var Circ2Label: UILabel!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //Circ Bar 1
        CircBar.style = .ontop
        CircBar.startAngle = 90 + 45
        CircBar.endAngle = 42
        CircBar.outerRingWidth = 6
        CircBar.innerRingWidth = 7
        CircBar.innerCapStyle = .round
        CircBar.outerCapStyle = .round
        CircBar.animationTimingFunction = .default
        CircBar.shouldShowValueText = false
        CircBar.innerRingColor = UIColor(red:0.74, green:0.42, blue:0.23, alpha:1.00)
        //CircBar.outerRingColor = UIColor(red:0.86, green:0.85, blue:0.85, alpha:1.00)
        
        //Circ Bar 2
        CircBar2.style = .ontop
        CircBar2.startAngle = 90 + 45
        CircBar2.endAngle = 45
        CircBar2.outerRingWidth = 6
        CircBar2.innerRingWidth = 7
        CircBar2.innerCapStyle = .round
        CircBar2.outerCapStyle = .round
        CircBar2.animationTimingFunction = .default
        CircBar2.shouldShowValueText = false
        CircBar2.innerRingColor = UIColor(red:0.74, green:0.42, blue:0.23, alpha:1.00)
        //CircBar2.outerRingColor = UIColor(red:0.86, green:0.85, blue:0.85, alpha:1.00)
        
        let screenRect = UIScreen.main.bounds
        let screenHeight = screenRect.size.height
        let bannersize = screenHeight * 0.34 - tabBarSize - handleArea.frame.size.height - 30
        
        BannerView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            BannerView.heightAnchor.constraint(equalToConstant: bannersize)
        ])
        
        InstagramScroll.delegate = self
        InstagramPageControl.currentPage = 0
        InstagramPageControl.hidesForSinglePage = true
        InstagramPageControl.numberOfPages = 7
        
        let db = Firestore.firestore()
        
        db.collection("instagram_links")
            .order(by: "time", descending: true)
            .limit(to: 7).getDocuments()
                { (querySnapshot, err) in
                    if let err = err {
                        print("Error getting documents: \(err)")
                    } else {
                        var counter = 0;
                        for document in querySnapshot!.documents {
                            counter = counter + 1
                            let link = document.get("link") as! String
                            
                            let imageView = UIImageView()
                            let url = URL(string: link)
                            imageView.kf.setImage(with: url)
                            
                            imageView.contentMode = .scaleAspectFit
                            let xPosition = self.InstagramScroll.frame.width * CGFloat(counter - 1)
                            
                            imageView.frame = CGRect(x: xPosition, y: 0, width: self.InstagramScroll.frame.width, height: self.InstagramScroll.frame.height)
                            
                            self.InstagramScroll.contentSize.width = self.InstagramScroll.frame.width * CGFloat(counter)
                            
                            self.InstagramScroll.contentSize.height = self.InstagramScroll.frame.height
                            
                            self.InstagramScroll.addSubview(imageView)
                            print("Added")
                        }
                    }
        }
        
    }
    
    
    
    func scrollViewDidEndDecelerating(_ scrollView: UIScrollView) {
        let pageNumber = round(self.InstagramScroll.contentOffset.x / InstagramScroll.frame.size.width)
        InstagramPageControl.currentPage = Int(pageNumber)
    }
    
}
