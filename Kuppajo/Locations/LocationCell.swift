//
//  LocationCell.swift
//  Kuppajo
//
//  Created by Sagar Patel on 2019-10-12.
//  Copyright © 2019 Sagar. All rights reserved.
//

import UIKit

class LocationCell: UITableViewCell {
    
    
    @IBOutlet weak var LocationName: UILabel!
    @IBOutlet weak var LocationTimeDetail: UILabel!
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: true)
    }
    
}
