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
        
        let alertController = MDCAlertController(title: titelstring, attributedMessage: NSAttributedString(string:message,
        attributes: [NSAttributedString.Key.foregroundColor:Appcolor.textcolor,NSAttributedString.Key.font:  UIFont(name: "Muli-Bold", size: 16)!]))
       // let alertController = MDCAlertController(title: titelstring, message: message)
        let action = MDCAlertAction(title:"OK")
        { (action) in  print("ok")
             
        }
        alertController.addAction(action)
         vc.present(alertController, animated: true, completion: nil)
       
    
    }
    class func configurscollview(scrollV:UIScrollView)
    {
        let refreshControld = UIRefreshControl()
        refreshControld.backgroundColor = Appcolor.backgorund2

        //the color of the spinner
        refreshControld.tintColor = UIColor.white
        
          // the color of the label
        let title = "Loading..."
        let attrsDictionary = [ NSAttributedString.Key.foregroundColor: UIColor.white ]
        let attributedTitle = NSAttributedString(string: title, attributes: attrsDictionary)
        refreshControld.attributedTitle = attributedTitle
        //scrollV.delegate = self
        scrollV.bounces = true
        scrollV.alwaysBounceVertical = true
        scrollV.refreshControl = refreshControld
    }
    
   
        
     
     
     class func Internetconnection(vc:UIViewController)
     {

           let alertController = MDCAlertController(title: "Oops!", message: "Cannot connect to Internet...Please check your connection!")
      
        alertController.cornerRadius = 4
        alertController.buttonTitleColor = Appcolor.backgorund3
           let action = MDCAlertAction(title:"OK")
           { (action) in
            print("ok")
                
           }
           alertController.addAction(action)
            vc.present(alertController, animated: true, completion: nil)
          
     }
    
    class func ShowLoader(vc:UIViewController)
    {
        let activityIndicator = MDCActivityIndicator()
        activityIndicator.tag = 601601
        activityIndicator.sizeToFit()
        activityIndicator.bounds = vc.view.bounds
        activityIndicator.center = vc.view.center
        activityIndicator.cycleColors = [Appcolor.loadercolor]
        activityIndicator.indicatorMode = .indeterminate
        
        activityIndicator.radius = 20
        activityIndicator.strokeWidth = 4
        activityIndicator.startAnimating()
        vc.view.addSubview(activityIndicator)
      // UIApplication.shared.keyWindow?.addSubview(activityIndicator)
      // UIApplication.shared.keyWindow?.bringSubviewToFront(activityIndicator)
        
    }
    class  func hideLoader(vc:UIViewController)  {
        for item in vc.view.subviews
          where item.tag == 601601 {
              item.removeFromSuperview()
          }
      }
    class func ShowLoaderbollywood(vc:UIViewController)
    {
        let activityIndicator = MDCActivityIndicator()
        activityIndicator.tag = 60160111
        activityIndicator.sizeToFit()
        activityIndicator.bounds = vc.view.bounds
        activityIndicator.center = vc.view.center
        activityIndicator.cycleColors = [Appcolor.loadercolor]
        activityIndicator.indicatorMode = .indeterminate
        activityIndicator.radius = 20
        activityIndicator.strokeWidth = 4
        activityIndicator.startAnimating()
        vc.view.addSubview(activityIndicator)
      // UIApplication.shared.keyWindow?.addSubview(activityIndicator)
      // UIApplication.shared.keyWindow?.bringSubviewToFront(activityIndicator)
        
    }
    class  func hideLoaderbollywood(vc:UIViewController)  {
        for item in vc.view.subviews
          where item.tag == 60160111 {
              item.removeFromSuperview()
          }
      }
    class func ShowplayerLoader(vi:UIView)
    {
        let activityIndicator = MDCActivityIndicator()
        activityIndicator.tag = 601602
        activityIndicator.sizeToFit()
        activityIndicator.frame =  CGRect(x: vi.frame.midX, y:  vi.frame.midY, width: 200, height: 200)
        activityIndicator.center = vi.center
        activityIndicator.cycleColors = [Appcolor.loadercolor]
        activityIndicator.indicatorMode = .indeterminate
        activityIndicator.radius = 14
        activityIndicator.strokeWidth = 3
        activityIndicator.startAnimating()
        vi.addSubview(activityIndicator)
      // UIApplication.shared.keyWindow?.addSubview(activityIndicator)
      // UIApplication.shared.keyWindow?.bringSubviewToFront(activityIndicator)
        
    }
    class  func hideplayerLoader(vc:UIViewController)  {
        for item in vc.view.subviews
          where item.tag == 601602 {
              item.removeFromSuperview()
          }
      }
}


