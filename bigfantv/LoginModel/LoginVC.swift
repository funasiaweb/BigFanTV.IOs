//
//  LoginVC.swift
//  bigfantv
//
//  Created by Ganesh on 07/07/20.
//  Copyright © 2020 Ganesh. All rights reserved.
//

import UIKit
import Alamofire
import SwiftyJSON
import MaterialComponents.MDCButton
import GoogleSignIn
import FBSDKLoginKit
import DTTextField
import FirebaseFirestore
import CoreLocation

class LoginVC: UIViewController {
       let manager: Alamofire.SessionManager = {
        let configuration = URLSessionConfiguration.default
         configuration.timeoutIntervalForRequest = TimeInterval(60)
        configuration.timeoutIntervalForResource = TimeInterval(60)
        return  Alamofire.SessionManager(configuration: configuration)
    }()
    static var isfromLogin = true
    var IsPassword1 = false
    
    
    var activeField: UITextField?
    @IBOutlet var TfEmail: UITextField!
    
    @IBOutlet var TfPassword: UITextField!
    
    @IBOutlet var ScrollV: UIScrollView!
    
    @IBOutlet var BtLogin: MDCButton!
    
    @IBOutlet var ViLogin: UIView!
    
    @IBOutlet var LbOr: UILabel!
    
    @IBOutlet var ViGoogle: UIView!
    
    @IBOutlet var ViFb: UIView!
    
    
    
    @IBOutlet var ViEmail: CardView!
    
    @IBOutlet var Errpass: UILabel!
    @IBOutlet var ErrEmail: UILabel!
    @IBOutlet var ViPassword: CardView!
    
    @IBOutlet var BtPassword1: UIButton!
    
