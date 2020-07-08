//
//  AppDelegate.swift
//  bigfantv
//
//  Created by Ganesh on 25/06/20.
//  Copyright © 2020 Ganesh. All rights reserved.
//

import UIKit
import MuviSDK
@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate
{


var window: UIWindow?
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool
    {
        // Override point for customization after application launch.
      //  MuviAPISDK.initialiseSDK(with: "57b8617205fa3446ba004d583284f475")
        checkLogged()
        return true
    }
    func checkLogged()
       {
           if UserDefaults.standard.value(forKey: "email") != nil
           {
            let mainStoryboard = UIStoryboard(name: "MainIpad", bundle: Bundle.main)
            let vc : UITabBarController = mainStoryboard.instantiateViewController(withIdentifier: "TabBarVC") as! UITabBarController
            let share = UIApplication.shared.delegate as? AppDelegate
                     
               share?.window?.rootViewController = vc
               share?.window?.makeKeyAndVisible()
           }
       }

    // MARK: UISceneSession Lifecycle
  func application(_ application: UIApplication, supportedInterfaceOrientationsFor window: UIWindow?) -> UIInterfaceOrientationMask {
        
        if UIDevice.current.userInterfaceIdiom == .pad {
           return .landscapeRight
        } else if UIDevice.current.userInterfaceIdiom == .phone  {
            return .portrait
        }
        return UIInterfaceOrientationMask()
    }
    
    
}

