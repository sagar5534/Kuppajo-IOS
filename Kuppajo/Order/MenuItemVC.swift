//
//  MenuItemVC.swift
//  Kuppajo
//
//  Created by Sagar on 2020-01-12.
//  Copyright © 2020 Sagar. All rights reserved.
//

import UIKit
import Kingfisher

class MenuItemVC: UIViewController, UITableViewDelegate, UITableViewDataSource {

    var item: Item!
    
    @IBOutlet weak var HeaderImage: UIImageView!
    @IBOutlet weak var itemTable: UITableView!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        title = item.item_name
        
        let url = URL(string: item.item_image)
        HeaderImage.kf.setImage(with: url)
        
        itemTable.delegate = self
        itemTable.dataSource = self
            
    }
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int
    {
        return 10
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "ItemSizeCell", for: indexPath) as! ItemSizeCell

        
        
        return cell
        
        if indexPath.row == 0{
            
            let cell = tableView.dequeueReusableCell(withIdentifier: "ItemSizeCell", for: indexPath) as! ItemSizeCell

            
            cell.sizeSegment.removeAllSegments()
            cell.sizeSegment.insertSegment(withTitle: "Medium", at: 0, animated: false)
            cell.sizeSegment.insertSegment(withTitle: "Large", at: 1, animated: false)
            
            
            return cell
            
        }else {
            
            let cell = tableView.dequeueReusableCell(withIdentifier: "ItemSizeCell", for: indexPath) as! ItemSizeCell

            return cell
            
        }
        
    
    }


    

}
