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
class testdetaisVC: UIViewController,UIPopoverPresentationControllerDelegate {
    @IBOutlet var ImgMovie: UIImageView!
      
      @IBOutlet var LbName: UILabel!
    
      @IBOutlet var LbGener: UILabel!
      
      
      @IBOutlet var LbTimenReleasedate: UILabel!
      @IBOutlet var LbLanguage: UILabel!
      
      @IBOutlet var LbDescription: UILabel!
     var currentTrack: Track!
     var imagename = ""
     var moviename = ""
     var movietype = ""
     var timereleasedate  = ""
     var language = ""
     var movdescription: String = ""
  
    
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
    var contenttypesid  = ""
     var passarray:FeaturedDataList?
    @IBOutlet var ViPlayer: UIView!
    var ActionMoviedata:newFilteredComedyMovieList?
    var actiondata = [newFilteredSubComedymovieList]()
    
    let sampledata:[sample] = [
          sample(img: "c1", labletext: "kolhapur"),
          sample(img: "c2", labletext: "kolhapur"),
          sample(img: "c3", labletext: "kolhapur"),
          sample(img: "c5", labletext: "kolhapur"),
          sample(img: "c6", labletext: "kolhapur")
            ]
            
       var Isfavourite = 0
      private var authorizeddata:Authorizescontent?
     var Successdata:SuccessResponse?
     var WatchDuration = 0
    var tappedCell:FeaturedDatadetails?
    var imdbId = ""
      var playerurlstr = ""
    @IBOutlet var BtFav: UIButton!
          var isFullscreen = false
          var screenheight = 0.0
          var screenwidth = 0.0
        let playerview = MuviPlayerView()
            override func viewDidLoad() {
            super.viewDidLoad()
                
                print("called")
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
                //self.playerview.frame = CGRect(x: 0, y: navigationController?.navigationBar.frame.size.height ?? 20 + 20 , width:self.view.frame.size.width, height: self.ViPlayer.frame.size.height)
                
                           
                            NotificationCenter.default.addObserver(self, selector: #selector(deviceOrientationDidChange), name: UIDevice.orientationDidChangeNotification, object: nil)
              
                
              self.CollectionV.register(UINib(nibName:"MyCell", bundle:nil), forCellWithReuseIdentifier: cellIdentifier)
                self.CollectionV.delegate = self
                self.CollectionV.dataSource = self
         NotificationCenter.default.addObserver(self, selector:#selector(stopplayer), name:UIApplication.didEnterBackgroundNotification, object: nil)
                
                Timer.scheduledTimer(withTimeInterval: 0.1, repeats: false) { (t) in
                       
                                        if Connectivity.isConnectedToInternet()
                                        {
                                           self.getcontendeatils(permaa: self.perma)
                                           //self.GetActionMovielist()
                                            
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
                                   
                                     print("saved")
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
                                   }else if Isfavourite == 1
                                   {
                                        self.BtFav.setBackgroundImage(UIImage(named: "liked"), for: .normal)
                                   }
                   self.LbName.text = self.moviename
                 // self.LbDescription.text  = self.movdescription
                 // self.LbTimenReleasedate.text = self.timereleasedate
                 // self.LbLanguage.text  = self.language
            Viback.layer.cornerRadius = Viback.frame.size.height/2
            Viback.layer.borderColor = UIColor.clear.cgColor
            Viback.layer.borderWidth = 1
             ViDetails.isHidden = true
        }
        override func viewDidAppear(_ animated: Bool) {
           
                screenwidth = Double(UIScreen.main.bounds.width)
                screenheight = Double(UIScreen.main.bounds.height)
                self.playerview.frame = CGRect(x: 0, y: navigationController?.navigationBar.frame.size.height ?? 20 + 20 , width:self.view.frame.size.width, height: self.ViPlayer.frame.size.height)
      
                self.view.addSubview(playerview)
                 NotificationCenter.default.addObserver(self, selector: #selector(deviceOrientationDidChange), name: UIDevice.orientationDidChangeNotification, object: nil)
            
            
            let tabBar = MDCTabBar(frame: CGRect(x: 0, y:0, width: ViTab.bounds.width, height: 80))
                  tabBar.items = [
                  UITabBarItem(title: "Similar", image: UIImage(named: "phone"), tag: 0)
                 // UITabBarItem(title: "More Details", image: UIImage(named: "heart"), tag: 1)
                  
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
                        // self.present(activityVC, animated: true, completion: nil)
                         if let popOver = activityVC.popoverPresentationController {
                             popOver.sourceView = view
                             popOver.sourceRect = CGRect(x: view.frame.size.width - 100, y: 100, width: 400, height: 30)
                             popOver.delegate = self
                             popOver.permittedArrowDirections = .right
                                               
                             //popOver.barButtonItem
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
            print(permaa)
            Api.getcontentdetails(permaa, endpoint: ApiEndPoints.getcontentdetails, vc: self) { (res, err) -> (Void) in
                do
                        {
                       
                            let decoder = JSONDecoder()
                            self.contentdata = try decoder.decode(contentdetails.self, from: res  ?? Data())
  
                             self.playerurlstr = self.contentdata?.submovie?.embeddedUrl ?? ""
                        
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
                            }else
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
                      
                        
                        }
                catch let error
                {
                    Utility.showAlert(vc: self, message:"\(error)", titelstring: Appcommon.Appname)
                }
            }
        }
    @IBAction func BackBtTapped(_ sender: UIButton) {
        let cmtime = self.playerview.player.currentTime()
       
        let floattime = Float(CMTimeGetSeconds(cmtime))
        if floattime.isNaN
        {
         self.dismiss(animated: true, completion: nil)
        }else
        {
            if Connectivity.isConnectedToInternet()
                     {
                       if floattime != nil
                       {
                         savelog(duration: floattime)
                     }
                   }
        }
         
            
        }
        
    }
    extension testdetaisVC:MDCTabBarDelegate
    {

        func tabBar(_ tabBar: MDCTabBar, didSelect item: UITabBarItem) {
            
            if item.tag == 0
            {
                ViDetails.isHidden = true
                CollectionV.isHidden = false
               
                
            }else if item.tag == 1
            {
                ViDetails.isHidden = false
                CollectionV.isHidden = true
            }
          
        }
        
    }

    extension testdetaisVC:UICollectionViewDelegate,UICollectionViewDataSource
    {
        func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
            if passarray?.contents?.count ?? 0 <= 0
            {
                CollectionV.setEmptyViewnew1(title:"No Similar Channels found")
                
            }else
            {
                CollectionV.restore()
                
            }
            
            return passarray?.contents?.count ?? 0
        }
        
        func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell
        {
          
                     let Actioncell = collectionView.dequeueReusableCell(withReuseIdentifier: cellIdentifier, for: indexPath) as! MyCell
                   let item = passarray?.contents?[indexPath.row]
                       Actioncell.ImgSample.sd_setImage(with: URL(string: "\(item?.poster ?? "")"), completed: nil)
                       // Actioncell.ViLabel.isHidden = true
            Actioncell.LbName.text = item?.title ?? ""
                     
                  return Actioncell
         
        }
        func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath)
               {
        
                      WatchDuration = ActionMoviedata?.subComedymovList[indexPath.row].watch_duration_in_seconds ?? 0
                      imagename = ActionMoviedata?.subComedymovList[indexPath.row].poster ?? ""
                      moviename = ActionMoviedata?.subComedymovList[indexPath.row].title ?? ""
                      movietype = ActionMoviedata?.subComedymovList[indexPath.row].poster ?? ""
                      imdbId = ActionMoviedata?.subComedymovList[indexPath.row].custom?.customimdb?.field_value ?? ""
                      movieuniqid =  ActionMoviedata?.subComedymovList[indexPath.row].movie_uniq_id ?? ""
                      perma = ActionMoviedata?.subComedymovList[indexPath.row].c_permalink ?? ""
                      Isfavourite =  ActionMoviedata?.subComedymovList[indexPath.row].is_fav_status ?? 0
                      getcontentauthorised(movieid: ActionMoviedata?.subComedymovList[indexPath.row].movie_uniq_id ?? "")
                           
               }
                
                  func getcontentauthorised(movieid:String)
                  {
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
                         
                    self.present(displayVC, animated: true, completion: nil)
                      /*
                      Api.IsContentAuthorised(movieid, endpoint: ApiEndPoints.isContentAuthorized, vc: self) { (res, err) -> (Void) in
                       do
                       {
                           let decoder = JSONDecoder()
                           self.authorizeddata = try decoder.decode(Authorizescontent.self, from: res  ?? Data())
                                             
                        if self.authorizeddata?.status == "OK"
                        {
                             
                           if UIDevice.current.userInterfaceIdiom == .pad
                           {
                              let storyBoard: UIStoryboard = UIStoryboard(name: "MainIpad", bundle: nil)
                              let secondViewController =  storyBoard.instantiateViewController(withIdentifier: "MoviesdetailsVC1") as! MoviesdetailsVC1
                                    secondViewController.imagename = self.imagename
                                    secondViewController.moviename = self.moviename
                                    secondViewController.movietype = self.movietype
                                    secondViewController.timereleasedate = self.timereleasedate
                                    secondViewController.language = self.language
                                    secondViewController.movdescription = self.movdescription
                                   secondViewController.imdbID = self.imdbId
                                    secondViewController.perma = self.perma
                                    secondViewController.Movcategory = self.Movcategory
                                    secondViewController.MovSubcategory = self.MovSubcategory
                                     secondViewController.Isfavourite = self.Isfavourite
                                    secondViewController.movieuniqid = self.movieuniqid
                                                   secondViewController.WatchDuration = self.WatchDuration
                                                   
                                                   
                           self.navigationController?.pushViewController(secondViewController, animated: true)
                                                 
                           }
                           else if UIDevice.current.userInterfaceIdiom == .phone
                           {
                               
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
                                    
                               self.present(displayVC, animated: true, completion: nil)
                                  }
                           
                        }
                        else
                        {
                           let alertController = MDCAlertController(title: "BigFan TV", message:  "Subscribe to a plan to view this content")
                                 let action = MDCAlertAction(title:"OK")
                                           { (action) in
                                       let storyBoard: UIStoryboard = UIStoryboard(name: "Main", bundle: nil)
                                       let VC1 = storyBoard.instantiateViewController(withIdentifier: "MyplansVC") as! MyplansVC
                                                       
                                       let navController = UINavigationController(rootViewController: VC1) // Creating a navigation controller with VC1 at the root of the navigation stack.
                                        navController.navigationBar.barTintColor = Appcolor.backgorund3
                                            navController.navigationBar.isTranslucent = false
                                        navController.modalPresentationStyle = .fullScreen
                                        self.present(navController, animated:true, completion: nil)
                                         
                                 }
                                    let cancelaction = MDCAlertAction(title:"Cancel")
                                    { (cancelaction) in
                                         
                                    }
                                    alertController.addAction(action)
                                    alertController.addAction(cancelaction)
                                  self.present(alertController, animated: true, completion: nil)
                           
                           }
                           
                       }
                                           catch let error
                                           {
                                               Utility.showAlert(vc: self, message:"\(error)", titelstring: Appcommon.Appname)
                                           }
                                       }
                    */
                  }
    }
       
    extension testdetaisVC: UICollectionViewDelegateFlowLayout {
            func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
              /*
                if UIDevice.current.userInterfaceIdiom == .pad {
                         return CGSize(width: 180, height: collectionView.frame.size.height)
                       } else if UIDevice.current.userInterfaceIdiom == .phone  {
               
                return CGSize(width: collectionView.frame.size.height + 30, height: collectionView.frame.size.height)
                         
                       }
                */
                return CGSize(width: collectionView.frame.size.height + 30, height: collectionView.frame.size.height)
            }
        }
     
extension testdetaisVC:MuviPlayerPlaybackDelegate
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
        //self.dismiss(animated: true, completion: nil)
        // self.view.window!.rootViewController?.dismiss(animated: false, completion: nil)
        
        //let touch = UITouch()//
       //  touch.view?.isUserInteractionEnabled = false
            
          

      }
    func playbackItemReady(player: MuviVideoPlayer, item: MuviPlayerItem?) {
         self.playerview.controls?.showBuffering()
    }
    func playbackShouldBegin(player: MuviVideoPlayer) -> Bool {
        
        ((self.playerview.controls?.showBuffering()) != nil)
    }
    func playbackDidBegin(player: MuviVideoPlayer) {
         self.playerview.controls?.hideBuffering()
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
}
