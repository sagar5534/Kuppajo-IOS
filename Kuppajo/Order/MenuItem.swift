//
//  MenuItem.swift
//  Kuppajo
//
//  Created by Sagar on 2020-01-06.
//  Copyright © 2020 Sagar. All rights reserved.
//

import Foundation

class MenuItem {
    
    var name = ""
    var price = 0.0
    var category = ""
    var data: AnyObject
    
    init(category: String, name: String, price: Double, data: AnyObject) {
        self.category = category
        self.name = name
        self.price = price
        self.data = data
    }
    
}

class MenuCateogry {
    
    var name = ""
    var image = ""
    var type = ""
    
    init(name: String, image: String, type: String) {
        self.image = image
        self.name = name
        self.type = type
    }
    
}

class Drink {
    
    var milk = ""
    
    init(milk: String){
        self.milk = milk
    }
    
}
