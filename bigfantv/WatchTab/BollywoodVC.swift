//
//  MovieVC.swift
//  bigfantv
//
//  Created by Ganesh on 23/07/20.
//  Copyright © 2020 Ganesh. All rights reserved.
//

import UIKit
import Alamofire
import SwiftyJSON
import SDWebImage
 
import MaterialComponents.MaterialDialogs
 
class BollywoodVC: UIViewController ,UIPopoverPresentationControllerDelegate {
//
    //FSPagerview
     
    private var authorizeddata:Authorizescontent?
    var contentdata:contentdetails?
    var PPVdata:PPVplans?

    
    //
    private var ComedyMoviedata:newFilteredComedyMovieList?
    private var Successdata:SuccessResponse?
    private var passComedyMoviedata:newFilteredSubComedymovieList?
    private var ThrillerMoviedata:newFilteredComedyMovieList?
    private var ActionMoviedata:newFilteredComedyMovieList?
    private var  fantasyMoviedata:newFilteredComedyMovieList?
    private var  adventureMoviedata:newFilteredComedyMovieList?
    private var  animationMoviedata:newFilteredComedyMovieList?
    private var  crimeMoviedata:newFilteredComedyMovieList?
    private var  mysteryMoviedata:newFilteredComedyMovieList?
    private var  dramaMoviedata:newFilteredComedyMovieList?
    private var  romanceMoviedata:newFilteredComedyMovieList?
    private var horrorMoviedata:newFilteredComedyMovieList?
    private var  scifiMoviedata:newFilteredComedyMovieList?
    private var  tollywoodMoviedata:newFilteredComedyMovieList?
    private var  clipsMoviedata:newFilteredComedyMovieList?
    private var  GameplaysMoviedata:newFilteredComedyMovieList?
    private var  GameTrailersMoviedata:newFilteredComedyMovieList?
     private var  PassMoviedata:newFilteredComedyMovieList?
       
    
//    private var authorizeddata:Authorizescontent?
     @IBOutlet var ViScroll: UIView!
    
    @IBOutlet var ComedyCollectionV: UICollectionView!
    
    @IBOutlet var ThrillerCollectionV: UICollectionView!
    
    @IBOutlet var ActionCollectioV: UICollectionView!
    @IBOutlet var  fantasyCollectioV: UICollectionView!
    @IBOutlet var  adventureCollectioV: UICollectionView!
    @IBOutlet var  animationCollectioV: UICollectionView!
    @IBOutlet var  crimeCollectioV: UICollectionView!
    @IBOutlet var  mysteryCollectioV: UICollectionView!
    @IBOutlet var  dramaCollectioV: UICollectionView!
    @IBOutlet var  romanceCollectioV: UICollectionView!
    @IBOutlet var  horrorCollectioV: UICollectionView!
    @IBOutlet var  scifiCollectioV: UICollectionView!
    @IBOutlet var  tollywoodCollectioV: UICollectionView!
    @IBOutlet var  clipsCollectioV: UICollectionView!
    @IBOutlet var GameplaysCollectioV: UICollectionView!
    @IBOutlet var GameTrailersCollectioV: UICollectionView!
    
    @IBOutlet var myScrollingView: UIScrollView!
      private let serialDispatchQueue = DispatchQueue(label: "serial-dispatch-queue")
    static var isfrom = 0
      var Isfavourite = 0
    static var toviewall = 0
       var imagename = ""
       var moviename = ""
       var movietype = ""
       var timereleasedate  = ""
       var language = ""
       var movdescription: String = ""
    
    var totalcount = 0
    var movieuniqid = ""
    var perma = ""
    let cellIdentifier = "cell"
    var Movcategory = ""
    var MovSubcategory = ""
    var WatchDuration = 0
     var newperma = ""
      var selftitle  = ""
    var collectionarray =  [UICollectionView]()
    override func viewDidLoad() {
           super.viewDidLoad()

        collectionarray = [ComedyCollectionV,ActionCollectioV, ThrillerCollectionV,fantasyCollectioV,adventureCollectioV,animationCollectioV,crimeCollectioV,mysteryCollectioV,dramaCollectioV,romanceCollectioV,horrorCollectioV,scifiCollectioV ]
        
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
            }
            else
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
        myScrollingView.refreshControl?.addTarget(self, action: #selector(handleRefreshControl), for: .valueChanged)
     }
            
