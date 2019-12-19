//
//  Locations.swift
//  Kuppajo
//
//  Created by Sagar on 2019-12-19.
//  Copyright © 2019 Sagar. All rights reserved.
//

import Foundation

class Locations {
    
    var name = ""
    var address1 = ""
    var address2 = ""
    var phone = ""
    var hours: Hours
    var googleMap = ""
    
    init(name: String, address1: String, address2: String, phone: String, hours: Hours, googleMap: String) {
        self.name = name
        self.address1 = address1
        self.address2 = address2
        self.phone = phone
        self.hours = hours
        self.googleMap = googleMap
    }
    
}

class Hours {
    
    var days = [String]()
    init(_ days: [String]) {
        self.days = days
    }
}
