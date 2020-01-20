//
//  ItemSizeCell.swift
//  Kuppajo
//
//  Created by Sagar on 2020-01-19.
//  Copyright © 2020 Sagar. All rights reserved.
//

import UIKit

class ItemSizeCell: UITableViewCell {

    @IBOutlet weak var sizeSegment: UISegmentedControl!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        //sizeSegment.removeAllSegments()
        
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