    @objc func handleRefreshControl()
    {
        // Update your content…
        myScrollingView.refreshControl?.beginRefreshing()
                           
      if Connectivity.isConnectedToInternet()
      {
          
        self.LoadallData()
      }else
      {
          Utility.Internetconnection(vc: self)
      }
        DispatchQueue.main.async
            {
                self.myScrollingView.refreshControl?.endRefreshing()
            }
        
    }
     func LoadallData()
        {
            Utility.ShowLoader(vc: self)
              
             
                       
                Common.shared.getfeiltereddata2(category: "bollywood-videos", subcategory: "facts") { (data, err) -> (Void) in
             
                     self.ComedyMoviedata = data
 
                    DispatchQueue.main.async
                        {
                             self.ComedyCollectionV.reloadData()
                        }
                  }
            
              
                        
                 Common.shared.getfeiltereddata2(category: "bollywood-videos", subcategory: "behind-the-scenes") { (data, err) -> (Void) in
              
                      self.ThrillerMoviedata = data
 
                     DispatchQueue.main.async
                         {
                              self.ThrillerCollectionV.reloadData()
                         }
                   }
             
              
                        
                 Common.shared.getfeiltereddata2(category: "bollywood-videos", subcategory: "photoshoots") { (data, err) -> (Void) in
              
                      self.ActionMoviedata = data
 
                     DispatchQueue.main.async
                         {
                            Utility.hideLoader(vc:  self)
                              self.ActionCollectioV.reloadData()
                         }
                   }
            
               
                         
                  Common.shared.getfeiltereddata2(category: "bollywood-videos", subcategory: "rare-footage") { (data, err) -> (Void) in
               
                       self.fantasyMoviedata = data
 
                      DispatchQueue.main.async
                          {
                             Utility.hideLoader(vc:  self)
                               self.fantasyCollectioV.reloadData()
                          }
                    }
              
              
                        
                 Common.shared.getfeiltereddata2(category: "bollywood-videos", subcategory: "interviews") { (data, err) -> (Void) in
              
                      self.adventureMoviedata = data
 
                     DispatchQueue.main.async
                         {
                             Utility.hideLoader(vc:  self)
                              self.adventureCollectioV.reloadData()
                         }
                   }
           
               
                         
                  Common.shared.getfeiltereddata2(category: "bollywood-videos", subcategory: "launches") { (data, err) -> (Void) in
               
                       self.animationMoviedata = data
 
                      DispatchQueue.main.async
                          {
                             Utility.hideLoader(vc:  self)
                               self.animationCollectioV.reloadData()
                          }
                    }
             
              
                        
                 Common.shared.getfeiltereddata2(category: "bollywood-videos", subcategory: "flashback") { (data, err) -> (Void) in
              
                      self.crimeMoviedata = data
 
                     DispatchQueue.main.async
                         {
                             Utility.hideLoader(vc:  self)
                              self.crimeCollectioV.reloadData()
                         }
                   }
            
               
                         
                  Common.shared.getfeiltereddata2(category: "movie-trailers", subcategory: "") { (data, err) -> (Void) in
               
                       self.mysteryMoviedata = data
 
                      DispatchQueue.main.async
                          {
                               self.mysteryCollectioV.reloadData()
                          }
                    }
             
              
                        
                 Common.shared.getfeiltereddata2(category: "movie-reviews", subcategory: "") { (data, err) -> (Void) in
              
                      self.dramaMoviedata = data
 
                     DispatchQueue.main.async
                         {
                              self.dramaCollectioV.reloadData()
                         }
                   }
             
               
                         
                  Common.shared.getfeiltereddata2(category: "celebrity-interviews", subcategory: "") { (data, err) -> (Void) in
               
                       self.romanceMoviedata = data
 
                      DispatchQueue.main.async
                          {
                               self.romanceCollectioV.reloadData()
                          }
                    }
             
              
                        
                 Common.shared.getfeiltereddata2(category: "bollywood-gossips", subcategory: "") { (data, err) -> (Void) in
              
                      self.horrorMoviedata = data
 
                     DispatchQueue.main.async
                         {
                              self.horrorCollectioV.reloadData()
                         }
                   }
             
               
                         
                  Common.shared.getfeiltereddata2(category:"bollywood-videos", subcategory: "making-of-movies") { (data, err) -> (Void) in
               
                       self.scifiMoviedata = data
 
                      DispatchQueue.main.async
                          {
                               self.scifiCollectioV.reloadData()
                          }
                    }
             
            
            
            
    }
    
  
    
    
      @IBAction func ViewAllcomedyBtTapped(_ sender: UIButton) {
        if sender.tag == 1
        {
            Movcategory = "bollywood-videos"
            MovSubcategory = "facts"
            selftitle = "Facts"
        }else if sender.tag == 2
        {
            Movcategory = "bollywood-videos"
            MovSubcategory = "behind-the-scenes"
             selftitle = "Behind-the-scenes"
        }else if sender.tag == 3
        {
            Movcategory = "bollywood-videos"
            MovSubcategory = "photoshoots"
             selftitle = "Photoshoots"
        }else if sender.tag == 4
        {
            Movcategory = "bollywood-videos"
            MovSubcategory =  "rare-footage"
             selftitle =  "Rare-Footage"
        }else if sender.tag == 5
        {
            Movcategory = "bollywood-videos"
            MovSubcategory = "interviews"
             selftitle = "Interviews"
        }else if sender.tag == 6
        {
            Movcategory = "bollywood-videos"
            MovSubcategory = "launches"
             selftitle = "Launches"
        }else if sender.tag == 7
        {
            Movcategory = "bollywood-videos"
            MovSubcategory =  "flashback"
             selftitle = "Flashback"
        }else if sender.tag == 8
        {
            Movcategory = "movie-trailers"
            MovSubcategory = ""
             selftitle = "Movie-Trailers"
        }else if sender.tag == 9
        {
            Movcategory =  "movie-reviews"
            MovSubcategory = ""
             selftitle = "Movie-Reviews"
        }else if sender.tag == 10
        {
            Movcategory = "celebrity-interviews"
            MovSubcategory = ""
             selftitle = "Celebrity-Interviews"
        }else if sender.tag == 11
        {
            Movcategory = "bollywood-gossips"
            MovSubcategory = ""
             selftitle = "Bollywood-Gossips"
        }else if sender.tag == 12
        {
            Movcategory =  "bollywood-videos"
            MovSubcategory = "making-of-movies"
             selftitle = "Making-of-movies"
        }  
         let storyBoard: UIStoryboard = UIStoryboard(name: "Main", bundle: nil)
         let VC1 = storyBoard.instantiateViewController(withIdentifier: "OtherVidViewAll") as! OtherVidViewAll
          VC1.Movcategory = Movcategory
          VC1.MovSubcategory = MovSubcategory
         VC1.selftitle = selftitle
         let navController = UINavigationController(rootViewController: VC1) // Creating a navigation controller with VC1 at the root of the navigation stack.
        navController.navigationBar.barTintColor = Appcolor.backgorund3
        let textAttributes = [NSAttributedString.Key.foregroundColor:UIColor.white,NSAttributedString.Key.font: UIFont(name: "Muli-ExtraBold", size: 19)!]
        navController.navigationBar.titleTextAttributes = textAttributes
          navController.navigationBar.isTranslucent = false
        navController.modalPresentationStyle = .fullScreen
         self.present(navController, animated:true, completion: nil)
       
    }
    
    
    
}

