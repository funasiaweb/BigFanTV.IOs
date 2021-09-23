//
//  SongsDetailsVC.swift
//  bigfantv
//
//  Created by Ganesh on 26/08/20.
//  Copyright © 2020 Ganesh. All rights reserved.
//

import UIKit
import MaterialComponents.MDCButton
import SDWebImage
import AVFoundation
import MuviPlayer
class SongsDetailsVC: UIViewController ,AVAudioPlayerDelegate{
    var contentdata:contentdetails?
  
    
    @IBOutlet var ImgMusic: UIImageView!
    @IBOutlet var ViPlay: MDCButton!
    
     
     
    
     @IBOutlet var Viback: UIView!

    @IBOutlet var BtPlay: UIButton!
    
    
    @IBOutlet var LbLanguage: UILabel!
    
    @IBOutlet var LbTitle: UILabel!
    @IBOutlet var LbCoverartist: UILabel!
    @IBOutlet var LbMovie: UILabel!
    @IBOutlet var LbArtist: UILabel!
    var playerUrl:URL?
    var permalink = ""
    var isplaying = false
    var audioPlayer = AVAudioPlayer()
    var perma = ""
   var songtitle = ""
    let  playerview = MuviPlayerView()
    var IsAuthorizedContent = 0
    var PPVdata:PPVplans?
    var playerurlstr = ""
    @IBOutlet var ViPlayer: UIView!
    override func viewDidLoad() {
        super.viewDidLoad()
        LbTitle.text = songtitle
        playerview.backgroundColor = UIColor.black
        playerview.playbackDelegate = self
        playerview.useMuviPlayerControls = true
        playerview.controls?.airplayButton?.isHidden = true
        playerview.controls?.forwardButton?.isHidden = true
        playerview.controls?.rewindButton?.isHidden = true
        playerview.controls?.resolutionButton?.isHidden = true
        playerview.controls?.multipleAudioButton?.isHidden = true
        playerview.controls?.fullscreenButton?.isHidden = true
        playerview.controls?.subtitleButton?.isHidden = true
        playerview.controls?.seekbarSlider?.isHidden = false
        
        
     //   playerview.controls.b
        self.playerview.enablePlaybackSpeed = true
        
      //  BtPlay.layer.cornerRadius = BtPlay.frame.size.height / 2
       // BtPlay.layer.borderColor = UIColor.clear.cgColor
       // BtPlay.layer.borderWidth = 0.0

    // NotificationCenter.default.addObserver(self, selector:#selector(stopplayer), name:UIApplication.didEnterBackgroundNotification, object: nil)
          }
          @objc func stopplayer()
          {
              if self.playerview.isPlaying
              {
              self.playerview.player.pause()
          }
          }
    override func viewDidAppear(_ animated: Bool)
    {
        self.playerview.frame = CGRect(x: self.ViPlayer.frame.minX, y:self.ViPlayer.frame.minY, width:self.ViPlayer.frame.size.width, height: self.ViPlayer.frame.size.height)
        
        self.view.addSubview(self.playerview)
         
        Timer.scheduledTimer(withTimeInterval: 0.01, repeats: false) { (t) in
                             if Connectivity.isConnectedToInternet()
                             {
                                 
                               self.getcontendeatils(perma: self.permalink)
                                 
                             }else
                             {
                                 Utility.Internetconnection(vc: self)
                             }
                         }
        
        
        Viback.layer.cornerRadius = Viback.frame.size.height/2
        Viback.layer.borderColor = UIColor.clear.cgColor
        Viback.layer.borderWidth = 1    }
    override func viewWillAppear(_ animated: Bool) {
//        BtPlay.backgroundColor = UIColor(patternImage: UIImage(named: "gradient-image") ?? UIImage())
    }
     @IBAction func BackBtTapped(_ sender: UIButton) {
                  self.dismiss(animated: true, completion: nil)
              }
              
    
  
