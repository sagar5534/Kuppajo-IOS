
import UIKit

class ProductVC: UITableViewController {
    
    var product: Product!

    @IBOutlet weak var HeaderImage: UIImageView!
    @IBOutlet weak var HeaderDesc: UILabel!

    override func viewDidLoad() {
        super.viewDidLoad()
    
        title = product.name
        HeaderImage.kf.setImage(with: product.toImageURL())
        HeaderDesc.text = product.desc
    
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
        return product.productOptions.count
    }

    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "ItemSelectionCell", for: indexPath) as! ItemSelectionCell
        
        cell.CellName.text = product.productOptions[indexPath.row].name
        
        return cell
        
//        if indexPath.row == 0{
//
//            let cell = tableView.dequeueReusableCell(withIdentifier: "ItemSizeCell", for: indexPath) as! ItemSizeCell
//
//            cell.sizeSegment.removeAllSegments()
//
//            for i in product.sizes{
//                cell.sizeSegment.insertSegment(withTitle: i.SizeCode.rawValue, at: 0, animated: false)
//            }
//
//            cell.sizeSegment.selectedSegmentIndex = 0
//
//            return cell
//
//        }
//
//        else if indexPath.row == 1{
//
//            let cell = tableView.dequeueReusableCell(withIdentifier: "ItemSelectionCell", for: indexPath) as! ItemSelectionCell
//
//            cell.CellName.text = "Add-Ins"
//
//            return cell
//
//        }
//
        
        
    }
}
