//
//  StepperCell.swift
//  
//
//  Created by Sagar on 2020-02-02.
//

import UIKit

class StepperCell: UITableViewCell {

    @IBOutlet weak var Name: UILabel!
    @IBOutlet weak var Stepper: UIStepper!
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
