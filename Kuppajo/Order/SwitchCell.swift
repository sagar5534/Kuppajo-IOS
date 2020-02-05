//
//  SwitchCell.swift
//  Kuppajo
//
//  Created by Sagar on 2020-02-02.
//  Copyright © 2020 Sagar. All rights reserved.
//

import UIKit

class SwitchCell: UITableViewCell {

    @IBOutlet weak var Name: UILabel!
    @IBOutlet weak var Switch: UISwitch!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
