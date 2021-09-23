//
//  MyLibrariesVC.swift
//  bigfantv
//
//  Created by iOS on 12/05/2021.
//  Copyright © 2021 Ganesh. All rights reserved.
//

import UIKit
import MaterialComponents.MaterialBottomNavigation

class MyLibrariesVC: UIViewController {
    
     lazy var WatchHistoryViewController: WatchHistoryVC = {
         let mainstoryboard = UIStoryboard(name: "Main", bundle: Bundle.main)
          var viewController = mainstoryboard.instantiateViewController(withIdentifier: "WatchHistoryVC") as! WatchHistoryVC
      self.addViewControllerAsChildViewController(childViewController: viewController)
        return viewController
        
      }()
    
     lazy var FavoritesViewController: FavoritesVC = {
         let mainstoryboard = UIStoryboard(name: "Main", bundle: Bundle.main)
            var viewController = mainstoryboard.instantiateViewController(withIdentifier: "FavoritesVC") as! FavoritesVC
           self.addViewControllerAsChildViewController(childViewController: viewController)
          return viewController
          
        }()
    
    @IBOutlet var Viadd: UIView!
    @IBOutlet var Vitest: UIView!
    @IBOutlet var visegment: UIView!
    override func viewDidLoad()
    {
        super.viewDidLoad()
        
        
        FavoritesViewController.view.isHidden = false
        let tabBar = MDCTabBar(frame: CGRect(x: 0, y:0, width: visegment.bounds.width , height: visegment.bounds.height))
               
        tabBar.items = [
             UITabBarItem(title: "Favorites", image: UIImage(named: "heart"), tag: 0),
            UITabBarItem(title: "Watch History", image: UIImage(named: "phone"), tag: 1)
           ]
        tabBar.itemAppearance = .titles
        tabBar.displaysUppercaseTitles = false
        tabBar.tintColor = UIColor(red: 0/255.0, green: 175/255.0, blue: 240/255.0, alpha: 1.0)
        tabBar.bottomDividerColor = UIColor.clear
        tabBar.selectedItemTintColor = UIColor(red: 0/255.0, green: 175/255.0, blue: 240/255.0, alpha: 1.0)
        tabBar.barTintColor = Appcolor.backgorund2
        tabBar.alignment = .justified
        tabBar.selectedItemTitleFont = UIFont(name: "Muli-Bold", size: 16)!
        tabBar.unselectedItemTitleFont = UIFont(name: "Muli-Bold", size: 16)!
        tabBar.delegate = self
        tabBar.autoresizingMask = [.flexibleWidth, .flexibleBottomMargin]
        tabBar.sizeToFit()
                      
        visegment.addSubview(tabBar)

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


 
    private func addViewControllerAsChildViewController(childViewController: UIViewController) {
 
        addChild(childViewController)
     Viadd.addSubview(childViewController.view)
      
      childViewController.view.frame = Viadd.bounds
      childViewController.view.autoresizingMask = [.flexibleWidth, .flexibleHeight]
      
      // Notify the childViewController, that you are going to add it into the Container-View -Controller
        childViewController.didMove(toParent: self)
      
    }
  private func remove(asChildViewController viewController: UIViewController) {
      // Notify Child View Controller
    viewController.willMove(toParent: nil)

      // Remove Child View From Superview
      viewController.view.removeFromSuperview()

      // Notify Child View Controller
    viewController.removeFromParent()
  }
}
extension MyLibrariesVC:MDCTabBarDelegate
{

    func tabBar(_ tabBar: MDCTabBar, didSelect item: UITabBarItem) {
     
        if item.tag == 0
        {
             
            FavoritesViewController.view.isHidden = false
            WatchHistoryViewController.view.isHidden = true

         
            
        }else if item.tag == 1
        {
             
            FavoritesViewController.view.isHidden = true
            WatchHistoryViewController.view.isHidden = false

         
        }
       
    }
    
}


