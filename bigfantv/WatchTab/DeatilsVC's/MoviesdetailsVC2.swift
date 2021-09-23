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
import CoreMedia
class MoviesdetailsVC2: UIViewController ,UIPopoverPresentationControllerDelegate{
    
    
    @IBOutlet var ImgMovie: UIImageView!
    
    @IBOutlet var LbName: UILabel!
    @IBOutlet var LbCategory: UILabel!
    @IBOutlet var LbProduction: UILabel!
    @IBOutlet var LbWriter: UILabel!
    
    @IBOutlet var LbGener: UILabel!
    @IBOutlet var LbActors: UILabel!
    
    @IBOutlet var Viplayer: UIView!
    var ComedyMoviedata:newFilteredComedyMovieList?
    var ThrillerMoviedata:newFilteredComedyMovieList?
    var ActionMoviedata:newFilteredComedyMovieList?
    var comedydata = [newFilteredSubComedymovieList]()
    var thrillerdata = [newFilteredSubComedymovieList]()
    var actiondata = [newFilteredSubComedymovieList]()
    
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
            
          
    
    var imagename = ""
    var moviename = ""
    var movietype = ""
    var timereleasedate  = ""
    var language = ""
    var movdescription: String = ""
    var imdbID = ""
    var IMDBdata:IMDBdataList?
    var contentdata:contentdetails?
     var Successdata:SuccessResponse?
       private var authorizeddata:Authorizescontent?
    var perma = ""
    var playerUrl:URL?
    var Movcategory = ""
    var MovSubcategory = ""
    let cellIdentifier = "cell"
     var imdbId = ""
      var movieuniqid = ""
     