    var googlelogindata:GoogleLogin?
    var facebookdata:FacebookLogin?
    var logindetails:LoginData?
    override func viewDidLoad() {
        super.viewDidLoad()

         
        TfEmail.attributedPlaceholder = NSAttributedString(string: "Enter your Email",
               attributes: [NSAttributedString.Key.foregroundColor:Appcolor.textcolor])
         
        TfPassword.attributedPlaceholder = NSAttributedString(string: "Enter Password",
               attributes: [NSAttributedString.Key.foregroundColor:Appcolor.textcolor])
        
        registerForKeyboardNotifications()
         
         
         TfEmail.delegate = self
         TfPassword.delegate = self
         
        
          
         TfEmail.returnKeyType = .next
         TfPassword.returnKeyType = .next
          
        
    }
    override func viewWillAppear(_ animated: Bool)
    {
          ErrEmail.isHidden  = true
          Errpass.isHidden = true
    }
    override func viewDidAppear(_ animated: Bool) {
         
         //   TfEmail.text = "ashishpatil9292@gmail.com"
     
         //  TfPassword.text = "123456"
         //GIDSignIn.sharedInstance().signOut()
        BtLogin.layer.cornerRadius = BtLogin.frame.size.height / 2
        BtLogin.layer.borderColor = UIColor.clear.cgColor
        BtLogin.layer.borderWidth = 0.2
        
               let paddingView22 = UIView(frame: CGRect(origin: CGPoint(x: 0,y :0), size: CGSize(width: 20, height: 50)))
               TfPassword.leftView = paddingView22
               TfPassword.leftViewMode = UITextField.ViewMode.always
               
               let paddingView13 = UIView(frame: CGRect(origin: CGPoint(x: 0,y :0), size: CGSize(width: 20, height: 50)))
               TfEmail.leftView = paddingView13
               TfEmail.leftViewMode = UITextField.ViewMode.always
           
               TfPassword.attributedPlaceholder = NSAttributedString(string: "Enter your Password",
               attributes: [NSAttributedString.Key.foregroundColor:Appcolor.textcolor])
               TfEmail.attributedPlaceholder = NSAttributedString(string: "Enter your Email",
               attributes: [NSAttributedString.Key.foregroundColor:Appcolor.textcolor])
      /*
              let googlesgninbutton = GIDSignInButton()
               //  googlesgninbutton.frame = CGRect(x:0 , y: 0  , width: ViGoogle.frame.size.width, height: 30)
               //   ViGoogle.addSubview(googlesgninbutton)
        
       
              let frame = BtLogin.frame
           
            //  googlesgninbutton.frame.origin.x = frame.origin.x
            //  googlesgninbutton.frame.minY = LbOr.frame.maxY + 20
            //  googlesgninbutton.frame.minY
             // googlesgninbutton.frame.size.width = BtLogin.frame.size.width
              //googlesgninbutton.frame.size.height = BtLogin.frame.size.height
              
            //  googlesgninbutton.frame = CGRect(x: loginButton.frame.origin.x , y: loginButton.frame.origin.y +  loginButton.frame.size.height + 50  , width: loginButton.frame.size.width, height: 50)
        
              googlesgninbutton.translatesAutoresizingMaskIntoConstraints = false
            // ViGoogle.addSubview(googlesgninbutton)
        
        googlesgninbutton.leadingAnchor.constraint(equalTo: ViGoogle.leadingAnchor, constant: 0).isActive = true
        googlesgninbutton.widthAnchor.constraint(equalTo: ViGoogle.widthAnchor , constant: 0).isActive = true
         googlesgninbutton.heightAnchor.constraint(equalTo: ViGoogle.heightAnchor , constant: 10).isActive = true
      //  googlesgninbutton.widthAnchor.constraint(equalTo: BtLogin.frame..widtsizeh , multiplier: <#T##CGFloat#>, constant: <#T##CGFloat#>)
         googlesgninbutton.topAnchor.constraint(equalTo: ViGoogle.topAnchor, constant: 0).isActive = true
         //googlesgninbutton.heightAnchor.constraint(equalToConstant: 20).isActive = true
        
              
              view.layoutIfNeeded()
             
      //  GIDSignIn.sharedInstance().pre = self
              GIDSignIn.sharedInstance()?.delegate  = self
              GIDSignIn.sharedInstance()?.presentingViewController = self

        */
/*
      
        let loginButton = FBLoginButton()
        //loginButton.frame = CGRect(x:0 , y: 0  , width: ViFb.frame.size.width, height: googlesgninbutton.frame.size.height)
        //ViFb.addSubview(loginButton)
     //   loginButton.delegate = self
      //  loginButton.tooltipColorStyle = .neutralGray
        loginButton.isUserInteractionEnabled = true
        loginButton.tooltipColorStyle = .friendlyBlue
        loginButton.permissions = ["public_profile", "email"]
        loginButton.delegate = self
        
       loginButton.translatesAutoresizingMaskIntoConstraints = false
          //   ViFb.addSubview(loginButton)
        loginButton.leadingAnchor.constraint(equalTo: ViFb.leadingAnchor, constant: 0).isActive = true
        
        loginButton.widthAnchor.constraint(equalTo: ViFb.widthAnchor, constant: 0).isActive = true
        loginButton.topAnchor.constraint(equalTo: ViFb.topAnchor, constant: 4).isActive = true
         loginButton.heightAnchor.constraint(equalTo: ViFb.heightAnchor, constant: 5).isActive = true
        */
        //702741550448367
         
    }
    
