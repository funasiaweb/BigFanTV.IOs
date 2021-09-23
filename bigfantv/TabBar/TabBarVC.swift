//
//  TabBarVC.swift
//  bigfantv
//
//  Created by Ganesh on 25/06/20.
//  Copyright © 2020 Ganesh. All rights reserved.
//

import UIKit

class TabBarVC: UITabBarController {

  
    
    @IBOutlet var NewTab: UITabBar!
    override func viewDidLoad() {
        super.viewDidLoad()
        if HomeViewController.isfromgame == 1
        {
     //selectedIndex  = 3
        }else
        {
            selectedIndex = 0
        }
        selectedIndex = 0
       
        UITabBarItem.appearance().setTitleTextAttributes([NSAttributedString.Key.font: UIFont(name: "Muli-Bold", size: 16)!,NSAttributedString.Key.foregroundColor : UIColor.white], for: .normal)
        UITabBarItem.appearance().setTitleTextAttributes([NSAttributedString.Key.font: UIFont(name: "Muli-Bold", size: 16)!,NSAttributedString.Key.foregroundColor : UIColor(red: 0/255.0, green: 175/255.0, blue: 240/255.0, alpha: 1.0)], for: .selected)
        
        let button = UIButton()
        button.frame = CGRect(x: self.view.frame.size.width - 60, y: self.view.frame.size.height - tabBar.frame.size.height - 120, width: 50, height: 50)
        button.setImage(UIImage(named: "comment"), for: .normal)
        button.backgroundColor = UIColor(red: 152/255.0, green: 56/255.0, blue: 226/255.0, alpha: 1.0)
        button.imageEdgeInsets = UIEdgeInsets(top: 10, left:10, bottom: 10, right: 10)

       // button.setBackgroundImage(UIImage(named: "comment"), for: .normal)
        button.clipsToBounds = true
        button.layer.cornerRadius = button.frame.size.height / 2
        button.layer.borderWidth = 1
        button.layer.borderColor = UIColor.clear.cgColor
        button.addTarget(self, action: #selector(feeddback), for: .touchUpInside)
        if UserDefaults.standard.bool(forKey: "isLoggedin") == true
        {
     
            self.view.addSubview(button)
        }
    }
    @objc func feeddback()
    {
         let storyBoard: UIStoryboard = UIStoryboard(name: "Main", bundle: nil)
          let VC1 = storyBoard.instantiateViewController(withIdentifier: "FeedbackVC") as! FeedbackVC
        //https://funasia.net/bigfantvfeedback.funasia.net/addfeedback.html?
        
        //https://bigfantv.funasia.net/
        //https://funasia.net/bigfantv.funasia.net/
       VC1.planurl = "https://bigfantv.funasia.net/welcomefeedback.html?id=\(UserDefaults.standard.string(forKey: "id") ?? "")&email=\(UserDefaults.standard.string(forKey: "email") ?? "")&display_name=\(UserDefaults.standard.string(forKey: "display_name") ?? "")"
           
        let navController = UINavigationController(rootViewController: VC1) // Creating a navigation controller with VC1 at the root of the navigation stack.
        navController.navigationBar.barTintColor = Appcolor.backgorund3
        navController.modalPresentationStyle = .fullScreen
         let textAttributes = [NSAttributedString.Key.foregroundColor:UIColor.white,NSAttributedString.Key.font: UIFont(name: "Muli-ExtraBold", size: 19)!]
         navController.navigationBar.titleTextAttributes = textAttributes
        self.present(navController, animated:true, completion: nil)
        
    }
   override func viewDidLayoutSubviews()
   {
    super.viewDidLayoutSubviews()
   //  self.tabBarItem.imageInsets = UIEdgeInsets(top: -10, left: 0, bottom: 10, right: 0)

      // tabBar.frame.size.height = 100
      // tabBar.frame.origin.y = view.frame.height - 100
   }
    
}
