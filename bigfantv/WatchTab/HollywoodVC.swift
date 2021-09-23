//
//  SeriesVC.swift
//  bigfantv
//
//  Created by Ganesh on 24/07/20.
//  Copyright © 2020 Ganesh. All rights reserved.
//

import UIKit
import Alamofire
import SwiftyJSON
import MaterialComponents.MaterialDialogs
class HollywoodVC: UIViewController {
    
       var sportsdata:newFilteredComedyMovieList?
       var spirtualdata:newFilteredComedyMovieList?
       var musicdata:newFilteredComedyMovieList?
       var newsdata:newFilteredComedyMovieList?
       var entertainmentdata:newFilteredComedyMovieList?
    private var passComedyMoviedata:newFilteredSubComedymovieList?
       private var Successdata:SuccessResponse?
       private var authorizeddata:Authorizescontent?
      
    private let serialDispatchQueue = DispatchQueue(label: "serial-dispatch-queue")
    @IBOutlet var TVSHOWCollectionV: UICollectionView!
    
    @IBOutlet var DocumentryCollectionV: UICollectionView!
    
    @IBOutlet var RadioCollecionV: UICollectionView!
    
    @IBOutlet var myScrollingView: UIScrollView!
    
     static var toviewall = 0
    static var isfrom = 0
      var Isfavourite = 0
    var imagename = ""
    var moviename = ""
    var movietype = ""
    var timereleasedate  = ""
    var language = ""
    var movdescription: String = ""
       var perma = ""
     let cellIdentifier = "cell"
    var Movcategory = ""
    var MovSubcategory = ""
    var WatchDuration = 0
    var movieuniqid = ""
    var newperma = ""
      var selftitle  = ""
    var collectionarray =  [UICollectionView]()
    override func viewDidLoad() {
           super.viewDidLoad()

        collectionarray = [TVSHOWCollectionV,DocumentryCollectionV, RadioCollecionV  ]
        
        for i in collectionarray
        {
              let flowLayout = UICollectionViewFlowLayout()
              flowLayout.scrollDirection = .horizontal
            let width = (i.frame.size.height * 280)/156
            
           
              flowLayout.itemSize = CGSize(width: width, height: i.frame.size.height)
              flowLayout.minimumLineSpacing = 10
              flowLayout.minimumInteritemSpacing = 10.0
              i.collectionViewLayout = flowLayout
              i.showsHorizontalScrollIndicator = false
            i.delegate = self
            i.dataSource = self
           i.register(UINib(nibName:"MyCell", bundle:nil), forCellWithReuseIdentifier: cellIdentifier)
        }
 
        Timer.scheduledTimer(withTimeInterval: 0.01, repeats: false) { (t) in
            if Connectivity.isConnectedToInternet()
            {
           self.LoadallData()
                
            }else
            {
                Utility.Internetconnection(vc: self)
            }
        }
              configureRefreshControl()
                         }
                      

                func configureRefreshControl ()
                {
                // Add the refresh control to your UIScrollView object.
                
                    Utility.configurscollview(scrollV: myScrollingView)
                    myScrollingView.refreshControl?.addTarget(self, action:
                                                   #selector(handleRefreshControl),
                                                   for: .valueChanged)
                   
               
               }
                
               @objc func handleRefreshControl()
               {
                   // Update your content…
                              myScrollingView.refreshControl?.beginRefreshing()
                              
                             if Connectivity.isConnectedToInternet()
                             {
                                 
                                LoadallData()
                             }else
                             {
                                 Utility.Internetconnection(vc: self)
                             }
                                 DispatchQueue.main.async {
                               self.myScrollingView.refreshControl?.endRefreshing()
                            }
                         }
      
    func LoadallData()
       {
        Utility.ShowLoader(vc: self)
          
         
                                    
            Common.shared.getfeiltereddata(category: "hollywood", subcategory: "gossip") { (data, err) -> (Void) in
                                       
                 self.sportsdata = data
 
                DispatchQueue.main.async {
                     self.TVSHOWCollectionV.reloadData()
                  }
             }
          
         
                                 
            Common.shared.getfeiltereddata(category: "hollywood", subcategory: "celebrity-interviews1") { (data, err) -> (Void) in
                         
                 self.spirtualdata = data
 
                DispatchQueue.main.async {
                     self.DocumentryCollectionV.reloadData()
                 }
             }
          
         
                                  
            Common.shared.getfeiltereddata(category: "hollywood", subcategory: "movie-trailers1") { (data, err) -> (Void) in
               
                 self.musicdata = data
 
                DispatchQueue.main.async {
                    Utility.hideLoader(vc:  self)
                     self.RadioCollecionV.reloadData()
               }
             }
         
            
    }
   
