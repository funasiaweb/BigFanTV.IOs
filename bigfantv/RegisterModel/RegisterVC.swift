//
//  RegisterVC.swift
//  bigfantv
//
//  Created by Ganesh on 07/07/20.
//  Copyright © 2020 Ganesh. All rights reserved.
//

import UIKit
import Alamofire
import SwiftyJSON
import MaterialComponents.MDCButton
import  MaterialComponents.MDCActivityIndicator
class RegisterVC: UIViewController {

    @IBOutlet var TfName: UITextField!
    @IBOutlet var TfEmail: UITextField!
    @IBOutlet var TfPassword: UITextField!
    @IBOutlet var TfPassword2: UITextField!
   
    
    @IBOutlet var VEmail: CardView!
    @IBOutlet var ScrollV: UIScrollView!
    
    @IBOutlet var ActivityInd: UIActivityIndicatorView!
    
      var activeField: UITextField?
      var IsEmailexists = true
    
    @IBOutlet var LbError: UILabel!
    
    @IBOutlet var BtRegister: MDCButton!
    override func viewDidLoad() {
        super.viewDidLoad()
    
        // To make the activity indicator appear:
         
        registerForKeyboardNotifications()
        
        TfName.delegate  = self
        TfEmail.delegate = self
        TfPassword.delegate = self
        TfPassword2.delegate  = self
       
        TfName.returnKeyType = .next
        TfEmail.returnKeyType = .next
        TfPassword.returnKeyType = .next
        TfPassword2.returnKeyType = .done
        
        LbError.isHidden = true
        
        IsEmailexists = true
        ActivityInd.isHidden = true
        
    }
    override func viewWillAppear(_ animated: Bool) {
     
    }
    override func viewDidAppear(_ animated: Bool) {
      
        BtRegister.layer.cornerRadius = BtRegister.frame.size.height / 2
        BtRegister.layer.borderColor = UIColor.clear.cgColor
        BtRegister.layer.borderWidth = 0.2
        
        
        let paddingView = UIView(frame: CGRect(origin: CGPoint(x: 0,y :0), size: CGSize(width: 20, height: 50)))
            TfName.leftView = paddingView
            TfName.leftViewMode = UITextField.ViewMode.always
            
        let paddingView1 = UIView(frame: CGRect(origin: CGPoint(x: 0,y :0), size: CGSize(width: 20, height: 50)))
        TfEmail.leftView = paddingView1
        TfEmail.leftViewMode = UITextField.ViewMode.always
       
        let paddingView22 = UIView(frame: CGRect(origin: CGPoint(x: 0,y :0), size: CGSize(width: 20, height: 50)))
        TfPassword.leftView = paddingView22
        TfPassword.leftViewMode = UITextField.ViewMode.always
        
        let paddingView13 = UIView(frame: CGRect(origin: CGPoint(x: 0,y :0), size: CGSize(width: 20, height: 50)))
        TfPassword2.leftView = paddingView13
        TfPassword2.leftViewMode = UITextField.ViewMode.always
    
        TfName.attributedPlaceholder = NSAttributedString(string: "Enter your Name",
        attributes: [NSAttributedString.Key.foregroundColor:Appcolor.textcolor])
        TfEmail.attributedPlaceholder = NSAttributedString(string: "Enter your Email",
        attributes: [NSAttributedString.Key.foregroundColor:Appcolor.textcolor])
        TfPassword.attributedPlaceholder = NSAttributedString(string: "Enter Password",
        attributes: [NSAttributedString.Key.foregroundColor:Appcolor.textcolor])
        TfPassword2.attributedPlaceholder = NSAttributedString(string: "Confirm Password",
        attributes: [NSAttributedString.Key.foregroundColor:Appcolor.textcolor])
        
     
     let viewright = UIView(frame: CGRect(x:  0, y: 0, width: 50,height: 30))
                            viewright.backgroundColor = UIColor.clear
     let  button4 = UIButton(frame: CGRect(x: 0,y: 0, width: 30, height: 30))
          button4.setImage(UIImage(named: "backarrow"), for: UIControl.State.normal)
          button4.setTitle("close", for: .normal)
          button4.addTarget(self, action: #selector(close), for: UIControl.Event.touchUpInside)
    
        viewright.addSubview(button4)
                    
        let leftbuttton = UIBarButtonItem(customView: viewright)
         self.navigationItem.leftBarButtonItem = leftbuttton
               }
               @objc func close()
               {
                   self.dismiss(animated: true, completion: nil)
               }
 
    @IBAction func RegisterBtTapped(_ sender: MDCButton)
    {
        if Connectivity.isConnectedToInternet()
        {
          checkforregister()
        }else
        {
            Utility.Internetconnection(vc: self)
        }
        
    }
    func checkforregister()
    {
        if TfName.text?.isEmpty ?? false
            {
                self.view.makeToast("Please enter Name")
            }
            else if TfEmail.text?.isEmpty ?? false
            {
                self.view.makeToast("Please enter Email")
            }
            else if TfPassword.text?.isEmpty ?? false
            {
                self.view.makeToast("Please enter password")
            }
            else if TfPassword2.text?.isEmpty ?? false
            {
                self.view.makeToast("Please enter password")
            }
            else if TfPassword2.text != TfPassword.text
            {
                self.view.makeToast("Passwords do not match")
            }
            else if TfPassword2.text?.count ?? 0 < 6 || TfPassword.text?.count ?? 0 < 6
            {
                self.view.makeToast("Passwords must more than 6 letters")
            }
            else
            {
                guard isValidEmail(testStr: TfEmail.text ?? "")else {
                     
                    view.makeToast("Please enter proper Email Address")
                    return
                }
                if Connectivity.isConnectedToInternet()
                {
                    checkFinalemailexistance()
                }else
                {
                    Utility.Internetconnection(vc: self)
                }
               
            }
    }
    func checkFinalemailexistance()
     {
          
        
         let url = Configurator.baseURL + ApiEndPoints.CheckEmailExistance
         let parameters = [
                  "authToken":Keycenter.authToken,
                  "email":TfEmail.text ?? "",
                ] as? [String:Any]
        
        
        
            let manager = Alamofire.Session.default
            manager.session.configuration.timeoutIntervalForRequest = 20

            manager.request(url, method: .post, parameters: parameters)
                    .responseJSON {
                        response in
                        switch (response.result)
                        {
                        case .success:
                       guard let swiftyJsonVar = JSON(response.value!) as? JSON else {return}
                                                        
                                                        
                                                        if swiftyJsonVar["isExists"].int == 0
                                                        {
                                                           if Connectivity.isConnectedToInternet()
                                                           {
                                                               self.registerUser()
                                                           }else
                                                           {
                                                               Utility.Internetconnection(vc: self)
                                                           }
                                                          
                                                        }
                                                        else if swiftyJsonVar["isExists"].int == 1
                                                        {
                                                            self.IsEmailexists = true
                                                            self.LbError.text = "Email already exists"
                                                            self.LbError.isHidden = false
                                                            self.VEmail.layer.borderColor = UIColor.red.cgColor
                                                       
                                                        }
                            break
                        case .failure(let error):
                            Utility.hideLoader()
                            if error._code == NSURLErrorTimedOut {
                                print("Request timeout!")
                            }
                        }
                    }
        
       
     }
    func checkemailexistance()
    {
         
        ActivityInd.isHidden = false
        ActivityInd.startAnimating()
        let url = Configurator.baseURL + ApiEndPoints.CheckEmailExistance
        let parameters = [
                 "authToken":Keycenter.authToken,
                 "email":TfEmail.text ?? "",
               ] as? [String:Any]
                  
        let manager = Alamofire.Session.default
            manager.session.configuration.timeoutIntervalForRequest = 20

            manager.request(url, method: .post, parameters: parameters)  .responseJSON {
                              response in
                             
                switch (response.result)
                  {
                              case .success:
                          if let json = response.value
                                                       {
                                                          // successHandler((json as! [String:AnyObject]))
                                                        guard let swiftyJsonVar = JSON(response.value!) as? JSON else {return}
                                                        
                                                        
                                                        if swiftyJsonVar["isExists"].int == 0
                                                        {
                                                            
                                                            self.IsEmailexists = false
                                                            self.TfEmail.resignFirstResponder()
                                                            self.TfPassword.becomeFirstResponder()
                                                            self.LbError.isHidden = true
                                                            self.VEmail.layer.borderColor = Appcolor.textBordercolor.cgColor
                                                        }
                                                        else if swiftyJsonVar["isExists"].int == 1
                                                        {
                                                            self.IsEmailexists = true
                                                            self.LbError.text = "Email already exists"
                                                            self.LbError.isHidden = false
                                                            self.VEmail.layer.borderColor = UIColor.red.cgColor
                                                       
                                                        }
                                                        self.ActivityInd.isHidden = true
                                                        self.ActivityInd.stopAnimating()
                                                        print("succesfull")
                                                         
                                                       }
                                                       
                                                       break
                              case .failure(let error):
                                  Utility.hideLoader()
                                  if error._code == NSURLErrorTimedOut {
                                      print("Request timeout!")
                                  }
                              }
                          }
         
    }
    
    func registerUser()
    {
        Utility.ShowLoader()
        let url = Configurator.baseURL + ApiEndPoints.Register
        
        let parameters = [
            "authToken":Keycenter.authToken,
            "name":TfName.text ?? "",
            "email":TfEmail.text ?? "",
            "password":TfPassword.text ?? ""
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
                                                   
                                                   UserDefaults.standard.set(swiftyJsonVar["email"].description, forKey: "email")
                                                   UserDefaults.standard.set(swiftyJsonVar["id"].description, forKey: "id")
                                                   UserDefaults.standard.set(swiftyJsonVar["profile_image"].description, forKey: "profile_image")
                                                   UserDefaults.standard.set(swiftyJsonVar["studio_id"].description, forKey: "studio_id")
                                                   
                                                   Utility.hideLoader()
                                                   self.dismiss(animated: true, completion: nil)
                                                  }
                                                  
                                                  break
                             case .failure(let error):
                                 Utility.hideLoader()
                                 if error._code == NSURLErrorTimedOut {
                                     print("Request timeout!")
                                 }
                             }
                         }
             }
}

