//
//  MenuTableViewCell.swift
//  Kuppajo
//
//  Created by Sagar on 2020-01-08.
//  Copyright © 2020 Sagar. All rights reserved.
//

import UIKit

class MenuTableViewCell: UITableViewCell {

    @IBOutlet weak var MenuTitle: UILabel!
    @IBOutlet weak var CollectionView: UICollectionView!
    
    override func awakeFromNib() {
        super.awakeFromNib()

    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

    }
    
    func setCollectionViewDataSourceDelegate(dataSourceDelegate: UICollectionViewDataSource & UICollectionViewDelegate, forRow row: Int) {
        CollectionView.delegate = dataSourceDelegate
        CollectionView.dataSource = dataSourceDelegate
        CollectionView.tag = row
        CollectionView.reloadData()
    }

}
