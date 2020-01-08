//
//  MenuVC.swift
//  Kuppajo
//
//  Created by Sagar on 2020-01-07.
//  Copyright © 2020 Sagar. All rights reserved.
//

import UIKit
import Firebase
import Promises

class MenuVC: UIViewController, UICollectionViewDelegate, UICollectionViewDataSource {

    @IBOutlet weak var CollectionView: UICollectionView!
    
    let db = Firestore.firestore()
    var category: MenuCateogry!
    var menuItems = [MenuCateogry]()
       

    override func viewDidLoad() {
        super.viewDidLoad()

        title = category.name
        
        getMenuItems(category: category)
        CollectionView.delegate = self
        CollectionView.dataSource = self
        
        
    }
    
    func getMenuItems(category: MenuCateogry){
        
        let docRef = db.collection("app_details").document("menu").collection(category.type).document("Hot Coffee")
        
        docRef.getDocument { (document, error) in
            if let document = document, document.exists {
                for data in document.data()!{
                    print(data)
                    let innerData = data.value as! [String:Any]
                    let name = innerData["Name"] as! String
                    let type = innerData["Type"] as! String
                    let image = innerData["Image"] as! String
                    self.menuItems.append(.init(name: name, image: image, type: type))
                }
            } else {}
        }
    
    }
    
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 10
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let cell:MenuCollectionCell = self.CollectionView.dequeueReusableCell(withReuseIdentifier: "MenuCollectionCell", for: indexPath) as! MenuCollectionCell
    
        cell.CellTitle.text = "HEY"
        
//        let url = URL(string: DrinkCategory[indexPath.row].image)
//        cell.cellImage.kf.setImage(with: url)
    
        return cell
        
    }
    
    
    

}