extension RegisterVC:UITextFieldDelegate
{
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        if textField == TfName
        {
            TfName.resignFirstResponder()
            TfEmail.becomeFirstResponder()
        }else if textField == TfEmail && !(TfEmail.text?.isEmpty ?? false)
        {
            //TfEmail.resignFirstResponder()
            guard isValidEmail(testStr: TfEmail.text ?? "")else
            {       //view.makeToast("Please enter proper Email Address")
                self.LbError.isHidden = false
                self.VEmail.layer.borderColor = UIColor.red.cgColor
                LbError.text = "Please enter proper Email address"
                return false
            }
            if Connectivity.isConnectedToInternet()
            {
            checkemailexistance()
            }else
            {
                Utility.Internetconnection(vc: self)
            }
        }else if textField == TfPassword
        {
            TfPassword.resignFirstResponder()
            TfPassword2.becomeFirstResponder()
        }else if textField == TfPassword2
        {
            TfPassword2.resignFirstResponder()
            checkforregister()
        }
        
        return true
    }
}
extension RegisterVC
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
                VEmail.layer.borderColor = UIColor.clear.cgColor
                LbError.isHidden = true
                activeField = textField
              
            }

        func textFieldDidEndEditing(_ textField: UITextField)
            {
            
                activeField = nil
                 
            }
}