extension BollywoodVC:UICollectionViewDelegate,UICollectionViewDataSource
{
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        
        if collectionView == ComedyCollectionV
        {
 
            return ComedyMoviedata?.subComedymovList.count ?? 0
        }else if collectionView == ThrillerCollectionV
        {
 
            return ThrillerMoviedata?.subComedymovList.count ?? 0
        }else if collectionView == ActionCollectioV
        {
 
            return ActionMoviedata?.subComedymovList.count ?? 0
        }else if collectionView == fantasyCollectioV
        {
 
            return fantasyMoviedata?.subComedymovList.count ?? 0
        }else if collectionView == adventureCollectioV
        {
 
            return adventureMoviedata?.subComedymovList.count ?? 0
        }else if collectionView == animationCollectioV
        {
 
            return animationMoviedata?.subComedymovList.count ?? 0
        }else if collectionView == crimeCollectioV
        {
            return crimeMoviedata?.subComedymovList.count ?? 0
        }else if collectionView == mysteryCollectioV
        {
 
            return mysteryMoviedata?.subComedymovList.count ?? 0
        }else if collectionView == dramaCollectioV
        {
 
            return dramaMoviedata?.subComedymovList.count ?? 0
        }else if collectionView == romanceCollectioV
        {
 
            return romanceMoviedata?.subComedymovList.count ?? 0
        }else if collectionView == horrorCollectioV
        {
 
            return horrorMoviedata?.subComedymovList.count ?? 0
        }else if collectionView == scifiCollectioV
        {
 
            return scifiMoviedata?.subComedymovList.count ?? 0
        }
        return 0
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        
        var Cell   = collectionView.dequeueReusableCell(withReuseIdentifier: cellIdentifier, for: indexPath) as! MyCell

        
        
