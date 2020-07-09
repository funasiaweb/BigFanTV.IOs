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
class LoginVC: UIViewController {

    var activeField: UITextField?
    @IBOutlet var TfEmail: UITextField!
    
    @IBOutlet var TfPassword: UITextField!
    
    @IBOutlet var ScrollV: UIScrollView!
    
    @IBOutlet var BtLogin: MDCButton!
    
    @IBOutlet var ViLogin: UIView!
    
    @IBOutlet var LbOr: UILabel!
    
    @IBOutlet var ViGoogle: UIView!
    
    @IBOutlet var ViFb: UIView!
    
    @IBOutlet var Btfb: FBButton!
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
    
    override func viewDidAppear(_ animated: Bool) {
         
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
             ViGoogle.addSubview(googlesgninbutton)
        
        googlesgninbutton.leadingAnchor.constraint(equalTo: ViGoogle.leadingAnchor, constant: 0).isActive = true
        googlesgninbutton.widthAnchor.constraint(equalTo: ViGoogle.widthAnchor , constant: 0).isActive = true
         googlesgninbutton.heightAnchor.constraint(equalTo: ViGoogle.heightAnchor , constant: 10).isActive = true
      //  googlesgninbutton.widthAnchor.constraint(equalTo: BtLogin.frame..widtsizeh , multiplier: <#T##CGFloat#>, constant: <#T##CGFloat#>)
         googlesgninbutton.topAnchor.constraint(equalTo: ViGoogle.topAnchor, constant: 0).isActive = true
         //googlesgninbutton.heightAnchor.constraint(equalToConstant: 20).isActive = true
        
              
              view.layoutIfNeeded()
             
      //  GIDSignIn.sharedInstance().pre = self
              GIDSignIn.sharedInstance()?.delegate  = self
              GIDSignIn.sharedInstance()?.uiDelegate = self
       
        let loginButton = FBLoginButton()
        //loginButton.frame = CGRect(x:0 , y: 0  , width: ViFb.frame.size.width, height: googlesgninbutton.frame.size.height)
        //ViFb.addSubview(loginButton)
     //   loginButton.delegate = self
      //  loginButton.tooltipColorStyle = .neutralGray
        loginButton.isUserInteractionEnabled = false
       loginButton.translatesAutoresizingMaskIntoConstraints = false
             ViFb.addSubview(loginButton)
        loginButton.leadingAnchor.constraint(equalTo: ViFb.leadingAnchor, constant: 0).isActive = true
        
        loginButton.widthAnchor.constraint(equalTo: ViFb.widthAnchor, constant: 0).isActive = true
        loginButton.topAnchor.constraint(equalTo: ViFb.topAnchor, constant: 4).isActive = true
         loginButton.heightAnchor.constraint(equalTo: ViFb.heightAnchor, constant: 5).isActive = true
        
         
    }
    
    func Tolog()
    {
        if TfEmail.text?.isEmpty ?? false
        {
            view.makeToast("Please enter youe Email.")
        }
        else if TfEmail.text?.isEmpty ?? false
        {
            view.makeToast("Please enter youe Password.")
        }else
        {
            guard isValidEmail(testStr: TfEmail.text ?? "") else {
                view.makeToast("Please enter proper Email.")
           return
                
            }
            if Connectivity.isConnectedToInternet()
            {
            getlogged()
            }else
            {
                Utility.Internetconnection(vc: self)
            }
        }
    }
    
    @IBAction func BtLoginTapped(_ sender: MDCButton) {
        if Connectivity.isConnectedToInternet()
        {
            Tolog()
        }else
        {
            Utility.Internetconnection(vc: self)
        }
        
    }
    
    func getlogged()
    {
        Utility.ShowLoader()
        let url = Configurator.baseURL + ApiEndPoints.login
        let parameters = [
                 "authToken":Keycenter.authToken,
                 "email":TfEmail.text ?? "",
                 "password" : TfPassword.text ?? ""
               ] as? [String:Any]
        
        let manager = Alamofire.Session.default
        manager.session.configuration.timeoutIntervalForRequest = 20

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
                                                 Utility.hideLoader()
                                                Utility.showAlert(vc: self, message: swiftyJsonVar["msg"].description, titelstring: "BigFan TV")
                                            }else if swiftyJsonVar["status"].description == "OK"
                                            {
                                                 Utility.hideLoader()
                                                UserDefaults.standard.set(swiftyJsonVar["email"].description, forKey: "email")
                                                self.performSegue(withIdentifier: "tabbarcontroll", sender: self)
                                            }
                                           
                                           }
                                           
                                           break // succes path
                    case .failure(let error):
                        Utility.hideLoader()
                        if error._code == NSURLErrorTimedOut {
                            print("Request timeout!")
                        }
                    }
                }
        
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
                activeField = textField
              
            }

        func textFieldDidEndEditing(_ textField: UITextField)
            {
            
                activeField = nil
                 
            }
}
extension LoginVC:GIDSignInDelegate,GIDSignInUIDelegate
{
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
         let userId = user.userID                  // For client-side use only!
         let idToken = user.authentication.idToken // Safe to send to the server
         let fullName = user.profile.name
         let givenName = user.profile.givenName
         let familyName = user.profile.familyName
         var email = user.profile.email
         
        print("fullName===\(fullName)")
      
       }
}
