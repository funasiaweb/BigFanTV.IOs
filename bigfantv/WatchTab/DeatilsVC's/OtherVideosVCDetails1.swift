//
//  LiveTvDetailsVC.swift
//  bigfantv
//
//  Created by Ganesh on 20/07/20.
//  Copyright © 2020 Ganesh. All rights reserved.
//

import UIKit
import MaterialComponents.MDCTabBar
import MuviPlayer
import CoreMedia
import PassKit
import StoreKit
import MuviSDK
class OtherVideosVCDetails1: UIViewController ,UIPopoverPresentationControllerDelegate{
    @IBOutlet var ImgMovie: UIImageView!
      
      @IBOutlet var LbName: UILabel!
    
      @IBOutlet var LbGener: UILabel!
    var productsArray = [SKProduct]()

      
      @IBOutlet var LbTimenReleasedate: UILabel!
      @IBOutlet var LbLanguage: UILabel!
    private var authorizeddata:Authorizescontent?

      @IBOutlet var LbDescription: UILabel!
     var imagename = ""
     var moviename = ""
     var movietype = ""
     var timereleasedate  = ""
     var language = ""
     var movdescription: String = ""
     var currentTrack: Track!
    var sportsdata:newFilteredComedyMovieList?
    var spirtualdata:newFilteredComedyMovieList?
    var musicdata:newFilteredComedyMovieList?
    var newsdata:newFilteredComedyMovieList?
    var entertainmentdata:newFilteredComedyMovieList?
    var Subsportsdata = [newFilteredSubComedymovieList]()
    var Subspirtualdata = [newFilteredSubComedymovieList]()
    var Submusicdata = [newFilteredSubComedymovieList]()
    var Subnewsdata = [newFilteredSubComedymovieList]()
    var Subentertainmentdata = [newFilteredSubComedymovieList]()
        @IBOutlet var Viback: UIView!
        @IBOutlet var ViDetails: UIView!
        @IBOutlet var CollectionV: UICollectionView!
        @IBOutlet var ViTab: UIView!
    var contentdata:contentdetails?
     var perma = ""
      var playerUrl:URL?
        
    var Movcategory = ""
    var MovSubcategory = ""
     var cellIdentifier = "cell"
     var movieuniqid = ""
    @IBOutlet var ViPlayer: UIView!
    var ActionMoviedata:newFilteredComedyMovieList?
    var actiondata = [newFilteredSubComedymovieList]()
     var Isfavourite = 0
    var contenttypesid = ""
     var Successdata:SuccessResponse?
    
     @IBOutlet var BtFav: UIButton!
    var isFullscreen = false
    var screenheight = 0.0
    var screenwidth = 0.0
    let sampledata:[sample] = [
          sample(img: "c1", labletext: "kolhapur"),
          sample(img: "c2", labletext: "kolhapur"),
          sample(img: "c3", labletext: "kolhapur"),
          sample(img: "c5", labletext: "kolhapur"),
          sample(img: "c6", labletext: "kolhapur")
            ]
            
            var WatchDuration = 0
          
        let playerview = MuviPlayerView()
      var playerurlstr = ""
    var IsAuthorizedContent = 0
    var PPVdata:PPVplans?

