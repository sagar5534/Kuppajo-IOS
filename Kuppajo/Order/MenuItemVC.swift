//
//  MenuItemVC.swift
//  Kuppajo
//
//  Created by Sagar on 2020-01-12.
//  Copyright © 2020 Sagar. All rights reserved.
//

import UIKit
import Kingfisher

class MenuItemVC: UIViewController {

    var item: Item!
    
    @IBOutlet weak var HeaderImage: UIImageView!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        title = item.item_name
        
        let url = URL(string: item.item_image)
        HeaderImage.kf.setImage(with: url)
        // Do any additional setup after loading the view.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
