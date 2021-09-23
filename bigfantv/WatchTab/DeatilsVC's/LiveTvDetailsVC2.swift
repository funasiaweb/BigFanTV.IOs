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
class LiveTvDetailsVC2: UIViewController {
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
    @IBOutlet var ViPlayer: UIView!
    var ActionMoviedata:newFilteredComedyMovieList?
    var actiondata = [newFilteredSubComedymovieList]()
     var WatchDuration = 0
    let sampledata:[sample] = [
          sample(img: "c1", labletext: "kolhapur"),
          sample(img: "c2", labletext: "kolhapur"),
          sample(img: "c3", labletext: "kolhapur"),
          sample(img: "c5", labletext: "kolhapur"),
          sample(img: "c6", labletext: "kolhapur")
            ]
            
           
          let playerview = MuviPlayerView()
        
            override func viewDidLoad() {
            super.viewDidLoad()
                
              self.CollectionV.register(UINib(nibName:"MyCell", bundle:nil), forCellWithReuseIdentifier: cellIdentifier)
         NotificationCenter.default.addObserver(self, selector:#selector(stopplayer), name:UIApplication.didEnterBackgroundNotification, object: nil)
              }
              @objc func stopplayer()
              {
                  if self.playerview.isPlaying
                  {
                  self.playerview.player.pause()
              }
              }
        override func viewWillAppear(_ animated: Bool) {
            print(moviename)
                   self.LbName.text = self.moviename
                  self.LbDescription.text  = self.movdescription
                  self.LbTimenReleasedate.text = self.timereleasedate
                  self.LbLanguage.text  = self.language
            Viback.layer.cornerRadius = Viback.frame.size.height/2
            Viback.layer.borderColor = UIColor.clear.cgColor
            Viback.layer.borderWidth = 1
             ViDetails.isHidden = true
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
                  UITabBarItem(title: "Upcoming", image: UIImage(named: "phone"), tag: 0) 
                  
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
     func getcontendeatils(permaa:String)
        {
            print(permaa)
            Api.getcontentdetails(permaa, endpoint: ApiEndPoints.getcontentdetails, vc: self) { (res, err) -> (Void) in
                do
                        {
                       
                            let decoder = JSONDecoder()
                            self.contentdata = try decoder.decode(contentdetails.self, from: res  ?? Data())
                
                                     self.playerview.frame = CGRect(x: 0, y:0, width:self.ViPlayer.frame.size.width, height: self.ViPlayer.frame.size.height)
                                      self.playerview.backgroundColor = .black
                         self.ViPlayer.addSubview(self.playerview)
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
                           do {
                            guard let url = URL(string:  self.contentdata?.submovie?.movieUrl ?? "") else {
                                                            return
                                                        }
                                                        let item = MuviPlayerItem(url:  url )
                                                          self.playerview.set(item: item)
                                                          self.playerview.useMuviPlayerControls = true
                                                          self.playerview.player.play()
                                                       
                                                    }
                                                    catch
                                                    {
                                                        print(error)
                                                    }
                        
                        
                        }
                catch let error
                {
                    Utility.showAlert(vc: self, message:"\(error)", titelstring: Appcommon.Appname)
                }
            }
        }
    @IBAction func BackBtTapped(_ sender: UIButton) {
        self.navigationController?.popViewController(animated: true)
        }
        
    }
    extension LiveTvDetailsVC2:MDCTabBarDelegate
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

    extension LiveTvDetailsVC2:UICollectionViewDelegate,UICollectionViewDataSource
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
                        Actioncell.ViLabel.isHidden = true
                     
                  return Actioncell
         
        }
        func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
              
             imagename = ActionMoviedata?.subComedymovList[indexPath.row].poster ?? ""
             moviename = ActionMoviedata?.subComedymovList[indexPath.row].title ?? ""
             LiveTVvc.isfrom = 1
              perma = ActionMoviedata?.subComedymovList[indexPath.row].c_permalink ?? ""
            WatchDuration = ActionMoviedata?.subComedymovList[indexPath.row].watch_duration_in_seconds ?? 0
            if UIDevice.current.userInterfaceIdiom == .pad
            {
               let storyBoard: UIStoryboard = UIStoryboard(name: "MainIpad", bundle: nil)
             let secondViewController =  storyBoard.instantiateViewController(withIdentifier: "LiveTvDetailsVC1") as! LiveTvDetailsVC1
             secondViewController.imagename = self.imagename
             secondViewController.moviename = self.moviename
             secondViewController.movietype = self.movietype
             secondViewController.timereleasedate = self.timereleasedate
             secondViewController.language = self.language
             secondViewController.perma = self.perma
             secondViewController.Movcategory = self.Movcategory
             secondViewController.MovSubcategory = self.MovSubcategory
                   secondViewController.WatchDuration = self.WatchDuration
             self.navigationController?.pushViewController(secondViewController, animated: true)
                
            }
            else if UIDevice.current.userInterfaceIdiom == .phone
            {
                 let storyBoard: UIStoryboard = UIStoryboard(name: "Main", bundle: nil)
                     let secondViewController =  storyBoard.instantiateViewController(withIdentifier: "LiveTvDetailsVC1") as! LiveTvDetailsVC1
                     secondViewController.imagename = self.imagename
                     secondViewController.moviename = self.moviename
                     secondViewController.movietype = self.movietype
                     secondViewController.timereleasedate = self.timereleasedate
                     secondViewController.language = self.language
                     secondViewController.perma = self.perma
                     secondViewController.Movcategory = self.Movcategory
                     secondViewController.MovSubcategory = self.MovSubcategory
                   secondViewController.WatchDuration = self.WatchDuration
                     self.navigationController?.pushViewController(secondViewController, animated: true)
           
                
            }
              
                 
           }
    }
       
    extension LiveTvDetailsVC2: UICollectionViewDelegateFlowLayout {
            func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
               if UIDevice.current.userInterfaceIdiom == .pad {
                         return CGSize(width: 180, height: collectionView.frame.size.height)
                       } else if UIDevice.current.userInterfaceIdiom == .phone  {
                return CGSize(width: 156, height: collectionView.frame.size.height)
                         
                       }
                
                return CGSize(width: 180, height: 280)
            }
        }
     