struct Appcolor {
    static let backgorund2 = UIColor(red: 46/255.0, green: 51/255.0, blue: 80/255.0, alpha: 1.0)
     static let backgorund3 = UIColor(red: 31/255.0, green: 32/255.0, blue: 62/255.0, alpha: 1.0)
    static let backgorund4 = UIColor(red: 18/255.0, green: 22/255.0, blue: 51/255.0, alpha: 1.0)
   // static let backgorund3 = UIColor(red: 0/255.0, green: 0/255.0, blue: 0/255.0, alpha: 1.0)
   //   static let backgorund4 = UIColor(red: 0/255.0, green: 0/255.0, blue: 0/255.0, alpha: 1.0)
      
    static let textcolor = UIColor(red: 101/255.0, green: 109/255.0, blue: 128/255.0, alpha: 1.0)
    static let textBordercolor = UIColor(red: 18/255.0, green: 22/255.0, blue: 51/255.0, alpha: 1.0)
    static let loadercolor =  UIColor(red: 3/255.0, green: 218/255.0, blue: 197/255.0, alpha: 1.0)
    
}

class AnimationFrames {
    
    class func createFrames() -> [UIImage] {
    
        // Setup "Now Playing" Animation Bars
        var animationFrames = [UIImage]()
        for i in 0...3 {
            if let image = UIImage(named: "NowPlayingBars-\(i)") {
                animationFrames.append(image)
            }
        }
        
