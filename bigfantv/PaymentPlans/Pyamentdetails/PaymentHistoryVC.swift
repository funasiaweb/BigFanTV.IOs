//
//  PaymentHistoryVC.swift
//  bigfantv
//
//  Created by Ganesh on 17/10/20.
//  Copyright © 2020 Ganesh. All rights reserved.
//

import UIKit
import MaterialComponents.MaterialBottomNavigation
class PaymentHistoryVC: UIViewController {
   
       lazy var firstController: PurchasehistoryVC = {
            var viewController = self.storyboard?.instantiateViewController(withIdentifier: "PurchasehistoryVC") as! PurchasehistoryVC
          self.addViewControllerAsChildViewController(childViewController: viewController)
          return viewController
          
        }()
       lazy var secondController: CarddetailsVC = {
              var viewController = self.storyboard?.instantiateViewController(withIdentifier: "CarddetailsVC") as! CarddetailsVC
            self.addViewControllerAsChildViewController(childViewController: viewController)
            return viewController
            
          }()
    
    @IBOutlet var Viadd: UIView!
       
       @IBOutlet var visegment: UIView!
       
    override func viewDidLoad() {
        super.viewDidLoad()
        firstController.view.isHidden = false
        secondController.view.isHidden = true
        // Do any additional setup after loading the view.
    }
    
 override func viewDidAppear(_ animated: Bool) {
        
 
        let tabBar = MDCTabBar(frame: CGRect(x: 0, y:0, width: visegment.bounds.width , height: visegment.bounds.height))
                    tabBar.items = [
                    UITabBarItem(title: "Purchase History", image: UIImage(named: "phone"), tag: 0),
                  
                    UITabBarItem(title: "Card Details", image: UIImage(named: "phone"), tag: 1) 
                    ]
                    tabBar.itemAppearance = .titles
                    tabBar.displaysUppercaseTitles = false
       
                    tabBar.tintColor = UIColor.white
                    tabBar.bottomDividerColor = UIColor.clear
                    tabBar.selectedItemTintColor = UIColor.white
                    tabBar.barTintColor = Appcolor.backgorund2
                    tabBar.alignment = .justified
                    tabBar.selectedItemTitleFont = UIFont(name: "Muli-Bold", size: 16)!
                    tabBar.unselectedItemTitleFont = UIFont(name: "Muli-Bold", size: 16)!
                    tabBar.delegate = self
                    tabBar.autoresizingMask = [.flexibleWidth, .flexibleBottomMargin]
                    tabBar.sizeToFit()
              
                    visegment.addSubview(tabBar)
        
    
            
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
    private func addViewControllerAsChildViewController(childViewController: UIViewController) {
       
         addChild(childViewController)
       self.Viadd.addSubview(childViewController.view)
       
       childViewController.view.frame = Viadd.bounds
       childViewController.view.autoresizingMask = [.flexibleWidth, .flexibleHeight]
       
       // Notify the childViewController, that you are going to add it into the Container-View -Controller
         childViewController.didMove(toParent: self)
       
     }
    
}
extension PaymentHistoryVC:MDCTabBarDelegate
{

    func tabBar(_ tabBar: MDCTabBar, didSelect item: UITabBarItem) {
        
        if item.tag == 0
        {
            
            firstController.view.isHidden = false
            secondController.view.isHidden = true
             
        }else if item.tag == 1
        {
            
            firstController.view.isHidden = true
             secondController.view.isHidden = false
           
        }
        
}
}