            override func viewDidLoad() {
            super.viewDidLoad()
                
                   self.playerview.backgroundColor = .black
                 self.playerview.playbackDelegate = self
                  self.playerview.useMuviPlayerControls = true
                 self.playerview.controls?.showBuffering()
                 self.playerview.controls?.multipleAudioButton?.isHidden = true
                 self.playerview.controls?.subtitleButton?.isHidden = true
                 self.playerview.controls?.pollingCardButton.isHidden = true
                 self.playerview.controls?.pipButton?.isHidden = true
                 self.playerview.controls?.multipleAudioButton?.set(active: false)
                 self.playerview.controls?.subtitleButton?.set(active: false)
                self.playerview.controls?.backButton?.set(active: true)
                              self.playerview.controls?.playPauseButton?.set(active: true)
                              self.playerview.controls?.pipButton?.isHidden = false
                            //  self.playerview.controls?.fullscreenButton?.isHidden = false
                            //  self.playerview.controls?.fullscreenButton?.set(active: true)
                 
                              self.playerview.controls?.forwardButton?.isHidden = false
                              self.playerview.controls?.rewindButton?.isHidden = false
                              self.playerview.controls?.rewindButton?.set(active: true)
                              self.playerview.controls?.resolutionButton?.isHidden = false
                              self.playerview.enablePlaybackSpeed = true
              self.CollectionV.register(UINib(nibName:"MyCell", bundle:nil), forCellWithReuseIdentifier: cellIdentifier)
                self.playerview.frame = CGRect(x: 0, y: 0 , width:self.view.frame.size.width, height: self.ViPlayer.frame.size.height)
                 self.view.addSubview(playerview)
          NotificationCenter.default.addObserver(self, selector:#selector(stopplayer), name:UIApplication.didEnterBackgroundNotification, object: nil)
                Timer.scheduledTimer(withTimeInterval: 0.1, repeats: false) { (t) in
                           
                                            if Connectivity.isConnectedToInternet()
                                            {
                                               self.getcontendeatils(permaa: self.perma)
                                               self.GetActionMovielist()
                                                
                                            }else
                                            {
                                                Utility.Internetconnection(vc: self)
                                            }
                                        }
                           
              }
          @objc func stopplayer()
          {
            if self.playerview.isPlaying
            {
             let cmtime = self.playerview.player.currentTime()
             let floattime = Float(CMTimeGetSeconds(cmtime))
               if Connectivity.isConnectedToInternet()
               {
                    savelog(duration: floattime)
               }
           self.playerview.player.pause()
                
            }
            
    }
                 func savelog(duration:Float)
                    {
                        Api.SavevideoLog(movieuniqid, ip_address: "12334535464", duration: duration, endpoint: ApiEndPoints.VideoLogNew, vc: self)   { (res, err) -> (Void) in
                             do
                             {
                                 let decoder = JSONDecoder()
                                 self.Successdata = try decoder.decode(SuccessResponse.self, from: res  ?? Data())
                               
                                 if self.Successdata?.code == 200
                                 {
                                    
                                     
                                 }else
                                  {
                                      

                                 }
                                
                             }
                             catch let error
                             {
                                 Utility.showAlert(vc: self, message:"\(error)", titelstring: Appcommon.Appname)
                             }
                            
                        }
                    }
        override func viewWillAppear(_ animated: Bool) {
            if Isfavourite == 0
           {
            self.BtFav.setBackgroundImage(UIImage(named: "like"), for: .normal)
           }
            else if Isfavourite == 1
            {
                self.BtFav.setBackgroundImage(UIImage(named: "liked"), for: .normal)
             }
 
        }
    override func viewDidAppear(_ animated: Bool) {
       
         
        let tabBar = MDCTabBar(frame: CGRect(x: 0, y:0, width: ViTab.bounds.width, height: 80))
              tabBar.items = [
              UITabBarItem(title: "Similar", image: UIImage(named: "phone"), tag: 0)
              
              ]
              tabBar.itemAppearance = .titles
              tabBar.displaysUppercaseTitles = false
              tabBar.tintColor = .white
              tabBar.bottomDividerColor = UIColor.gray
              tabBar.selectedItemTintColor = .white
              tabBar.barTintColor = .clear
              tabBar.alignment = .justified
              tabBar.selectedItemTitleFont = UIFont(name: "Muli-Bold", size: 18)!
              tabBar.unselectedItemTitleFont = UIFont(name: "Muli-Bold", size: 16)!
              tabBar.delegate = self
              tabBar.autoresizingMask = [.flexibleWidth, .flexibleBottomMargin]
              tabBar.sizeToFit()
        
              ViTab.addSubview(tabBar)
    }

    override func viewWillDisappear(_ animated: Bool) {
        if playerview.isPlaying
        {
            self.playerview.pause()
        }
    }
    @IBAction func BtShareTapped(_ sender: UIButton) {
          let url = URL(string:imagename)
        
          if let data = try? Data(contentsOf: url!)
          {
              let image: UIImage = UIImage(data:data)!
              guard  let videoLink =  URL(string: playerurlstr) else {return}
              let radioShoutout =  "Please download the BigFan TV application to view the content : \(videoLink)"
              //currentTrack.artworkImage = image
              
               currentTrack = Track(title: moviename, artworkImage: image)
               
            
              let shareImage = ShareImageGenerator(radioShoutout: radioShoutout, track: currentTrack).generate()
              
              let activityViewController = UIActivityViewController(activityItems: [radioShoutout, shareImage], applicationActivities: nil)
              activityViewController.popoverPresentationController?.sourceRect = CGRect(x: view.center.x, y: view.center.y, width: 0, height: 0)
              activityViewController.popoverPresentationController?.sourceView = view
              activityViewController.popoverPresentationController?.permittedArrowDirections = UIPopoverArrowDirection(rawValue: 0)
              
              activityViewController.completionWithItemsHandler = {(activityType: UIActivity.ActivityType?, completed:Bool, returnedItems:[Any]?, error: Error?) in
                  if completed
                  {
                      // do something on completion if you want
                  }
              }
              present(activityViewController, animated: true, completion: nil)
              
          }
                       let firstActivityItem = "Please download the BigFan TV application to view the content."
                            let videoLink =  URL(string: playerurlstr)
                           let activityVC = UIActivityViewController(activityItems: [firstActivityItem, videoLink!], applicationActivities: nil)
                        // activityVC.setValue("Video", forKey: "subject")
                         //New Excluded Activities Code
                         if #available(iOS 13.0, *) {
                             activityVC.excludedActivityTypes = [
                                 
                                 UIActivity.ActivityType.airDrop,
                                 UIActivity.ActivityType.addToReadingList,
                                 UIActivity.ActivityType.assignToContact,
                                 UIActivity.ActivityType.copyToPasteboard,
                                 UIActivity.ActivityType.mail,
                                 UIActivity.ActivityType.message,
                                 UIActivity.ActivityType.openInIBooks,
                                 UIActivity.ActivityType.postToTencentWeibo,
                                 UIActivity.ActivityType.postToVimeo,
                                 UIActivity.ActivityType.postToWeibo,
                                 UIActivity.ActivityType.print]
                         } else {
                             // Fallback on earlier versions
                             activityVC.excludedActivityTypes = [
                                 UIActivity.ActivityType.airDrop,
                                 UIActivity.ActivityType.addToReadingList,
                                 UIActivity.ActivityType.assignToContact,
                                 UIActivity.ActivityType.copyToPasteboard,
                                 UIActivity.ActivityType.mail,
                                 UIActivity.ActivityType.message,
                                 UIActivity.ActivityType.postToTencentWeibo,
                                 UIActivity.ActivityType.postToVimeo,
                                 UIActivity.ActivityType.postToWeibo,
                                 UIActivity.ActivityType.print ]
                         }
                  //       self.present(activityVC, animated: true, completion: nil)
                         if let popOver = activityVC.popoverPresentationController {
                             popOver.sourceView = view
                             popOver.sourceRect = CGRect(x: view.frame.size.width - 100, y: 100, width: 400, height: 30)
                             popOver.delegate = self
                             popOver.permittedArrowDirections = .right
                                               
                             //popOver.barButtonItem
                         }
             }
    @objc func deviceOrientationDidChange() {
       switch UIDevice.current.orientation {
       case .faceUp, .faceDown, .portrait, .unknown, .portraitUpsideDown:
         // default the player to original rotation
         self.playerview.transform = .identity
         self.playerview.frame = CGRect(x: 0, y:  20, width: self.view.frame.size.width  ,  height: self.ViPlayer.frame.size.height)
       //  self.playerview.frame = CGRect(x: 0, y:  self.playerview.safeAreaInsets.top, width: self.view.bounds.width, height: self.Viplayer.frame.size.height)

       case .landscapeLeft:
         self.playerview.transform = CGAffineTransform(rotationAngle: CGFloat((90 * Double.pi)/180))
        self.playerview.frame = CGRect(x: 0, y: 0, width: screenwidth, height: screenheight)

       case .landscapeRight:
         self.playerview.transform = CGAffineTransform(rotationAngle: CGFloat((-90 * Double.pi)/180))
         self.playerview.frame = CGRect(x: 0, y: 0, width: screenwidth, height: screenheight)
       @unknown default:
         print("")
         }
     }
             @IBAction func BtFavouriteTapped(_ sender: UIButton) {
                 if Connectivity.isConnectedToInternet()
                 {
                     self.Addtofav()
                 }else
                 {
                     Utility.Internetconnection(vc: self)
                 }
             }
             func Addtofav()
                      {
                         if Isfavourite == 0
                               {
                               Api.Addtofavourite(UserDefaults.standard.string(forKey: "id") ?? "", movie_uniq_id: movieuniqid, lang_code: "en", content_type: 0, endpoint: ApiEndPoints.AddToFavlist, vc: self)  { (res, err) -> (Void) in
                                                   do
                                                   {
                                                       let decoder = JSONDecoder()
                                                       self.Successdata = try decoder.decode(SuccessResponse.self, from: res  ?? Data())
                                               
                                                       if self.Successdata?.code == 200
                                                       {
                                                         
                                                           self.BtFav.setBackgroundImage(UIImage(named: "liked"), for: .normal)
                                                             self.Isfavourite = 1
                                                       }
                                                      
                                                   }
                                                   catch let error
                                                   {
                                                       Utility.showAlert(vc: self, message:"\(error)", titelstring: Appcommon.Appname)
                                                   }
                                               }
                               }else if Isfavourite == 1
                               {
                                   Api.Addtofavourite(UserDefaults.standard.string(forKey: "id") ?? "", movie_uniq_id: movieuniqid, lang_code: "en", content_type: 0, endpoint: ApiEndPoints.DeleteFavLIst, vc: self)  { (res, err) -> (Void) in
                                                              do
                                                              {
                                                                  let decoder = JSONDecoder()
                                                                  self.Successdata = try decoder.decode(SuccessResponse.self, from: res  ?? Data())
                                                                 print(self.Successdata?.msg)
                                                                  if self.Successdata?.code == 200
                                                                  {
                                                                    
                                                                     self.BtFav.setBackgroundImage(UIImage(named: "like"), for: .normal)
                                                                       self.Isfavourite = 0
                                                                  }
                                                                 
                                                              }
                                                              catch let error
                                                              {
                                                                  Utility.showAlert(vc: self, message:"\(error)", titelstring: Appcommon.Appname)
                                                              }
                                                          }
                               }
                      }
             