        switch collectionView
        {
        case self.ComedyCollectionV:
            
            let maincell = collectionView.dequeueReusableCell(withReuseIdentifier: cellIdentifier, for: indexPath) as! MyCell
          
            if let data = ComedyMoviedata
            {
                Loaddataincell(maincell: maincell, data: data, ind: indexPath.row, tag: "ActionCollectioV")
            }
            
            Cell = maincell
             
        case self.ThrillerCollectionV:
                
                let maincell = collectionView.dequeueReusableCell(withReuseIdentifier: cellIdentifier, for: indexPath) as! MyCell
              
                if let data = ThrillerMoviedata
                {
                    Loaddataincell(maincell: maincell, data: data, ind: indexPath.row, tag: "ActionCollectioV")
                }
                
                Cell = maincell
                 
        case self.ActionCollectioV:
                    
            let maincell = collectionView.dequeueReusableCell(withReuseIdentifier: cellIdentifier, for: indexPath) as! MyCell
                   
            if let data = ActionMoviedata
            {
                Loaddataincell(maincell: maincell, data: data, ind: indexPath.row, tag: "ActionCollectioV")
            }
            Cell = maincell
        
        case self.fantasyCollectioV:
                         
            let maincell = collectionView.dequeueReusableCell(withReuseIdentifier: cellIdentifier, for: indexPath) as! MyCell
                       
            if let data = fantasyMoviedata
            {
                Loaddataincell(maincell: maincell, data: data, ind: indexPath.row, tag: "ActionCollectioV")
            }
            
            Cell = maincell
         case self.adventureCollectioV:
             
             let maincell = collectionView.dequeueReusableCell(withReuseIdentifier: cellIdentifier, for: indexPath) as! MyCell
           
             if let data = adventureMoviedata
             {
                 Loaddataincell(maincell: maincell, data: data, ind: indexPath.row, tag: "ActionCollectioV")
             }
             
             Cell = maincell
              
         case self.animationCollectioV:
                 
                 let maincell = collectionView.dequeueReusableCell(withReuseIdentifier: cellIdentifier, for: indexPath) as! MyCell
               
                 if let data = animationMoviedata
                 {
                     Loaddataincell(maincell: maincell, data: data, ind: indexPath.row, tag: "ActionCollectioV")
                 }
                 
                 Cell = maincell
                  
         case self.crimeCollectioV:
                     
             let maincell = collectionView.dequeueReusableCell(withReuseIdentifier: cellIdentifier, for: indexPath) as! MyCell
                    
             if let data = crimeMoviedata
             {
                 Loaddataincell(maincell: maincell, data: data, ind: indexPath.row, tag: "ActionCollectioV")
             }
             Cell = maincell
         
         case self.mysteryCollectioV:
                          
             let maincell = collectionView.dequeueReusableCell(withReuseIdentifier: cellIdentifier, for: indexPath) as! MyCell
                        
             if let data = mysteryMoviedata
             {
                 Loaddataincell(maincell: maincell, data: data, ind: indexPath.row, tag: "ActionCollectioV")
             }
             
             Cell = maincell
         case self.dramaCollectioV:
                          
             let maincell = collectionView.dequeueReusableCell(withReuseIdentifier: cellIdentifier, for: indexPath) as! MyCell
                        
             if let data = dramaMoviedata
             {
                 Loaddataincell(maincell: maincell, data: data, ind: indexPath.row, tag: "ActionCollectioV")
             }
             
             Cell = maincell
          case self.romanceCollectioV:
              
              let maincell = collectionView.dequeueReusableCell(withReuseIdentifier: cellIdentifier, for: indexPath) as! MyCell
            
              if let data = romanceMoviedata
              {
                  Loaddataincell(maincell: maincell, data: data, ind: indexPath.row, tag: "ActionCollectioV")
              }
              
              Cell = maincell
               
          case self.horrorCollectioV:
                  
                  let maincell = collectionView.dequeueReusableCell(withReuseIdentifier: cellIdentifier, for: indexPath) as! MyCell
                
                  if let data = horrorMoviedata
                  {
                      Loaddataincell(maincell: maincell, data: data, ind: indexPath.row, tag: "ActionCollectioV")
                  }
                  
                  Cell = maincell
                   
          case self.scifiCollectioV:
                      
              let maincell = collectionView.dequeueReusableCell(withReuseIdentifier: cellIdentifier, for: indexPath) as! MyCell
                     
              if let data = scifiMoviedata
              {
                  Loaddataincell(maincell: maincell, data: data, ind: indexPath.row, tag: "ActionCollectioV")
              }
              Cell = maincell
          
        default :
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
        
        if collectionView == ComedyCollectionV
        {
            Movcategory = "bollywood-videos"
            MovSubcategory = "facts"
            passComedyMoviedata = ComedyMoviedata?.subComedymovList[indexPath.row]
            let item = ComedyMoviedata?.subComedymovList[indexPath.row]
            self.getcontentauthorized(movieid: item?.movie_uniq_id ?? "", planurls: "", index: indexPath.row, permad: item?.c_permalink ?? "")         }
        else if collectionView == ThrillerCollectionV
        {
            Movcategory = "bollywood-videos"
            MovSubcategory = "behind-the-scenes"
            passComedyMoviedata = ThrillerMoviedata?.subComedymovList[indexPath.row]
            let item = ThrillerMoviedata?.subComedymovList[indexPath.row]
            self.getcontentauthorized(movieid: item?.movie_uniq_id ?? "", planurls: "", index: indexPath.row, permad: item?.c_permalink ?? "")        }
        else if collectionView == ActionCollectioV
        {
            Movcategory = "bollywood-videos"
            MovSubcategory = "photoshoots"
            passComedyMoviedata = ActionMoviedata?.subComedymovList[indexPath.row]
            let item = ActionMoviedata?.subComedymovList[indexPath.row]
            self.getcontentauthorized(movieid: item?.movie_uniq_id ?? "", planurls: "", index: indexPath.row, permad: item?.c_permalink ?? "")        }
        else if collectionView == fantasyCollectioV
        {
            Movcategory = "bollywood-videos"
            MovSubcategory = "rare-footage"
            passComedyMoviedata = fantasyMoviedata?.subComedymovList[indexPath.row]
            let item = fantasyMoviedata?.subComedymovList[indexPath.row]
            self.getcontentauthorized(movieid: item?.movie_uniq_id ?? "", planurls: "", index: indexPath.row, permad: item?.c_permalink ?? "")        }
        else if collectionView == adventureCollectioV
        {
            Movcategory = "bollywood-videos"
            MovSubcategory = "interviews"
            passComedyMoviedata = adventureMoviedata?.subComedymovList[indexPath.row]
            let item = adventureMoviedata?.subComedymovList[indexPath.row]
            self.getcontentauthorized(movieid: item?.movie_uniq_id ?? "", planurls: "", index: indexPath.row, permad: item?.c_permalink ?? "")
        }
        else if collectionView == animationCollectioV
        {
            Movcategory = "bollywood-videos"
            MovSubcategory = "launches"
            passComedyMoviedata = animationMoviedata?.subComedymovList[indexPath.row]
            let item = animationMoviedata?.subComedymovList[indexPath.row]
            self.getcontentauthorized(movieid: item?.movie_uniq_id ?? "", planurls: "", index: indexPath.row, permad: item?.c_permalink ?? "")
        }
        else if collectionView == crimeCollectioV
        {
            Movcategory = "bollywood-videos"
            MovSubcategory = "flashback"
            passComedyMoviedata = crimeMoviedata?.subComedymovList[indexPath.row]
            let item = crimeMoviedata?.subComedymovList[indexPath.row]
            self.getcontentauthorized(movieid: item?.movie_uniq_id ?? "", planurls: "", index: indexPath.row, permad: item?.c_permalink ?? "")       }
        else if collectionView == mysteryCollectioV
        {
            Movcategory = "movie-trailers"
            MovSubcategory = ""
            passComedyMoviedata = mysteryMoviedata?.subComedymovList[indexPath.row]
            let item = mysteryMoviedata?.subComedymovList[indexPath.row]
            self.getcontentauthorized(movieid: item?.movie_uniq_id ?? "", planurls: "", index: indexPath.row, permad: item?.c_permalink ?? "")          }
        else if collectionView == dramaCollectioV
        {
            Movcategory = "movie-reviews"
            MovSubcategory = ""
            passComedyMoviedata = dramaMoviedata?.subComedymovList[indexPath.row]
            let item = dramaMoviedata?.subComedymovList[indexPath.row]
            self.getcontentauthorized(movieid: item?.movie_uniq_id ?? "", planurls: "", index: indexPath.row, permad: item?.c_permalink ?? "")
        }
        else if collectionView == romanceCollectioV
        {
            Movcategory = "celebrity-interviews"
            MovSubcategory = ""
            passComedyMoviedata = romanceMoviedata?.subComedymovList[indexPath.row]
            let item = romanceMoviedata?.subComedymovList[indexPath.row]
            self.getcontentauthorized(movieid: item?.movie_uniq_id ?? "", planurls: "", index: indexPath.row, permad: item?.c_permalink ?? "")      }
        else if collectionView == horrorCollectioV
        {
            Movcategory = "bollywood-gossips"
            MovSubcategory = ""
            passComedyMoviedata = horrorMoviedata?.subComedymovList[indexPath.row]
            let item = horrorMoviedata?.subComedymovList[indexPath.row]
            self.getcontentauthorized(movieid: item?.movie_uniq_id ?? "", planurls: "", index: indexPath.row, permad: item?.c_permalink ?? "")
        }
        else if collectionView == scifiCollectioV
        {
            Movcategory =   "bollywood-videos"
            MovSubcategory = "making-of-movies"
            passComedyMoviedata = scifiMoviedata?.subComedymovList[indexPath.row]
            let item = scifiMoviedata?.subComedymovList[indexPath.row]
            self.getcontentauthorized(movieid: item?.movie_uniq_id ?? "", planurls: "", index: indexPath.row, permad: item?.c_permalink ?? "")
 
        }
        
    }
    func getcontentauthorized(movieid:String,planurls:String,index:Int,permad:String)
    {
 
        Api.IsContentAuthorised(movieid, endpoint: ApiEndPoints.isContentAuthorized, vc: self) { (res, err) -> (Void) in
                             
            do{
                                 
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
                        displayVC.IsAuthorizedContent = 1
                      }
                       
                  self.present(displayVC, animated: true, completion: nil)

                }
                                
                else
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
                        displayVC.IsAuthorizedContent = 0

                      }
                       
