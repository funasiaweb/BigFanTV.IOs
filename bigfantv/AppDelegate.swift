//
//  AppDelegate.swift
//  bigfantv
//
//  Created by Ganesh on 25/06/20.
//  Copyright © 2020 Ganesh. All rights reserved.
//

import UIKit
import Firebase
import FBSDKCoreKit
import  GoogleSignIn
import AVKit
import MuviPlayer
import GoogleMobileAds
import Alamofire
import MuviAudioPlayer
import MuviSDK
@UIApplicationMain
 class AppDelegate: UIResponder, UIApplicationDelegate,GIDSignInDelegate,MessagingDelegate
{
       let manager: Alamofire.SessionManager =
        {
        let configuration = URLSessionConfiguration.default
         configuration.timeoutIntervalForRequest = TimeInterval(60)
        configuration.timeoutIntervalForResource = TimeInterval(60)
        return  Alamofire.SessionManager(configuration: configuration)
    }()

    
    var DevideId = ""
    var DeviceToken = ""

    var window: UIWindow?
    
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool
    {
        
        MuviAPISDK.initialiseSDK(with: "57b8617205fa3446ba004d583284f475") { (Result) in
            
           switch Result {
           case .success(let code,let message):
            print(code)
            print("muvi sdk = \(message)")
           case .failure(let error):
            print("muvi sdk error = \(error)")

        }
        }
        
        
        FirebaseApp.configure()

        Messaging.messaging().delegate = self
        
        let center = UNUserNotificationCenter.current()
        center.requestAuthorization(options:[.badge, .alert, .sound]) { (granted, error) in
            
            if granted
            {
                print("registered for push notifications")
            }
            // Enable or disable features based on authorization.
        }
        application.registerForRemoteNotifications()
        
       
        do
        {
            try AVAudioSession.sharedInstance().setCategory(.playback, mode: .default, options: [.mixWithOthers, .allowAirPlay])
            print("Playback OK")
            try AVAudioSession.sharedInstance().setActive(true)
            print("Session is Active")
        }
        catch
        {
            print(error)
        }
        MuviPlayerSDK.authorizationToken = "57b8617205fa3446ba004d583284f475"
       
         FBSDKCoreKit.ApplicationDelegate.shared.application(application, didFinishLaunchingWithOptions: launchOptions)
        MuviAudioPlayerManager.authorizationToken = "57b8617205fa3446ba004d583284f475"
        
      //  UserDefaults.standard.set("6825993", forKey: "id")

        GIDSignIn.sharedInstance().clientID = "535839392360-j4hh70m8jip5kuiqc58tu84r0e96q3vv.apps.googleusercontent.com"
        GIDSignIn.sharedInstance().delegate = self
        GADMobileAds.sharedInstance().start(completionHandler: nil)
         // deviceTokenString = D104726B1D3B5D9458504C04A7C9554D73AABF49AC3523F4DFDD6D7989E32780
        
      //devide id  F72E7D94-B621-4029-9674-924C37A5CFFD
      // UserDefaults.standard.set("F72E7D94-B621-4029-9674-924C37A5CFFD", forKey: "deviceid")
 
     //UserDefaults.standard.set("D104726B1D3B5D9458504C04A7C9554D73AABF49AC3523F4DFDD6D7989E32780", forKey: "devicetoken")
       /*
        let domain = Bundle.main.bundleIdentifier!
        UserDefaults.standard.removePersistentDomain(forName: domain)
        UserDefaults.standard.synchronize()
        print(Array(UserDefaults.standard.dictionaryRepresentation().keys).count)
        */
   // checkLogged()
       // UserDefaults.standard.set("", forKey: "AccessToken")

       
        return true
    }
    func messaging(_ messaging: Messaging, didReceiveRegistrationToken fcmToken: String)
    {
      print("Firebase registration token: \(String(describing: fcmToken))")

      let dataDict:[String: String] = ["token": fcmToken ?? ""]
      NotificationCenter.default.post(name: Notification.Name("FCMToken"), object: nil, userInfo: dataDict)
      // TODO: If necessary send token to application server.
      // Note: This callback is fired at each app startup and whenever a new token is generated.
    }

    func userNotificationCenter(_ center: UNUserNotificationCenter,
                                willPresent notification: UNNotification,
                                withCompletionHandler completionHandler: @escaping (UNNotificationPresentationOptions) -> Void)
    {
        let userInfo = notification.request.content.userInfo
 
         completionHandler([.alert,.sound])
    }
     func userNotificationCenter(_ center: UNUserNotificationCenter,
                                   didReceive response: UNNotificationResponse,
                                   withCompletionHandler completionHandler: @escaping () -> Void) {
           let userInfo = response.notification.request.content.userInfo
           
           
           // Print full message.
           print("tap on on forground app",userInfo)
           
           completionHandler()
       }

    func application(_ application: UIApplication, didRegisterForRemoteNotificationsWithDeviceToken deviceToken: Data) {
        let deviceIds = UIDevice.current.identifierForVendor?.uuidString
        DevideId = deviceIds ?? ""
        UserDefaults.standard.set("\(DevideId)", forKey: "deviceid")
        let deviceTokenString = deviceToken.reduce("", {$0 + String(format: "%02X", $1)})
        DeviceToken = deviceToken.hexString
        UserDefaults.standard.set("\(DeviceToken)", forKey: "devicetoken")
          print("deviceTokenString = \(deviceTokenString)")
        print(DevideId)
     
        if UserDefaults.standard.value(forKey: "email") != nil
        {
            if Connectivity.isConnectedToInternet()
            {
                registerforpushnotifi()
            }
        }
        
        
        
    }
    func application(_ application: UIApplication, didFailToRegisterForRemoteNotificationsWithError error: Error) {

            print("i am not available in simulator \(error)")
    }
    func application(_ app: UIApplication, open url: URL, options: [UIApplication.OpenURLOptionsKey : Any] = [:]) -> Bool {
        let sourceApplication = options[UIApplication.OpenURLOptionsKey.sourceApplication] as? String
               let annotation = options[UIApplication.OpenURLOptionsKey.annotation]
        let handledFB = FBSDKCoreKit.ApplicationDelegate.shared.application(app, open: url, options: options)
        let handledGoogle = (GIDSignIn.sharedInstance()?.handle(url))!
       // let handledGoogle = GIDSignIn.sharedInstance().handle(url, sourceApplication: sourceApplication, annotation: annotation)
        return handledFB || handledGoogle
    }
  
