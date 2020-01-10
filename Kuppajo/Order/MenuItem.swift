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


class Category {
    var category_name = ""
    var category_image = ""
    
    init(category_name: String, category_image: String){
        self.category_image = category_image
        self.category_name = category_name
    }
    
}

class MenuCateogry {
    
    var parent = ""
    var category = [Category]()
    
    init(parent: String, categories: [Category]) {
        self.parent = parent
        self.category = categories
    }
    
    func addCategory(name: String, image: String){
        self.category.append(.init(category_name: name , category_image: image))
    }
    
}
