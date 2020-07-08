//
//  testvc.swift
//  bigfantv
//
//  Created by Ganesh on 02/07/20.
//  Copyright © 2020 Ganesh. All rights reserved.
//

import UIKit
//import MaterialComponents
import MaterialComponents.MaterialBottomNavigation

class testvc: UIViewController,MDCBottomNavigationBarDelegate{
    let bottomNavBar = MDCBottomNavigationBar()
    lazy var firstController: test2 = {
         var viewController = self.storyboard?.instantiateViewController(withIdentifier: "test2") as! test2
       self.addViewControllerAsChildViewController(childViewController: viewController)
       return viewController
       
     }()
    lazy var secondController: test3 = {
           var viewController = self.storyboard?.instantiateViewController(withIdentifier: "test3") as! test3
         self.addViewControllerAsChildViewController(childViewController: viewController)
         return viewController
         
       }()
    lazy var thirdController: test4 = {
        var viewController = self.storyboard?.instantiateViewController(withIdentifier: "test4") as! test4
      self.addViewControllerAsChildViewController(childViewController: viewController)
      return viewController
      
    }()
    lazy var FourthController: test5 = {
           var viewController = self.storyboard?.instantiateViewController(withIdentifier: "test5") as! test5
         self.addViewControllerAsChildViewController(childViewController: viewController)
         return viewController
         
       }()
    
    @IBOutlet var Viadd: UIView!
    @IBOutlet var Vitest: UIView!
    override func viewDidLoad() {
        super.viewDidLoad()
         firstController.view.isHidden = false
         secondController.view.isHidden = true
         thirdController.view.isHidden = true
        FourthController.view.isHidden = true
      
    }
    override func viewDidAppear(_ animated: Bool) {
        
 
        
        let tabBar = MDCTabBar(frame: CGRect(x: 0, y:Vitest.frame.maxY, width: view.bounds.width, height: 48))
              tabBar.items = [
              UITabBarItem(title: "Movies", image: UIImage(named: "phone"), tag: 0),
              UITabBarItem(title: "Live TV", image: UIImage(named: "heart"), tag: 1),
              UITabBarItem(title: "Series", image: UIImage(named: "phone"), tag: 2),
              UITabBarItem(title: "Videos", image: UIImage(named: "heart"), tag: 3),
              ]
              tabBar.itemAppearance = .titles
              tabBar.displaysUppercaseTitles = false
              tabBar.tintColor = .systemRed
              tabBar.bottomDividerColor = UIColor.clear
              tabBar.selectedItemTintColor = .systemRed
              tabBar.barTintColor = Appcolor.backgorund2
              tabBar.alignment = .justified
              tabBar.selectedItemTitleFont = UIFont(name: "Muli-Bold", size: 16)!
              tabBar.unselectedItemTitleFont = UIFont(name: "Muli-Bold", size: 16)!
              tabBar.delegate = self
              tabBar.autoresizingMask = [.flexibleWidth, .flexibleBottomMargin]
              tabBar.sizeToFit()
        
              view.addSubview(tabBar)
        
        Viadd.frame = CGRect(x: 0, y: tabBar.frame.maxY - 10, width: view.bounds.width, height: UIScreen.main.bounds.height)
        
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
extension testvc:MDCTabBarDelegate
{

    func tabBar(_ tabBar: MDCTabBar, didSelect item: UITabBarItem) {
        
        if item.tag == 0
        {
            
            firstController.view.isHidden = false
            secondController.view.isHidden = true
            thirdController.view.isHidden = true
            FourthController.view.isHidden = true
            
        }else if item.tag == 1
        {
            
            firstController.view.isHidden = true
             secondController.view.isHidden = false
            thirdController.view.isHidden = true
            FourthController.view.isHidden = true
        }
        else if item.tag == 2
        {
            secondController.view.isHidden = true
            firstController.view.isHidden = true
            thirdController.view.isHidden = false
            FourthController.view.isHidden = true
        }
        else if item.tag == 3
        {
            secondController.view.isHidden = true
            firstController.view.isHidden = true
            thirdController.view.isHidden = true
            FourthController.view.isHidden = false
        }
    }
    
}
