//
//  Utils.swift
//  bigfantv
//
//  Created by Ganesh on 25/06/20.
//  Copyright © 2020 Ganesh. All rights reserved.
//

import Foundation
import UIKit
import Alamofire
import MaterialComponents.MaterialDialogs
import MaterialComponents.MDCActivityIndicator
 class Utility:NSObject
 {
     
    class func showAlert(vc: UIViewController, message: String,titelstring:String ) {
        let alertController = MDCAlertController(title: titelstring, message: message)
        let action = MDCAlertAction(title:"OK")
        { (action) in  print("ok")
             
        }
        alertController.addAction(action)
         vc.present(alertController, animated: true, completion: nil)
       
    
    }
     
     
     class func Internetconnection(vc:UIViewController)
     {
           let alertController = MDCAlertController(title: "Oops!", message: "No internet connection available")
           let action = MDCAlertAction(title:"OK")
           { (action) in  print("ok")
                
           }
           alertController.addAction(action)
            vc.present(alertController, animated: true, completion: nil)
          
     }
    
    class func ShowLoader()
    {
        let activityIndicator = MDCActivityIndicator()
        activityIndicator.tag = 601601
        activityIndicator.sizeToFit()
        activityIndicator.frame = CGRect(x: 0, y: 0, width: UIScreen.main.bounds.size.width, height: UIScreen.main.bounds.size.width)
        activityIndicator.cycleColors = [.black,.red,.green,.brown,.magenta,.orange]
        activityIndicator.indicatorMode = .indeterminate
        activityIndicator.radius = 20
        activityIndicator.strokeWidth = 2
        activityIndicator.startAnimating()
        //view.addSubview(activityIndicator)
       UIApplication.shared.keyWindow?.addSubview(activityIndicator)
       UIApplication.shared.keyWindow?.bringSubviewToFront(activityIndicator)
        
    }
    class  func hideLoader()   {
          for item in UIApplication.shared.keyWindow!.subviews
          where item.tag == 601601 {
              item.removeFromSuperview()
          }
      }
}


struct Appcolor {
    static let backgorund2 = UIColor(red: 46/255.0, green: 51/255.0, blue: 80/255.0, alpha: 1.0)
    static let textcolor = UIColor(red: 101/255.0, green: 109/255.0, blue: 128/255.0, alpha: 1.0)
    static let textBordercolor = UIColor(red: 18/255.0, green: 22/255.0, blue: 51/255.0, alpha: 1.0)
    
    
}
class Connectivity {
    class func isConnectedToInternet() -> Bool {
        return NetworkReachabilityManager()!.isReachable
    }
}
 @IBDesignable
 class CardView: UIView {

     @IBInspectable var cornerRadius: CGFloat = 2

     @IBInspectable var shadowOffsetWidth: Int = 0
     @IBInspectable var shadowOffsetHeight: Int = 3
     @IBInspectable var shadowColor: UIColor? = UIColor.black
     @IBInspectable var shadowOpacity: Float = 0.5

     override func layoutSubviews() {
         layer.cornerRadius = cornerRadius
         let shadowPath = UIBezierPath(roundedRect: bounds, cornerRadius: cornerRadius)

         layer.masksToBounds = false
         layer.shadowColor = shadowColor?.cgColor
         layer.shadowOffset = CGSize(width: shadowOffsetWidth, height: shadowOffsetHeight);
         layer.shadowOpacity = shadowOpacity
         layer.shadowPath = shadowPath.cgPath
     }

 }

extension UIView{
    
    @IBInspectable
    var cornerRadius1: CGFloat {
        get {
            return layer.cornerRadius
        }
        set {
            layer.cornerRadius = newValue
        }
    }
    
    @IBInspectable
    var borderWidth1: CGFloat {
        get {
            return layer.borderWidth
        }
        set {
            layer.borderWidth = newValue
        }
    }
    
    @IBInspectable
    var borderColor1: UIColor? {
        get {
            if let color = layer.borderColor {
                return UIColor(cgColor: color)
            }
            return nil
        }
        set {
            if let color = newValue {
                layer.borderColor = color.cgColor
            } else {
                layer.borderColor = nil
            }
        }
    }
    
    @IBInspectable
    var shadowRadius1: CGFloat {
        get {
            return layer.shadowRadius
        }
        set {
            layer.shadowRadius = newValue
        }
    }
    
    @IBInspectable
    var shadowOpacity1: Float {
        get {
            return layer.shadowOpacity
        }
        set {
            layer.shadowOpacity = newValue
        }
    }
    
    @IBInspectable
    var shadowOffset1: CGSize {
        get {
            return layer.shadowOffset
        }
        set {
            layer.shadowOffset = newValue
        }
    }
    
    @IBInspectable
    var shadowColor1: UIColor? {
        get {
            if let color = layer.shadowColor {
                return UIColor(cgColor: color)
            }
            return nil
        }
        set {
            if let color = newValue {
                layer.shadowColor = color.cgColor
            } else {
                layer.shadowColor = nil
            }
        }
    }
}

