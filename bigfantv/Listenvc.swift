//
//  Listenvc.swift
//  bigfantv
//
//  Created by Ganesh on 02/07/20.
//  Copyright © 2020 Ganesh. All rights reserved.
//

import UIKit
import AVKit
//import MaterialComponents
import MaterialComponents.MaterialBottomNavigation

class Listenvc: UIViewController,MDCBottomNavigationBarDelegate{
    let bottomNavBar = MDCBottomNavigationBar()
    lazy var firstController: MusicListVC = {
         var viewController = self.storyboard?.instantiateViewController(withIdentifier: "MusicListVC") as! MusicListVC
       self.addViewControllerAsChildViewController(childViewController: viewController)
       return viewController
       
     }()
    lazy var secondController: RadioListVC = {
           var viewController = self.storyboard?.instantiateViewController(withIdentifier: "RadioListVC") as! RadioListVC
         self.addViewControllerAsChildViewController(childViewController: viewController)
         return viewController
         
       }()
    lazy var thirdController: NewPodcastlistVC = {
        var viewController = self.storyboard?.instantiateViewController(withIdentifier: "NewPodcastlistVC") as! NewPodcastlistVC
      self.addViewControllerAsChildViewController(childViewController: viewController)
      return viewController
      
    }()
    
    @IBOutlet var Viadd: UIView!
     @IBOutlet var ViCast: UIView!
    @IBOutlet var ViTab: UIView!
    
    @IBOutlet var Vitest: UIView!
    
    
    @IBOutlet var Containerview: UIView!
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let tabBar = MDCTabBar(frame: CGRect(x: 0, y: 0, width: ViTab.frame.size.width, height: ViTab.frame.size.height))
                  tabBar.items = [
                    
                     UITabBarItem(title: "Live Radio", image: UIImage(named: "heart"), tag: 1),
                     UITabBarItem(title: "Music", image: UIImage(named: "phone"), tag: 0),
                     UITabBarItem(title: "Podcast", image: UIImage(named: "phone"), tag: 2)
                   
                  ]
                  tabBar.itemAppearance = .titles
                  tabBar.displaysUppercaseTitles = false
                  tabBar.tintColor = UIColor(red: 0/255.0, green: 175/255.0, blue: 240/255.0, alpha: 1.0)
                  tabBar.bottomDividerColor = UIColor.clear
                  tabBar.selectedItemTintColor =   UIColor(red: 0/255.0, green: 175/255.0, blue: 240/255.0, alpha: 1.0)
                  tabBar.barTintColor = Appcolor.backgorund2
                  tabBar.alignment = .justified
                  tabBar.selectedItemTitleFont = UIFont(name: "Muli-Bold", size: 16)!
                  tabBar.unselectedItemTitleFont = UIFont(name: "Muli-Bold", size: 16)!
                  tabBar.delegate = self
                  tabBar.autoresizingMask = [.flexibleWidth, .flexibleBottomMargin]
                  tabBar.sizeToFit()
            
                  ViTab.addSubview(tabBar)
            
         //   Viadd.frame = CGRect(x: 0, y: tabBar.frame.maxY - 10, width: view.bounds.width, height: UIScreen.main.bounds.height)
         firstController.view.isHidden = true
         secondController.view.isHidden = false
         thirdController.view.isHidden = true
        
        
      
    }
    override func viewDidAppear(_ animated: Bool) {
        
 
    setupAirPlayButton()
        
    }
    func setupAirPlayButton() {
                var buttonView: UIView? = nil
                let buttonFrame = CGRect(x: 0, y: 0, width: 48, height: 48)

                // It's highly recommended to use the AVRoutePickerView in order to avoid AirPlay issues after iOS 11.
                if #available(iOS 11.0, *)
              {
                    let airplayButton = AVRoutePickerView(frame: buttonFrame)
           
               
                    airplayButton.activeTintColor = UIColor.blue
               
                    airplayButton.tintColor = UIColor.white
                  
               if #available(iOS 13.0, *) {
                   airplayButton.prioritizesVideoDevices = true
               } else {
                   // Fallback on earlier versions
               }
                    buttonView = airplayButton
                } else {
                    // If you still support previous iOS versions you can use MPVolumeView
                  // let airplayButton = MPVolumeView(frame: buttonFrame)
                    //airplayButton.showsVolumeSlider = false
                   // buttonView = airplayButton
                }
              
               
               ViCast.addSubview(buttonView ?? UIView())
                // If there are no AirPlay devices available, the button will not be displayed.
                let buttonItem = UIBarButtonItem(customView: buttonView!)
               // self.navigationItem.setRightBarButton(buttonItem, animated: true)
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
extension Listenvc:MDCTabBarDelegate
{

    func tabBar(_ tabBar: MDCTabBar, didSelect item: UITabBarItem) {
        
        if item.tag == 0
        {
            
             firstController.view.isHidden = false
             secondController.view.isHidden = true
             thirdController.view.isHidden = true
          //  FourthController.view.isHidden = true
            
        }else if item.tag == 1
        {
            
             firstController.view.isHidden = true
            secondController.view.isHidden = false
           thirdController.view.isHidden = true
          //  FourthController.view.isHidden = true
        }
        else if item.tag == 2
        {
            secondController.view.isHidden = true
           firstController.view.isHidden = true
            thirdController.view.isHidden = false
          //  FourthController.view.isHidden = true
        }
        
    }
    
}
