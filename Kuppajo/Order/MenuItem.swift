//
//  MenuItem.swift
//  Kuppajo
//
//  Created by Sagar on 2020-01-06.
//  Copyright © 2020 Sagar. All rights reserved.
//

import Foundation

class Item {
    
    var item_name = ""
    var item_image = ""
    
    init(name: String, image: String) {
           self.item_name = name
           self.item_image = image
    }
}

class MenuItem {
    
    var item_type = ""
    var item = [Item]()
    
    init(type: String, item: [Item]) {
        self.item_type = type
        self.item = item
    }
    
}

class Category {
    var category_name = ""
    var category_image = ""
    var items = [MenuItem]()
    
    init(category_name: String, category_image: String, items: [MenuItem]){
        self.category_image = category_image
        self.category_name = category_name
        self.items = items
    }
    
}

class MenuCateogry {
    
    var parent = ""
    var category = [Category]()
    
    init(parent: String, categories: [Category]) {
        self.parent = parent
        self.category = categories
    }
    
}
