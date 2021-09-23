//
//  FeaturedVC.swift
//  bigfantv
//
//  Created by Ganesh on 14/08/20.
//  Copyright © 2020 Ganesh. All rights reserved.
//

import UIKit
 
 import AVKit
class FeaturedVC: UIViewController   {

 @IBOutlet var ViCast: UIView!
    lazy var firstController: FeatureHomeVC = {
        
            var viewController = self.storyboard?.instantiateViewController(withIdentifier: "FeatureHomeVC") as! FeatureHomeVC
           self.addViewControllerAsChildViewController(childViewController: viewController)
          return viewController
          
        }()
    
    @IBOutlet var Viadd: UIView!
 
     override func viewDidLoad()
     {
         super.viewDidLoad()
      
        firstController.view.isHidden = false
  
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