    func application(_ application: UIApplication, open url: URL, sourceApplication: String?, annotation: Any) -> Bool {
      
       let handledFB = FBSDKCoreKit.ApplicationDelegate.shared.application(application, open: url, sourceApplication: sourceApplication, annotation: annotation)
        let handledGoogle = GIDSignIn.sharedInstance()?.handle(url)
      // let handledGoogle = GIDSignIn.sharedInstance().handle(url, sourceApplication: sourceApplication, annotation: annotation)
        
        return handledFB || handledGoogle!
       //  return   handledGoogle
     }
  
   /*
    func application(_ app: UIApplication, open url: URL, options: [UIApplication.OpenURLOptionsKey : Any] = [:]) -> Bool {
        let sourceApplication = options[UIApplication.OpenURLOptionsKey.sourceApplication] as? String
        let annotation = options[UIApplication.OpenURLOptionsKey.annotation]
         let handledFB = FBSDKCoreKit.ApplicationDelegate.shared.application(app, open: url, options: options)
        let handledGoogle = GIDSignIn.sharedInstance().handle(url, sourceApplication: sourceApplication, annotation: annotation)
         return handledFB || handledGoogle
 //    return   handledGoogle
    }
    */
    func checkLogged()
       {
       
           if UserDefaults.standard.value(forKey: "email") != nil
           {
            /*
            if UIDevice.current.userInterfaceIdiom == .pad
            {
                /*
                 let mainStoryboard = UIStoryboard(name: "MainIpad", bundle: Bundle.main)
                 let vc : UITabBarController = mainStoryboard.instantiateViewController(withIdentifier: "TabBarVC") as! UITabBarController
                 let share = UIApplication.shared.delegate as? AppDelegate
                          
                    share?.window?.rootViewController = vc
                    share?.window?.makeKeyAndVisible()
                */
            }
            else if UIDevice.current.userInterfaceIdiom == .phone
            {
                */
           // "userId": "6825993", "AccessToken": "MjUzLTg1REFXMlMzLUFEU1M1RC1FSTVCNkFTVEhCMTk4NjY4MjU5OTM="
            let userid = ""
            let AccessToken = "MjUzLTg1REFXMlMzLUFEU1M1RC1FSTVCNkFTVEhCMTk4NjY4MjU5OTM="
           UserDefaults.standard.set("6825993", forKey: "id")
          // UserDefaults.standard.set("\(AccessToken)", forKey: "AccessToken")
           
                 let mainStoryboard = UIStoryboard(name: "Main", bundle: Bundle.main)
                 let vc : UITabBarController = mainStoryboard.instantiateViewController(withIdentifier: "TabBarVC") as! UITabBarController
                 let share = UIApplication.shared.delegate as? AppDelegate
                          
                    share?.window?.rootViewController = vc
                    share?.window?.makeKeyAndVisible()
         //   }
       // }
    }
    }
      
      func registerforpushnotifi()
      {
         guard let parameters =
             [
                "display_name" : UserDefaults.standard.string(forKey: "display_name") ?? "",
                "email" : UserDefaults.standard.string(forKey: "email") ?? "",
                 "deviceType" : "I",
                 "deviceTokenId" :DeviceToken,
                 "deviceId" : DevideId,
                 "userId":UserDefaults.standard.string(forKey: "id") ?? "",
                 "image":UserDefaults.standard.string(forKey: "profile_image") ?? "",
                 "longitude":UserDefaults.standard.string(forKey: "Longitude"),
                 "latitude":UserDefaults.standard.string(forKey: "Latitude")
                 ] as? [String:Any] else { return  }
           
        let url:URL = URL(string: "https://bigfantv.funasia.net/service/registerDeviceToken.html")!
             
              
            manager.request(url, method: .post, parameters: parameters, encoding: JSONEncoding.default, headers: nil).responseJSON { (response) in
          print(response)
                 switch response.result
                 {

            
                 case .success(_):
                
                     if response.value != nil
                     {
                        do
                         {
                            let decoder = JSONDecoder()
                            let data = try decoder.decode(registerDeviceToken.self, from: response.data ?? Data())
                            
                            if data.success == 1
                            {
                                print(data.AccessToken)
                                UserDefaults.standard.set("\(data.AccessToken ?? "")", forKey: "AccessToken")
                            }
                            
                         }
                         catch let error
                         {
                            print(error.localizedDescription)
                         }
                 }
                 break
             case .failure(let error):
                 print(error)
                 break
             }
         }
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
  
  func application(_ application: UIApplication, supportedInterfaceOrientationsFor window: UIWindow?) -> UIInterfaceOrientationMask
  {
        if UIDevice.current.userInterfaceIdiom == .pad
        {
           return .portrait
        }
        else if UIDevice.current.userInterfaceIdiom == .phone
        {
            return .portrait
        }
        return UIInterfaceOrientationMask()
  
  }
}