    func Tolog()
    {
        if TfEmail.text?.isEmpty ?? false
        {
           // view.makeToast("Please enter youe Email.")
            HideALL(viewa: ViEmail, Label: ErrEmail, message: "Email required.")
            
        }
        else if TfPassword.text?.isEmpty ?? false
        {
            HideALL(viewa: ViPassword, Label: Errpass, message: "Password required.")
        }else
        {
            guard isValidEmail(testStr: TfEmail.text ?? "") else {
                HideALL(viewa: ViEmail, Label: ErrEmail, message: "Enter valid email")
           return
                
            }
            HideconfirmALL()
            if Connectivity.isConnectedToInternet()
            {
              getlogged()
            }else
            {
                Utility.Internetconnection(vc: self)
            }
        }
    }
    func HideALL(viewa:CardView,Label:UILabel,message:String)
    {
        Errpass.isHidden = true
        ErrEmail.isHidden  = true
        ViPassword.layer.borderColor = Appcolor.textBordercolor.cgColor
        ViEmail.layer.borderColor = Appcolor.textBordercolor.cgColor
        
         
        viewa.layer.borderColor = UIColor.red.cgColor
        Label.isHidden  = false
         viewa.isHidden = false
        Label.text = message
        
        
        
        
    }
    func HideconfirmALL()
      {
          Errpass.isHidden = true
          ErrEmail.isHidden  = true
          ViPassword.layer.borderColor = Appcolor.textBordercolor.cgColor
          ViEmail.layer.borderColor = Appcolor.textBordercolor.cgColor
      
      }
    @IBAction func BtLoginTapped(_ sender: MDCButton) {
        if Connectivity.isConnectedToInternet()
        {
            TfPassword.resignFirstResponder()
             Tolog()
            
        }else
        {
            Utility.Internetconnection(vc: self)
        }
        
    }
    
    @IBAction func BtPasswordTapped(_ sender: UIButton)
      {
        if IsPassword1 == true
        {
            BtPassword1.setBackgroundImage(UIImage(named: "eyenew"), for: .normal)
            TfPassword.isSecureTextEntry = true
            IsPassword1 = false
        }else
        {
            BtPassword1.setBackgroundImage(UIImage(named: "hidenew"), for: .normal)
            TfPassword.isSecureTextEntry = false
            IsPassword1 = true
        }
        
    }
    
