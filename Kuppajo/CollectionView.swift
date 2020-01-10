//
//  CollectionView.swift
//  Kuppajo
//
//  Created by Sagar on 2020-01-08.
//  Copyright © 2020 Sagar. All rights reserved.
//

import Foundation
import UIKit

@IBDesignable
class CollectionView: UIView {
    let nibName = "CollectionView"
    var contentView:UIView?
    
    
    @IBOutlet weak var CollectionTitle: UILabel!
    @IBOutlet weak var CollectionView: UICollectionView!
    

    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        commonInit()
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        commonInit()
    }
    
    func commonInit() {
        guard let view = loadViewFromNib() else { return }
        view.frame = self.bounds
        self.addSubview(view)
        contentView = view
        
        self.CollectionView.register(UINib(nibName: "CollectionCell", bundle: nil), forCellWithReuseIdentifier: "CollectionCell")
    }
    
    func loadViewFromNib() -> UIView? {
        let bundle = Bundle(for: type(of: self))
        let nib = UINib(nibName: nibName, bundle: bundle)
        return nib.instantiate(withOwner: self, options: nil).first as? UIView
    }
    
}

