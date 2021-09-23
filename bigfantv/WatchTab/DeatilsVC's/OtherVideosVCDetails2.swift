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
class OtherVideosVCDetails2: UIViewController ,UIPopoverPresentationControllerDelegate{
  
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
        var playerurlstr = ""
    var Movcategory = ""
    var MovSubcategory = ""
     var cellIdentifier = "cell"
     
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
     var Successdata:SuccessResponse?
     var movieuniqid = ""
     var WatchDuration = 0
     @IBOutlet var BtFav: UIButton!
           
          let  playerview = MuviPlayerView()
        
            override func viewDidLoad() {
            super.viewDidLoad()
                
              self.CollectionV.register(UINib(nibName:"MyCell", bundle:nil), forCellWithReuseIdentifier: cellIdentifier)
         NotificationCenter.default.addObserver(self, selector:#selector(stopplayer), name:UIApplication.didEnterBackgroundNotification, object: nil)
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
                  self.LbDescription.text  = self.movdescription
                  self.LbTimenReleasedate.text = self.timereleasedate
                  self.LbLanguage.text  = self.language
            
        }
        override func viewDidAppear(_ animated: Bool) {
           
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
    @IBAction func BtShareTapped(_ sender: UIButton) {
                        let firstActivityItem = "Hello,Someone has shared you a video"
                           let videoLink = NSURL(string: "")
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
                                       self.LbTimenReleasedate.text = "\(myStringArr[0])hours :\(myStringArr[1])min) | \(self.contentdata?.submovie?.custommetadata?.language_type ?? "")"
                                   }
                            
                                       
                                       
                                     //  self.playerview.playbackDelegate = self
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
                           catch let error
                           {
                               Utility.showAlert(vc: self, message:"\(error)", titelstring: Appcommon.Appname)
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
        self.navigationController?.popViewController(animated: true)
        }
        
    }
    extension OtherVideosVCDetails2:MDCTabBarDelegate
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

    extension OtherVideosVCDetails2:UICollectionViewDelegate,UICollectionViewDataSource
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
                      //  Actioncell.ViLabel.isHidden = true
                        Actioncell.LbName.text = item.title ?? ""
                     
                  return Actioncell
         
        }
        func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
               
             imagename = ActionMoviedata?.subComedymovList[indexPath.row].poster ?? ""
             moviename = ActionMoviedata?.subComedymovList[indexPath.row].title ?? ""
playerurlstr = ActionMoviedata?.subComedymovList[indexPath.row].permalink ?? ""
    perma = ActionMoviedata?.subComedymovList[indexPath.row].c_permalink ?? ""
            Isfavourite = ActionMoviedata?.subComedymovList[indexPath.row].is_fav_status ?? 0
             movieuniqid = ActionMoviedata?.subComedymovList[indexPath.row].movie_uniq_id ?? ""
            WatchDuration = ActionMoviedata?.subComedymovList[indexPath.row].watch_duration_in_seconds ?? 0
            
             if UIDevice.current.userInterfaceIdiom == .pad
            {
                         let storyBoard: UIStoryboard = UIStoryboard(name: "MainIpad", bundle: nil)
                         let secondViewController =  storyBoard.instantiateViewController(withIdentifier: "OtherVideosVCDetails1") as! OtherVideosVCDetails1
                         secondViewController.imagename = self.imagename
                         secondViewController.moviename = self.moviename
                         secondViewController.movietype = self.movietype
                         secondViewController.timereleasedate = self.timereleasedate
                         secondViewController.language = self.language
                         secondViewController.perma = self.perma
                         secondViewController.Movcategory = self.Movcategory
                         secondViewController.MovSubcategory = self.MovSubcategory
                         secondViewController.movieuniqid = movieuniqid
                         secondViewController.Isfavourite = Isfavourite
                   secondViewController.WatchDuration = self.WatchDuration
                secondViewController.playerurlstr = self.playerurlstr
                         self.navigationController?.pushViewController(secondViewController, animated: true)
                
            }
            else if UIDevice.current.userInterfaceIdiom == .phone
            {
                let storyBoard: UIStoryboard = UIStoryboard(name: "Main", bundle: nil)
                let secondViewController =  storyBoard.instantiateViewController(withIdentifier: "OtherVideosVCDetails1") as! OtherVideosVCDetails1
                  secondViewController.imagename = self.imagename
                  secondViewController.moviename = self.moviename
                  secondViewController.movietype = self.movietype
                  secondViewController.timereleasedate = self.timereleasedate
                  secondViewController.language = self.language
                  secondViewController.perma = self.perma
                  secondViewController.Movcategory = self.Movcategory
                  secondViewController.MovSubcategory = self.MovSubcategory
                  secondViewController.movieuniqid = movieuniqid
                 secondViewController.Isfavourite = Isfavourite
                   secondViewController.WatchDuration = self.WatchDuration
                secondViewController.playerurlstr = self.playerurlstr

                  self.navigationController?.pushViewController(secondViewController, animated: true)
                
            }
             
                 
           }
    }
       
    extension OtherVideosVCDetails2: UICollectionViewDelegateFlowLayout {
            func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
               if UIDevice.current.userInterfaceIdiom == .pad {
                         return CGSize(width: 180, height: collectionView.frame.size.height)
                       } else if UIDevice.current.userInterfaceIdiom == .phone  {
                return CGSize(width: 156, height: collectionView.frame.size.height)
                         
                       }
                
                return CGSize(width: 180, height: 280)
            }
        }
     