        for i in stride(from: 2, to: 0, by: -1) {
            if let image = UIImage(named: "NowPlayingBars-\(i)") {
                animationFrames.append(image)
            }
        }
        return animationFrames
    }

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

extension UICollectionView {
    func setEmptyView() {
        let emptyView = UIView(frame: CGRect(x: self.center.x, y: self.center.y, width: self.bounds.size.width, height: self.bounds.size.height))
        let titleLabel = UILabel()
        let messageLabel = UILabel()
        titleLabel.translatesAutoresizingMaskIntoConstraints = false
        messageLabel.translatesAutoresizingMaskIntoConstraints = false
        titleLabel.textColor = UIColor.white
        titleLabel.font = UIFont(name: "Muli-Bold", size: 16)
        messageLabel.textColor = UIColor.lightGray
        messageLabel.font = UIFont(name: "Muli-Bold", size: 17)
        emptyView.addSubview(titleLabel)
        emptyView.addSubview(messageLabel)
        titleLabel.centerYAnchor.constraint(equalTo: emptyView.centerYAnchor).isActive = true
        titleLabel.centerXAnchor.constraint(equalTo: emptyView.centerXAnchor).isActive = true
        messageLabel.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 20).isActive = true
        messageLabel.leftAnchor.constraint(equalTo: emptyView.leftAnchor, constant: 20).isActive = true
        messageLabel.rightAnchor.constraint(equalTo: emptyView.rightAnchor, constant: -20).isActive = true
        titleLabel.text = "Content Coming Soon"
        messageLabel.text = ""
        messageLabel.numberOfLines = 0
        messageLabel.textAlignment = .center
        // The only tricky part is here:
        self.backgroundView = emptyView
    }
    func setEmptyViewnew() {
        let emptyView = UIView(frame: CGRect(x: self.center.x, y: self.center.y, width: self.bounds.size.width, height: self.bounds.size.height))
        let titleLabel = UILabel()
        let messageLabel = UILabel()
        titleLabel.translatesAutoresizingMaskIntoConstraints = false
        messageLabel.translatesAutoresizingMaskIntoConstraints = false
        titleLabel.textColor = UIColor.white
        titleLabel.font = UIFont(name: "Muli-Bold", size: 16)
        messageLabel.textColor = UIColor.lightGray
        messageLabel.font = UIFont(name: "Muli-Bold", size: 17)
        emptyView.addSubview(titleLabel)
        emptyView.addSubview(messageLabel)
        titleLabel.centerYAnchor.constraint(equalTo: emptyView.centerYAnchor).isActive = true
        titleLabel.centerXAnchor.constraint(equalTo: emptyView.centerXAnchor).isActive = true
        messageLabel.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 20).isActive = true
        messageLabel.leftAnchor.constraint(equalTo: emptyView.leftAnchor, constant: 20).isActive = true
        messageLabel.rightAnchor.constraint(equalTo: emptyView.rightAnchor, constant: -20).isActive = true
        titleLabel.text = "No Watch History"
        messageLabel.text = ""
        messageLabel.numberOfLines = 0
        messageLabel.textAlignment = .center
        // The only tricky part is here:
        self.backgroundView = emptyView
    }
    func setEmptyViewnew1(title:String) {
        let emptyView = UIView(frame: CGRect(x: self.center.x, y: self.center.y, width: self.bounds.size.width, height: self.bounds.size.height))
        let titleLabel = UILabel()
        let messageLabel = UILabel()
        titleLabel.translatesAutoresizingMaskIntoConstraints = false
        messageLabel.translatesAutoresizingMaskIntoConstraints = false
        titleLabel.textColor = UIColor.white
        titleLabel.font = UIFont(name: "Muli-Bold", size: 16)
        messageLabel.textColor = UIColor.lightGray
        messageLabel.font = UIFont(name: "Muli-Bold", size: 17)
        emptyView.addSubview(titleLabel)
        emptyView.addSubview(messageLabel)
        titleLabel.centerYAnchor.constraint(equalTo: emptyView.centerYAnchor).isActive = true
        titleLabel.centerXAnchor.constraint(equalTo: emptyView.centerXAnchor).isActive = true
        messageLabel.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 20).isActive = true
        messageLabel.leftAnchor.constraint(equalTo: emptyView.leftAnchor, constant: 20).isActive = true
        messageLabel.rightAnchor.constraint(equalTo: emptyView.rightAnchor, constant: -20).isActive = true
        titleLabel.text = title
        messageLabel.text = ""
        messageLabel.numberOfLines = 0
        messageLabel.textAlignment = .center
        // The only tricky part is here:
        self.backgroundView = emptyView
    }
    func restore() {
        self.backgroundView = nil
    }
}

extension UITableView {
     
    func setEmptyView(title:String) {
        let emptyView = UIView(frame: CGRect(x: self.center.x, y: self.center.y, width: self.bounds.size.width, height: self.bounds.size.height))
        let titleLabel = UILabel()
        let messageLabel = UILabel()
        titleLabel.translatesAutoresizingMaskIntoConstraints = false
        messageLabel.translatesAutoresizingMaskIntoConstraints = false
        titleLabel.textColor = UIColor.white
        titleLabel.font = UIFont(name: "Muli-Bold", size: 16)
        messageLabel.textColor = UIColor.lightGray
        messageLabel.font = UIFont(name: "Muli-Bold", size: 17)
        emptyView.addSubview(titleLabel)
        emptyView.addSubview(messageLabel)
        titleLabel.centerYAnchor.constraint(equalTo: emptyView.centerYAnchor).isActive = true
        titleLabel.centerXAnchor.constraint(equalTo: emptyView.centerXAnchor).isActive = true
        messageLabel.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 20).isActive = true
        messageLabel.leftAnchor.constraint(equalTo: emptyView.leftAnchor, constant: 20).isActive = true
        messageLabel.rightAnchor.constraint(equalTo: emptyView.rightAnchor, constant: -20).isActive = true
        titleLabel.text = title
        messageLabel.text = ""
        messageLabel.numberOfLines = 0
        messageLabel.textAlignment = .center
        // The only tricky part is here:
        self.backgroundView   = emptyView
        self.separatorStyle = .none
         
    }
    func restore() {
        self.backgroundView = nil
    }
}
 
