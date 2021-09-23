//
//  SerirsDetailsVC1.swift
//  bigfantv
//
//  Created by Ganesh on 20/07/20.
//  Copyright © 2020 Ganesh. All rights reserved.
//

import UIKit
import MaterialComponents.MDCTabBar
import SDWebImage
import MuviPlayer
import CoreMedia
class SerirsDetailsVC1: UIViewController,UIPopoverPresentationControllerDelegate {

   @IBOutlet var ImgMovie: UIImageView!
   
   @IBOutlet var LbName: UILabel!
 
   @IBOutlet var LbGener: UILabel!
   
   
   @IBOutlet var LbTimenReleasedate: UILabel!
   @IBOutlet var LbLanguage: UILabel!
   
   @IBOutlet var LbDescription: UILabel!
   
       @IBOutlet var Viback: UIView!
       @IBOutlet var ViDetails: UIView!
       @IBOutlet var CollectionV: UICollectionView!
   
   @IBOutlet var CollectionV2: UICollectionView!
   @IBOutlet var ViTab: UIView!
         
       
          var moviename = ""
          var videoduration = ""
          var episodedate  = ""
          var episodestory = ""
          var episodeurl: String = ""
           var perma = ""
          var imagename = ""
             var ActionMoviedata:newFilteredComedyMovieList?
             var actiondata = [newFilteredSubComedymovieList]()
             var spirtualdata:newFilteredComedyMovieList?
             var musicdata:newFilteredComedyMovieList?
             var newsdata:newFilteredComedyMovieList?
             var entertainmentdata:newFilteredComedyMovieList?
           
            var Subspirtualdata = [newFilteredSubComedymovieList]()
            var Submusicdata = [newFilteredSubComedymovieList]()
            var Subnewsdata = [newFilteredSubComedymovieList]()
            var Subentertainmentdata = [newFilteredSubComedymovieList]()
    var Successdata:SuccessResponse?
    