    func getlogged()
    {
        Utility.ShowLoader(vc: self)
        Api.Login(email: TfEmail.text ?? "", password: TfPassword.text ?? "", endpoint: ApiEndPoints.login, vc: self) { (res, err) -> (Void) in
            
                                
            do
             {
                
            
                Utility.hideLoader(vc: self)
                let decoder = JSONDecoder()
                self.logindetails = try decoder.decode(LoginData.self, from: res  ?? Data())
                
                if self.logindetails?.status == "OK"

                {
                    UserDefaults.standard.set(self.logindetails?.email, forKey: "email")
                    UserDefaults.standard.set(self.logindetails?.id, forKey: "id")
                    UserDefaults.standard.set(self.logindetails?.display_name, forKey: "display_name")
                    UserDefaults.standard.set("\(self.logindetails?.profile_image ?? "")", forKey: "profile_image")
                     
                    if Connectivity.isConnectedToInternet()
                    {
                        self.registerforpushnotifi()
                    }
                    if self.logindetails?.isSubscribed == 0
                    {
                        UserDefaults.standard.set(false, forKey: "isSubscribed")
                    }else if self.logindetails?.isSubscribed == 1
                    {
                        UserDefaults.standard.set(true, forKey: "isSubscribed")
                    }
                                                    LoginVC.isfromLogin = false

                }else
                {
                    Utility.showAlert(vc: self, message: "", titelstring: self.logindetails?.msg ?? "")
                }
                
             }
            catch let error
            {
                Utility.hideLoader(vc: self)
                Utility.showAlert(vc: self, message:"\(error)", titelstring: Appcommon.Appname)
            }
            
        }
        /*
        let url = Configurator.baseURL + ApiEndPoints.login
        let parameters = [
                 "authToken":Keycenter.authToken,
                 "email":TfEmail.text ?? "",
                 "password" : TfPassword.text ?? ""
               ] as? [String:Any]
        
        let manager = Alamofire.SessionManager.default
        manager.session.configuration.timeoutIntervalForRequest = 2000
 
        manager.request(url, method: .post, parameters: parameters)
                .responseJSON {
                    response in
                    switch (response.result)
                    {
                    case .success:
                        if let json = response.value
                                           {
                                              // successHandler((json as! [String:AnyObject]))
            guard let swiftyJsonVar = JSON(response.value!) as? JSON else {return}
             
            if swiftyJsonVar["status"].description == "failure"
            {
                  Utility.hideLoader(vc: self)
                Utility.showAlert(vc: self, message: swiftyJsonVar["msg"].description, titelstring: "BigFan TV")
            }
            else if swiftyJsonVar["status"].description == "OK"
            {
                 Utility.hideLoader(vc: self)
               
                UserDefaults.standard.set("\(swiftyJsonVar["email"].description)", forKey: "email")
                UserDefaults.standard.set("\(swiftyJsonVar["id"].description)", forKey: "id")
                UserDefaults.standard.set("\(swiftyJsonVar["display_name"].description)", forKey: "display_name")
             //   UserDefaults.standard.set(swiftyJsonVar["id"].description, forKey: "id")
                LoginVC.isfromLogin = false
                guard let userid = UserDefaults.standard.string(forKey: "id")  else {return}
                         let docRef = Firestore.firestore().collection("UserLanguagepreference").document(userid)

                            docRef.getDocument { (document, error) in
                             if let err = error
                             {
                                   print("Error fetch document: \(err)")
                             }
                             else {
         guard let data = document?.data() else {
             self.performSegue(withIdentifier: "toaddreference", sender: self)
          
                                     return}
             self.performSegue(withIdentifier: "tomaintab", sender: self)
           
                              
                                
                                }
                            
                             
                             
                            }
                
                
            }
                                           
                                           }
                                           
                                           break // succes path
                    case .failure(let error):
                        Utility.hideLoader(vc: self)
                        if error._code == NSURLErrorTimedOut {
                            print("Request timeout!")
                        }
                    }
                }
        */
        /*
        AF.request(url, method: .post, parameters: parameters,encoding: JSONEncoding.default, headers: nil).responseJSON {
            response in
        print(response)
                switch response.result {

                       case .success(_):
                           if let json = response.value
                           {
                              // successHandler((json as! [String:AnyObject]))
                            guard let swiftyJsonVar = JSON(response.value!) as? JSON else {return}
                             
                            if swiftyJsonVar["status"].description == "failure"
                            {
                                 Utility.hideLoader()
                                Utility.showAlert(vc: self, message: swiftyJsonVar["msg"].description, titelstring: "BigFan TV")
                            }else if swiftyJsonVar["status"].description == "OK"
                            {
                                 Utility.hideLoader()
                                UserDefaults.standard.set(swiftyJsonVar["email"].description, forKey: "email")
                                self.performSegue(withIdentifier: "tabbarcontroll", sender: self)
                            }
                           
                           }
                           
                           break
                       case .failure(let error):
                       
                        
                        print("failed==\(error.errorDescription ?? "")")
                        Utility.hideLoader()
                           break
                       }
            
            
        }
        */
    }
    func registerforpushnotifi()
    {
        Utility.ShowLoader(vc: self)


       guard let parameters =
           [
              "display_name" : UserDefaults.standard.string(forKey: "display_name") ?? "",
              "email" : UserDefaults.standard.string(forKey: "email") ?? "",
              "deviceType" : "I",
              "deviceTokenId" :UserDefaults.standard.string(forKey: "devicetoken") ?? "",
              "deviceId" : UserDefaults.standard.string(forKey: "deviceid") ?? "",
              "userId": UserDefaults.standard.string(forKey: "id") ?? "",
              "image": UserDefaults.standard.string(forKey: "profile_image") ?? ""
            ] as? [String:Any] else { return  }
         print(parameters)
      let url:URL = URL(string: "https://funasia.net/bigfantv.funasia.net/service/registerDeviceToken.html")!
          
        manager.request(url, method: .post, parameters: parameters, encoding: JSONEncoding.default, headers: nil).responseJSON { (response) in
        //print("register response \(response)")
          
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
                            UserDefaults.standard.set("\(data.AccessToken ?? "")", forKey: "AccessToken")
                           
                            UserDefaults.standard.set(true, forKey: "isLoggedin")
                            
                            guard let userid = UserDefaults.standard.string(forKey: "id")  else {return}
                            
                            let docRef = Firestore.firestore().collection("UserLanguagepreference").document(userid)

                            docRef.getDocument { (document, error) in
                                                
                                if let err = error
                                {
                                    print("Error fetch document: \(err)")
                                }
                                else
                                {
                                    guard let data = document?.data() else {
                                
                                                       // self.performSegue(withIdentifier: "toaddreference", sender: self)
                             
                                        let storyBoard: UIStoryboard = UIStoryboard(name: "Main", bundle: nil)
                                        let VC1 = storyBoard.instantiateViewController(withIdentifier: "Newlang") as! Newlang
                                        let navController = UINavigationController(rootViewController: VC1) // Creating a navigation controller with VC1 at the root of the navigation stack.
                                        navController.navigationBar.barTintColor = Appcolor.backgorund3
                                        navController.modalPresentationStyle = .fullScreen
                                        let textAttributes = [NSAttributedString.Key.foregroundColor:UIColor.white,NSAttributedString.Key.font: UIFont(name: "Muli-ExtraBold", size: 19)!]
                                        navController.navigationBar.titleTextAttributes = textAttributes
                                        self.present(navController, animated:true, completion: nil)

                                        return
                                        
                                    }
                                         
                                    let mainStoryboard = UIStoryboard(name: "Main", bundle: Bundle.main)
                                    let vc : UITabBarController = mainStoryboard.instantiateViewController(withIdentifier: "TabBarVC") as! UITabBarController
                                    let share = UIApplication.shared.delegate as? AppDelegate
                                                       
                                    share?.window?.rootViewController = vc
                                    share?.window?.makeKeyAndVisible()
                                
                                }
                                
                            }
                          
                          }
                          
                       }
                       catch let error
                       {
                        Utility.showAlert(vc:self , message: "\(error.localizedDescription)", titelstring: "")
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
    private func customClassGetDocument() {
               // [START custom_type]
        
         
            guard let userid = UserDefaults.standard.value(forKey: "id")as? String  else {return}
            let docRef = Firestore.firestore().collection("UserLanguagepreference").document(userid)

               docRef.getDocument { (document, error) in
                if let err = error
                {
                      print("Error fetch document: \(err)")
                }
                else {
                    guard let data = document?.data() else {
                        
                        return}
                     
                 
                   
                   }
               
                
                
               }

    }
    override var prefersStatusBarHidden: Bool
        {
        return true
    }
}
extension LoginVC:UITextFieldDelegate
{
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        if textField == TfEmail
        {
             guard isValidEmail(testStr: TfEmail.text ?? "") else {
                           HideALL(viewa: ViEmail, Label: ErrEmail, message: "Enter valid email")
                      return false
                           
                       }
            HideconfirmALL()
            TfEmail.resignFirstResponder()
            TfPassword.becomeFirstResponder()
            
            
        }else if textField == TfPassword
        {
            TfPassword.resignFirstResponder()
            Tolog()
        }
        
