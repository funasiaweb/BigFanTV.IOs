//
//  StaticMovies.swift
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
import AVKit
 

class StaticMovies: UIViewController ,UIPopoverPresentationControllerDelegate,  StackContainable
{
 
    //FSPagerview
    
    
    
    
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
    private var  FavsMoviedata:FavouriteList?
    
     private let serialDispatchQueue = DispatchQueue(label: "serial-dispatch-queue")
    private var authorizeddata:Authorizescontent?
     private var Bannerdata:BannerList?
     @IBOutlet var ViScroll: UIView!
    
    @IBOutlet var Vinew: UIView!
    @IBOutlet var ComedyCollectionV: UICollectionView!
    
    
    
    @IBOutlet var ActionCollectioV: UICollectionView!
    @IBOutlet var  fantasyCollectioV: UICollectionView!
    @IBOutlet var  adventureCollectioV: UICollectionView!
    
    @IBOutlet var  mysteryCollectioV: UICollectionView!
     
    @IBOutlet var  romanceCollectioV: UICollectionView!
    @IBOutlet var  horrorCollectioV: UICollectionView!
    @IBOutlet var  scifiCollectioV: UICollectionView!
    
    
    @IBOutlet var FavCollectionV: UICollectionView!
    
    
    @IBOutlet var LanguageCollectionV: UICollectionView!
    
    static var isfrom = 0
    static var IsFrommovie = 0
    static var toviewall = 0
       var imagename = ""
       var moviename = ""
       var movietype = ""
       var timereleasedate  = ""
       var language = ""
       var movdescription: String = ""
    
    var imdbId = ""
    var totalcount = 0
    var movieuniqid = ""
    var perma = ""
    let cellIdentifier = "cell"
    var Movcategory = ""
    var MovSubcategory = ""
    var Isfavourite = 0
    var WatchDuration = 0
    var newperma = ""
    //Bannervideos
          
          private var banerdata = [Dictionary<String,String>]()
          var filterPlayers : [AVPlayer?] = []
          var currentPage: Int = 0
          var filterScrollView : UIScrollView?
          var player: AVPlayer?
          var playerController : AVPlayerViewController?
          var avPlayerLayer : AVPlayerLayer!
    
   
    var category = ""
    var subcategory = ""
     let imagearray =
        ["lang1","lang8", "lang11", "lang10", "lang9", "lang5", "lang7", "lang8","lang4","lang2","lang6"]
    let newarray =
        ["English","Hindi", "Punjabi", "Tamil", "Telugu", "Marathi", "Malayalam", "Bhojpuri","Gujarati","Bengali","Kannada"]
     let subcatearray = ["English","Hindi", "Punjabi", "Tamil", "Telugu", "Marathi", "Malyalam", "bhojpuri","Gujarati","Bengali","Kannada"]
    
