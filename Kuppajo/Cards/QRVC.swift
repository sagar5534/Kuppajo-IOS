//
//  QRVC.swift
//  Kuppajo
//
//  Created by Luna on 2019-09-24.
//  Copyright © 2019 Sagar. All rights reserved.
//

import UIKit

class QRVC: UIViewController {
    
    @IBOutlet weak var QRImage: UIImageView!
    @IBOutlet weak var QRCodeNumber: UILabel!
    
    var QRCode: String = ""
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.QRImage.image = self.generateQRCode(from: QRCode)
        self.QRCodeNumber.text = QRCode
    }
    
    
    func generateQRCode(from string: String) -> UIImage? {
        let data = string.data(using: String.Encoding.ascii)
        
        if let filter = CIFilter(name: "CIQRCodeGenerator") {
            filter.setValue(data, forKey: "inputMessage")
            let transform = CGAffineTransform(scaleX: 100, y: 100)
            
            if let output = filter.outputImage?.transformed(by: transform) {
                return UIImage(ciImage: output)
            }
        }
        
        return nil
    }
    
    
    @IBAction func dismissView(_ sender: Any) {
        dismiss(animated: true, completion: nil)
    }
    
}
