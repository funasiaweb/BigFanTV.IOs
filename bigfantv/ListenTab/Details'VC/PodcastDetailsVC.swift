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
class PodcastDetailsVC: UIViewController,UIPopoverPresentationControllerDelegate {
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
   
    var playerurls = ""
    var selftitle = ""
    var timed = ""
    var pubdate = ""
     var Loadhomedata:NewPodcastDataList?
    var localdata = [NewPodcastDataListDetails]()
     var Isfavourite = 0
     var Successdata:SuccessResponse?
     var WatchDuration = 0
    
     @IBOutlet var BtFav: UIButton!
           
        let playerview = MuviPlayerView()
            override func viewDidLoad() {
            super.viewDidLoad()
               
                for i in Loadhomedata?.list ?? [NewPodcastDataListDetails]()
                {
                    if   i.pubDate != pubdate
                    {
                        localdata.append(i)
                    }
                }
                
                print(localdata.count)
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
             
                if let url = URL(string:playerurls)
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
                
                
        let cellNib = UINib(nibName: "CollectionViewCellnew", bundle: nil)
         self.CollectionV.register(cellNib, forCellWithReuseIdentifier: "collectionviewcellid")
                self.CollectionV.delegate = self
                self.CollectionV.dataSource = self
                self.CollectionV.reloadData()
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
 
        override func viewDidAppear(_ animated: Bool) {
           
            
           
            self.LbName.text = selftitle
            self.LbGener.text = timed
            self.LbTimenReleasedate.text = pubdate
                      screenwidth = Double(UIScreen.main.bounds.width)
                      screenheight = Double(UIScreen.main.bounds.height)
                      self.playerview.frame = CGRect(x: 0, y: navigationController?.navigationBar.frame.size.height ?? 20 + 20 , width:self.view.frame.size.width, height: self.ViPlayer.frame.size.height)
            
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
    extension PodcastDetailsVC:MDCTabBarDelegate
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

    extension PodcastDetailsVC:UICollectionViewDelegate,UICollectionViewDataSource
    {
        func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
            if localdata.count <= 0
              {
                  self.CollectionV.setEmptyViewnew1(title: "No contents found")
              }else
              {
                  self.CollectionV.restore()
              }
            return self.localdata.count
                
             
          }
          
          func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
               if let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "collectionviewcellid", for: indexPath) as? CollectionViewCellnew {
                   
                   cell.backgroundView?.backgroundColor = Appcolor.backgorund3
                   cell.contentView.backgroundColor = Appcolor.backgorund3
                 
                   cell.Imageview.sd_setImage(with: URL(string: "\(localdata[indexPath.item].itunesimage ?? "")"), completed: nil)
                  cell.LbTime.text = localdata[indexPath.item].pubDate ?? ""
                   cell.LbDate.text = localdata[indexPath.item].duration
                   return cell
               }
               return UICollectionViewCell()
           }
        func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath)
        {
                     let storyBoard: UIStoryboard = UIStoryboard(name: "Main", bundle: nil)
                      let secondViewController =  storyBoard.instantiateViewController(withIdentifier: "PodcastDetailsVC1") as! PodcastDetailsVC1
                       secondViewController.selftitle = localdata[indexPath.item].title ?? ""
                       secondViewController.playerurls = localdata[indexPath.item].url ?? ""
                       secondViewController.timed = localdata[indexPath.item].duration ?? ""
                      secondViewController.pubdate = localdata[indexPath.item].pubDate ?? ""
                      secondViewController.Loadhomedata = Loadhomedata
            
                     self.present(secondViewController, animated: true)
                   }
      
                
    }
       
    extension PodcastDetailsVC: UICollectionViewDelegateFlowLayout {
            func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
              /*
                if UIDevice.current.userInterfaceIdiom == .pad
               {
                         return CGSize(width: 180, height: collectionView.frame.size.height)
                       } else if UIDevice.current.userInterfaceIdiom == .phone
               {
                return CGSize(width: collectionView.frame.size.height + 30 , height: collectionView.frame.size.height)
                         
                       }
                */
                return CGSize(width: collectionView.frame.size.height + 30 , height: collectionView.frame.size.height)
            }
        }
     

extension PodcastDetailsVC:MuviPlayerPlaybackDelegate
{
    func backButtonAction(player: MuviVideoPlayer, item: MuviPlayerItem?) {
       let cmtime = self.playerview.player.currentTime()
        let floattime = Float(CMTimeGetSeconds(cmtime))
        
        if !floattime.isNaN
        {
          if Connectivity.isConnectedToInternet()
          {
               savelog(duration: floattime)
          }
        }
          
        self.dismiss(animated: true, completion: nil)

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
