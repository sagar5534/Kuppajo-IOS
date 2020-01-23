//
//  ItemSelectionCell.swift
//  Kuppajo
//
//  Created by Sagar on 2020-01-22.
//  Copyright © 2020 Sagar. All rights reserved.
//

import UIKit

class ItemSelectionCell: UITableViewCell {

    @IBOutlet weak var CellName: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()

    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
