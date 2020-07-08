//
//  tbVC.swift
//  bigfantv
//
//  Created by Ganesh on 04/07/20.
//  Copyright © 2020 Ganesh. All rights reserved.
//

import UIKit
import MaterialComponents.MaterialBottomNavigation

class tbVC: UITabBarController {
    lazy var firstController: ViewController = {
         var viewController = self.storyboard?.instantiateViewController(withIdentifier: "ViewController") as! ViewController
       self.addViewControllerAsChildViewController(childViewController: viewController)
       return viewController
       
     }()
    private func addViewControllerAsChildViewController(childViewController: UIViewController) {
      
        addChild(childViewController)
      self.view.addSubview(childViewController.view)
      
      childViewController.view.frame = view.bounds
      childViewController.view.autoresizingMask = [.flexibleWidth, .flexibleHeight]
      
      // Notify the childViewController, that you are going to add it into the Container-View -Controller
        childViewController.didMove(toParent: self)
      
    }
    let bottomNavBar = MDCBottomNavigationBar()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        bottomNavBar.items = [
        UITabBarItem(title: "watch", image:  UIImage(named: "setting1"), tag: 1),
        UITabBarItem(title: "watch", image:  UIImage(named: "watchnew"), tag: 2),
        UITabBarItem(title: "watch", image:  UIImage(named: "watchnew"), tag: 3),
        UITabBarItem(title: "watch", image:  UIImage(named: "watchnew"), tag: 4),
        UITabBarItem(title: "watch", image:  UIImage(named: "watchnew"), tag: 5) ]
     
       
        
        bottomNavBar.alignment = .justified
        bottomNavBar.titleVisibility = .selected
        bottomNavBar.backgroundColor = Appcolor.backgorund2
        bottomNavBar.selectedItemTintColor = .systemRed
        bottomNavBar.unselectedItemTintColor = .white
        bottomNavBar.itemTitleFont = UIFont(name: "Muli-Bold", size: 16)!
        bottomNavBar.selectedItem = bottomNavBar.items.first
        bottomNavBar.delegate = self
        bottomNavBar.sizeToFit()
        
        view.addSubview(bottomNavBar)
   
    }
    override func viewWillLayoutSubviews() {
    super.viewWillLayoutSubviews()
    let size = bottomNavBar.sizeThatFits(view.bounds.size)
    let bottomNavBarFrame = CGRect(x: 0,
    y: view.bounds.height - size.height,
    width: size.width,
    height: size.height)
    bottomNavBar.frame = bottomNavBarFrame
    }

    

}
extension tbVC:MDCBottomNavigationBarDelegate
{
    override func tabBar(_ tabBar: UITabBar, didSelect item: UITabBarItem) {
        if item.tag == 1
        {
            print("1")
        }    }
    func bottomNavigationBar(_ bottomNavigationBar: MDCBottomNavigationBar, shouldSelect item: UITabBarItem) -> Bool {
         if item.tag == 1
          {
            firstController.view.isHidden  = false
          }else
          {
            firstController.view.isHidden  = true
         }
        return true
    }
    
}
