//
//  FeedbackVC.swift
//  bigfantv
//
//  Created by Ganesh on 19/11/20.
//  Copyright © 2020 Ganesh. All rights reserved.
//

import UIKit
import WebKit
class BuyPlanVC: UIViewController ,UIScrollViewDelegate{
    @IBOutlet var WebV: WKWebView!
       var planurl = ""
       override func viewDidLoad() {
           super.viewDidLoad()

       // self.title = "Feedback"
        let urlStr     = planurl.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed)!
        print(urlStr)
        let myURL = URL(string:urlStr)
        let myRequest = URLRequest(url: myURL!)
        WebV.scrollView.bounces = false
        WebV.scrollView.delegate = self
        WebV.load(myRequest)
 
 
           
       }
    func viewForZooming(in scrollView: UIScrollView) -> UIView? {
        return nil
    }
    func scrollViewWillBeginZooming(_ scrollView: UIScrollView, with view: UIView?) {
         scrollView.pinchGestureRecognizer?.isEnabled = false
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
                                     self.dismiss(animated: true, completion: nil)
                                 }
    
}