    @IBAction func ViewAllcomedyBtTapped(_ sender: UIButton) {
            if sender.tag == 1
            {
                Movcategory = "hollywood"
                MovSubcategory = "gossip"
                selftitle  = "Gossip"
            }else if sender.tag == 2
            {
                Movcategory = "hollywood"
                MovSubcategory = "celebrity-interviews1"
                selftitle = "Celebrity-Interviews"
            }else if sender.tag == 3
            {
                Movcategory = "hollywood"
                MovSubcategory = "movie-trailers1"
                selftitle = "Movie-Trailers"
            }
            
          let storyBoard: UIStoryboard = UIStoryboard(name: "Main", bundle: nil)
            let VC1 = storyBoard.instantiateViewController(withIdentifier: "OtherVidViewAll") as! OtherVidViewAll
             VC1.Movcategory = Movcategory
             VC1.MovSubcategory = MovSubcategory
         VC1.selftitle = selftitle
            let navController = UINavigationController(rootViewController: VC1) // Creating a navigation controller with VC1 at the root of the navigation stack.
           navController.navigationBar.barTintColor = Appcolor.backgorund3
             navController.navigationBar.isTranslucent = false
           navController.modalPresentationStyle = .fullScreen
           let textAttributes = [NSAttributedString.Key.foregroundColor:UIColor.white,NSAttributedString.Key.font: UIFont(name: "Muli-ExtraBold", size: 19)!]
           navController.navigationBar.titleTextAttributes = textAttributes
            self.present(navController, animated:true, completion: nil)
        }
       
    }

    extension HollywoodVC:UICollectionViewDelegate,UICollectionViewDataSource
    {
        func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
            
            if collectionView == TVSHOWCollectionV
            {
                return sportsdata?.subComedymovList.count ?? 0
            }
            else if collectionView == DocumentryCollectionV
            {
               return spirtualdata?.subComedymovList.count ?? 0
            }
           else if collectionView == RadioCollecionV
           {
              return musicdata?.subComedymovList.count ?? 0
           }
            
            return 0
        }
        
        func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell
        {
            var Cell   = collectionView.dequeueReusableCell(withReuseIdentifier: cellIdentifier, for: indexPath) as! MyCell

            
            
            switch collectionView
            {
            case self.TVSHOWCollectionV:
                
                let maincell = collectionView.dequeueReusableCell(withReuseIdentifier: cellIdentifier, for: indexPath) as! MyCell
              
                if let data = sportsdata
                {
                    Loaddataincell(maincell: maincell, data: data, ind: indexPath.row, tag: "ActionCollectioV")
                }
                
                Cell = maincell
               
            case self.DocumentryCollectionV:
                  
                let maincell = collectionView.dequeueReusableCell(withReuseIdentifier: cellIdentifier, for: indexPath) as! MyCell
                
                  if let data = spirtualdata
                  {
                      Loaddataincell(maincell: maincell, data: data, ind: indexPath.row, tag: "adventureCollectioV")
                  }
                  
                  Cell = maincell
                
            case self.RadioCollecionV:
               
                let maincell = collectionView.dequeueReusableCell(withReuseIdentifier: cellIdentifier, for: indexPath) as! MyCell
                
                  if let data = musicdata
                  {
                      Loaddataincell(maincell: maincell, data: data, ind: indexPath.row, tag: "fantasyCollectioV")
                  }
                  
                  Cell = maincell
 
                
                default:
                   print("")
                }
                return Cell
            
            
            
        }
        func Loaddataincell(maincell:MyCell,data:newFilteredComedyMovieList,ind:Int,tag:String)
        {
                   let item = data.subComedymovList[ind]
                    
                   if let url = URL(string: item.poster ?? "")
                   {
            
                       maincell.ImgSample.sd_setImage(with: url, placeholderImage: UIImage(named: "placeholder"), options: .highPriority, completed: nil)
            
                   }
            maincell.LbName.text = item.title ?? ""
            let image = item.is_fav_status == 1 ? UIImage(named: "liked") : UIImage(named: "like")
            maincell.btnCounter.setBackgroundImage(image, for: .normal)
            maincell.actionBlock = {
                () in
                if item.is_fav_status == 0
                {
                    maincell.btnCounter.setBackgroundImage(UIImage(named: "liked"), for: .normal)
                    self.AddtoFav(movieuniqidx: item.movie_uniq_id ?? "", endpoint: ApiEndPoints.AddToFavlist) { (true) in
                    maincell.btnCounter.setBackgroundImage(UIImage(named: "liked"), for: .normal)
                        
                        data.subComedymovList[ind].is_fav_status = 1
                       
                }
                }else if item.is_fav_status == 1
                {
                    maincell.btnCounter.setBackgroundImage(UIImage(named: "like"), for: .normal)
                    self.AddtoFav(movieuniqidx: item.movie_uniq_id ?? "", endpoint: ApiEndPoints.DeleteFavLIst) { (true) in
                    maincell.btnCounter.setBackgroundImage(UIImage(named: "like"), for: .normal)
                        data.subComedymovList[ind].is_fav_status = 0
                     
                }
                }
               
            }
             
        }
        func AddtoFav(movieuniqidx:String,endpoint:String, completionBlock: @escaping (Bool) -> Void) -> Void
        {
            Api.Addtofav(movie_uniq_id: movieuniqidx, endpoint: endpoint, vc: self) { (res, err) -> (Void) in
                do
                {
                    let decoder = JSONDecoder()
                    self.Successdata = try decoder.decode(SuccessResponse.self, from: res  ?? Data())
                    if self.Successdata?.code == 200
                    {
                        completionBlock(true)
                    }
                   
                }
                catch let error
                {
                  //  Utility.showAlert(vc: self, message:"\(error)", titelstring: Appcommon.Appname)
                }
            }
            
        }
        func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
            
            switch collectionView {
                 
            case self.TVSHOWCollectionV:
                
                 if let data = sportsdata?.subComedymovList[indexPath.row]
                 {
                    Movcategory = "hollywood"
                    MovSubcategory = "gossip"
                    passComedyMoviedata = data
                    getcontentauthorised(movieid: data.movie_uniq_id ?? "")
                }
            case self.DocumentryCollectionV:
                if let data = spirtualdata?.subComedymovList[indexPath.row]
                {
                    Movcategory = "documentary"
                    MovSubcategory = "celebrity-interviews1"
                    passComedyMoviedata = data
                    getcontentauthorised(movieid: data.movie_uniq_id ?? "")
                }
             case self.RadioCollecionV:
                 
                if let data = musicdata?.subComedymovList[indexPath.row]
                   {
                    Movcategory = "Radio Shows"
                    MovSubcategory = "movie-trailers1"
                    passComedyMoviedata = data
                    getcontentauthorised(movieid: data.movie_uniq_id ?? "")
                   }
 
                
            default:
                print("error")
        
                }
        }
        
                                                       
   func getcontentauthorised(movieid:String)
                    {
                        let storyBoard: UIStoryboard = UIStoryboard(name: "Main", bundle: nil)
                       let displayVC = storyBoard.instantiateViewController(withIdentifier: "OtherVideosVCDetails") as! OtherVideosVCDetails
                          displayVC.modalPresentationStyle = .fullScreen
                          if let item = self.passComedyMoviedata
                          {
                              displayVC.imagename = item.poster ?? ""
                              displayVC.moviename = item.title ?? ""
                              displayVC.perma = item.c_permalink ?? ""
                              displayVC.Movcategory = self.Movcategory
                              displayVC.MovSubcategory = self.MovSubcategory
                              displayVC.movieuniqid = item.movie_uniq_id ?? ""
                              displayVC.Isfavourite = item.is_fav_status ?? 0
                              displayVC.WatchDuration = item.watch_duration_in_seconds ?? 0
                              displayVC.playerurlstr = item.permalink ?? ""
                          }
                           
                      self.present(displayVC, animated: true, completion: nil)
                        /*
                        Api.IsContentAuthorised(movieid, endpoint: ApiEndPoints.isContentAuthorized, vc: self) { (res, err) -> (Void) in
                                             do
                                             {
                                                 let decoder = JSONDecoder()
                                                 self.authorizeddata = try decoder.decode(Authorizescontent.self, from: res  ?? Data())
                                                
                                                if self.authorizeddata?.status == "OK"
                                                {
                                            
                                                 let storyBoard: UIStoryboard = UIStoryboard(name: "Main", bundle: nil)
                                                let displayVC = storyBoard.instantiateViewController(withIdentifier: "OtherVideosVCDetails") as! OtherVideosVCDetails
                                                   displayVC.modalPresentationStyle = .fullScreen
                                                   if let item = self.passComedyMoviedata
                                                   {
                                                       displayVC.imagename = item.poster ?? ""
                                                       displayVC.moviename = item.title ?? ""
                                                       displayVC.perma = item.c_permalink ?? ""
                                                       displayVC.Movcategory = self.Movcategory
                                                       displayVC.MovSubcategory = self.MovSubcategory
                                                       displayVC.movieuniqid = item.movie_uniq_id ?? ""
                                                       displayVC.Isfavourite = item.is_fav_status ?? 0
                                                       displayVC.WatchDuration = item.watch_duration_in_seconds ?? 0
                                                       displayVC.playerurlstr = item.permalink ?? ""
                                                   }
                                                    
                                               self.present(displayVC, animated: true, completion: nil)
                                    
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
       
    