    var episodedt:EdpisodeData?
    var Episodesdata = [Edpisodedetails]()
    var contentdata:contentdetails?
    var PaasEpisodesdata = [Edpisodedetails]()
       var currentTrack: Track!
      var playerUrl:URL?
     var isFullscreen = false
    var cellIdentifier = "cell"
    var Movcategory = ""
    var MovSubcategory = ""
   let  playerview = MuviPlayerView()
     var Isfavourite = 0
     var movieuniqid = ""
    var offset = 1
     var screenheight = 0.0
     var screenwidth = 0.0
     var totalconents = 0
    var index = 1
    var isloading:Bool?
    @IBOutlet var Viplayer: UIView!
     var WatchDuration = 0
      var playerurlstr = ""
     var contenttypesid = ""
           override func viewDidLoad() {
           super.viewDidLoad()
             ViDetails.isHidden = true
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
               self.CollectionV2.register(UINib(nibName:"MyCell", bundle:nil), forCellWithReuseIdentifier: cellIdentifier)
            
                                 screenwidth = Double(UIScreen.main.bounds.width)
                                 screenheight = Double(UIScreen.main.bounds.height)
            self.playerview.frame = CGRect(x: self.Viplayer.frame.minX, y: self.Viplayer.frame.minY , width:self.view.frame.size.width, height: self.Viplayer.frame.size.height)
                       
                                 self.view.addSubview(playerview)
                                   NotificationCenter.default.addObserver(self, selector: #selector(deviceOrientationDidChange), name: UIDevice.orientationDidChangeNotification, object: nil)
              
                     self.PaasEpisodesdata = self.Episodesdata
                     Episodesdata =  self.Episodesdata.filter({$0.episode_title != moviename})
                     let myString1: String = videoduration
                     let myStringArr1 = myString1.components(separatedBy: ":")
                     let fr1 = "\(myStringArr1[0]) Hr \(myStringArr1[1]) Min \(myStringArr1[2]) Sec"
                     self.LbName.text =  self.moviename
                     self.LbGener.text = "Hindi"
                     self.LbTimenReleasedate.text = "\(fr1) | \(episodedate)"
                     self.LbDescription.text = episodestory
                     
                     
                     self.CollectionV.delegate = self
                     self.CollectionV.dataSource  = self
                     DispatchQueue.main.async
                         {
                             self.CollectionV.reloadData()
                           
                         }
                     self.CollectionV2.delegate = self
                     self.CollectionV2.dataSource = self
                       DispatchQueue.main.async
                           {
                           self.CollectionV2.reloadData()
                           }
                     if let url = URL(string:  episodeurl)
                      {
                          let item = MuviPlayerItem(url: url)
                          self.playerview.set(item: item)
                           self.playerview.player.play()
                         
                  
                     }
                        
                        let tabBar = MDCTabBar(frame: CGRect(x: 0, y:0, width: ViTab.bounds.width, height: 80))
                              if self.contenttypesid == "3"
                               {
                                   ViDetails.isHidden = true
                                                  tabBar.items = [
                               UITabBarItem(title: "Episodes", image: UIImage(named: "phone"), tag: 0),
                               UITabBarItem(title: "Similar", image: UIImage(named: "heart"), tag: 1)
                               
                               ]
                              }else if self.contenttypesid == "1"
                              {
                                  CollectionV.isHidden = true
                                   ViDetails.isHidden = false
                                  tabBar.items = [
                                  
                                  UITabBarItem(title: "Similar", image: UIImage(named: "heart"), tag: 1)
                                  
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
 override func viewWillDisappear(_ animated: Bool) {
     if playerview.isPlaying
     {
         self.playerview.pause()
     }
 }
     @objc func deviceOrientationDidChange() {
        switch UIDevice.current.orientation {
        case .faceUp, .faceDown, .portrait, .unknown, .portraitUpsideDown:
          // default the player to original rotation
          self.playerview.transform = .identity
          self.playerview.frame = CGRect(x: 0, y:  20, width: self.view.frame.size.width  ,  height: self.Viplayer.frame.size.height)
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
    
 
    func GetActionMovielist()
              {
                  
                  Api.Getconent6(Movcategory, subCat: MovSubcategory, endpoint: ApiEndPoints.getFilteredContent, vc: self, offset: 1) { (res, err) -> (Void) in
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
                                    print(self.actiondata.count)
                                    
                                    self.CollectionV2.delegate = self
                                    self.CollectionV2.dataSource = self
                                      DispatchQueue.main.async
                                          {
                                          self.CollectionV2.reloadData()
                                          }
                                     
                                  }
                                  catch let error
                                  {
                                      Utility.showAlert(vc: self, message:"\(error)", titelstring: Appcommon.Appname)
                                  }
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
                print("total =\(self.totalconents)")
                for i in self.episodedt?.list ?? [Edpisodedetails]()
                {
                    self.Episodesdata.append(i)
                }
                self.PaasEpisodesdata = self.Episodesdata
                let item = self.Episodesdata[0]
                let myString1: String = item.video_duration ?? ""
                let myStringArr1 = myString1.components(separatedBy: ":")
                let fr1 = "\(myStringArr1[0]) Hr \(myStringArr1[1]) Min \(myStringArr1[2]) Sec"
                self.LbName.text =  item.episode_title ?? ""
                self.LbGener.text = "Hindi"
                self.LbTimenReleasedate.text = "\(fr1) | \(item.episode_date ?? "")"
                self.LbDescription.text = item.episode_story ?? ""
                self.playerurlstr = item.embeddedUrl ?? ""
                self.Episodesdata =  self.Episodesdata.filter({$0.episode_title != item.episode_title})
                if let url = URL(string:  item.video_url ?? "")
                 {
                     let item = MuviPlayerItem(url: url)
                     self.playerview.set(item: item)
                      self.playerview.player.play()
                    
                    /*
                     if self.WatchDuration != 0
                     {
                         let timeIntvl: TimeInterval = TimeInterval(self.WatchDuration)
                         let cmTime = CMTime(seconds: timeIntvl, preferredTimescale: 1)
                         self.playerview.player.seek(to: cmTime)
                         
                     }
                    */
                }
                
          
                                            
               }
               
               self.CollectionV.delegate = self
               self.CollectionV.dataSource  = self
               DispatchQueue.main.async
                   {
                       self.CollectionV.reloadData()
                    self.isloading = false
                   }
            
            }
            catch let error
            {
                Utility.showAlert(vc: self, message:"\(error)", titelstring: Appcommon.Appname)
            }
        }
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
                self.PaasEpisodesdata = self.Episodesdata
           self.CollectionV.delegate = self
           self.CollectionV.dataSource  = self
           DispatchQueue.main.async
               {
                   self.CollectionV.reloadData()
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
   extension SerirsDetailsVC1:MDCTabBarDelegate
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

   extension SerirsDetailsVC1:UICollectionViewDelegate,UICollectionViewDataSource
   {
    
    func collectionView(_ collectionView: UICollectionView, willDisplay cell: UICollectionViewCell, forItemAt indexPath: IndexPath)
    {
        
        if collectionView == CollectionV
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
            if Episodesdata.count <= 0
            {
                CollectionV.setEmptyViewnew1(title:"No Episodes found")
            }else
            {
                CollectionV.restore()
            }
            return Episodesdata.count
         }
         else if collectionView == CollectionV2
         {
            return actiondata.count
           }
        return 0
       }
       
       func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
         
            if collectionView == CollectionV2
           {
            let Actioncell = collectionView.dequeueReusableCell(withReuseIdentifier: cellIdentifier, for: indexPath) as! MyCell
             let item = actiondata[indexPath.row]
               Actioncell.ImgSample.sd_setImage(with: URL(string: "\(item.poster ?? "")"), completed: nil)
               Actioncell.LbName.text = item.title ?? ""
               Actioncell.ViLabel.isHidden = true
            
         return Actioncell
            }
            
           
        
          if collectionView == CollectionV
           {
            
             let Comedycell1 = collectionView.dequeueReusableCell(withReuseIdentifier: cellIdentifier, for: indexPath) as! MyCell
            Comedycell1.ViLike.isHidden = true
            Comedycell1.ImgSample.sd_setImage(with: URL(string: "\(Episodesdata[indexPath.row].poster_url ?? "")"), completed: nil)
            Comedycell1.LbName.text = self.Episodesdata[indexPath.row].episode_title ?? ""
               return Comedycell1
           }
            
        return UICollectionViewCell()
       }
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
          if collectionView == CollectionV
        {
            let storyBoard: UIStoryboard = UIStoryboard(name: "Main", bundle: nil)
            
            let displayVC = storyBoard.instantiateViewController(withIdentifier: "SerirsDetailsVC2") as! SerirsDetailsVC2
                displayVC.modalPresentationStyle = .fullScreen
              let item = Episodesdata[indexPath.row]
            displayVC.moviename = item.episode_title ?? ""
            displayVC.videoduration = item.video_duration ?? ""
            displayVC.episodedate = item.episode_date ?? ""
            displayVC.episodestory = item.episode_story ?? ""
            displayVC.episodeurl = item.video_url ?? ""
            displayVC.Episodesdata = self.PaasEpisodesdata
            displayVC.actiondata = self.actiondata
            displayVC.totalconents = self.totalconents
            displayVC.index = self.index
            displayVC.perma  = self.perma
            displayVC.Movcategory = self.Movcategory
            displayVC.MovSubcategory = self.MovSubcategory
               
            self.present(displayVC, animated: true, completion: nil)
            
    
        }
         
    
    }
   }
      
   extension SerirsDetailsVC1: UICollectionViewDelegateFlowLayout {
           func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
            /*
            if UIDevice.current.userInterfaceIdiom == .pad
              {
                        return CGSize(width: 180, height: collectionView.frame.size.height)
                      } else if UIDevice.current.userInterfaceIdiom == .phone
              {
               return CGSize(width: 280, height: 156)
                        
                      }
               */
               return CGSize(width: 280, height: 156)
           }
       }
    
extension SerirsDetailsVC1:MuviPlayerPlaybackDelegate
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
              self.playerview.frame = CGRect(x: 0, y:  self.playerview.safeAreaInsets.top, width: self.view.frame.size.width  ,  height: self.Viplayer.frame.size.height)
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