    public static func create() -> StaticMovies {
          return UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "StaticMovies") as! StaticMovies
      }
    var collectionarray = [UICollectionView]()
    override func viewDidLoad()
    {
        super.viewDidLoad()
        
        //Register collectionviewcell
        collectionarray = [ActionCollectioV,adventureCollectioV,fantasyCollectioV,romanceCollectioV,ComedyCollectionV,  mysteryCollectioV ,horrorCollectioV,scifiCollectioV,FavCollectionV]
        
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
 
       
        self.LanguageCollectionV.register(UINib(nibName:"LnagCellFeatured", bundle:nil), forCellWithReuseIdentifier: cellIdentifier)
           let flowLayout = UICollectionViewFlowLayout()
           flowLayout.scrollDirection = .horizontal
         
           flowLayout.itemSize = CGSize(width: LanguageCollectionV.frame.size.height, height: LanguageCollectionV.frame.size.height)
           flowLayout.minimumLineSpacing = 10
           flowLayout.minimumInteritemSpacing = 10.0
           LanguageCollectionV.collectionViewLayout = flowLayout
           LanguageCollectionV.showsHorizontalScrollIndicator = false
        self.LanguageCollectionV.delegate = self
        self.LanguageCollectionV.dataSource = self
        
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
         
    }
    
    public func preferredAppearanceInStack() -> ScrollingStackController.ItemAppearance {
           return .view(height: 2000)
       }
           
    override func viewWillAppear(_ animated: Bool) {
         
        if Connectivity.isConnectedToInternet()
        {
         self.GetFavlist()
         }
            else
            {
                Utility.Internetconnection(vc: self)
            }
    
    }

       func LoadallData()
       {
          // Utility.ShowLoader(vc: self)
             
                     serialDispatchQueue.async {[weak self] in
                                        
                      Common.shared.getfeiltereddata(category: "movies", subcategory: "action") { (data, err) -> (Void) in
           
                         self?.ActionMoviedata = data
 
                         DispatchQueue.main.async {
                             self?.ActionCollectioV.reloadData()
                              
                         }
                     }
                     }
                        serialDispatchQueue.async {[weak self] in
                                    
                          Common.shared.getfeiltereddata(category: "movies", subcategory: "adventure") { (data, err) -> (Void) in
           
                            self?.adventureMoviedata = data
 
                            DispatchQueue.main.async {
                                self?.adventureCollectioV.reloadData()
                                
                            }
                        }
                     }
                     serialDispatchQueue.async {[weak self] in
                                    
                      Common.shared.getfeiltereddata(category: "movies", subcategory: "fantasy") { (data, err) -> (Void) in
           
                         self?.fantasyMoviedata = data
 
                         DispatchQueue.main.async {
                          Utility.hideLoader(vc: self!)
                             self?.fantasyCollectioV.reloadData()
                                
                         }
                     }
                     }
                        serialDispatchQueue.async {[weak self] in
                        
                                           
                          Common.shared.getfeiltereddata(category: "movies", subcategory: "romance") { (data, err) -> (Void) in
           
                         self?.romanceMoviedata = data
 
                         DispatchQueue.main.async {
                          Utility.hideLoader(vc: self!)
                             self?.romanceCollectioV.reloadData()
                                
                         }
                     }
                     }
           
 
                         serialDispatchQueue.async {[weak self] in
                                        
                          Common.shared.getfeiltereddata(category: "movies", subcategory: "horror") { (data, err) -> (Void) in
           
                         self?.horrorMoviedata = data
 
                         DispatchQueue.main.async {
                          Utility.hideLoader(vc: self!)
                             self?.horrorCollectioV.reloadData()
                                
                         }
                     }
                     }
                        serialDispatchQueue.async {[weak self] in
                         
                          Common.shared.getfeiltereddata(category: "movies", subcategory: "mystery") { (data, err) -> (Void) in
                            self?.mysteryMoviedata = data
 
                            DispatchQueue.main.async {
                                self?.mysteryCollectioV.reloadData()
                                
                            }
                        }
                     }
                     serialDispatchQueue.async {[weak self] in
                                
                      Common.shared.getfeiltereddata(category: "movies", subcategory: "sci-fi") { (data, err) -> (Void) in
           
                         self?.scifiMoviedata = data
 
                         DispatchQueue.main.async {
                          Utility.hideLoader(vc: self!)
                             self?.scifiCollectioV.reloadData()
                                
                         }
                     }
                     }
                     serialDispatchQueue.async {[weak self] in
                     
                      Common.shared.getfeiltereddata(category: "movies", subcategory: "comedy1") { (data, err) -> (Void) in
           
                         self?.ComedyMoviedata = data
 
                         DispatchQueue.main.async {
                             self?.ComedyCollectionV.reloadData()
                                
                         }
                     }
                     }
           
          
    
       }
    
    func GetFavlist()
       {
        Api.Viewfavourite(UserDefaults.standard.string(forKey: "id") ?? "", endpoint: ApiEndPoints.ViewFavourite, vc: self)   { (res, err) -> (Void) in
                           do
                           {
                               let decoder = JSONDecoder()
                               self.FavsMoviedata = try decoder.decode(FavouriteList.self, from: res  ?? Data())
                               self.FavCollectionV.delegate = self
                               self.FavCollectionV.dataSource  = self
                               DispatchQueue.main.async
                                   {
                                   self.FavCollectionV.reloadData()
                                   }
                           }
                           catch let error
                           {
                               Utility.showAlert(vc: self, message:"\(error)", titelstring: Appcommon.Appname)
                           }
                       }
        }
       
       
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        
                   if segue.identifier == "tomoviedetails"
                   {
                    guard let navController = segue.destination as? UINavigationController,
                        let displayVC = navController.topViewController as? MoviesDetailsVC else {
                            return
                    }
                     
                            displayVC.imagename = imagename
                            displayVC.moviename = moviename
                            displayVC.movietype = movietype
                            displayVC.timereleasedate = timereleasedate
                            displayVC.language = language
                            displayVC.movdescription = movdescription
                            displayVC.imdbID = imdbId
                            displayVC.perma = perma
                            displayVC.Movcategory = Movcategory
                            displayVC.MovSubcategory = MovSubcategory
                            displayVC.movieuniqid = movieuniqid
                            displayVC.Isfavourite = Isfavourite
                            displayVC.WatchDuration = WatchDuration
                            
                    
                   }else if segue.identifier == "viewallmovie"
                   {
                  guard let navController = segue.destination as? UINavigationController,
                                       let displayVC = navController.topViewController as? ComedyViewAllVC else {
                                           return
                                   }
                         
                           displayVC.Movcategory = Movcategory
                           displayVC.MovSubcategory = MovSubcategory
                            
                    
                   }else if segue.identifier == "tosubscribe"
                   {
                    guard let navController = segue.destination as? UINavigationController,
                                                        let displayVC = navController.topViewController as? MyplansVC else {
                                                            return
                                                    }
                                          
                           displayVC.movieuniqid = movieuniqid
                                            
                    
                 }
        
      
        }
    
    
    @IBAction func ViewAllcomedyBtTapped(_ sender: UIButton) {
        if sender.tag == 1
        {
           Movcategory = "movies"
           MovSubcategory = "Action"
        }else if sender.tag == 2
        {
            Movcategory = "movies"
            MovSubcategory = "adventure"
        }else if sender.tag == 3
        {
            Movcategory = "movies"
            MovSubcategory = "fantasy"
        }else if sender.tag == 4
        {
            Movcategory = "movies"
            MovSubcategory = "romance"
        }else if sender.tag == 5
        {
            Movcategory = "movies"
            MovSubcategory = "horror"

        }else if sender.tag == 6
        {
            Movcategory = "movies"
            MovSubcategory = "mystery"
        }else if sender.tag == 7
        {
            Movcategory = "movies"
            MovSubcategory = "sci-fi"
        }else if sender.tag == 8
        {
            Movcategory = "movies"
            MovSubcategory = "comedy1"

        }
        StaticMovies.IsFrommovie = 1
        let storyBoard: UIStoryboard = UIStoryboard(name: "Main", bundle: nil)
         let VC1 = storyBoard.instantiateViewController(withIdentifier: "ComedyViewAllVC") as! ComedyViewAllVC
         VC1.Movcategory = Movcategory
         VC1.MovSubcategory = MovSubcategory
       let navController = UINavigationController(rootViewController: VC1) // Creating a navigation controller with VC1 at the root of the navigation stack.
       navController.navigationBar.barTintColor = Appcolor.backgorund3
       navController.modalPresentationStyle = .fullScreen
        let textAttributes = [NSAttributedString.Key.foregroundColor:UIColor.white,NSAttributedString.Key.font: UIFont(name: "Muli-ExtraBold", size: 19)!]
        navController.navigationBar.titleTextAttributes = textAttributes
       self.present(navController, animated:true, completion: nil)
    }
    
     
    
}

