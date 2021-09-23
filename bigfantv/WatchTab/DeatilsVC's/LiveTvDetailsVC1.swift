//
//  LiveTvDetailsVC1.swift
//  bigfantv
//
//  Created by Ganesh on 20/07/20.
//  Copyright © 2020 Ganesh. All rights reserved.
//

import UIKit
import MaterialComponents.MDCTabBar
import MuviPlayer
import CoreMedia
class LiveTvDetailsVC1: UIViewController,UIPopoverPresentationControllerDelegate {
    @IBOutlet var ImgMovie: UIImageView!
      
      @IBOutlet var LbName: UILabel!
    
      @IBOutlet var LbGener: UILabel!
      
      
      @IBOutlet var LbTimenReleasedate: UILabel!
      @IBOutlet var LbLanguage: UILabel!
      
      @IBOutlet var LbDescription: UILabel!
     var imagename = ""
     var moviename = ""
     var movietype = ""
     var timereleasedate  = ""
     var language = ""
     var movdescription: String = ""
    var isFullscreen = false
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
    
    var spcfcLivetvData:SpecififcLiveTVData?
    var livetvid = ""
    var livetvCategoryid = ""
    
        @IBOutlet var Viback: UIView!
        @IBOutlet var ViDetails: UIView!
        @IBOutlet var CollectionV: UICollectionView!
        @IBOutlet var ViTab: UIView!
    var contentdata:contentdetails?
     var perma = ""
     private var authorizeddata:Authorizescontent?
      var playerUrl:URL?
      
    var Movcategory = ""
    var MovSubcategory = ""
     var cellIdentifier = "cell"
     var movieuniqid = ""
    
    var screenheight = 0.0
    var screenwidth = 0.0
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
            
            var Isfavourite = "0"
     var Successdata:SuccessResponse?
     var WatchDuration = 0
    var passarray:LiveTvCategoriesList?
     @IBOutlet var BtFav: UIButton!
          
        let playerview = MuviPlayerView()
      var playerurlstr = ""
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
        
