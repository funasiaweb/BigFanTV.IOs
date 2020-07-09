//
//  ForgotPassVC.swift
//  bigfantv
//
//  Created by Ganesh on 09/07/20.
//  Copyright © 2020 Ganesh. All rights reserved.
//

import UIKit
import  MaterialComponents.MDCButton
import Alamofire
import SwiftyJSON
class ForgotPassVC: UIViewController {

    @IBOutlet var ViEmail: CardView!
    var activeField: UITextField?
       @IBOutlet var TfEmail: UITextField!
       @IBOutlet var ScrollV: UIScrollView!
    @IBOutlet var LbError: UILabel!
    
    @IBOutlet var Btsubmit: MDCButton!
    override func viewDidLoad() {
        super.viewDidLoad()

        LbError.isHidden = true
         TfEmail.attributedPlaceholder = NSAttributedString(string: "Enter your Email",
                       attributes: [NSAttributedString.Key.foregroundColor:Appcolor.textcolor])
           
                registerForKeyboardNotifications()
                 
                 
                 TfEmail.delegate = self
           
                
                  
                 TfEmail.returnKeyType = .done
      }
    override func viewDidAppear(_ animated: Bool)
    {
        let paddingView13 = UIView(frame: CGRect(origin: CGPoint(x: 0,y :0), size: CGSize(width: 20, height: 50)))
            TfEmail.leftView = paddingView13
            TfEmail.leftViewMode = UITextField.ViewMode.always
        
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
    
    @IBAction func BtSubmitTapped(_ sender: MDCButton) {
    if TfEmail.text?.isEmpty ?? false
    {
        LbError.text = "Please enter your Email."
        ViEmail.layer.borderColor = UIColor.red.cgColor
        LbError.isHidden = false
    }else
    {
        guard isValidEmail(testStr: TfEmail.text ?? "") else {
            LbError.text = "Please enter proper Email."
            self.ViEmail.layer.borderColor = UIColor.red.cgColor
            LbError.isHidden = false
            return
        }
        LbError.isHidden = true
        if Connectivity.isConnectedToInternet()
        {
          forgotpass()
        }else
        {
            Utility.Internetconnection(vc: self)
        }
        
        }
    }
    func forgotpass()
    {
        Utility.ShowLoader()
        let url = Configurator.baseURL + ApiEndPoints.forgotpassword
        
        let parameters = [
            "authToken":Keycenter.authToken,
             "email":TfEmail.text ?? ""
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
                                                   
                                                     
                                                   Utility.hideLoader()
                                                    
                                                    if swiftyJsonVar["status"].description == "OK"
                                                    {
                                                        let alertController = MDCAlertController(title: "BigFan TV", message: swiftyJsonVar["msg"].description)
                                                                                  let action = MDCAlertAction(title:"OK")
                                                                                    { (action) in
                                                                                     self.dismiss(animated: true, completion: nil)
                                                                                     }
                                                        alertController.addAction(action)
                                                        self.present(alertController, animated: true, completion: nil)
                                                    }else
                                                    {
                                                        Utility.showAlert(vc: self, message: swiftyJsonVar["msg"].description, titelstring: "BigFan TV")
                                                    }
                          
                                                         
                                                    
                                                    
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
extension ForgotPassVC:UITextFieldDelegate
{
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        if textField == TfEmail && !(TfEmail.text?.isEmpty ?? false)
        {
            ViEmail.layer.borderColor = UIColor.clear.cgColor
            LbError.isHidden = true
            
           guard isValidEmail(testStr: TfEmail.text ?? "") else {
                   
                 LbError.text = "Please enter proper Email."
                 self.ViEmail.layer.borderColor = UIColor.red.cgColor
                 LbError.isHidden = false
                     return false
               }
             TfEmail.resignFirstResponder()
            
              if Connectivity.isConnectedToInternet()
                  {
                    forgotpass()
                  }else
                  {
                      Utility.Internetconnection(vc: self)
                  }
        }
        return true
    }
    
    
    
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
          
            ViEmail.layer.borderColor = UIColor.clear.cgColor
            LbError.isHidden = true
               activeField = textField
             
           }

       func textFieldDidEndEditing(_ textField: UITextField)
           {
           
               activeField = nil
                
           }
}