        return true
    }
}
extension LoginVC
{
    func isValidEmail(testStr:String) -> Bool
    {
        let emailRegex = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,64}"
        let emailTest = NSPredicate(format: "SELF MATCHES %@", emailRegex)
        return emailTest.evaluate(with: testStr)
        
    }
    
     func registerForKeyboardNotifications()
            {
                //Adding notifies on keyboard appearing
                NotificationCenter.default.addObserver(self, selector: #selector(keyboardWasShown(notification:)), name: UIResponder.keyboardWillShowNotification, object: nil)
                NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillBeHidden(notification:)), name: UIResponder.keyboardWillHideNotification, object: nil)
            }


            func deregisterFromKeyboardNotifications()
            {
                //Removing notifies on keyboard appearing
                NotificationCenter.default.removeObserver(self, name: UIResponder.keyboardWillShowNotification, object: nil)
                NotificationCenter.default.removeObserver(self, name: UIResponder.keyboardWillHideNotification, object: nil)
            }

        @objc func keyboardWasShown(notification: NSNotification)
            {
                print("notified")
                //Need to calculate keyboard exact size due to Apple suggestions
                self.ScrollV.isScrollEnabled = true
                let info : NSDictionary = notification.userInfo! as NSDictionary
                let keyboardSize = (info[UIResponder.keyboardFrameBeginUserInfoKey] as? NSValue)?.cgRectValue.size
                let contentInsets : UIEdgeInsets = UIEdgeInsets(top: 0.0, left: 0.0, bottom: keyboardSize!.height + 60, right: 0.0)

                self.ScrollV.contentInset = contentInsets
                self.ScrollV.scrollIndicatorInsets = contentInsets

                var aRect : CGRect = self.view.frame
                aRect.size.height -= keyboardSize!.height
             if (activeField) != nil
                {
                    if (!aRect.contains((activeField?.frame.origin)!))
                    {
                        self.ScrollV.scrollRectToVisible(activeField!.frame, animated: true)
                    }
                }


            }


        @objc func keyboardWillBeHidden(notification: NSNotification)
            {
                
                //Once keyboard disappears, restore original positions
                let info : NSDictionary = notification.userInfo! as NSDictionary
             let keyboardSize = (info[UIResponder.keyboardFrameBeginUserInfoKey] as? NSValue)?.cgRectValue.size
                let contentInsets : UIEdgeInsets = UIEdgeInsets(top: 0.0, left: 0.0, bottom: -keyboardSize!.height - 50, right: 0.0)
                self.ScrollV.contentInset = contentInsets
                self.ScrollV.scrollIndicatorInsets = contentInsets
                self.view.endEditing(true)
                self.ScrollV.isScrollEnabled = false

            }

        private func textFieldDidBeginEditing(textField: UITextField!)
            {
                 HideconfirmALL()
                activeField = textField
              
            }

        func textFieldDidEndEditing(_ textField: UITextField)
            {
            
                activeField = nil
                 
            }
    
    
    func loginWithGoogle(emai:String,name:String,googleid:String)
    {
        Api.LoginWithGoogle(email: emai, name: name, gplus_userid: googleid, endpoint: ApiEndPoints.SocialAuth, vc: self)  { (res, err) -> (Void) in
            do
            {
                 let decoder = JSONDecoder()
                 self.googlelogindata = try decoder.decode(GoogleLogin.self, from: res  ?? Data())
                if self.googlelogindata?.status == "OK"
                {
                    UserDefaults.standard.set("\(self.googlelogindata?.email ?? "")", forKey: "email")
                    UserDefaults.standard.set("\(self.googlelogindata?.id ?? "")", forKey: "id")
                     UserDefaults.standard.set("\(self.googlelogindata?.display_name ?? "")", forKey: "display_name")
                        //   UserDefaults.standard.set(swiftyJsonVar["id"].description, forKey: "id")
                           LoginVC.isfromLogin = false
 
                    if Connectivity.isConnectedToInternet()
                    {
                        self.registerforpushnotifi()
                    }
                }else
                {
                    Utility.showAlert(vc: self, message: self.googlelogindata?.msg ?? "", titelstring: Appcommon.Appname)
                }
                
             }
             catch let error
             {
                 Utility.showAlert(vc: self, message:"\(error)", titelstring: Appcommon.Appname)
             }
                                         }
        
    }
    func loginWithFb(emai:String,name:String,googleid:String)
       {
           Api.LoginWithFb(email: emai, name: name, gplus_userid: googleid, endpoint: ApiEndPoints.SocialAuth, vc: self)  { (res, err) -> (Void) in
               do
               {
                    let decoder = JSONDecoder()
                    self.googlelogindata = try decoder.decode(GoogleLogin.self, from: res  ?? Data())
                   if self.googlelogindata?.status == "OK"
                   {
                    
                       UserDefaults.standard.set("\(self.googlelogindata?.email ?? "")", forKey: "email")
                       UserDefaults.standard.set("\(self.googlelogindata?.id ?? "")", forKey: "id")
                        UserDefaults.standard.set("\(self.googlelogindata?.display_name ?? "")", forKey: "display_name")
                           //   UserDefaults.standard.set(swiftyJsonVar["id"].description, forKey: "id")
      
                    if Connectivity.isConnectedToInternet()
                    {
                        self.registerforpushnotifi()
                    }
                   }else
                   {
                       Utility.showAlert(vc: self, message: self.googlelogindata?.msg ?? "", titelstring: Appcommon.Appname)
                   }
                   
                }
                catch let error
                {
                    Utility.showAlert(vc: self, message:"\(error)", titelstring: Appcommon.Appname)
                }
            
        }
           
       }
}
extension LoginVC:GIDSignInDelegate
    
