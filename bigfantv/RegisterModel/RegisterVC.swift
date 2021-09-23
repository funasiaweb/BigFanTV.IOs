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
    
    @IBOutlet var BtPassword1: UIButton!
    
    @IBOutlet var BtPassword2: UIButton!
    
    @IBOutlet var VEmail: CardView!
    @IBOutlet var ViName: CardView!
    
    
    @IBOutlet var ViPassword2: CardView!
    @IBOutlet var ViPassword1: CardView!
    
    @IBOutlet var ErrName: UILabel!
    @IBOutlet var ErrPass1: UILabel!
    
    @IBOutlet var Errpass2: UILabel!
    
    @IBOutlet var ScrollV: UIScrollView!
    
    @IBOutlet var ActivityInd: UIActivityIndicatorView!
    
    @IBOutlet var BtEmailexist: UIButton!
    var activeField: UITextField?
      var IsEmailexists = true
    var IsPassword1 = false
    var IsPassword2 = false
    
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
        ErrName.isHidden  = true
        ErrPass1.isHidden  = true
        Errpass2.isHidden  = true
        
        IsEmailexists = true
        ActivityInd.isHidden = true
        
        BtEmailexist.isHidden = true
        
    }
     
    override func viewDidAppear(_ animated: Bool) {
      
        //TfPassword.text = "123456"
       // TfPassword2.text = "123456"
         
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
            HideconfirmALL()
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
                HideALL(viewa: ViName, Label: ErrName, message: "Name required.")
                 
            }
            else if TfEmail.text?.isEmpty ?? false
            {
                 HideALL(viewa: VEmail, Label: LbError, message: "Email required.")
               
            }
            else if TfPassword.text?.isEmpty ?? false
            {
                 HideALL(viewa: ViPassword1, Label: ErrPass1, message: "Password required.")
                
            }
            else if TfPassword2.text?.isEmpty ?? false
            {
                 HideALL(viewa: ViPassword2, Label: Errpass2 , message: "Password required.")
              
            }
            else if TfPassword2.text != TfPassword.text
            {
                 HideALL(viewa: ViPassword2, Label: Errpass2, message: "Passwords do not match.")
               
            }
            else
            {
                guard isValidEmail(testStr: TfEmail.text ?? "")else {
                      HideALL(viewa: ViName, Label: ErrName, message: "Enter valid email.")
                    
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
        
        
        
            let manager = Alamofire.SessionManager.default
            manager.session.configuration.timeoutIntervalForRequest = 2000

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
                                                            self.HideconfirmALL()
                                                               self.registerUser()
                                                           }else
                                                           {
                                                               Utility.Internetconnection(vc: self)
                                                           }
                                                          
                                                        }
                                                        else if swiftyJsonVar["isExists"].int == 1
                                                        {
                                                            self.IsEmailexists = true
                                                           // self.LbError.text = "Email already exists"
                                                           // self.LbError.isHidden = false
                                                            self.HideALL(viewa: self.VEmail, Label: self.LbError, message: "Email already exists")
                                                            self.BtEmailexist.isHidden = false
                                                            self.BtEmailexist.setBackgroundImage(UIImage(named: "criss-cross"), for: .normal)
                                                            self.VEmail.layer.borderColor = UIColor.red.cgColor
                                                       
                                                        }
                            break
                        case .failure(let error):
                            Utility.hideLoader(vc: self)
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
                  
        let manager = Alamofire.SessionManager.default
            manager.session.configuration.timeoutIntervalForRequest = 2000

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
                                                            self.BtEmailexist.isHidden = false
                                                            self.BtEmailexist.setBackgroundImage(UIImage(named: "correct"), for: .normal)
                                                            self.VEmail.layer.borderColor = Appcolor.textBordercolor.cgColor
                                                        }
                                                        else if swiftyJsonVar["isExists"].int == 1
                                                        {
                                                            self.IsEmailexists = true
                                                         //   self.LbError.text = "Email already exists"
                                                          //  self.LbError.isHidden = false
                                                          //  self.VEmail.layer.borderColor = UIColor.red.cgColor
                                                            self.HideALL(viewa: self.VEmail, Label: self.LbError, message: "Email already exists")
                                                            self.BtEmailexist.isHidden = false
                                                            self.BtEmailexist.setBackgroundImage(UIImage(named: "criss-cross"), for: .normal)
                                                       
                                                        }
                                                        self.ActivityInd.isHidden = true
                                                        self.ActivityInd.stopAnimating()
                                                        print("succesfull")
                                                         
                                                       }
                                                       
                                                       break
                              case .failure(let error):
                                Utility.hideLoader(vc: self)
                                  if error._code == NSURLErrorTimedOut {
                                      print("Request timeout!")
                                  }
                              }
                          }
         
    }
    func HideALL(viewa:CardView,Label:UILabel,message:String)
       {
           ErrName.isHidden = true
           ErrPass1.isHidden  = true
           Errpass2.isHidden = true
           LbError.isHidden = true
            
           ViName.layer.borderColor = Appcolor.textBordercolor.cgColor
           VEmail.layer.borderColor = Appcolor.textBordercolor.cgColor
           ViPassword1.layer.borderColor = Appcolor.textBordercolor.cgColor
           ViPassword2.layer.borderColor = Appcolor.textBordercolor.cgColor
           
            
           viewa.layer.borderColor = UIColor.red.cgColor
           Label.isHidden  = false
            viewa.isHidden = false
           Label.text = message
           
           
           
           
       }
    func HideconfirmALL()
       {
           ErrName.isHidden = true
           ErrPass1.isHidden  = true
           Errpass2.isHidden = true
           LbError.isHidden = true
            
           ViName.layer.borderColor = Appcolor.textBordercolor.cgColor
           VEmail.layer.borderColor = Appcolor.textBordercolor.cgColor
           ViPassword1.layer.borderColor = Appcolor.textBordercolor.cgColor
           ViPassword2.layer.borderColor = Appcolor.textBordercolor.cgColor
           
      
           
       }
    func registerUser()
    {
       Utility.ShowLoader(vc: self)
        let url = Configurator.baseURL + ApiEndPoints.Register
        
        let parameters = [
            "authToken":Keycenter.authToken,
            "name":TfName.text,
            "email":TfEmail.text ?? "",
            "password":TfPassword.text ?? "",
            "device_id": UIDevice.current.identifierForVendor?.uuidString ?? "",
            "device_type":"3"
            ] as? [String:Any]
        print(parameters)
        
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
                                                   
                                                   UserDefaults.standard.set(swiftyJsonVar["email"].description, forKey: "email")
                                                   UserDefaults.standard.set(swiftyJsonVar["id"].description, forKey: "id")
                                                   
                                                   UserDefaults.standard.set(swiftyJsonVar["profile_image"].description, forKey: "profile_image")
                                                   UserDefaults.standard.set(swiftyJsonVar["studio_id"].description, forKey: "studio_id")
                                                   
                                                   Utility.hideLoader(vc: self)
        let alertController = UIAlertController(title: "BigFan TV", message: "Email has sent on your registered Email address", preferredStyle: .alert)
        alertController.addAction(UIAlertAction(title: "Ok", style: .default) { action in
                   self.dismiss(animated: true , completion: nil)
            alertController.dismiss(animated: true, completion: nil)
                 })
        
                self.present(alertController, animated: true, completion: {() -> Void in
             alertController.view.superview?.addGestureRecognizer(UITapGestureRecognizer(target: self, action: nil))
                                                                       })
                                                   
                                                  }
                                                  
                                                  break
                             case .failure(let error):
                                 Utility.hideLoader(vc: self)
                                 if error._code == NSURLErrorTimedOut {
                                     print("Request timeout!")
                                 }
                             }
                         }
             }
    
    @IBAction func BtPassword1Tapped(_ sender: UIButton) {
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
    
    @IBAction func BtPassword2Tapped(_ sender: UIButton) {
        if IsPassword2 == true
               {
                   BtPassword2.setBackgroundImage(UIImage(named: "eyenew"), for: .normal)
                   IsPassword2 = false
                TfPassword2.isSecureTextEntry = true
               }else
               {
                   BtPassword2.setBackgroundImage(UIImage(named: "hidenew"), for: .normal)
                   IsPassword2 = true
                TfPassword2.isSecureTextEntry = false
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
               // self.LbError.isHidden = false
               // self.VEmail.layer.borderColor = UIColor.red.cgColor
                 HideALL(viewa: VEmail, Label: LbError, message: "Enter valid email.")
               // LbError.text = "Enter valid email"
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
                HideconfirmALL()
                activeField = textField
              
            }

        func textFieldDidEndEditing(_ textField: UITextField)
            {
            
                activeField = nil
                 
            }
}