     func GetActionMovielist()
                  {
                    print(MovSubcategory)
                      
                      Api.Getconent(Movcategory, subCat: MovSubcategory, endpoint: ApiEndPoints.getFilteredContent, vc: self, offset: 1) { (res, err) -> (Void) in
                                      do
                                      {
                                          let decoder = JSONDecoder()
                                          self.ActionMoviedata = try decoder.decode(newFilteredComedyMovieList.self, from: res  ?? Data())
                                        for item in self.ActionMoviedata?.subComedymovList ?? [newFilteredSubComedymovieList]()
                                        {
                                            if item.movie_uniq_id == self.movieuniqid
                                            {
                                                
                                            }else
                                            {
                                                self.actiondata.append(item)
                                            }
                                            
                                        }
                                        
                                        self.CollectionV.delegate = self
                                        self.CollectionV.dataSource = self
                                          DispatchQueue.main.async
                                              {
                                              self.CollectionV.reloadData()
                                              }
                                         
                                      }
                                      catch let error
                                      {
                                          Utility.showAlert(vc: self, message:"\(error)", titelstring: Appcommon.Appname)
                                      }
                                  }
                        }
    func getcontendeatils(permaa:String)
       {
           Api.getcontentdetails(permaa, endpoint: ApiEndPoints.getcontentdetails, vc: self) { (res, err) -> (Void) in
               do{
                      
                   let decoder = JSONDecoder()
                   self.contentdata = try decoder.decode(contentdetails.self, from: res  ?? Data())
                         
                   self.LbName.text = self.contentdata?.submovie?.name
                   self.LbDescription.text = self.contentdata?.submovie?.story
                   self.LbGener.text = self.contentdata?.submovie?.custommetadata?.language_type
                      
                   if  let myString = self.contentdata?.submovie?.video_duration
                   {
                       let myStringArr = myString.components(separatedBy: ":")
                           //self.LbTimenReleasedate.text = "\(myStringArr[0])hours :\(myStringArr[1])min) | \(self.contentdata?.submovie?.custommetadata?.language_type ?? "")"
                   }
                
                           
                           
                           self.playerview.playbackDelegate = self
                           self.playerview.useMuviPlayerControls = true
                           self.playerview.controls?.showBuffering()
                         
              self.playerview.controls?.multipleAudioButton?.isHidden = true
              self.playerview.controls?.subtitleButton?.isHidden = true
              self.playerview.controls?.pollingCardButton.isHidden = true
              self.playerview.controls?.pipButton?.isHidden = true
              self.playerview.controls?.multipleAudioButton?.set(active: false)
              self.playerview.controls?.subtitleButton?.set(active: false)
               
           self.playerview.controls?.playPauseButton?.set(active: true)
           self.playerview.controls?.pipButton?.isHidden = false
           self.playerview.controls?.fullscreenButton?.isHidden = false
          // self.playerview.controls?.fullscreenButton?.set(active: true)
           self.playerview.controls?.forwardButton?.isHidden = true
           self.playerview.controls?.rewindButton?.isHidden = true
           self.playerview.controls?.rewindButton?.set(active: true)
           self.playerview.controls?.resolutionButton?.isHidden = false
           self.playerview.enablePlaybackSpeed = true
              
                   if self.contentdata?.code == 200 && self.contentdata?.msg == "Ok"
                   {
                   if self.IsAuthorizedContent == 1
                  {
                   
                   if self.contenttypesid == "4"
                   {
                       if let url = URL(string:   self.contentdata?.submovie?.feed_url ?? "")
                               {
                                   let item = MuviPlayerItem(url: url)
                                   self.playerview.set(item: item)
                          
                                   self.playerview.player.play()
                       
                                   if self.WatchDuration != 0
                                   {
                                       let timeIntvl: TimeInterval = TimeInterval(self.WatchDuration)
                                       let cmTime = CMTime(seconds: timeIntvl, preferredTimescale: 1)
                                       self.playerview.player.seek(to: cmTime)
                                       
                                   }
                                       
                               }
                           }
                   else
                   {
                       if let url = URL(string:   self.contentdata?.submovie?.movieUrl ?? "")
                        {
                           let item = MuviPlayerItem(url: url)
                           self.playerview.set(item: item)
                          
                           self.playerview.player.play()
                      
                           if self.WatchDuration != 0
                           {
                               let timeIntvl: TimeInterval = TimeInterval(self.WatchDuration)
                               let cmTime = CMTime(seconds: timeIntvl, preferredTimescale: 1)
                               self.playerview.player.seek(to: cmTime)
                           }
                           
                       }
                       
                   }
                   }else
                       {
                           Utility.showAlert(vc: self, message:"\(self.contentdata?.msg ?? "")", titelstring: Appcommon.Appname)

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
   func getcontendeatilsAfterppv(permaa:String)
      {
          Api.getcontentdetailsafterppv(permaa, endpoint: ApiEndPoints.getcontentdetails, vc: self) { (res, err) -> (Void) in
              do{
                     
                  let decoder = JSONDecoder()
                  self.contentdata = try decoder.decode(contentdetails.self, from: res  ?? Data())
                        
               
                  self.LbName.text = self.contentdata?.submovie?.name
                  self.LbDescription.text = self.contentdata?.submovie?.story
                  self.LbGener.text = self.contentdata?.submovie?.custommetadata?.language_type
                     
                  if  let myString = self.contentdata?.submovie?.video_duration
                  {
                      let myStringArr = myString.components(separatedBy: ":")
                          //self.LbTimenReleasedate.text = "\(myStringArr[0])hours :\(myStringArr[1])min) | \(self.contentdata?.submovie?.custommetadata?.language_type ?? "")"
                  }
               
                          
                          
                          self.playerview.playbackDelegate = self
                          self.playerview.useMuviPlayerControls = true
                          self.playerview.controls?.showBuffering()
                        
             self.playerview.controls?.multipleAudioButton?.isHidden = true
             self.playerview.controls?.subtitleButton?.isHidden = true
             self.playerview.controls?.pollingCardButton.isHidden = true
             self.playerview.controls?.pipButton?.isHidden = true
             self.playerview.controls?.multipleAudioButton?.set(active: false)
             self.playerview.controls?.subtitleButton?.set(active: false)
              
          self.playerview.controls?.playPauseButton?.set(active: true)
          self.playerview.controls?.pipButton?.isHidden = false
          self.playerview.controls?.fullscreenButton?.isHidden = false
         // self.playerview.controls?.fullscreenButton?.set(active: true)
          self.playerview.controls?.forwardButton?.isHidden = true
          self.playerview.controls?.rewindButton?.isHidden = true
          self.playerview.controls?.rewindButton?.set(active: true)
          self.playerview.controls?.resolutionButton?.isHidden = false
          self.playerview.enablePlaybackSpeed = true
             
                   
               if self.contentdata?.code == 200 && self.contentdata?.msg == "Ok"
               {
                  if self.contenttypesid == "4"
                  {
                      if let url = URL(string:   self.contentdata?.submovie?.feed_url ?? "")
                              {
                                  let item = MuviPlayerItem(url: url)
                                  self.playerview.set(item: item)
                         
                                  self.playerview.player.play()
                      
                                  if self.WatchDuration != 0
                                  {
                                      let timeIntvl: TimeInterval = TimeInterval(self.WatchDuration)
                                      let cmTime = CMTime(seconds: timeIntvl, preferredTimescale: 1)
                                      self.playerview.player.seek(to: cmTime)
                                      
                                  }
                                      
                              }
                          }
                  else
                  {
                      if let url = URL(string:   self.contentdata?.submovie?.movieUrl ?? "")
                       {
                          let item = MuviPlayerItem(url: url)
                          self.playerview.set(item: item)
                         
                          self.playerview.player.play()
                     
                          if self.WatchDuration != 0
                          {
                              let timeIntvl: TimeInterval = TimeInterval(self.WatchDuration)
                              let cmTime = CMTime(seconds: timeIntvl, preferredTimescale: 1)
                              self.playerview.player.seek(to: cmTime)
                          }
                          
                      }
                   
                  }
               }else
               {
                  // Utility.showAlert(vc: self, message:"\(self.contentdata?.msg ?? "")", titelstring: Appcommon.Appname)

               }
                  
                  
              }
                 catch let error
                 {
                    // Utility.showAlert(vc: self, message:"\(error)", titelstring: Appcommon.Appname)
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
    func getPPVplans(movieuniqids:String,planid:String)
   {
       guard let parameters =
           [
               "authToken":Keycenter.authToken,
               "movie_id":movieuniqids            ]
               as? [String:Any] else { return  }
      // let currentController = self.getCurrentViewController()

       print(parameters)
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
                                   
                                   self.buyTheccontents(planId: i.externalID, movieid: movieuniqids)
                                                     
                               }
                               let cancelaction = MDCAlertAction(title:"Cancel")
                               { (cancelaction) in
                                   
                                   self.view.window!.rootViewController?.dismiss(animated: false, completion: nil)
                                
                                 }
                                                   
                               alertController.addAction(action)
                                                       
                               alertController.addAction(cancelaction)
                               self.present(alertController, animated: true, completion: nil)
                               
                           }
                       }
                    
                   }else
                   {
                       Utility.showAlert(vc: self, message: "No PPV plans available", titelstring: Appcommon.Appname)                    }
               }
               
           }catch
           {
            Utility.showAlert(vc: self, message: "\(error.localizedDescription)", titelstring: Appcommon.Appname)             }
       }
       
    }
           
   func buyTheccontents(planId:String,movieid:String)
   {
       Utility.ShowLoader(vc: self)
       let Canmakepurchase = PKIAPHandler.shared.canMakePurchases()
        if Canmakepurchase
        {
            PKIAPHandler.shared.setProductIds(ids: ["\(planId)"])

            PKIAPHandler.shared.fetchAvailableProducts { [weak self](products)   in
               
                guard let sSelf = self else {return}
                
                sSelf.productsArray = products
               PKIAPHandler.shared.purchase(product: sSelf.productsArray[0]) { (alert, product, transaction) in
                   Utility.hideLoader(vc: self ?? UIViewController() )
                   if let _ = transaction, let _ = product
                  {
                    //use transaction details and purchased product as you want
                 let userids =  UserDefaults.standard.string(forKey: "id") ?? ""
                   let input = InAppPpvPaymentInput(userId: userids, movieId: movieid)
                 
                   MuviAPISDK.controller.inAppPpvPaymentDataTask(input) { (result) in
                       switch result
                       {
                       case .success(let output, let response):
                           self?.getcontendeatilsAfterppv(permaa: self?.perma ?? "")
                           print("output ::: \(response)")
                       case .failure(let error):
                           
                         
                           print("error \(error.errorDescription)")
                       }
                   }
                  
                  }
                //  Globals.shared.showWarnigMessage(alert.message)
                  }

            }
            
        }else
        {
            Utility.showAlert(vc: self, message: "Cannot purchase the plan", titelstring: "")
         }
       
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
 */
    @IBAction func BackBtTapped(_ sender: UIButton) {
        let cmtime = self.playerview.player.currentTime()
        let floattime = Float(CMTimeGetSeconds(cmtime))
          if Connectivity.isConnectedToInternet()
          {
               savelog(duration: floattime)
          }
        self.navigationController?.popViewController(animated: true)
        }
        
    }
    extension OtherVideosVCDetails1:MDCTabBarDelegate
    {

        func tabBar(_ tabBar: MDCTabBar, didSelect item: UITabBarItem) {
            
            if item.tag == 0
            {
                  CollectionV.isHidden = false
               
                
            }else if item.tag == 1
            {
               
                CollectionV.isHidden = true
            }
          
        }
        
    }

    extension OtherVideosVCDetails1:UICollectionViewDelegate,UICollectionViewDataSource
    {
        func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
            if actiondata.count ?? 0 <= 0
            {
                CollectionV.setEmptyViewnew1(title:"No Similar Channels found")
                
            }else
            {
                CollectionV.restore()
                
            }
            
            return actiondata.count
        }
        
        func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell
        {
          
                     let Actioncell = collectionView.dequeueReusableCell(withReuseIdentifier: cellIdentifier, for: indexPath) as! MyCell
                     let item = actiondata[indexPath.row]
                        Actioncell.ImgSample.sd_setImage(with: URL(string: "\(item.poster ?? "")"), completed: nil)
                       // Actioncell.ViLabel.isHidden = true
                         Actioncell.LbName.text = item.title ?? ""
                     
                  return Actioncell
         
        }
        func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath)
        {
            
             imagename = ActionMoviedata?.subComedymovList[indexPath.row].poster ?? ""
             moviename = ActionMoviedata?.subComedymovList[indexPath.row].title ?? ""
             perma = ActionMoviedata?.subComedymovList[indexPath.row].c_permalink ?? ""
            Isfavourite = ActionMoviedata?.subComedymovList[indexPath.row].is_fav_status ?? 0
            movieuniqid = ActionMoviedata?.subComedymovList[indexPath.row].movie_uniq_id ?? ""
            WatchDuration = ActionMoviedata?.subComedymovList[indexPath.row].watch_duration_in_seconds ?? 0
            playerurlstr = ActionMoviedata?.subComedymovList[indexPath.row].permalink ?? ""
            getcontentauthorised(movieid: ActionMoviedata?.subComedymovList[indexPath.row].movie_uniq_id ?? "")
                               
                   }
        func getcontentauthorised(movieid:String)
        {
         Utility.ShowLoader(vc: self)
         Api.IsContentAuthorised(movieid, endpoint: ApiEndPoints.isContentAuthorized, vc: UIViewController()) { (res, err) -> (Void) in
                              
             do{
                                  
                 let decoder = JSONDecoder()
                 self.authorizeddata = try decoder.decode(Authorizescontent.self, from: res  ?? Data())
                                 
                 if self.authorizeddata?.status == "OK"
                 {
                     Utility.hideLoader(vc: self)

                    let storyBoard: UIStoryboard = UIStoryboard(name: "Main", bundle: nil)
                    let displayVC = storyBoard.instantiateViewController(withIdentifier: "OtherVideosVCDetails") as! OtherVideosVCDetails
                       displayVC.modalPresentationStyle = .fullScreen
                       displayVC.imagename = self.imagename
                       displayVC.moviename = self.moviename
                       displayVC.movietype = self.movietype
                       displayVC.timereleasedate = self.timereleasedate
                       displayVC.language = self.language
                       displayVC.movdescription = self.movdescription
                      displayVC.perma = self.perma
                       displayVC.Movcategory = self.Movcategory
                       displayVC.MovSubcategory = self.MovSubcategory
                       displayVC.movieuniqid = self.movieuniqid
                       displayVC.Isfavourite = self.Isfavourite
                       displayVC.WatchDuration = self.WatchDuration
                       displayVC.contenttypesid = self.contenttypesid
                    displayVC.IsAuthorizedContent = 1
                    displayVC.playerurlstr = self.playerurlstr

                   self.present(displayVC, animated: true, completion: nil)
                   
                 
                 }else
                 {
                     Utility.hideLoader(vc: self)

                    let storyBoard: UIStoryboard = UIStoryboard(name: "Main", bundle: nil)
                    let displayVC = storyBoard.instantiateViewController(withIdentifier: "OtherVideosVCDetails") as! OtherVideosVCDetails
                       displayVC.modalPresentationStyle = .fullScreen
                       displayVC.imagename = self.imagename
                       displayVC.moviename = self.moviename
                       displayVC.movietype = self.movietype
                       displayVC.timereleasedate = self.timereleasedate
                       displayVC.language = self.language
                       displayVC.movdescription = self.movdescription
                      displayVC.perma = self.perma
                       displayVC.Movcategory = self.Movcategory
                       displayVC.MovSubcategory = self.MovSubcategory
                       displayVC.movieuniqid = self.movieuniqid
                       displayVC.Isfavourite = self.Isfavourite
                       displayVC.WatchDuration = self.WatchDuration
                       displayVC.contenttypesid = self.contenttypesid
                    displayVC.IsAuthorizedContent = 0
                    displayVC.playerurlstr = self.playerurlstr
                   self.present(displayVC, animated: true, completion: nil)
                    
                   
                     
                 }
                 
             }
             catch let error
             {
                 Utility.hideLoader(vc: self)

                             //     Utility.showAlert(vc: self, message:"\(error)", titelstring: Appcommon.Appname)
                              }
                          }
       
             
        }
                       
    }
       
    extension OtherVideosVCDetails1: UICollectionViewDelegateFlowLayout {
            func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
                let widths = (collectionView.frame.size.height * 280)/156
              
          let  itemSize = CGSize(width: widths, height: collectionView.frame.size.height)
                    return itemSize
                
            }
        }
     

