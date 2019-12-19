//
//  LocationInfoTVC.swift
//  Kuppajo
//
//  Created by Sagar Patel on 2019-10-14.
//  Copyright © 2019 Sagar. All rights reserved.
//

import UIKit
import MapKit

class LocationInfoTVC: UITableViewController {
    
    var locationData: Locations!
    
    @IBOutlet weak var Address1: UILabel!
    @IBOutlet weak var Address2: UILabel!
    @IBOutlet weak var Phone: UILabel!
    
    @IBOutlet var HoursGroup: [UILabel]!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        print(locationData.name)
        title = locationData.name
        Address1.text = locationData.address1
        Address2.text = locationData.address2
        Phone.text = locationData.phone
        
        for n in 0...HoursGroup.count-1{
            HoursGroup[n].text = locationData.hours.days[n]
        }
        
    }
    
    @IBAction func CallButton(_ sender: Any) {
        
        var phone = locationData.phone
        phone = phone.replacingOccurrences(of: "-", with: "")
        guard let number = URL(string: "tel://" + phone) else {return}

        UIApplication.shared.open(number, options: [:], completionHandler: nil)
        
    }

    @IBAction func DirectionButton(_ sender: Any) {
        
        if (UIApplication.shared.canOpenURL(NSURL(string:"comgooglemaps://")! as URL)) {
            
            UIApplication.shared.open(NSURL(string: locationData.googleMap)! as URL, options: [:], completionHandler: nil)
            
        } else {
            //Get Apple Maps Working if needed
        }
        
    }
    
}