extension StaticMovies:UICollectionViewDelegate,UICollectionViewDataSource
{
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        
        if collectionView == ComedyCollectionV
        {
 
            return ComedyMoviedata?.subComedymovList.count ?? 0
        } else if collectionView == ActionCollectioV
        {
 
            return ActionMoviedata?.subComedymovList.count ?? 0
        }else if collectionView == fantasyCollectioV
        {
 
            return fantasyMoviedata?.subComedymovList.count ?? 0
        }else if collectionView == adventureCollectioV
        {
 
            return adventureMoviedata?.subComedymovList.count ?? 0
        } else if collectionView == mysteryCollectioV
        {
 
            return mysteryMoviedata?.subComedymovList.count ?? 0
        } else if collectionView == romanceCollectioV
        {
 
            return romanceMoviedata?.subComedymovList.count ?? 0
        }else if collectionView == horrorCollectioV
        {
 
            return horrorMoviedata?.subComedymovList.count ?? 0
        }else if collectionView == scifiCollectioV
        {
 
            return scifiMoviedata?.subComedymovList.count ?? 0
        }else if collectionView == FavCollectionV
        {
 
            return FavsMoviedata?.subComedymovList?.count ?? 0
        }else if collectionView == LanguageCollectionV
        {
            return 11
        }
        return 0
    }
    
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
             if collectionView == FavCollectionV
             {
                 let Comedycell = collectionView.dequeueReusableCell(withReuseIdentifier: cellIdentifier, for: indexPath) as! MyCell
                 Comedycell.ImgSample.sd_setImage(with: URL(string: "\(FavsMoviedata?.subComedymovList?[indexPath.row].poster ?? "")"), completed: nil)
                Comedycell.LbName.text = FavsMoviedata?.subComedymovList?[indexPath.row].title
                Comedycell.btnCounter.tag = indexPath.row
               // Comedycell.btnCounter.addTarget(self, action: #selector(self.buttonClicked), for: .touchUpInside)
               Comedycell.btnCounter.setBackgroundImage(UIImage(named: "liked"), for: .normal)
               
                        
                 return Comedycell
        
             }else if collectionView == LanguageCollectionV
             {
                let Comedycell = collectionView.dequeueReusableCell(withReuseIdentifier: cellIdentifier, for: indexPath) as! LnagCellFeatured
                    Comedycell.ImgLang.image = UIImage(named: imagearray[indexPath.row])
                    Comedycell.LbLang.text = newarray[indexPath.row]
                   
                return Comedycell
                
        }
          var Cell   = collectionView.dequeueReusableCell(withReuseIdentifier: cellIdentifier, for: indexPath) as! MyCell
 
                    switch collectionView
                    {
                    case self.ActionCollectioV:
                        
                        let maincell = collectionView.dequeueReusableCell(withReuseIdentifier: cellIdentifier, for: indexPath) as! MyCell
                      
                        if let data = ActionMoviedata
                        {
                            Loaddataincell(maincell: maincell, data: data, ind: indexPath.row, tag: "ActionCollectioV")
                        }
                        
                        Cell = maincell
                       
                    case self.adventureCollectioV:
                          
                        let maincell = collectionView.dequeueReusableCell(withReuseIdentifier: cellIdentifier, for: indexPath) as! MyCell
                        
                          if let data = adventureMoviedata
                          {
                              Loaddataincell(maincell: maincell, data: data, ind: indexPath.row, tag: "adventureCollectioV")
                          }
                          
                          Cell = maincell
                        
                    case self.fantasyCollectioV:
                       
                        let maincell = collectionView.dequeueReusableCell(withReuseIdentifier: cellIdentifier, for: indexPath) as! MyCell
                        
                          if let data = fantasyMoviedata
                          {
                              Loaddataincell(maincell: maincell, data: data, ind: indexPath.row, tag: "fantasyCollectioV")
                          }
                          
                          Cell = maincell
                    case self.romanceCollectioV:
                        
                        let maincell = collectionView.dequeueReusableCell(withReuseIdentifier: cellIdentifier, for: indexPath) as! MyCell
                        
                          if let data = romanceMoviedata
                          {
                              Loaddataincell(maincell: maincell, data: data, ind: indexPath.row, tag: "romanceCollectioV")
                          }
                          
                          Cell = maincell
                        
                    case self.horrorCollectioV:
                        
                        let maincell = collectionView.dequeueReusableCell(withReuseIdentifier: cellIdentifier, for: indexPath) as! MyCell
                        
                          if let data = horrorMoviedata
                          {
                              Loaddataincell(maincell: maincell, data: data, ind: indexPath.row, tag: "horrorCollectioV")
                          }
                          
                          Cell = maincell
                    case self.mysteryCollectioV:
                         let maincell = collectionView.dequeueReusableCell(withReuseIdentifier: cellIdentifier, for: indexPath) as! MyCell
                        
                          if let data = mysteryMoviedata
                          {
                              Loaddataincell(maincell: maincell, data: data, ind: indexPath.row, tag: "mysteryCollectioV")
                          }
                          
                          Cell = maincell
                    case self.scifiCollectioV:
                        
                         let maincell = collectionView.dequeueReusableCell(withReuseIdentifier: cellIdentifier, for: indexPath) as! MyCell
                        
                          if let data = scifiMoviedata
                          {
                              Loaddataincell(maincell: maincell, data: data, ind: indexPath.row, tag: "scifiCollectioV")
                          }
                          
                          Cell = maincell
                   
                    case self.ComedyCollectionV:
                        
                         let maincell = collectionView.dequeueReusableCell(withReuseIdentifier: cellIdentifier, for: indexPath) as! MyCell
                        
                          if let data = ComedyMoviedata
                          {
                              Loaddataincell(maincell: maincell, data: data, ind: indexPath.row, tag: "ComedyCollectionV")
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
        maincell.ImgSample.sd_setImage(with: URL(string: item.poster ?? ""), completed: nil)
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
                Utility.showAlert(vc: self, message:"\(error)", titelstring: Appcommon.Appname)
            }
        }
        
    }
    
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
        if collectionView == ComedyCollectionV
        {
            
            Movcategory = "movies"
            MovSubcategory = "comedy1"
            let item = ComedyMoviedata?.subComedymovList[indexPath.row]
            imagename = item?.poster ?? ""
            moviename = item?.title ?? ""
            movietype = item?.poster ?? ""
            imdbId = item?.custom?.customimdb?.field_value ?? ""
            movieuniqid =  item?.movie_uniq_id ?? ""
            newperma =  item?.permalink ?? ""
            perma = item?.c_permalink ?? ""
            Isfavourite = item?.is_fav_status ?? 0
            WatchDuration = item?.watch_duration_in_seconds ?? 0
            getcontentauthorised(movieid: item?.movie_uniq_id ?? "")
          
        }
         
        else if collectionView == ActionCollectioV
        {
            Movcategory = "movies"
            MovSubcategory = "Action"
            let item = ActionMoviedata?.subComedymovList[indexPath.row]
            imagename = item?.poster ?? ""
            moviename = item?.title ?? ""
            movietype = item?.poster ?? ""
            movdescription = item?.poster ?? ""
            imdbId = item?.custom?.customimdb?.field_value ?? ""
            movieuniqid = item?.movie_uniq_id ?? ""
            newperma =  item?.permalink ?? ""
            perma = item?.c_permalink ?? ""
            Isfavourite = item?.is_fav_status ?? 0
            WatchDuration = item?.watch_duration_in_seconds ?? 0
            getcontentauthorised(movieid: item?.movie_uniq_id ?? "")
        }
        else if collectionView == fantasyCollectioV
        {
            Movcategory = "movies"
            MovSubcategory = "fantasy"
            let item = fantasyMoviedata?.subComedymovList[indexPath.row]
            imagename = item?.poster ?? ""
            moviename = item?.title ?? ""
            movietype = item?.poster ?? ""
            movdescription = item?.poster ?? ""
            newperma =  item?.permalink ?? ""
            imdbId = item?.custom?.customimdb?.field_value ?? ""
            movieuniqid = item?.movie_uniq_id ?? ""
            perma = item?.c_permalink ?? ""
            Isfavourite = item?.is_fav_status ?? 0
            WatchDuration = item?.watch_duration_in_seconds ?? 0
            getcontentauthorised(movieid: item?.movie_uniq_id ?? "")
        }
        else if collectionView == adventureCollectioV
        {
            Movcategory = "movies"
            MovSubcategory = "adventure"
           let item = adventureMoviedata?.subComedymovList[indexPath.row]
            imagename = item?.poster ?? ""
            moviename = item?.title ?? ""
            movietype = item?.poster ?? ""
            movdescription = item?.poster ?? ""
            newperma =  item?.permalink ?? ""
            imdbId = item?.custom?.customimdb?.field_value ?? ""
            movieuniqid = item?.movie_uniq_id ?? ""
            perma = item?.c_permalink ?? ""
            Isfavourite = item?.is_fav_status ?? 0
            WatchDuration = item?.watch_duration_in_seconds ?? 0
             getcontentauthorised(movieid: item?.movie_uniq_id ?? "")
                
        }
        else if collectionView == mysteryCollectioV
        {
           Movcategory = "movies"
           MovSubcategory = "mystery"
           let item = mysteryMoviedata?.subComedymovList[indexPath.row]
           imagename = item?.poster ?? ""
           moviename = item?.title ?? ""
           movietype = item?.poster ?? ""
           movdescription = item?.poster ?? ""
            newperma =  item?.permalink ?? ""
           imdbId = item?.custom?.customimdb?.field_value ?? ""
           movieuniqid = item?.movie_uniq_id ?? ""
           perma = item?.c_permalink ?? ""
           Isfavourite = item?.is_fav_status ?? 0
           WatchDuration = item?.watch_duration_in_seconds ?? 0
           getcontentauthorised(movieid: item?.movie_uniq_id ?? "")
            
        }
         else if collectionView == romanceCollectioV
        {
              Movcategory = "movies"
              MovSubcategory = "romance"
              let item  = romanceMoviedata?.subComedymovList[indexPath.row]
              imagename = item?.poster ?? ""
              moviename = item?.title ?? ""
              movietype = item?.poster ?? ""
              movdescription = item?.poster ?? ""
            newperma =  item?.permalink ?? ""
              imdbId = item?.custom?.customimdb?.field_value ?? ""
              movieuniqid = item?.movie_uniq_id ?? ""
              perma = item?.c_permalink ?? ""
              Isfavourite = item?.is_fav_status ?? 0
              WatchDuration = item?.watch_duration_in_seconds ?? 0
             getcontentauthorised(movieid: item?.movie_uniq_id ?? "")
            
        }
        else if collectionView == horrorCollectioV
        {
             Movcategory = "movies"
             MovSubcategory = "horror"
            let item = horrorMoviedata?.subComedymovList[indexPath.row]
             imagename = item?.poster ?? ""
             moviename = item?.title ?? ""
             movietype = item?.poster ?? ""
             movdescription = item?.poster ?? ""
            newperma =  item?.permalink ?? ""
             imdbId = item?.custom?.customimdb?.field_value ?? ""
             movieuniqid = item?.movie_uniq_id ?? ""
             perma = item?.c_permalink ?? ""
             Isfavourite = item?.is_fav_status ?? 0
             WatchDuration = item?.watch_duration_in_seconds ?? 0
             getcontentauthorised(movieid: item?.movie_uniq_id ?? "")
          }
        else if collectionView == scifiCollectioV
        {
           Movcategory = "movies"
           MovSubcategory = "sci-fi"
           let item = scifiMoviedata?.subComedymovList[indexPath.row]
           imagename = item?.poster ?? ""
           moviename = item?.title ?? ""
           movietype = item?.poster ?? ""
           movdescription = item?.poster ?? ""
            newperma =  item?.permalink ?? ""
           imdbId = item?.custom?.customimdb?.field_value ?? ""
           movieuniqid = item?.movie_uniq_id ?? ""
           perma = item?.c_permalink ?? ""
           Isfavourite = item?.is_fav_status ?? 0
           WatchDuration = item?.watch_duration_in_seconds ?? 0
           getcontentauthorised(movieid: item?.movie_uniq_id ?? "")
            
        }else if collectionView == LanguageCollectionV
        {
               let storyBoard: UIStoryboard = UIStoryboard(name: "Main", bundle: nil)
            
               let VC1 = storyBoard.instantiateViewController(withIdentifier: "ComedyViewAllVC") as! ComedyViewAllVC
                 VC1.Movcategory = "language-1"
                 VC1.MovSubcategory = subcatearray[indexPath.row]
               let navController = UINavigationController(rootViewController: VC1) // Creating a navigation controller with VC1 at the root of the navigation stack.
               navController.navigationBar.barTintColor = Appcolor.backgorund3
               navController.modalPresentationStyle = .fullScreen
               let textAttributes = [NSAttributedString.Key.foregroundColor:UIColor.white,NSAttributedString.Key.font: UIFont(name: "Muli-ExtraBold", size: 19)!]
              navController.navigationBar.titleTextAttributes = textAttributes
               self.present(navController, animated:true, completion: nil)
        }else if collectionView == FavCollectionV
        {
            passComedyMoviedata = FavsMoviedata?.subComedymovList?[indexPath.row]
            getFavcontentauthorised(movieid: passComedyMoviedata?.movie_uniq_id ?? "", contenttypesid: passComedyMoviedata?.content_types_id ?? "")
            
        }
        
        
    }
    func getFavcontentauthorised(movieid:String,contenttypesid:String)
    {
        if contenttypesid == "1"
                          {
                      let storyBoard: UIStoryboard = UIStoryboard(name: "Main", bundle: nil)
                      let displayVC = storyBoard.instantiateViewController(withIdentifier: "MoviesDetailsVC") as! MoviesDetailsVC
                         displayVC.modalPresentationStyle = .fullScreen
                          if let item = self.passComedyMoviedata
                          {
                              displayVC.imagename = item.poster ?? ""
                              displayVC.moviename = item.title ?? ""
                              displayVC.imdbID = item.custom?.customimdb?.field_value ?? ""
                              displayVC.perma = item.c_permalink ?? ""
                              displayVC.Movcategory = self.Movcategory
                              displayVC.MovSubcategory = self.MovSubcategory
                              displayVC.movieuniqid = item.movie_uniq_id ?? ""
                              displayVC.Isfavourite = item.is_fav_status ?? 0
                              displayVC.WatchDuration = item.watch_duration_in_seconds ?? 0
                              displayVC.contenttypeid = item.content_types_id ?? ""
                              displayVC.playerurlstr = item.permalink ?? ""
                          }
                          self.present(displayVC, animated: true, completion: nil)
                          }else if  contenttypesid == "3"
                          {
                              let storyBoard: UIStoryboard = UIStoryboard(name: "Main", bundle: nil)
                               let displayVC = storyBoard.instantiateViewController(withIdentifier: "SerirsDetailsVC") as! SerirsDetailsVC
                                  displayVC.modalPresentationStyle = .fullScreen
                                   
                                  displayVC.perma = self.passComedyMoviedata?.c_permalink ?? ""
                                  displayVC.movieuniqid = self.passComedyMoviedata?.movie_uniq_id ?? ""
                               //   displayVC.Movcategory = self.Movcategory
                               //   displayVC.MovSubcategory = self.MovSubcategory
                              displayVC.playerurlstr = self.passComedyMoviedata?.permalink ?? ""
                                 
                              self.present(displayVC, animated: true, completion: nil)
                          }else if  contenttypesid == "5"
                          {
                               let storyBoard: UIStoryboard = UIStoryboard(name: "Main", bundle: nil)
                               let displayVC = storyBoard.instantiateViewController(withIdentifier: "SongsDetailsVC") as! SongsDetailsVC
                                  displayVC.modalPresentationStyle = .fullScreen
                                   
                              displayVC.permalink = self.passComedyMoviedata?.c_permalink ?? ""
                                   
                              self.present(displayVC, animated: true, completion: nil)
                          }
        /*
        Api.IsContentAuthorised(movieid, endpoint: ApiEndPoints.isContentAuthorized, vc: self) { (res, err) -> (Void) in
                       
            do
            {
                let decoder = JSONDecoder()
                self.authorizeddata = try decoder.decode(Authorizescontent.self, from: res  ?? Data())
               
                if self.authorizeddata?.status == "OK"
                {
                    if contenttypesid == "1"
                    {
                let storyBoard: UIStoryboard = UIStoryboard(name: "Main", bundle: nil)
                let displayVC = storyBoard.instantiateViewController(withIdentifier: "MoviesDetailsVC") as! MoviesDetailsVC
                   displayVC.modalPresentationStyle = .fullScreen
                    if let item = self.passComedyMoviedata
                    {
                        displayVC.imagename = item.poster ?? ""
                        displayVC.moviename = item.title ?? ""
                        displayVC.imdbID = item.custom?.customimdb?.field_value ?? ""
                        displayVC.perma = item.c_permalink ?? ""
                        displayVC.Movcategory = self.Movcategory
                        displayVC.MovSubcategory = self.MovSubcategory
                        displayVC.movieuniqid = item.movie_uniq_id ?? ""
                        displayVC.Isfavourite = item.is_fav_status ?? 0
                        displayVC.WatchDuration = item.watch_duration_in_seconds ?? 0
                        displayVC.contenttypeid = item.content_types_id ?? ""
                        displayVC.playerurlstr = item.permalink ?? ""
                    }
                    self.present(displayVC, animated: true, completion: nil)
                    }else if  contenttypesid == "3"
                    {
                        let storyBoard: UIStoryboard = UIStoryboard(name: "Main", bundle: nil)
                         let displayVC = storyBoard.instantiateViewController(withIdentifier: "SerirsDetailsVC") as! SerirsDetailsVC
                            displayVC.modalPresentationStyle = .fullScreen
                             
                            displayVC.perma = self.passComedyMoviedata?.c_permalink ?? ""
                            displayVC.movieuniqid = self.passComedyMoviedata?.movie_uniq_id ?? ""
                         //   displayVC.Movcategory = self.Movcategory
                         //   displayVC.MovSubcategory = self.MovSubcategory
                        displayVC.playerurlstr = self.passComedyMoviedata?.permalink ?? ""
                           
                        self.present(displayVC, animated: true, completion: nil)
                    }else if  contenttypesid == "5"
                    {
                         let storyBoard: UIStoryboard = UIStoryboard(name: "Main", bundle: nil)
                         let displayVC = storyBoard.instantiateViewController(withIdentifier: "SongsDetailsVC") as! SongsDetailsVC
                            displayVC.modalPresentationStyle = .fullScreen
                             
                        displayVC.permalink = self.passComedyMoviedata?.c_permalink ?? ""
                             
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
                    { (cancelaction) in  }
                    alertController.addAction(action)
                    alertController.addAction(cancelaction)
                    self.present(alertController, animated: true, completion: nil)
                    
                }
                
            }
            catch let error
            {
              //  Utility.showAlert(vc: self, message:"\(error)", titelstring: Appcommon.Appname)
             }
            
        }
        */
    }
    func getcontentauthorised(movieid:String)
    {
         let storyBoard: UIStoryboard = UIStoryboard(name: "Main", bundle: nil)
         let displayVC = storyBoard.instantiateViewController(withIdentifier: "MoviesDetailsVC") as! MoviesDetailsVC
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
             displayVC.playerurlstr = self.newperma
             
        self.present(displayVC, animated: true, completion: nil)
        /*
        Api.IsContentAuthorised(movieid, endpoint: ApiEndPoints.isContentAuthorized, vc: self) { (res, err) -> (Void) in
                             do
                             {
                                 let decoder = JSONDecoder()
                                 self.authorizeddata = try decoder.decode(Authorizescontent.self, from: res  ?? Data())
                                
                                if self.authorizeddata?.status == "OK"
                                {
                                    //self.performSegue(withIdentifier: "tomoviedetails", sender: self)
                                
                                let storyBoard: UIStoryboard = UIStoryboard(name: "Main", bundle: nil)
                                let displayVC = storyBoard.instantiateViewController(withIdentifier: "MoviesDetailsVC") as! MoviesDetailsVC
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
                                    displayVC.playerurlstr = self.newperma
                                    
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
   /*
extension StaticMovies: UICollectionViewDelegateFlowLayout
{
        func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
            
            if UIDevice.current.userInterfaceIdiom == .pad
            {
                return CGSize(width: collectionView.frame.size.height + 40, height:collectionView.frame.size.height)
            }
            else if UIDevice.current.userInterfaceIdiom == .phone
            {
                if collectionView == LanguageCollectionV
                {
                  return CGSize(width: collectionView.frame.size.height, height: collectionView.frame.size.height)
                }else
                {
               return CGSize(width: 280, height: 156)
                }
                   }
            
            return CGSize(width: 180, height: 280)
        }
     
   
    }
 
*/

//fspager

   
