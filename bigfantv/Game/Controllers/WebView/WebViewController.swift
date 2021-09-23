//
//  WebViewController.swift
//  Outquiz
//
//  Created by Vasily Evreinov on 09.03.2018.
//  Copyright © 2018 UniProgy s.r.o. All rights reserved.
//

import UIKit
import WebKit
class WebViewController: BaseViewController   {
    
     
    
    @IBOutlet var webView: WKWebView!
    // title of the page to display
    var docTitle: String?
    
    // URL which WebView will need to show
    var docUrl: URL?
    
    // MARK: - View
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureView()
    }
    
    func configureView()
    {
        self.title = docTitle!
        webView.load(URLRequest(url: docUrl!))
        //webView.delegate = self
        navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .done, target: self, action: #selector(closePopup))
    }
    
    @objc func closePopup()
    {
        self.dismiss(animated: true, completion: nil)
    }
   
 
    
    
}