extension Array where Element: Hashable {
    func difference(from other: [Element]) -> [Element] {
        let thisSet = Set(self)
        let otherSet = Set(other)
        return Array(thisSet.symmetricDifference(otherSet))
    }
}
//Common functions :-
  
 
extension UIView {
    func roundCorners(_ corners: UIRectCorner, radius: CGFloat, borderColor: UIColor?, borderWidth: CGFloat?) {
        let path = UIBezierPath(roundedRect: self.bounds, byRoundingCorners: corners, cornerRadii: CGSize(width: radius, height: radius))

        let mask = CAShapeLayer()
        mask.frame = self.bounds
        mask.path = path.cgPath
        self.layer.mask = mask

        if borderWidth != nil {
            addBorder(mask, borderWidth: borderWidth!, borderColor: borderColor!)
        }
    }

    private func addBorder(_ mask: CAShapeLayer, borderWidth: CGFloat, borderColor: UIColor) {
        let borderLayer = CAShapeLayer()
        borderLayer.path = mask.path
        borderLayer.fillColor = UIColor.clear.cgColor
        borderLayer.strokeColor = borderColor.cgColor
        borderLayer.lineWidth = borderWidth
        borderLayer.frame = bounds
        layer.addSublayer(borderLayer)
    }
}
struct Track {
    var title: String
    var artworkImage: UIImage?
    var artworkLoaded = false
    
    init(title: String ,artworkImage: UIImage?) {
        self.title = title
        self.artworkImage = artworkImage
     }
}

class ShareImageGenerator {
    
    private let radioShoutout: String
    private let track: Track
    
    init(radioShoutout: String, track: Track) {
        self.radioShoutout = radioShoutout
        self.track = track
    }
    
    func generate() -> UIImage {
        let logoShareView = LogoShareView.instanceFromNib()
        
        logoShareView.shareSetup(albumArt: track.artworkImage ?? #imageLiteral(resourceName: "albumArt"), trackTitle: track.title)
        
        UIGraphicsBeginImageContextWithOptions(CGSize(width: logoShareView.frame.width, height: logoShareView.frame.height), true, 0)
        logoShareView.drawHierarchy(in: logoShareView.frame, afterScreenUpdates: true)
        let shareImage = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        
        return shareImage ?? track.artworkImage ?? #imageLiteral(resourceName: "albumArt")
    }
}

protocol MDCalertProtocol: UIViewController
{
    func showAlert(_ message: String, handler: ((MDCAlertAction) -> Void)?)
    func showAlert(_ message: String)
}
extension MDCalertProtocol
{
    func showAlert(_ message: String, handler: ((MDCAlertAction) -> Void)?)
    {
        view.endEditing(true)
       
        let alertController = MDCAlertController(title: message, attributedMessage: NSAttributedString(string:message,
        attributes: [NSAttributedString.Key.foregroundColor:Appcolor.textcolor,NSAttributedString.Key.font:  UIFont(name: "Muli-Bold", size: 16)!]))
            alertController.addAction(MDCAlertAction(title: message, emphasis: .high, handler: handler))
        
         present(alertController, animated: true, completion: nil)
           
           
       }
    func showAlert(_ message: String) {
        showAlert(message, handler: nil)
    }
}