                print("ilvetv url =\(movietype)")
                     LbName.text = moviename
                    if let url = URL(string:   movietype)
                  {
                     let item = MuviPlayerItem(url: url)
                     self.playerview.set(item: item)
                    
                     self.playerview.player.play()
                
                     
                }
                NotificationCenter.default.addObserver(self, selector:#selector(stopplayer), name:UIApplication.didEnterBackgroundNotification, object: nil)
                
 
                Timer.scheduledTimer(withTimeInterval: 0.01, repeats: false) { (t) in
                     
                    if Connectivity.isConnectedToInternet()
                    {
                        self.getsimilarcontents(tvid: self.livetvCategoryid)
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
                         }else
                         {
                             

                        }
                        
                     }
                     catch let error
                     {
                        Utility.showAlert(vc: self, message:"\(error)", titelstring: Appcommon.Appname  )
                     }
                    
                }
            }
        override func viewWillAppear(_ animated: Bool) {
            if UserDefaults.standard.bool(forKey: "isLoggedin") == true
            {
                self.BtFav.isHidden = false
            }else
            {
                self.BtFav.isHidden = true

            }
              if Isfavourite == "0"
              {
                self.BtFav.setBackgroundImage(UIImage(named: "like"), for: .normal)
               }
              else if Isfavourite == "1"
              {
                self.BtFav.setBackgroundImage(UIImage(named: "liked"), for: .normal)
              }

                 // self.LbName.text = self.moviename
                 // self.LbDescription.text  = self.movdescription
                 // self.LbTimenReleasedate.text = self.timereleasedate
                 // self.LbLanguage.text  = self.language
            
             
        }
        override func viewDidAppear(_ animated: Bool) {
             let flowLayout = UICollectionViewFlowLayout()
             flowLayout.scrollDirection = .horizontal
           let width = ((CollectionV.frame.size.height - 18) * 280)/156
               flowLayout.itemSize = CGSize(width: width, height: CollectionV.frame.size.height)
            flowLayout.minimumLineSpacing = 10
            flowLayout.minimumInteritemSpacing = 10
            self.CollectionV.collectionViewLayout = flowLayout
             self.CollectionV.showsHorizontalScrollIndicator = false
            
                      screenwidth = Double(UIScreen.main.bounds.width)
                      screenheight = Double(UIScreen.main.bounds.height)
            self.playerview.frame = CGRect(x: self.ViPlayer.frame.minX, y: self.ViPlayer.frame.minY , width:self.view.frame.size.width, height: self.ViPlayer.frame.size.height)
            
                      self.view.addSubview(playerview)
                       NotificationCenter.default.addObserver(self, selector: #selector(deviceOrientationDidChange), name: UIDevice.orientationDidChangeNotification, object: nil)
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
    @objc func deviceOrientationDidChange()
    {
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
    override func viewWillDisappear(_ animated: Bool) {
        if playerview.isPlaying
        {
            self.playerview.pause()
        }
    }
             func Addtofav()
                      {
                         if Isfavourite == "0"
                               {
                                 guard let parameters = [
                                      "userId":UserDefaults.standard.string(forKey: "id") ?? ""  ,
                                      "AccessToken":UserDefaults.standard.string(forKey:"AccessToken") ?? "" ,
                                      "liveTvId": self.livetvid,
                                      "isFavourite":"1"
                                      ] as? [String:Any] else {
                                      return
                                  }
                                  Common.shared.Commonapi(parameters: parameters, urlString: CommonApiEndPoints.saveFavouriteLiveTv) { (data, err) -> (Void) in
                                      if data != nil
                                      {
                                       self.BtFav.setBackgroundImage(UIImage(named: "liked"), for: .normal)
                                      self.Isfavourite = "1"
                                       
                                   }
                               }
                               }else if Isfavourite == "1"
                               {
                                  guard let parameters = [
                                       "userId":UserDefaults.standard.string(forKey: "id") ?? ""  ,
                                       "AccessToken":UserDefaults.standard.string(forKey:"AccessToken") ?? "" ,
                                       "liveTvId": self.livetvid,
                                       "isFavourite":"0"
                                       ] as? [String:Any] else {
                                       return
                                   }
                                   Common.shared.Commonapi(parameters: parameters, urlString: CommonApiEndPoints.saveFavouriteLiveTv) { (data, err) -> (Void) in
                                       if data != nil
                                       {
                                        self.BtFav.setBackgroundImage(UIImage(named: "like"), for: .normal)
                                       self.Isfavourite = "0"
                                        
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
            print(permaa)
            Api.getcontentdetails(permaa, endpoint: ApiEndPoints.getcontentdetails, vc: self) { (res, err) -> (Void) in
                do
                        {
                       
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
            self.playerview.controls?.fullscreenButton?.set(active: true)
            self.playerview.controls?.forwardButton?.isHidden = true
            self.playerview.controls?.rewindButton?.isHidden = true
            self.playerview.controls?.rewindButton?.set(active: true)
            self.playerview.controls?.resolutionButton?.isHidden = false
            self.playerview.enablePlaybackSpeed = true
               
                            
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
                catch let error
                {
                    Utility.showAlert(vc: self, message:"\(error)", titelstring: Appcommon.Appname)
                }
            }
        }
    
    func getsimilarcontents(tvid:String)
    {
        Utility.ShowLoader(vc: self)
        guard let parameters = [
         "userId":UserDefaults.standard.string(forKey: "id") ?? "",
        "AccessToken":UserDefaults.standard.string(forKey:"AccessToken") ?? "",
        "offset":"1",
        "liveTvCategroryId":tvid
            ]as? [String:Any] else{return}
        print(parameters)
        Common.shared.Commonapi(parameters: parameters, urlString: CommonApiEndPoints.getSpecificCategoryLiveTv) { (data, err) -> (Void) in
            do
            {
                Utility.hideLoader(vc: self)
                let deode = JSONDecoder()
                self.spcfcLivetvData = try deode.decode(SpecififcLiveTVData.self, from: data ?? Data())
                if self.spcfcLivetvData?.specificCategoryWiseLiveTv?.count ?? 0 > 0
                {
                    self.spcfcLivetvData?.specificCategoryWiseLiveTv = self.spcfcLivetvData?.specificCategoryWiseLiveTv?.filter({$0.liveTvID  != self.livetvid})
                    self.CollectionV.delegate = self
                    self.CollectionV.dataSource = self
                    DispatchQueue.main.async {
                        self.CollectionV.reloadData()
                    }
                }else
                {
                    print("data not found...")
                }
            }catch
            {
                Utility.hideLoader(vc: self)
                print(error.localizedDescription)
            }
        }
    }
    @IBAction func BackBtTapped(_ sender: UIButton) {
        let cmtime = self.playerview.player.currentTime()
        let floattime = Float(CMTimeGetSeconds(cmtime))
          if Connectivity.isConnectedToInternet()
          {
               savelog(duration: floattime)
          }
         
            self.dismiss(animated: true, completion: nil)
        }
        
    }
    extension LiveTvDetailsVC1:MDCTabBarDelegate
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

    extension LiveTvDetailsVC1:UICollectionViewDelegate,UICollectionViewDataSource
    {
        func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
            if spcfcLivetvData?.specificCategoryWiseLiveTv?.count ?? 0 <= 0
            {
                CollectionV.setEmptyViewnew1(title:"No Similar Channels found")
                
            }else
            {
                CollectionV.restore()
                
            }
            
            return spcfcLivetvData?.specificCategoryWiseLiveTv?.count ?? 0
        }
        
        func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell
        {
          
          let Actioncell = collectionView.dequeueReusableCell(withReuseIdentifier: cellIdentifier, for: indexPath) as! MyCell
                     let item = spcfcLivetvData?.specificCategoryWiseLiveTv?[indexPath.row]
                     Actioncell.ImgSample.sd_setImage(with: URL(string: "\(item?.tvImage ?? "")"), completed: nil)
                     Actioncell.LbName.text = item?.title ?? ""
                     Actioncell.actionBlock = {
                         () in
                         if item?.isFavourite == "0"
                         {
                             Actioncell.btnCounter.setBackgroundImage(UIImage(named: "liked"), for: .normal)
                             guard let parameters = [
                                 "userId":UserDefaults.standard.string(forKey: "id") ?? ""  ,
                                 "AccessToken":UserDefaults.standard.string(forKey:"AccessToken") ?? "" ,
                                 "liveTvId": item?.liveTvID ?? "",
                                 "isFavourite":"1"
                                 ] as? [String:Any] else {
                                 return
                             }
                             Common.shared.Commonapi(parameters: parameters, urlString: CommonApiEndPoints.saveFavouriteLiveTv) { (data, err) -> (Void) in
                                 if data != nil
                                 {
                                     item?.isFavourite = "1"
                                     Actioncell.btnCounter.setBackgroundImage(UIImage(named: "liked"), for: .normal)
                                     
                                 }
                             }
                         }else if item?.isFavourite == "1"
                         {
                              Actioncell.btnCounter.setBackgroundImage(UIImage(named: "like"), for: .normal)
                              guard let parameters = [
                                  "userId":UserDefaults.standard.string(forKey: "id") ?? ""  ,
                                  "AccessToken":UserDefaults.standard.string(forKey:"AccessToken") ?? "" ,
                                  "liveTvId": item?.liveTvID ?? "",
                                  "isFavourite":"0"
                                  ] as? [String:Any] else {
                                  return
                              }
                              Common.shared.Commonapi(parameters: parameters, urlString: CommonApiEndPoints.saveFavouriteLiveTv) { (data, err) -> (Void) in
                                  if data != nil
                                  {
                                     item?.isFavourite = "0"
                                      Actioncell.btnCounter.setBackgroundImage(UIImage(named: "like"), for: .normal)
                                      
                                  }
                              }
                         }
                        
                     }
                            
                           return Actioncell
          }
        func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath)
        {
          let item =  spcfcLivetvData?.specificCategoryWiseLiveTv?[indexPath.row]
              
             moviename = item?.title ?? ""
             movietype = item?.source ?? ""
             Isfavourite = item?.isFavourite ?? ""
            
             let storyBoard: UIStoryboard = UIStoryboard(name: "Main", bundle: nil)
             let secondViewController =  storyBoard.instantiateViewController(withIdentifier: "LiveTvDetailsVC") as! LiveTvDetailsVC
              secondViewController.imagename = self.imagename
              secondViewController.moviename = self.moviename
              secondViewController.movietype = self.movietype
              secondViewController.Isfavourite = self.Isfavourite
             secondViewController.livetvCategoryid = self.livetvCategoryid
              
            self.present(secondViewController, animated: true)
                               
                   }
                     
        func getcontentauthorised(movieid:String)
        {
            let storyBoard: UIStoryboard = UIStoryboard(name: "Main", bundle: nil)
            let displayVC = storyBoard.instantiateViewController(withIdentifier: "OtherVideosVCDetails1") as! OtherVideosVCDetails1
                               
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
           //displayVC.Isfavourite = self.Isfavourite
            displayVC.WatchDuration = self.WatchDuration
            displayVC.playerurlstr = self.playerurlstr
                           
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
                                /*
                                  let storyBoard: UIStoryboard = UIStoryboard(name: "MainIpad", bundle: nil)
                                  let secondViewController =  storyBoard.instantiateViewController(withIdentifier: "MoviesdetailsVC1") as! MoviesdetailsVC1
                                        secondViewController.imagename = self.imagename
                                        secondViewController.moviename = self.moviename
                                        secondViewController.movietype = self.movietype
                                        secondViewController.timereleasedate = self.timereleasedate
                                        secondViewController.language = self.language
                                        secondViewController.movdescription = self.movdescription
                                        secondViewController.ComedyMoviedata = self.ComedyMoviedata
                                        secondViewController.ThrillerMoviedata = self.ThrillerMoviedata
                                       
                                        secondViewController.imdbID = self.imdbId
                                        secondViewController.perma = self.perma
                                        secondViewController.Movcategory = self.Movcategory
                                        secondViewController.MovSubcategory = self.MovSubcategory
                                         secondViewController.Isfavourite = self.Isfavourite
                                        secondViewController.movieuniqid = self.movieuniqid
                                                       secondViewController.WatchDuration = self.WatchDuration
                                                       
                                                       
                               self.navigationController?.pushViewController(secondViewController, animated: true)
                                */
                                                     
                               }
                               else if UIDevice.current.userInterfaceIdiom == .phone
                               {
                                   
                                   let storyBoard: UIStoryboard = UIStoryboard(name: "Main", bundle: nil)
                                    let displayVC = storyBoard.instantiateViewController(withIdentifier: "OtherVideosVCDetails1") as! OtherVideosVCDetails1
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
                                displayVC.playerurlstr = self.playerurlstr
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
       
 
     

extension LiveTvDetailsVC1:MuviPlayerPlaybackDelegate
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
