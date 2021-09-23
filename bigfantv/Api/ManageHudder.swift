/** This is custom made class to show and hide activity indicator
 */
import UIKit


class ManageHudder {

  static let sharedInstance = ManageHudder()
  
  var alertWindow: UIWindow?
  
  /**
   This function will show the activity indicator in centre of the screen.
   
   ### Usage Example: ###
   ````
   ManageHudder.sharedInstance.startActivityIndicator()
   ````
   */
  
  func startActivityIndicator() {
    alertWindow = UIWindow(frame: UIScreen.main.bounds)
    alertWindow?.rootViewController = UIViewController()
    alertWindow?.windowLevel = UIWindow.Level.alert + 1
    alertWindow?.makeKeyAndVisible()
    
    if let sourceView = alertWindow?.rootViewController?.view {
      let spinnerView = UIActivityIndicatorView()
        spinnerView.frame  = sourceView.frame
      
       // spinnerView.bounds = sourceView.bounds
       spinnerView.center = (sourceView.center)
        sourceView.addSubview(spinnerView)
    }
  }
  
  /**
   This function will hide the currently showing activity indicator.
   
   ### Usage Example: ###
   ````
   ManageHudder.sharedInstance.stopActivityIndicator()
   ````
   */
  
  func stopActivityIndicator() {
    DispatchQueue.main.async {
      if let sourceView = self.alertWindow?.rootViewController?.view {
        if sourceView.subviews.count > 0 {
          sourceView.subviews[0].removeFromSuperview()
          self.alertWindow?.resignKey()
        }
      }
      self.alertWindow = nil
    }
  }
  
}


