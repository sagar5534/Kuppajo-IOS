
import UIKit

class ProductVC: UITableViewController {
    
    var product: Product!
    var sendItem: ProductOption?
    
    @IBOutlet weak var HeaderImage: UIImageView!
    @IBOutlet weak var HeaderDesc: UILabel!
    @IBOutlet weak var HeaderStack: UIStackView!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        title = product.name
        HeaderImage.kf.setImage(with: product.toImageURL())
        HeaderDesc.text = product.desc
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        
        super.viewWillAppear(animated)
        
    }
    
    override func viewWillLayoutSubviews() {
        
        super.viewWillLayoutSubviews()
        
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        super.prepare(for: segue, sender: sender)
        
        if segue.identifier == "toProductDetail"{
            
            guard let DestinationView = segue.destination as? ProductDetailVC else {
                fatalError("Unexpected destination: \(segue.destination)")
            }
            DestinationView.option = self.sendItem
        }
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
        
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        self.sendItem = product.productOptions[indexPath.row]
        performSegue(withIdentifier: "toProductDetail", sender: self)
        
    }
    
}
