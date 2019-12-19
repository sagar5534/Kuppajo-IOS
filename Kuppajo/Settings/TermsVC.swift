//
//  TermsVC.swift
//  Kuppajo
//
//  Created by Sagar Patel on 2019-10-09.
//  Copyright © 2019 Sagar. All rights reserved.
//

import UIKit
import WebKit

class TermsVC: UIViewController, WKUIDelegate {
    
    @IBOutlet weak var webView: WKWebView!
    
    var viewurl: String = ""
    var viewtitle: String = ""
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //View
        let myURL = URL(string: viewurl)
        let myRequest = URLRequest(url: myURL!)
        webView.load(myRequest)
        
        //Title
        self.title = viewtitle
        
    }
    
    override func loadView() {
        let webConfiguration = WKWebViewConfiguration()
        webView = WKWebView(frame: .zero, configuration: webConfiguration)
        webView.uiDelegate = self
        view = webView
    }
    
    
    
}