                  self.present(displayVC, animated: true, completion: nil)
                    
                 //   self.getcontendeatils(permaa:permad)
                     
                }
                             }
                             catch let error
                             {
                            //     Utility.showAlert(vc: self, message:"\(error)", titelstring: Appcommon.Appname)
                             }
                         }
    }
    
       /*
    func getcontendeatils(permaa:String)
       {
        
           Api.getcontentdetails(permaa, endpoint: ApiEndPoints.getcontentdetails, vc: UIViewController()) { (res, err) -> (Void) in
               do
               {
                  let decoder = JSONDecoder()
                  self.contentdata = try decoder.decode(contentdetails.self, from: res  ?? Data())
           
                  if self.contentdata != nil
                  {
                      self.getPPVplans(movieuniqids: self.contentdata?.submovie?.muvi_uniq_id ?? "", planid: self.contentdata?.submovie?.ppv_plan_id  ?? "")
                      
                  }
                  
               }
               catch let error
               {
                   Utility.showAlert(vc: UIViewController(), message:"\(error)", titelstring: Appcommon.Appname)
               }
           }
       }
    func getPPVplans(movieuniqids:String,planid:String)
    {
        guard let parameters =
            [
                "authToken":Keycenter.authToken,
                "movie_id":movieuniqids            ]
                as? [String:Any] else { return  }
        
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
                                { (cancelaction) in}
                                                    
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
func getcontentauthorised(movieid:String)
      {
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
   
 
