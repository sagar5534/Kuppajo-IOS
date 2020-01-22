//
//  ItemTVC.swift
//  
//
//  Created by Sagar on 2020-01-20.
//

import UIKit

class ProductVC: UITableViewController {
    
    var product: Product!

    @IBOutlet weak var HeaderImage: UIImageView!

    override func viewDidLoad() {
        super.viewDidLoad()
        
        HeaderImage.kf.setImage(with: product.toImageURL())
        
    }
    
}

//Table View Functions
extension ProductVC{
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return 1
    }

    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "ItemSizeCell", for: indexPath) as! ItemSizeCell

        
        cell.sizeSegment.removeAllSegments()
        cell.sizeSegment.insertSegment(withTitle: "Medium", at: 0, animated: false)
        cell.sizeSegment.insertSegment(withTitle: "Large", at: 1, animated: false)
        
        
        return cell
    }
}
