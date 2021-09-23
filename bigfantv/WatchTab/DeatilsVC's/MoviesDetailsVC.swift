//
//  MoviesDetailsVC.swift
//  bigfantv
//
//  Created by Ganesh on 17/07/20.
//  Copyright © 2020 Ganesh. All rights reserved.
//

import UIKit
import MaterialComponents.MDCTabBar
import SDWebImage
 
import SafariServices
import AVKit
import MuviPlayer
import PassKit
import StoreKit
import MuviSDK
class MoviesDetailsVC: UIViewController,UIPopoverPresentationControllerDelegate {
    
    
    @IBOutlet var ImgMovie: UIImageView!
    @IBOutlet var star1: UIImageView!
    @IBOutlet var star2: UIImageView!
    @IBOutlet var star3: UIImageView!
    @IBOutlet var star4: UIImageView!
    @IBOutlet var star5: UIImageView!
    @IBOutlet var star6: UIImageView!
    @IBOutlet var star7: UIImageView!
    @IBOutlet var star8: UIImageView!
    @IBOutlet var star9: UIImageView!
    @IBOutlet var star10: UIImageView!
    
    var totalrate = 0.0
     let fullStarImage:  UIImage = UIImage(named: "fullwhite")!
     let halfStarImage:  UIImage = UIImage(named: "halfwhite")!
     let emptyStarImage: UIImage = UIImage(named: "emptywhite")!
    
    
    @IBOutlet var LbName: UILabel!
    @IBOutlet var LbCategory: UILabel!
    @IBOutlet var LbProduction: UILabel!
    @IBOutlet var LbWriter: UILabel!
    var productsArray = [SKProduct]()

    @IBOutlet var LbGener: UILabel!
    @IBOutlet var LbActors: UILabel!
    
    @IBOutlet var Viplayer: UIView!
    var ComedyMoviedata:newFilteredComedyMovieList?
    var ThrillerMoviedata:newFilteredComedyMovieList?
    var ActionMoviedata:newFilteredComedyMovieList?
    var comedydata = [newFilteredSubComedymovieList]()
    var thrillerdata = [newFilteredSubComedymovieList]()
    var actiondata = [newFilteredSubComedymovieList]()
   
    var currentTrack: Track!
    var newperma = ""
    @IBOutlet var LbTimenReleasedate: UILabel!
    @IBOutlet var LbLanguage: UILabel!
    
    @IBOutlet var LbDescription: UILabel!
    
        @IBOutlet var Viback: UIView!
        @IBOutlet var ViDetails: UIView!
        @IBOutlet var CollectionV: UICollectionView!
        @IBOutlet var ViTab: UIView!
        let sampledata:[sample] = [
          sample(img: "a11", labletext: "kolhapur"),
          sample(img: "a11", labletext: "kolhapur"),
         sample(img: "a11", labletext: "kolhapur"),
          sample(img: "a11", labletext: "kolhapur"),
          sample(img: "a11", labletext: "kolhapur"),
           sample(img: "a11", labletext: "kolhapur"),
          sample(img: "a11", labletext: "kolhapur"),
            ]
            
    @IBOutlet var ViRating:UIView!
    
    var imagename = ""
    var moviename = ""
    var movietype = ""
    var timereleasedate  = ""
    var language = ""
    var movdescription: String = ""
    var imdbID = ""
    var IMDBdata:IMDBdataList?
    var contentdata:contentdetails?
    private var authorizeddata:Authorizescontent?
    var perma = ""
    var playerUrl:URL?
    var Movcategory = ""
    var MovSubcategory = ""
    let cellIdentifier = "cell"
     var imdbId = ""
      var movieuniqid = ""
    var isFullscreen = false
    var screenheight = 0.0
    var screenwidth = 0.0
    
    let playerview = MuviPlayerView()
     var Isfavourite = 0
     var Successdata:SuccessResponse?
    var WatchDuration = 0
    var contenttypeid = "1"
    @IBOutlet var BtFav: UIButton!
    
    
    //Episode details
    var episodedt:EdpisodeData?
    var Episodesdata = [Edpisodedetails]()
    var PaasEpisodesdata = [Edpisodedetails]()
    var totalconents = 0
    var index = 1
    var isloading:Bool?
    