extension OtherVideosVCDetails1:MuviPlayerPlaybackDelegate
{
    func backButtonAction(player: MuviVideoPlayer, item: MuviPlayerItem?) {
       let cmtime = self.playerview.player.currentTime()
        let floattime = Float(CMTimeGetSeconds(cmtime))
        
        if !floattime.isNaN
        {
          if Connectivity.isConnectedToInternet()
          {
               savelog(duration: floattime)
          }else
           {
              

          }
        }else
         {
        

        }
            self.view.window!.rootViewController?.dismiss(animated: false, completion: nil)
        
        let touch = UITouch()
        touch.view?.isUserInteractionEnabled = false
    }
    func startBuffering(player: MuviVideoPlayer) {
      
        
    }
    func fullscreenButtonAction(player: MuviVideoPlayer, item: MuviPlayerItem?)
      {
         if isFullscreen
          {
              isFullscreen = false
              self.playerview.transform = .identity
              self.playerview.frame = CGRect(x: 0, y:  self.playerview.safeAreaInsets.top, width: self.view.frame.size.width  ,  height: self.ViPlayer.frame.size.height)
          } else
         {
            isFullscreen = true
          self.playerview.transform = CGAffineTransform(rotationAngle: CGFloat((90 * Double.pi)/180))
          self.playerview.frame = CGRect(x: 0, y: 0, width:  UIScreen.main.bounds.size.width    , height:UIScreen.main.bounds.size.height)

         }
      }
    
    func playbackWillBegin(player: MuviVideoPlayer) {
        self.playerview.controls?.hideBuffering()
    }
}
