//
//  CategoryCollectionCell.swift
//  Kuppajo
//
//  Created by Luna on 2020-01-08.
//  Copyright © 2020 Sagar. All rights reserved.
//

import UIKit

class CategoryCollectionCell: UICollectionViewCell {
    
    @IBOutlet weak var CellTitle: UILabel!
    @IBOutlet weak var CellImage: UIImageView!
    
    override func awakeFromNib() {
        CellImage.setRounded()
    }
    
}

extension UIImageView {

   func setRounded() {
        let radius = self.frame.width / 2
        self.layer.cornerRadius = radius
        self.layer.masksToBounds = true
        self.contentMode = .scaleToFill
    }
    
}
