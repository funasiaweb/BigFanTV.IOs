//
//  BannerVC.swift
//  bigfantv
//
//  Created by Ganesh on 12/01/21.
//  Copyright © 2021 Ganesh. All rights reserved.
//

import UIKit
import GoogleMobileAds
class BannerVC: UIViewController,StackContainable {
    public static func create() -> BannerVC {
        return UIStoryboard(name: "Containers", bundle: Bundle.main).instantiateViewController(withIdentifier: "BannerVC") as! BannerVC
    }
    @IBOutlet var Baneerview: GADBannerView!
    override func viewDidLoad() {
        super.viewDidLoad()

        Baneerview.adUnitID = "ca-app-pub-3940256099942544/6300978111"
        Baneerview.rootViewController = self
        
        Baneerview.load(GADRequest())
        Baneerview.delegate = self
    }
    
 public func preferredAppearanceInStack() -> ScrollingStackController.ItemAppearance {
     return .view(height: 300)
 }

}      
extension BannerVC:GADBannerViewDelegate
{
    func adViewDidReceiveAd(_ bannerView: GADBannerView) {
        print("receiveddid")
    }
    func adView(_ bannerView: GADBannerView, didFailToReceiveAdWithError error: GADRequestError) {
        print(error)
    }
}