    func getcontendeatils(perma:String)
    {
        Api.getcontentdetails(perma, endpoint: ApiEndPoints.getcontentdetails, vc: self) { (res, err) -> (Void) in
            do
            {
           
                let decoder = JSONDecoder()
                self.contentdata = try decoder.decode(contentdetails.self, from: res  ?? Data())
                if self.IsAuthorizedContent == 1
                {
           
                if let url:URL = URL(string: self.contentdata?.submovie?.movieUrl ?? "")
                {

                    
                  let item = MuviPlayerItem(url: url)
                  self.playerview.set(item: item)
                   
                  self.playerview.player.play()
                }
               
                }else
                {
                    self.loadnewSubscriptionPopup(permalink: "")

                    //self.loadSubscriptionPopup(permalink: self.playerurlstr)
                    //self.getPPVplans(movieuniqids: self.contentdata?.submovie?.muvi_uniq_id ?? "", planid: self.contentdata?.submovie?.ppv_plan_id  ?? "")
                }
                
            }
               catch let error
               {
                   Utility.showAlert(vc: self, message:"\(error)", titelstring: Appcommon.Appname)
               }
           }
       }
func loadnewSubscriptionPopup(permalink:String)
{
let alertController = MDCAlertController(title: "BigFan TV", message:  "Subscribe to watch this content")

let cancelaction = MDCAlertAction(title:"Ok")
{ (cancelaction) in
    
    self.view.window!.rootViewController?.dismiss(animated: false, completion: nil)
 
 let touch = UITouch()
 touch.view?.isUserInteractionEnabled = false
}
        print("alert presented...")

alertController.addAction(cancelaction)

self.present(alertController, animated: true, completion: {

    // When the Dialog view has pop up on screen then just put this line of code when Dialog view has completed pop up.
    alertController.view.superview?.subviews[0].isUserInteractionEnabled = false
})

}
    /*
func loadSubscriptionPopup(permalink:String)
{
let alertController = MDCAlertController(title: "BigFan TV", message:  "Purchase a plan to watch this movie.")
let action = MDCAlertAction(title:"Subscribe")
                                { (action) in
    let storyBoard: UIStoryboard = UIStoryboard(name: "Main", bundle: nil)
    let VC1 = storyBoard.instantiateViewController(withIdentifier: "BuyPlanVC") as! BuyPlanVC
    let url = permalink
    VC1.planurl = url
    let navController = UINavigationController(rootViewController: VC1) // Creating a navigation controller with VC1 at the root of the navigation stack.
                             
    navController.navigationBar.barTintColor = Appcolor.backgorund3
    navController.navigationBar.isTranslucent = false
    navController.modalPresentationStyle = .fullScreen
                             
    self.present(navController, animated:true, completion: nil)
                      
}
let cancelaction = MDCAlertAction(title:"Cancel")
{ (cancelaction) in
    
    self.view.window!.rootViewController?.dismiss(animated: false, completion: nil)
 
 let touch = UITouch()
 touch.view?.isUserInteractionEnabled = false
}
                    
alertController.addAction(action)
                        
alertController.addAction(cancelaction)
self.present(alertController, animated: true, completion: nil)
}
    */
    func getPPVplans(movieuniqids:String,planid:String)
    {
        guard let parameters =
            [
                "authToken":Keycenter.authToken,
                "movie_id":movieuniqids            ]
                as? [String:Any] else { return  }
       // let currentController = self.getCurrentViewController()

        Common1.Commonapi4(parameters: parameters, urlString: CommonApiEndPoints.GetPpvPlan) { (data, err) -> (Void) in
            do
            {
                let decoder = JSONDecoder()
                self.PPVdata = try decoder.decode(PPVplans.self, from: data ?? Data())
                if self.PPVdata?.status == "OK"
                {
                    if self.PPVdata?.plan.count ?? 0 > 0
                    {
                    
                        for i in self.PPVdata?.plan ?? [Plan]()
                        {
                            if i.planID == planid
                            {
                                let alertController = MDCAlertController(title: "BigFan TV", message:  "Purchase \(i.planName) plan for \(self.PPVdata?.currencySymbol ?? "") \(i.priceForSubscribed) to watch this movie")
                                let action = MDCAlertAction(title:"Subscribe")
                                                                { (action) in
                                    let storyBoard: UIStoryboard = UIStoryboard(name: "Main", bundle: nil)
                                    let VC1 = storyBoard.instantiateViewController(withIdentifier: "BuyPlanVC") as! BuyPlanVC
                                    let url = "https://bigfantv.com/en/rest/makeStripePayment?authToken=\(Keycenter.authToken)&user_id=\(UserDefaults.standard.string(forKey: "id") ?? "")&movie_unique_id=\(movieuniqids)&plan_id=\(i.planID)&payment_type=1&timeframe_id=933"
                                    VC1.planurl = url
                                    let navController = UINavigationController(rootViewController: VC1) // Creating a navigation controller with VC1 at the root of the navigation stack.
                                                             
                                    navController.navigationBar.barTintColor = Appcolor.backgorund3
                                    navController.navigationBar.isTranslucent = false
                                    navController.modalPresentationStyle = .fullScreen
                                                             
                                    self.present(navController, animated:true, completion: nil)
                                                      
                                }
                                let cancelaction = MDCAlertAction(title:"Cancel")
                                { (cancelaction) in
                                    
                                    self.view.window!.rootViewController?.dismiss(animated: false, completion: nil)
                                 
                                 let touch = UITouch()
                                 touch.view?.isUserInteractionEnabled = false
                                }
                                                    
                                alertController.addAction(action)
                                                        
                                alertController.addAction(cancelaction)
                                self.present(alertController, animated: true, completion: nil)
                                
                            }
                        }
                     
                    }else
                    {
                       // self.RadioView.isHidden = true
                    }
                }
                
            }catch
            {
                print(error.localizedDescription)
            }
        }
        
     }

}
extension SongsDetailsVC:MuviPlayerPlaybackDelegate
{
    func backButtonAction(player: MuviVideoPlayer, item: MuviPlayerItem?) {
    
        self.dismiss(animated: true, completion: nil)

    }
    func startBuffering(player: MuviVideoPlayer) {
      
        
    }
    
    func playbackWillBegin(player: MuviVideoPlayer) {
        self.playerview.controls?.hideBuffering()
    }
}
