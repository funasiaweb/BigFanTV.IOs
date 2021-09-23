//
//  SubscribePlanVC.swift
//  bigfantv
//
//  Created by Ganesh on 31/08/20.
//  Copyright © 2020 Ganesh. All rights reserved.
//

import UIKit
import WebKit
class SubscribePlanVC: UIViewController {

    @IBOutlet var WebV: WKWebView!
    var planurl = ""
    override func viewDidLoad() {
        super.viewDidLoad()

        if planurl != ""
       {
         WebV.load(NSURLRequest(url: NSURL(string: planurl)! as URL) as URLRequest)
       }
        

        
    }
    override func viewDidAppear(_ animated: Bool)
       {
                    let viewright = UIView(frame: CGRect(x:  0, y: 0, width: 50,height: 30))
                       viewright.backgroundColor = UIColor.clear
           
                    let  button4 = UIButton(frame: CGRect(x: 0,y: 0, width: 30, height: 30))
                         button4.setImage(UIImage(named: "backarrow"), for: UIControl.State.normal)
                         button4.setTitle("close", for: .normal)
                         button4.addTarget(self, action: #selector(close), for: UIControl.Event.touchUpInside)
                   
                       viewright.addSubview(button4)
                                   
                       let leftbuttton = UIBarButtonItem(customView: viewright)
                        self.navigationItem.leftBarButtonItem = leftbuttton
                              
       }
                              @objc func close()
                              {
                                  self.performSegue(withIdentifier: "toback", sender: self)
                              }
 

}