{
    func sign(_ signIn: GIDSignIn!, didSignInFor user: GIDGoogleUser!,
                 withError error: Error!)
    {
         if let error = error {
           if (error as NSError).code == GIDSignInErrorCode.hasNoAuthInKeychain.rawValue {
             print("The user has not signed in before or they have since signed out.")
           } else {
             print("\(error.localizedDescription)")
           }
           return
         }
        let userId = user.userID ?? ""                  // For client-side use only!
         let idToken = user.authentication.idToken // Safe to send to the server
         let fullName = user.profile.name
         let givenName = user.profile.givenName
         let familyName = user.profile.familyName
         var email = user.profile.email
          
        loginWithGoogle(emai: email ?? "", name: fullName ?? "", googleid: userId)
         
    }
}
 extension LoginVC
 {
    func validateData() -> Bool {
         
         guard !TfEmail.text!.isEmpty else {
             //TfEmail.showError(message: "Please Enter Email")
             return false
         }
         
         guard !TfPassword.text!.isEmpty else {
            // TfPassword.showError(message: "Please Enter Password")
             return false
         }
         
          
         
         return true
     }
}
 
 
extension LoginVC:LoginButtonDelegate
{
    func loginButton(_ loginButton: FBLoginButton, didCompleteWith result: LoginManagerLoginResult?, error: Error?) {
         
        
        if ((error) != nil)
             {
                 // Process error
             }
        else if result?.isCancelled ?? false {
                 // Handle cancellations
             }
             else {
            
            if result?.grantedPermissions.contains("email") ?? false
                 {
                 guard let accessToken = FBSDKLoginKit.AccessToken.current else { return }
                     let graphRequest = FBSDKLoginKit.GraphRequest(graphPath: "me",
                                                                   parameters: ["fields": "id, name, first_name, last_name, picture.type(large), email , gender"],
                                                                   tokenString: accessToken.tokenString,
                                                                   version: nil,
                                                                   httpMethod: .get)
                     graphRequest.start { (connection, result, error) -> Void in
                       if error != nil {
                             // Some error checking here
                         }
                         else if let userData = result as? [String:AnyObject] {

                        print(userData)
                             // Access user data
                        let username = "\(userData["first_name"] as? String ?? "") \(userData["last_name"] as? String ?? "")"
                             
                             let useremail = userData["email"] as? String
                         
                             let userid = userData["id"] as? String
                         
                        self.loginWithFb(emai: useremail ?? "", name: username ?? "", googleid: userid ?? "")
                             // ....
                         }
                     }
                 }
           
             }
       
    }
    
    func loginButtonDidLogOut(_ loginButton: FBLoginButton) {
        
        let loginManager = LoginManager()
         loginManager.logOut()
        print("logout")
    }
    
     
}
 