     let playerview = MuviPlayerView()
     var Isfavourite = 0
    var WatchDuration = 0
    @IBOutlet var BtFav: UIButton!
            override func viewDidLoad() {
            super.viewDidLoad()

                
                Timer.scheduledTimer(withTimeInterval: 0.1, repeats: false) { (t) in
                         if Connectivity.isConnectedToInternet()
                         {
                          
                            self.GetActionMovielist()
                            self.getcontendeatils(permaa: self.perma)
                            if self.imdbID != ""
                            {
                                self.GetrMoviedetails()
                                
                            }else
                            {
                                self.LbName.text = self.moviename
                             //   self.LbDescription.text  = self.movdescription
                                self.LbTimenReleasedate.text = self.timereleasedate
                                self.LbLanguage.text  = self.language
                                
                            }
                         }else
                         {
                             Utility.Internetconnection(vc: self)
                         }
                     }
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
        override func viewDidAppear(_ animated: Bool) {
 
       
            
            let tabBar = MDCTabBar(frame: CGRect(x: 0, y:0, width: ViTab.bounds.width, height: 80))
                  tabBar.items = [
                  UITabBarItem(title: "Similar", image: UIImage(named: "phone"), tag: 0),
                  UITabBarItem(title: "More Details", image: UIImage(named: "heart"), tag: 1)
                  
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
   
    func getcontendeatils(permaa:String)
               {
                   Api.getcontentdetails(permaa, endpoint: ApiEndPoints.getcontentdetails, vc: self) { (res, err) -> (Void) in
                     do
                     {
               
                    let decoder = JSONDecoder()
                    self.contentdata = try decoder.decode(contentdetails.self, from: res  ?? Data())
        
                                self.playerview.frame = CGRect(x: 0, y:0, width:self.Viplayer.frame.size.width, height: self.Viplayer.frame.size.height)
                              self.playerview.backgroundColor = .black
                              self.Viplayer.addSubview(self.playerview)
                              self.playerview.subtitleFontColor = .black
                              self.playerview.controls?.playPauseButton?.set(active: true)
                              self.playerview.controls?.pipButton?.isHidden = false
                              self.playerview.controls?.fullscreenButton?.isHidden = false
                              self.playerview.controls?.fullscreenButton?.set(active: true)
                              self.playerview.controls?.forwardButton?.isHidden = false
                              self.playerview.controls?.rewindButton?.isHidden = false
                              self.playerview.controls?.rewindButton?.set(active: true)
                              self.playerview.controls?.resolutionButton?.isHidden = false
                              self.playerview.enablePlaybackSpeed = true
                   
                   if let url = URL(string: self.contentdata?.submovie?.movieUrl ?? "")
                    {
                        let item = MuviPlayerItem(url: url)
                        self.playerview.set(item: item)
                        self.playerview.useMuviPlayerControls = true
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
            
              
             //self.playerviewController.load(videoId: "x4r5udv")
       
    
    
    
    
    
     
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
    extension MoviesdetailsVC2:MDCTabBarDelegate
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
        

        func GetrMoviedetails()
        {
                  
            
            Api.GetMovieDeatilsconent( imdbID, vc: self ) { (res, err) -> (Void) in
                            do
                            {
                                let decoder = JSONDecoder()
                               self.IMDBdata = try decoder.decode(IMDBdataList.self, from: res  ?? Data())
                                self.LbName.text = self.IMDBdata?.Title
                                self.LbCategory.text = self.IMDBdata?.Genre
                                self.LbTimenReleasedate.text = "\(self.IMDBdata?.Runtime ?? "") | \(self.IMDBdata?.Released ?? "")"
                                self.LbLanguage.text  = self.IMDBdata?.Language
                                self.LbActors.text = self.IMDBdata?.Actors
                                self.LbWriter.text = self.IMDBdata?.Director
                                self.LbProduction.text = self.IMDBdata?.Production
                                self.LbGener.text = self.IMDBdata?.Genre
                               
                               
                            }
                            catch let error
                            {
                                Utility.showAlert(vc: self, message:"\(error)", titelstring: Appcommon.Appname)
                            }
                        }
              }
        
    }

    extension MoviesdetailsVC2:UICollectionViewDelegate,UICollectionViewDataSource
    {
          func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
             
            return actiondata.count ?? 0
           
          }
          
          func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
             
             let Actioncell = collectionView.dequeueReusableCell(withReuseIdentifier: cellIdentifier, for: indexPath) as! MyCell
              
            let item = actiondata[indexPath.row]
            Actioncell.ImgSample.sd_setImage(with: URL(string: "\(item.poster ?? "")"), completed: nil)
            Actioncell.LbName.text = ActionMoviedata?.subComedymovList[indexPath.row].title
            return Actioncell
          }
        func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
              
            getcontentauthorised(movieid: ActionMoviedata?.subComedymovList[indexPath.row].movie_uniq_id ?? "")
                   
                   imagename = ActionMoviedata?.subComedymovList[indexPath.row].poster ?? ""
                   moviename = ActionMoviedata?.subComedymovList[indexPath.row].title ?? ""
                   movietype = ActionMoviedata?.subComedymovList[indexPath.row].poster ?? ""
                    
                  
                   WatchDuration = ActionMoviedata?.subComedymovList[indexPath.row].watch_duration_in_seconds ?? 0
                   imdbId = ActionMoviedata?.subComedymovList[indexPath.row].custom?.customimdb?.field_value ?? ""
                   movieuniqid =  ActionMoviedata?.subComedymovList[indexPath.row].movie_uniq_id ?? ""
                   perma = ActionMoviedata?.subComedymovList[indexPath.row].c_permalink ?? ""
                  Isfavourite = ActionMoviedata?.subComedymovList[indexPath.row].is_fav_status ?? 0
                   print(perma)
                 
              
        }
         func getcontentauthorised(movieid:String)
         {
             
             Api.IsContentAuthorised(movieid, endpoint: ApiEndPoints.isContentAuthorized, vc: self) { (res, err) -> (Void) in
                                  do
                                  {
                                      let decoder = JSONDecoder()
                                      self.authorizeddata = try decoder.decode(Authorizescontent.self, from: res  ?? Data())
                                    
                                     if self.authorizeddata?.status == "OK"
                                     {
                                         //self.performSegue(withIdentifier: "tomoviedetails", sender: self)
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
                                                 secondViewController.ComedyMoviedata = self.ComedyMoviedata
                                                 secondViewController.ThrillerMoviedata = self.ThrillerMoviedata
                                                secondViewController.movieuniqid = self.movieuniqid
                                                 secondViewController.imdbID = self.imdbId
                                                 secondViewController.perma = self.perma
                                                 secondViewController.Movcategory = self.Movcategory
                                                 secondViewController.MovSubcategory = self.MovSubcategory
                                                 secondViewController.Isfavourite = self.Isfavourite
                                                 secondViewController.WatchDuration = self.WatchDuration
                                                 self.navigationController?.pushViewController(secondViewController, animated: true)
                                   }
                                   else if UIDevice.current.userInterfaceIdiom == .phone
                                   {

                                    let storyBoard: UIStoryboard = UIStoryboard(name: "Main", bundle: nil)
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
                                                     // self.present(navController, animated:true, completion: nil)
                                                       
                                               }
                                                  let cancelaction = MDCAlertAction(title:"Cancel")
                                                  { (cancelaction) in
                                                       
                                                  }
                                                  alertController.addAction(action)
                                                  alertController.addAction(cancelaction)
                                                self.present(alertController, animated: true, completion: nil)
                                        // self.performSegue(withIdentifier: "tomoviedetails", sender: self)
                                        /*
                                         if UIDevice.current.userInterfaceIdiom == .pad
                                                                                                                                         {
                                                                                                                     let storyBoard: UIStoryboard = UIStoryboard(name: "MainIpad", bundle: nil)
                                                                                                                     let secondViewController =  storyBoard.instantiateViewController(withIdentifier: "MoviesdetailsVC2") as! MoviesdetailsVC2
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
                                                                                                                           self.navigationController?.pushViewController(secondViewController, animated: true)
                                                                                                             }
                                                                                                             else if UIDevice.current.userInterfaceIdiom == .phone
                                                                                                             {

                                                                                                              let storyBoard: UIStoryboard = UIStoryboard(name: "Main", bundle: nil)
                                                                                                               let secondViewController =  storyBoard.instantiateViewController(withIdentifier: "MoviesdetailsVC2") as! MoviesdetailsVC2
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
                                                                                                               self.navigationController?.pushViewController(secondViewController, animated: true)
                                                                                                             }
                                         */
                                            
                                     }
                                  }
                                  catch let error
                                  {
                                      Utility.showAlert(vc: self, message:"\(error)", titelstring: Appcommon.Appname)
                                  }
                              }
         }
     
    }
       
    extension MoviesdetailsVC2: UICollectionViewDelegateFlowLayout {
                   func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
                        
                        if UIDevice.current.userInterfaceIdiom == .pad
                        {
                            return CGSize(width: collectionView.frame.size.height + 20, height:collectionView.frame.size.height)
                        }
                        else if UIDevice.current.userInterfaceIdiom == .phone
                        {
                            return CGSize(width: collectionView.frame.size.height + 30, height: collectionView.frame.size.height)
                                 
                               }
                        
                        return CGSize(width: 180, height: 280)
                    }
                 
             
        }
     
 
