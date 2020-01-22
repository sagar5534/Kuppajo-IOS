//
//  MenuStructure.swift
//  Kuppajo
//
//  Created by Sagar on 2020-01-20.
//  Copyright © 2020 Sagar. All rights reserved.
//

import Foundation

// MARK: - MenuStructure
struct MenuStructure: Codable {
    let menus: [Menu]
}

// MARK: - Menu
struct Menu: Codable {
    let displayOrder: Int
    let name: String
    let products: [Product]
    let children: [Menu]
    let image: String
    //let id, uri: String
    
    func toImageURL() -> URL{
        return URL(string: image)!
    }
    
}

// MARK: - Product
struct Product: Codable {
    let name: String
    //let formCode: FormCode
    //let displayOrder, productNumber: Int
    let displayOrder: Int
    //let productType: ProductType
    //let availability: Availability
    //let assets: Assets
    let image: String
    let sizes: [Size]
    //let uri: String
    
    func toImageURL() -> URL{
        return URL(string: image)!
    }
}

// MARK: - Assets
struct Assets: Codable {
    let thumbnail: String
}

enum Availability: String, Codable {
    case available = "Available"
    case notOrderable = "NotOrderable"
}

enum FormCode: String, Codable {
    case hot = "Hot"
    case iced = "Iced"
    case kCup = "K-Cup"
    case packaged = "Packaged"
    case single = "Single"
    case verismoSystemPods = "verismo-system-pods"
    case via = "VIA"
    case wholeBean = "Whole-Bean"
}

enum ProductType: String, Codable {
    case beverage = "Beverage"
    case coffee = "Coffee"
    case food = "Food"
}

// MARK: - Size
struct Size: Codable {
    let SizeCode: SizeCode
}

enum SizeCode: String, Codable {
    case double = "Double"
    case grande = "Grande"
    case kids = "Kids"
    case quad = "Quad"
    case short = "Short"
    case single = "Single"
    case tall = "Tall"
    case the11Packaged = "11-Packaged"
    case the12Count = "12-count"
    case the1LB = "1-lb"
    case the1Piece = "1 Piece"
    case the200Packaged = "200-Packaged"
    case the237Packaged = "23.7-Packaged"
    case the500Packaged = "500-Packaged"
    case the88Oz = "8.8-oz"
    case trenta = "Trenta"
    case triple = "Triple"
    case venti = "Venti"
}