    @IBOutlet var ViEpisode: UIView!
    @IBOutlet var EpisodeCollectionV: UICollectionView!
    var playerurlstr = ""
    
    var IsAuthorizedContent = 0
    var PPVdata:PPVplans?

    
    
    override func viewDidLoad()
    {
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
        self.playerview.controls?.forwardButton?.isHidden = false
        self.playerview.controls?.rewindButton?.isHidden = false
        self.playerview.controls?.rewindButton?.set(active: true)
                          self.playerview.controls?.resolutionButton?.isHidden = false
                          self.playerview.enablePlaybackSpeed = true

                   // NotificationCenter.default.addObserver(self, selector: #selector(deviceOrientationDidChange), name: UIDevice.orientationDidChangeNotification, object: nil)
        screenwidth = Double(UIScreen.main.bounds.width)
        screenheight = Double(UIScreen.main.bounds.height)
            
        self.playerview.frame = CGRect(x: 0, y: 0 , width:self.view.frame.size.width, height: self.Viplayer.frame.size.height)
        self.Viplayer.addSubview(playerview)
        
                          self.ViEpisode.isHidden = true
                          Timer.scheduledTimer(withTimeInterval: 0.1, repeats: false) { (t) in
                                   if Connectivity.isConnectedToInternet()
                                   {
                                      self.GetActionMovielist()
                                    if self.contenttypeid == "1"
                                    {
                                        print(self.perma)
                                      self.getcontendeatils(permaa: self.perma)
                                    }else if self.contenttypeid == "3"
                                    {
                                        self.getEpisodedeatils(permaa: self.perma, offset: 1)
                                    }
                                      if self.imdbID != ""
                                      {
                                          self.GetrMoviedetails()
                                          
                                      }else
                                      {
                                         self.LbName.text = self.moviename
                                      //  self.LbDescription.text  = self.movdescription
                                       //  self.LbTimenReleasedate.text = self.timereleasedate
                                       //  self.LbLanguage.text  = self.language
                                          
                                      }
                                   }else
                                   {
                                       Utility.Internetconnection(vc: self)
                                   }
                               }
                
       self.CollectionV.register(UINib(nibName:"MyCell", bundle:nil), forCellWithReuseIdentifier: cellIdentifier)
       self.EpisodeCollectionV.register(UINib(nibName:"MyCell", bundle:nil), forCellWithReuseIdentifier: cellIdentifier)
                NotificationCenter.default.addObserver(self, selector:#selector(stopplayer), name:UIApplication.didEnterBackgroundNotification, object: nil)
        

              
            
        let tabBar = MDCTabBar(frame: CGRect(x: 0, y:0, width: ViTab.bounds.width, height: 80))
   
        if contenttypeid == "1"
        {
            self.ViEpisode.isHidden = true
        tabBar.items = [
            UITabBarItem(title: "Similar", image: UIImage(named: "phone"), tag: 0),
            UITabBarItem(title: "More Details", image: UIImage(named: "heart"), tag: 1)
        ]
    }else if contenttypeid == "3"
    {
        self.ViEpisode.isHidden = false
        tabBar.items = [
            UITabBarItem(title: "Episodes", image: UIImage(named: "heart"), tag: 2),
           UITabBarItem(title: "Similar", image: UIImage(named: "phone"), tag: 0)
           
                   ]
                    }
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
    
    
    override func viewWillDisappear(_ animated: Bool)
    {
        if self.playerview.isPlaying
        {
            self.playerview.pause()
        }
    }
    
    
    func getEpisodedeatils(permaa:String,offset:Int)
    {
        Api.GetEpisodedetails(permaa,offset:offset, endpoint: ApiEndPoints.episodeDetails, vc: self) { (res, err) -> (Void) in
            do
            {
           
                let decoder = JSONDecoder()
                self.episodedt = try decoder.decode(EdpisodeData.self, from: res  ?? Data())
                
               if self.episodedt?.list?.count ?? 0 > 0
               {
         
                self.totalconents = Int(self.episodedt?.string_code ?? "") ?? 0
               
                for i in self.episodedt?.list ?? [Edpisodedetails]()
                {
                    self.Episodesdata.append(i)
                }
                
                let item = self.Episodesdata[0]
                let myString1: String = item.video_duration ?? ""
                let myStringArr1 = myString1.components(separatedBy: ":")
                let fr1 = "\(myStringArr1[0]) Hr \(myStringArr1[1]) Min \(myStringArr1[2]) Sec"
                self.LbName.text =  item.episode_title ?? ""
              //  self.LbGener.text = "Hindi"
                self.LbTimenReleasedate.text = "\(fr1) | \(item.episode_date ?? "")"
                self.LbDescription.text = item.episode_story ?? ""
                self.Episodesdata =  self.Episodesdata.filter({$0.episode_title != item.episode_title})
               
                if let url = URL(string:  item.video_url ?? "")
                 {
                     let item = MuviPlayerItem(url: url)
                     self.playerview.set(item: item)
                      self.playerview.player.play()
 
                }
                
          
                                            
               }
               
               self.EpisodeCollectionV.delegate = self
               self.EpisodeCollectionV.dataSource  = self
               DispatchQueue.main.async
                   {
                       self.EpisodeCollectionV.reloadData()
                    self.isloading = false
                   }
            
            }
            catch let error
            {
                Utility.showAlert(vc: self, message:"\(error)", titelstring: Appcommon.Appname)
            }
        }
    }
     @objc func deviceOrientationDidChange() {
        switch UIDevice.current.orientation {
        case .faceUp, .faceDown, .portrait, .unknown, .portraitUpsideDown:
          // default the player to original rotation
            self.ViRating.isHidden = false

          self.playerview.transform = .identity
          self.playerview.frame = CGRect(x: 0, y:  20, width: self.view.frame.size.width  ,  height: self.Viplayer.frame.size.height)
        //  self.playerview.frame = CGRect(x: 0, y:  self.playerview.safeAreaInsets.top, width: self.view.bounds.width, height: self.Viplayer.frame.size.height)

        case .landscapeLeft:
            self.ViRating.isHidden = true

          self.playerview.transform = CGAffineTransform(rotationAngle: CGFloat((90 * Double.pi)/180))
         self.playerview.frame = CGRect(x: 0, y: 0, width: screenwidth, height: screenheight)

        case .landscapeRight:
            self.ViRating.isHidden = true

          self.playerview.transform = CGAffineTransform(rotationAngle: CGFloat((-90 * Double.pi)/180))
          self.playerview.frame = CGRect(x: 0, y: 0, width: screenwidth, height: screenheight)
        @unknown default:
          print("")
          }
      }
    
    
    @IBAction func BtShareTapped(_ sender: UIButton)
    {
       
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
            /*
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
                self.present(activityVC, animated: true, completion: nil)
                if let popOver = activityVC.popoverPresentationController {
                    popOver.sourceView = view
                    popOver.sourceRect = CGRect(x: view.frame.size.width - 100, y: 100, width: 400, height: 30)
                    popOver.delegate = self
                    popOver.permittedArrowDirections = .right
                                      
                    //popOver.barButtonItem
                }
        */
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
                                                
                                                  self.BtFav.setBackgroundImage(UIImage(named: "likedw"), for: .normal)
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
                                                          if self.Successdata?.code == 200
                                                         {
                                                           
                                                            self.BtFav.setBackgroundImage(UIImage(named: "likew"), for: .normal)
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
                  if Movcategory != ""
                  {
                  Api.Getconent(Movcategory, subCat: MovSubcategory, endpoint: ApiEndPoints.getFilteredContent, vc: self, offset: 1) { (res, err) -> (Void) in
                                  do
                                  {
                                      let decoder = JSONDecoder()
                                      self.ActionMoviedata = try decoder.decode(newFilteredComedyMovieList.self, from: res  ?? Data())
                                    for item in self.ActionMoviedata?.subComedymovList ?? [newFilteredSubComedymovieList]()
                                    {
                                        if item.title == self.moviename
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
                    }
            
           
        override func viewWillAppear(_ animated: Bool)
        {
            if Isfavourite == 0
            {
                self.BtFav.setBackgroundImage(UIImage(named: "like"), for: .normal)
            }else if Isfavourite == 1
            {
                 self.BtFav.setBackgroundImage(UIImage(named: "liked"), for: .normal)
            }
            Viback.layer.cornerRadius = Viback.frame.size.height/2
            Viback.layer.borderColor = UIColor.clear.cgColor
            Viback.layer.borderWidth = 1
             ViDetails.isHidden = true
        }
        override func viewDidAppear(_ animated: Bool)
        {
 
           // screenshot()
             
        }
    
    func screenshot()
    {
        let alertController = MDCAlertController(title: "BigFan TV", message:  "Purchase PPVplan10 plan for $ 9.9 USD to watch this movie")
        
        let action = MDCAlertAction(title:"Subscribe"){ (action) in
            // self.buyTheccontents(planId: i.externalID, movieid: movieuniqids)
                              
        }
        let cancelaction = MDCAlertAction(title:"Cancel")
        { (cancelaction) in
            
            self.view.window!.rootViewController?.dismiss(animated: false, completion: nil)
         
          }
                            
        alertController.addAction(action)
                                
        alertController.addAction(cancelaction)
        self.present(alertController, animated: true, completion: nil)
    }
            
          
            func getcontendeatils(permaa:String)
               {
                
                Api.getcontentdetails(permaa, endpoint: ApiEndPoints.getcontentdetails, vc: self) { (res, err) -> (Void) in
                    do{
                      
                        let decoder = JSONDecoder()
                        self.contentdata = try decoder.decode(contentdetails.self, from: res  ?? Data())
                   //     self.loadSubscriptionPopup(permalink: self.playerurlstr)
                         
                        if self.contentdata?.code == 200 && self.contentdata?.msg == "Ok"
                        {
                         if self.IsAuthorizedContent == 1
                        {
                   
                                if let url = URL(string: self.contentdata?.submovie?.movieUrl ?? "")
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
                        }else
                        {
                           // self.loadnewSubscriptionPopup(permalink: "")

                            //self.loadSubscriptionPopup(permalink: self.playerurlstr)
                            self.getPPVplans(movieuniqids: self.contentdata?.submovie?.muvi_uniq_id ?? "", planid: self.contentdata?.submovie?.ppv_plan_id  ?? "")
                        }
                    }else
                        {
                            Utility.showAlert(vc: self, message:"\(self.contentdata?.msg ?? "")", titelstring: Appcommon.Appname)

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
        //Utility.ShowLoader(vc: self)
        Api.getcontentdetailsafterppv(permaa, endpoint: ApiEndPoints.getcontentdetails, vc: self) { (res, err) -> (Void) in
            do{
              
               // Utility.hideLoader(vc: self)
                let decoder = JSONDecoder()
                self.contentdata = try decoder.decode(contentdetails.self, from: res  ?? Data())
 
                if let url = URL(string: self.contentdata?.submovie?.movieUrl ?? "")
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
               catch let error
               {
                //Utility.hideLoader(vc: self)

                   //Utility.showAlert(vc: self, message:"\(error)", titelstring: Appcommon.Appname)
               }
           }
       }
    func loadnewSubscriptionPopup(permalink:String)
    {
        let alertController = MDCAlertController(title: "BigFan TV", message:  "Subscribe to watch this content")
     
        let cancelaction = MDCAlertAction(title:"Ok")
        { (cancelaction) in
            
            //self.view.window!.rootViewController?.dismiss(animated: false, completion: nil)
         
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
                                    print(i.externalID)
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
                            print("output ::: \(response)")

                            self?.getcontendeatilsAfterppv(permaa: self?.perma ?? "")
                          return
                        case .failure(let error):
                            print("errors==== \(error)")
                            //self?.view.window!.rootViewController?.dismiss(animated: false, completion: nil)

                           // Utility.showAlert(vc: self ?? UIViewController(), message: "\(error.errorDescription)", titelstring: Appcommon.Appname)
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
          
     
        @IBAction func BackBtTapped(_ sender: UIButton) {
        }
        func getEpisodedeatilsnew(permaa:String,offset:Int)
           {
               Api.GetEpisodedetails(permaa,offset:offset, endpoint: ApiEndPoints.episodeDetails, vc: self) { (res, err) -> (Void) in
                   do
                   {
                  
                       let decoder = JSONDecoder()
                       self.episodedt = try decoder.decode(EdpisodeData.self, from: res  ?? Data())
                       
                      if self.episodedt?.list?.count ?? 0 > 0
                      {
                
                       self.totalconents = Int(self.episodedt?.string_code ?? "") ?? 0
                       print("total =\(self.totalconents)")
                       for i in self.episodedt?.list ?? [Edpisodedetails]()
                       {
                           self.Episodesdata.append(i)
                       }
                       
                        DispatchQueue.main.async
                      {
                          self.EpisodeCollectionV.reloadData()
                          self.isloading = false
                      }
                      }else
                      {
                       self.isloading = true
                       }
                      

                   
                   }
                   catch let error
                   {
                       Utility.showAlert(vc: self, message:"\(error)", titelstring: Appcommon.Appname)
                   }
               }
           }
    }
    extension MoviesDetailsVC:MDCTabBarDelegate
    {

        func tabBar(_ tabBar: MDCTabBar, didSelect item: UITabBarItem) {
            
            if item.tag == 0
            {
                ViDetails.isHidden = true
                CollectionV.isHidden = false
                ViEpisode.isHidden = true
               
                
            }else if item.tag == 1
            {
                ViDetails.isHidden = false
                CollectionV.isHidden = true
                ViEpisode.isHidden = true
            }else if item.tag == 2
            {
                ViDetails.isHidden = true
                CollectionV.isHidden = true
                ViEpisode.isHidden = false
            }
          
        }
        

        func GetrMoviedetails()
        {
 
            
            Api.GetMovieDeatilsconent( imdbID, vc: self ) { (res, err) -> (Void) in
                            do
                            {
                                let decoder = JSONDecoder()
                               self.IMDBdata = try decoder.decode(IMDBdataList.self, from: res  ?? Data())
                                
                                if self.IMDBdata?.Response == "True"
                                {
                                self.LbName.text = self.IMDBdata?.Title
                                self.LbCategory.text = self.IMDBdata?.Genre
                                self.LbTimenReleasedate.text = "\(self.IMDBdata?.Runtime ?? "") | \(self.IMDBdata?.Released ?? "")"
                                self.LbLanguage.text  = self.IMDBdata?.Language
                                self.LbActors.text = self.IMDBdata?.Actors
                                self.LbWriter.text = self.IMDBdata?.Director
                                self.LbProduction.text = self.IMDBdata?.Production
                                self.LbGener.text = self.IMDBdata?.Genre
                                    if let amountValue = self.IMDBdata?.imdbRating, let am = Double(amountValue) {
                                           // am
                                        self.totalrate = am
                                        self.star1.image = self.getStarImage(starNumber: 1, forRating: self.totalrate )
                                        self.star2.image = self.getStarImage(starNumber: 2, forRating: self.totalrate )
                                        self.star3.image = self.getStarImage(starNumber: 3, forRating: self.totalrate )
                                        self.star4.image = self.getStarImage(starNumber: 4, forRating: self.totalrate )
                                        self.star5.image = self.getStarImage(starNumber: 5, forRating: self.totalrate )
                                        self.star6.image = self.getStarImage(starNumber: 6, forRating: self.totalrate )
                                        self.star7.image = self.getStarImage(starNumber: 7, forRating: self.totalrate )
                                        self.star8.image = self.getStarImage(starNumber: 8, forRating: self.totalrate )
                                        self.star9.image = self.getStarImage(starNumber: 9, forRating: self.totalrate )
                                        self.star10.image = self.getStarImage(starNumber: 10, forRating: self.totalrate )
                                    }
                                        
                                    
                                    
                                    
                                    
                                }

                                 else
                                {
                                    self.LbActors.text = "No Info Available"
                                    self.LbWriter.text = "No Info Available"
                                    self.LbProduction.text = "No Info Available"
                                    self.LbGener.text = "No Info Available"
                                    self.LbName.text = self.moviename
                                    self.LbDescription.text  = self.movdescription
                                     self.LbTimenReleasedate.text = self.timereleasedate
                                     self.LbLanguage.text  = self.language
                                }
                               
                            }
                            catch let error
                            {
                                Utility.showAlert(vc: self, message:"\(error)", titelstring: Appcommon.Appname)
                            }
                        }
              }

func getStarImage(starNumber: Double, forRating rating: Double) -> UIImage {
    if rating >= starNumber {
        return fullStarImage
    } else if rating + 0.5 == starNumber {
        return halfStarImage
    } else {
        return emptyStarImage
    }
}
        
    }

    extension MoviesDetailsVC:UICollectionViewDelegate,UICollectionViewDataSource
    {
        func collectionView(_ collectionView: UICollectionView, willDisplay cell: UICollectionViewCell, forItemAt indexPath: IndexPath)
        {
            if collectionView == EpisodeCollectionV
                
            {
            if Episodesdata.count < totalconents
               {
          
                if indexPath.row == Episodesdata.count - 1 && !(isloading ?? false)
                   {  //numberofitem count
                       isloading = true
                      index = index + 1
                      self.getEpisodedeatilsnew(permaa: perma, offset: index)
                       
                   }
              }
            }
        }
          func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
             if collectionView == CollectionV
             {
                return actiondata.count ?? 0
             }else if collectionView == EpisodeCollectionV
             {
                if Episodesdata.count <= 0
                {
                    CollectionV.setEmptyViewnew1(title:"No Episodes found")
                }else
                {
                    CollectionV.restore()
                }
                return Episodesdata.count
            }
            return 0
          }
          
          func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell
          {
            if collectionView == CollectionV
            {
             
           let Actioncell = collectionView.dequeueReusableCell(withReuseIdentifier: cellIdentifier, for: indexPath) as! MyCell
              
            let item = actiondata[indexPath.row]
            Actioncell.ImgSample.sd_setImage(with: URL(string: "\(item.poster ?? "")"), completed: nil)
            Actioncell.LbName.text = item.title ?? ""
            return Actioncell
            }else if collectionView == EpisodeCollectionV
            {
                 let Comedycell1 = collectionView.dequeueReusableCell(withReuseIdentifier: cellIdentifier, for: indexPath) as! MyCell
                Comedycell1.ViLike.isHidden = true
                Comedycell1.ImgSample.sd_setImage(with: URL(string: "\(Episodesdata[indexPath.row].poster_url ?? "")"), completed: nil)
                Comedycell1.LbName.text = self.Episodesdata[indexPath.row].episode_title ?? ""
                   return Comedycell1
            }
            return UICollectionViewCell()
          }
        func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath)
        {
          if collectionView == CollectionV
            {
               WatchDuration = ActionMoviedata?.subComedymovList[indexPath.row].watch_duration_in_seconds ?? 0
               imagename = ActionMoviedata?.subComedymovList[indexPath.row].poster ?? ""
               moviename = ActionMoviedata?.subComedymovList[indexPath.row].title ?? ""
               movietype = ActionMoviedata?.subComedymovList[indexPath.row].poster ?? ""
               imdbId = ActionMoviedata?.subComedymovList[indexPath.row].custom?.customimdb?.field_value ?? ""
               movieuniqid =  ActionMoviedata?.subComedymovList[indexPath.row].movie_uniq_id ?? ""
               perma = ActionMoviedata?.subComedymovList[indexPath.row].c_permalink ?? ""
               Isfavourite =  ActionMoviedata?.subComedymovList[indexPath.row].is_fav_status ?? 0
                contenttypeid = ActionMoviedata?.subComedymovList[indexPath.row].content_types_id ?? ""
                playerurlstr = ActionMoviedata?.subComedymovList[indexPath.row].permalink ?? ""
               getcontentauthorised(movieid: ActionMoviedata?.subComedymovList[indexPath.row].movie_uniq_id ?? "")
          }else if collectionView == EpisodeCollectionV
          {
             let item = Episodesdata[indexPath.row]
 
              let myString1: String = item.video_duration ?? ""
              let myStringArr1 = myString1.components(separatedBy: ":")
              let fr1 = "\(myStringArr1[0]) Hr \(myStringArr1[1]) Min \(myStringArr1[2]) Sec"
              self.LbName.text =  item.episode_title ?? ""
            //  self.LbGener.text = "Hindi"
              self.LbTimenReleasedate.text = "\(fr1) | \(item.episode_date ?? "")"
              self.LbDescription.text = item.episode_story ?? ""
          
             if let url = URL(string:  item.video_url ?? "")
             {
                 let item = MuviPlayerItem(url: url)
                   playerview.player.replaceCurrentItem(with: item)
            }
        }
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
                         let displayVC = storyBoard.instantiateViewController(withIdentifier: "MoviesdetailsVC1") as! MoviesdetailsVC1
                            displayVC.modalPresentationStyle = .fullScreen
                            displayVC.imagename = self.imagename
                            displayVC.moviename = self.moviename
                            displayVC.movietype = self.movietype
                            displayVC.timereleasedate = self.timereleasedate
                            displayVC.language = self.language
                            displayVC.movdescription = self.movdescription
                            displayVC.imdbID = self.imdbId
                            displayVC.perma = self.perma
                            displayVC.Movcategory = self.Movcategory
                            displayVC.MovSubcategory = self.MovSubcategory
                            displayVC.movieuniqid = self.movieuniqid
                            displayVC.Isfavourite = self.Isfavourite
                            displayVC.WatchDuration = self.WatchDuration
                        displayVC.playerurlstr = self.playerurlstr
                        displayVC.IsAuthorizedContent = 1
                        self.present(displayVC, animated: true, completion: nil)
                       
                      
                    
                    }else
                    {
                        Utility.hideLoader(vc: self)

                        let storyBoard: UIStoryboard = UIStoryboard(name: "Main", bundle: nil)
                         let displayVC = storyBoard.instantiateViewController(withIdentifier: "MoviesdetailsVC1") as! MoviesdetailsVC1
                            displayVC.modalPresentationStyle = .fullScreen
                            displayVC.imagename = self.imagename
                            displayVC.moviename = self.moviename
                            displayVC.movietype = self.movietype
                            displayVC.timereleasedate = self.timereleasedate
                            displayVC.language = self.language
                            displayVC.movdescription = self.movdescription
                            displayVC.imdbID = self.imdbId
                            displayVC.perma = self.perma
                            displayVC.Movcategory = self.Movcategory
                            displayVC.MovSubcategory = self.MovSubcategory
                            displayVC.movieuniqid = self.movieuniqid
                            displayVC.Isfavourite = self.Isfavourite
                            displayVC.WatchDuration = self.WatchDuration
                        displayVC.playerurlstr = self.playerurlstr
                        displayVC.IsAuthorizedContent = 0
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
       
    extension MoviesDetailsVC: UICollectionViewDelegateFlowLayout {
                   func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
                        /*
                        if UIDevice.current.userInterfaceIdiom == .pad
                        {
                            return CGSize(width: collectionView.frame.size.height + 20, height:collectionView.frame.size.height)
                        }
                        else if UIDevice.current.userInterfaceIdiom == .phone
                        {
                             return CGSize(width: 280, height: 156)
                               }
                        */
                       return CGSize(width: 280, height: 156)
                    }
                 
             
        }
     
 
extension MoviesDetailsVC:MuviPlayerPlaybackDelegate
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
          // presentingViewController?.presentingViewController?.dismiss(animated: true, completion: nil)
            self.view.window!.rootViewController?.dismiss(animated: false, completion: nil)
         
         let touch = UITouch()
         touch.view?.isUserInteractionEnabled = false

    }
     
    func fullscreenButtonAction(player: MuviVideoPlayer, item: MuviPlayerItem?)
      {
         if isFullscreen
          {
            self.ViRating.isHidden = false

              isFullscreen = false
              self.playerview.transform = .identity
              self.playerview.frame = CGRect(x: 0, y:  self.playerview.safeAreaInsets.top, width: self.view.frame.size.width  ,  height: self.Viplayer.frame.size.height)
          } else
         {
            self.ViRating.isHidden = true

            isFullscreen = true
          self.playerview.transform = CGAffineTransform(rotationAngle: CGFloat((90 * Double.pi)/180))
          self.playerview.frame = CGRect(x: 0, y: 0, width:  UIScreen.main.bounds.size.width    , height:UIScreen.main.bounds.size.height)

         }
      }

    
    func playbackItemReady(player: MuviVideoPlayer, item: MuviPlayerItem?)
    {
         self.playerview.controls?.showBuffering()
    }
    func playbackShouldBegin(player: MuviVideoPlayer) -> Bool {
        
        ((self.playerview.controls?.showBuffering()) != nil)
    }
    func playbackDidBegin(player: MuviVideoPlayer) {
         self.playerview.controls?.hideBuffering()
    }
    
}
