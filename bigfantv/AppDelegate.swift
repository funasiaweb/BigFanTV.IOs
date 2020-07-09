//
//  AppDelegate.swift
//  bigfantv
//
//  Created by Ganesh on 25/06/20.
//  Copyright © 2020 Ganesh. All rights reserved.
//

import UIKit
import MuviSDK
import  GoogleSignIn
@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate,GIDSignInDelegate
{


var window: UIWindow?
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool
    {
        // Override point for customization after application launch.
      //  MuviAPISDK.initialiseSDK(with: "57b8617205fa3446ba004d583284f475")
       // checkLogged()
        GIDSignIn.sharedInstance().clientID = "438516930813-ssg8dte52kvfl6h6jubgtcgmtgjcv24o.apps.googleusercontent.com"
        GIDSignIn.sharedInstance().delegate = self
        
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

     func application(_ application: UIApplication, open url: URL, sourceApplication: String?, annotation: Any) -> Bool {
         return GIDSignIn.sharedInstance().handle(url, sourceApplication: sourceApplication, annotation: annotation)
     }
     
     func application(_ app: UIApplication, open url: URL, options: [UIApplication.OpenURLOptionsKey : Any] = [:]) -> Bool {
         let sourceApplication = options[UIApplication.OpenURLOptionsKey.sourceApplication] as? String
         let annotation = options[UIApplication.OpenURLOptionsKey.annotation]
         return GIDSignIn.sharedInstance().handle(url, sourceApplication: sourceApplication, annotation: annotation)
     }
    
     
     func sign(_ signIn: GIDSignIn!, didSignInFor user: GIDGoogleUser!,
               withError error: Error!) {
       if let error = error {
         if (error as NSError).code == GIDSignInErrorCode.hasNoAuthInKeychain.rawValue {
           print("The user has not signed in before or they have since signed out.")
         } else {
           print("\(error.localizedDescription)")
         }
         return
       }
       // Perform any operations on signed in user here.
       let userId = user.userID                  // For client-side use only!
       let idToken = user.authentication.idToken // Safe to send to the server
       let fullName = user.profile.name
       let givenName = user.profile.givenName
       let familyName = user.profile.familyName
       let email = user.profile.email
       // ...
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

