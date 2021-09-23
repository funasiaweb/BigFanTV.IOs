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
class MovieCellw:UICollectionViewCell
{
 
    @IBOutlet var btnCounter: UIButton!
    @IBOutlet var ImgSample: UIImageView!
    
    @IBOutlet var LbName: UILabel!
    
    @IBOutlet var LbType: UILabel!
    
    @IBOutlet var LbDuration: UILabel!
}


class OtherVideosVC: UIViewController ,UIPopoverPresentationControllerDelegate {
//
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
    private var  GameplaysMoviedata:newFilteredComedyMovieList?
    private var  GameTrailersMoviedata:newFilteredComedyMovieList?
       
    private let serialDispatchQueue = DispatchQueue(label: "serial-dispatch-queue")
    private var authorizeddata:Authorizescontent?
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
    
    static var isfrom = 0
    
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
   var selftitle  = ""
    var collectionarray =  [UICollectionView]()
    override func viewDidLoad() {
           super.viewDidLoad()

        collectionarray = [ComedyCollectionV,ActionCollectioV, ThrillerCollectionV,fantasyCollectioV,adventureCollectioV,animationCollectioV,crimeCollectioV,mysteryCollectioV,dramaCollectioV,romanceCollectioV,horrorCollectioV,scifiCollectioV,tollywoodCollectioV,clipsCollectioV,GameplaysCollectioV,GameTrailersCollectioV]
        
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
           i.register(UINib(nibName:"MyCell2", bundle:nil), forCellWithReuseIdentifier: cellIdentifier)
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
          
                           
         Common.shared.getfeiltereddata1(category: "standup-comedy", subcategory: "") { (data, err) -> (Void) in

              self.ComedyMoviedata = data
             print("1other")
            DispatchQueue.main.async
               {
                  self.ComedyCollectionV.reloadData()
                 
            }
        }
         
           
          Common.shared.getfeiltereddata1(category: "poetry", subcategory: "") { (data, err) -> (Void) in

               self.ThrillerMoviedata = data
               print("2other")
             DispatchQueue.main.async {
                   self.ThrillerCollectionV.reloadData()
                  
             }
         }
            
          
            
          Common.shared.getfeiltereddata1(category: "news", subcategory: "") { (data, err) -> (Void) in

               self.ActionMoviedata = data
               print("3")
             DispatchQueue.main.async {
                   self.ActionCollectioV.reloadData()
                  
             }
         }
         
            
          Common.shared.getfeiltereddata1(category: "lifestyle-amp-trends", subcategory: "") { (data, err) -> (Void) in

               self.adventureMoviedata = data
            Utility.hideLoader(vc:   self)
               print("4")
             DispatchQueue.main.async {
               
                   self.adventureCollectioV.reloadData()
                  
             }
         }
         
            
          Common.shared.getfeiltereddata1(category: "spiritual-amp-motivation", subcategory: "") { (data, err) -> (Void) in

               self.animationMoviedata = data
            Utility.hideLoader(vc:   self)
               print("5")
             DispatchQueue.main.async {
               
                   self.animationCollectioV.reloadData()
                  
             }
         }
         
            
          Common.shared.getfeiltereddata1(category: "fashion", subcategory: "") { (data, err) -> (Void) in

               self.crimeMoviedata = data
             Utility.hideLoader(vc:   self)
             DispatchQueue.main.async {
              
                   self.crimeCollectioV.reloadData()
                  
             }
         }
          
            
          Common.shared.getfeiltereddata1(category: "food-amp-recipes", subcategory: "") { (data, err) -> (Void) in

               self.mysteryMoviedata = data
              Utility.hideLoader(vc:   self)
             DispatchQueue.main.async {
               
                   self.mysteryCollectioV.reloadData()
                  
             }
         }
         
            
          Common.shared.getfeiltereddata1(category: "diy-amp-crafts", subcategory: "") { (data, err) -> (Void) in

               self.dramaMoviedata = data
             Utility.hideLoader(vc:   self)
             DispatchQueue.main.async {
               
                   self.dramaCollectioV.reloadData()
                  
             }
         }
          
            
          Common.shared.getfeiltereddata1(category: "kids", subcategory: "") { (data, err) -> (Void) in

               self.romanceMoviedata = data
              
             DispatchQueue.main.async {
                   self.romanceCollectioV.reloadData()
                  
             }
         }
          
            
          Common.shared.getfeiltereddata1(category: "sports", subcategory: "") { (data, err) -> (Void) in

               self.horrorMoviedata = data
              
             DispatchQueue.main.async {
                   self.horrorCollectioV.reloadData()
                  
             }
         }
          
            
          Common.shared.getfeiltereddata1(category: "technology", subcategory: "") { (data, err) -> (Void) in

               self.scifiMoviedata = data
              
             DispatchQueue.main.async {
                   self.scifiCollectioV.reloadData()
                  
             }
         }
          
            
          Common.shared.getfeiltereddata1(category: "healthcare-amp-remedies", subcategory: "") { (data, err) -> (Void) in

               self.tollywoodMoviedata = data
              
             DispatchQueue.main.async {
                   self.tollywoodCollectioV.reloadData()
                  
             }
         }
          
            
          Common.shared.getfeiltereddata1(category: "comedy", subcategory: "") { (data, err) -> (Void) in

               self.clipsMoviedata = data
              
             DispatchQueue.main.async {
                   self.clipsCollectioV.reloadData()
                  
             }
         }
         
            
          Common.shared.getfeiltereddata1(category: "gaming", subcategory: "gameplay") { (data, err) -> (Void) in

               self.GameplaysMoviedata = data
              
             DispatchQueue.main.async {
                   self.GameplaysCollectioV.reloadData()
                  
             }
         }
          
            
          Common.shared.getfeiltereddata1(category: "gaming", subcategory: "game-trailers") { (data, err) -> (Void) in

               self.GameTrailersMoviedata = data
              
             DispatchQueue.main.async {
                   self.GameTrailersCollectioV.reloadData()
                  
             }
         }
         
   
         
         
         
   }
    
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        
                   if segue.identifier == "toothervideos"
                   {
                    guard let navController = segue.destination as? UINavigationController,
                        let displayVC = navController.topViewController as? OtherVideosVCDetails else {
                            return
                    }
                     
                            displayVC.imagename = imagename
                            displayVC.moviename = moviename
                            displayVC.movietype = movietype
                            displayVC.timereleasedate = timereleasedate
                            displayVC.language = language
                            displayVC.movdescription = movdescription
                             displayVC.perma = perma
                            displayVC.Movcategory = Movcategory
                            displayVC.MovSubcategory = MovSubcategory
                            displayVC.Isfavourite = Isfavourite
                            displayVC.movieuniqid = movieuniqid
                            displayVC.WatchDuration = WatchDuration
                            
                    
                   } else if segue.identifier == "tosubscribe"
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
              Movcategory = "standup-comedy"
              MovSubcategory = ""
              selftitle = "Standup-Comedy"
          }else if sender.tag == 2
          {
              Movcategory = "poetry"
              MovSubcategory = ""
              selftitle = "Poetry"
          }else if sender.tag == 3
          {
              Movcategory = "news"
              MovSubcategory = ""
              selftitle = "News"
          }else if sender.tag == 4
          {
              Movcategory = "religious"
             MovSubcategory = ""
            selftitle = "Religious"
          }else if sender.tag == 5
          {
              Movcategory =  "lifestyle-amp-trends"
              MovSubcategory = ""
            selftitle = "Lifestyle-amp-trends"
          }else if sender.tag == 6
          {
              Movcategory = "spiritual-amp-motivation"
             MovSubcategory = ""
            selftitle = "Spiritual-amp-motivation"
          }else if sender.tag == 7
          {
              Movcategory = "fashion"
             MovSubcategory = ""
            selftitle = "Fashion"
          }else if sender.tag == 8
          {
              Movcategory = "food-amp-recipes"
             MovSubcategory = ""
            selftitle = "Food-amp-recipes"
          }else if sender.tag == 9
          {
              Movcategory = "diy-amp-crafts"
             MovSubcategory = ""
            selftitle = "Diy-amp-crafts"
          }else if sender.tag == 10
          {
              Movcategory = "kids"
             MovSubcategory = ""
            selftitle = "Kids"
          }else if sender.tag == 11
          {
              Movcategory = "sports"
              MovSubcategory = ""
              selftitle = "Sports"
          }else if sender.tag == 12
          {
              Movcategory = "technology"
              MovSubcategory = ""
            selftitle = "Technology"
          }else if sender.tag == 13
          {
              Movcategory =  "healthcare-amp-remedies"
              MovSubcategory = ""
            selftitle = "Healthcare-amp-remedies"
          }else if sender.tag == 14
          {
              Movcategory = "comedy"
              MovSubcategory = ""
            selftitle = "Comedy"
          }else if sender.tag == 15
          {
              Movcategory = "gaming"
              MovSubcategory = "gameplay"
            selftitle = "Gameplay"
          }else if sender.tag == 16
          {
              Movcategory = "gaming"
              MovSubcategory = "game-trailers"
            selftitle = "Game-Trailers"
          }
           let storyBoard: UIStoryboard = UIStoryboard(name: "Main", bundle: nil)
           let VC1 = storyBoard.instantiateViewController(withIdentifier: "OtherVidViewAll") as! OtherVidViewAll
            VC1.Movcategory = Movcategory
            VC1.MovSubcategory = MovSubcategory
             VC1.selftitle  = selftitle
           let navController = UINavigationController(rootViewController: VC1) // Creating a navigation controller with VC1 at the root of the navigation stack.
          navController.navigationBar.barTintColor = Appcolor.backgorund4
         let textAttributes = [NSAttributedString.Key.foregroundColor:UIColor.white,NSAttributedString.Key.font: UIFont(name: "Muli-ExtraBold", size: 19)!]
         navController.navigationBar.titleTextAttributes = textAttributes
            navController.navigationBar.isTranslucent = false
          navController.modalPresentationStyle = .fullScreen
           self.present(navController, animated:true, completion: nil)
      }
      
       
    
    
    
}

extension OtherVideosVC:UICollectionViewDelegate,UICollectionViewDataSource
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
        }else if collectionView == tollywoodCollectioV
        {
 
            return tollywoodMoviedata?.subComedymovList.count ?? 0
        }else if collectionView == clipsCollectioV
        {
 
            return clipsMoviedata?.subComedymovList.count ?? 0
        }else if collectionView == GameplaysCollectioV
        {
 
            return GameplaysMoviedata?.subComedymovList.count ?? 0
        }else if collectionView == GameTrailersCollectioV
        {
 
            return GameTrailersMoviedata?.subComedymovList.count ?? 0
        }
        return 0
    }
   
   
   func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell
      {
           
         let Cell   = collectionView.dequeueReusableCell(withReuseIdentifier: cellIdentifier, for: indexPath) as! MyCell2

          
          
          switch collectionView
          {
            case self.ComedyCollectionV:
    
               Loaddataincell(Cell: Cell, data: ComedyMoviedata!, ind: indexPath.row )
                  
            
            case self.ThrillerCollectionV:
                
 
                      Loaddataincell(Cell: Cell, data: ThrillerMoviedata!, ind: indexPath.row )
 
            
            
          case self.ActionCollectioV:
 
                  Loaddataincell(Cell: Cell, data: ActionMoviedata!, ind: indexPath.row )
 
             
          case self.fantasyCollectioV:
                
 
                       Loaddataincell(Cell: Cell, data: fantasyMoviedata!, ind: indexPath.row )
 
            
          case self.adventureCollectioV:
                
 
                    Loaddataincell(Cell: Cell, data: adventureMoviedata!, ind: indexPath.row )
 
            
              case self.animationCollectioV:
                      
   
                            Loaddataincell(Cell: Cell, data: animationMoviedata!, ind: indexPath.row )
 

               case self.crimeCollectioV:
                   
 
                         Loaddataincell(Cell: Cell, data: crimeMoviedata!, ind: indexPath.row )
 
            
            case self.mysteryCollectioV:
 
                      Loaddataincell(Cell: Cell, data: mysteryMoviedata!, ind: indexPath.row )
 
            
            case self.dramaCollectioV:
                
       
                      Loaddataincell(Cell: Cell, data: dramaMoviedata!, ind: indexPath.row )
 

          case self.romanceCollectioV:
              
 
                    Loaddataincell(Cell: Cell, data: romanceMoviedata!, ind: indexPath.row )
 
              
          case self.horrorCollectioV:
              
 
                    Loaddataincell(Cell: Cell, data: horrorMoviedata!, ind: indexPath.row )
 

          case self.scifiCollectioV:
              
 
                    Loaddataincell(Cell: Cell, data: scifiMoviedata!, ind: indexPath.row )
 
         
 
          case self.tollywoodCollectioV:
              
 
                    Loaddataincell(Cell: Cell, data: tollywoodMoviedata!, ind: indexPath.row )
 
            
         case self.clipsCollectioV:
 
                   Loaddataincell(Cell: Cell, data: clipsMoviedata!, ind: indexPath.row )
 

         case self.GameplaysCollectioV:
             
 
                   Loaddataincell(Cell: Cell, data: GameplaysMoviedata!, ind: indexPath.row  )
        

         case self.GameTrailersCollectioV:
  
                   Loaddataincell(Cell: Cell, data: GameTrailersMoviedata!, ind: indexPath.row )
 
         
          default:
             print("")
          }
          return Cell

      }
       func Loaddataincell(Cell:MyCell2,data:newFilteredComedyMovieList,ind:Int )
       {
         let item = data.subComedymovList[ind]
  
         Cell.ImgSample.sd_setImage(with: URL(string: item.poster ?? ""), completed: nil)
           
                  
           Cell.LbName.text = item.title ?? ""
           let image = item.is_fav_status == 1 ? UIImage(named: "liked") : UIImage(named: "like")
           Cell.btnCounter.setBackgroundImage(image, for: .normal)
           Cell.actionBlock = {
               () in
               if item.is_fav_status == 0
               {
                   Cell.btnCounter.setBackgroundImage(UIImage(named: "liked"), for: .normal)
                   self.AddtoFav(movieuniqidx: item.movie_uniq_id ?? "", endpoint: ApiEndPoints.AddToFavlist) { (true) in
                   Cell.btnCounter.setBackgroundImage(UIImage(named: "liked"), for: .normal)
                       
                       data.subComedymovList[ind].is_fav_status = 1
                      
               }
               }else if item.is_fav_status == 1
               {
                   Cell.btnCounter.setBackgroundImage(UIImage(named: "like"), for: .normal)
                   self.AddtoFav(movieuniqidx: item.movie_uniq_id ?? "", endpoint: ApiEndPoints.DeleteFavLIst) { (true) in
                   Cell.btnCounter.setBackgroundImage(UIImage(named: "like"), for: .normal)
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
       
       func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath)
       {
           switch collectionView {
                
           case self.ComedyCollectionV:
            if let data = ComedyMoviedata?.subComedymovList[indexPath.row]
            {
               Movcategory = "standup-comedy"
               MovSubcategory = ""
               passComedyMoviedata = data
               getcontentauthorised(movieid: data.movie_uniq_id ?? "")
            }
           case self.ThrillerCollectionV:
            if let data = ThrillerMoviedata?.subComedymovList[indexPath.row]
            {
               Movcategory = "poetry"
               MovSubcategory = ""
               passComedyMoviedata = data
               getcontentauthorised(movieid: data.movie_uniq_id ?? "")
            }
           case self.ActionCollectioV:
            if let data = ActionMoviedata?.subComedymovList[indexPath.row]
            {
               Movcategory = "news"
               MovSubcategory = ""
               passComedyMoviedata = data
               getcontentauthorised(movieid: data.movie_uniq_id ?? "")
            }
           case self.fantasyCollectioV:
            if let data = fantasyMoviedata?.subComedymovList[indexPath.row]
             {
               Movcategory = "religious"
               MovSubcategory = ""
               passComedyMoviedata = data
               getcontentauthorised(movieid: data.movie_uniq_id ?? "")
             }
           case self.adventureCollectioV:
            if let data = adventureMoviedata?.subComedymovList[indexPath.row]
            {
               Movcategory = "lifestyle-amp-trends"
               MovSubcategory = ""
               passComedyMoviedata = data
               getcontentauthorised(movieid: data.movie_uniq_id ?? "")
            }
           case self.fantasyCollectioV:
            if let data = fantasyMoviedata?.subComedymovList[indexPath.row]
            {
               Movcategory = "religious"
               MovSubcategory = ""
               passComedyMoviedata = data
               getcontentauthorised(movieid: data.movie_uniq_id ?? "")
            }
           case self.animationCollectioV:
            if let data = animationMoviedata?.subComedymovList[indexPath.row]
            {
               Movcategory = "spiritual-amp-motivation"
               MovSubcategory = ""
               passComedyMoviedata = data
               getcontentauthorised(movieid: data.movie_uniq_id ?? "")
            }
           case self.crimeCollectioV:
            if let data = crimeMoviedata?.subComedymovList[indexPath.row]
            {
               Movcategory = "fashion"
               MovSubcategory = ""
               passComedyMoviedata = data
               getcontentauthorised(movieid: data.movie_uniq_id ?? "")
            }
           case self.mysteryCollectioV:
            if let data = mysteryMoviedata?.subComedymovList[indexPath.row]
            {
               Movcategory = "food-amp-recipes"
               MovSubcategory = ""
               passComedyMoviedata = data
               getcontentauthorised(movieid: data.movie_uniq_id ?? "")
            }
           case self.dramaCollectioV:
            if let data = dramaMoviedata?.subComedymovList[indexPath.row]
            {
               Movcategory = "diy-amp-crafts"
               MovSubcategory = ""
               passComedyMoviedata = data
               getcontentauthorised(movieid: data.movie_uniq_id ?? "")
            }
           case self.romanceCollectioV:
            if let data = romanceMoviedata?.subComedymovList[indexPath.row]
            {
               Movcategory = "kids"
               MovSubcategory = ""
               passComedyMoviedata = data
               getcontentauthorised(movieid: data.movie_uniq_id ?? "")
            }
           case self.horrorCollectioV:
            if let data = horrorMoviedata?.subComedymovList[indexPath.row]
            {
               Movcategory = "sports"
               MovSubcategory = ""
               passComedyMoviedata = data
               getcontentauthorised(movieid: data.movie_uniq_id ?? "")
            }
           case self.scifiCollectioV:
            if let data = scifiMoviedata?.subComedymovList[indexPath.row]
            {
               Movcategory = "technology"
               MovSubcategory = ""
               passComedyMoviedata = data
               getcontentauthorised(movieid: data.movie_uniq_id ?? "")
            }
           case self.tollywoodCollectioV:
            if let data = tollywoodMoviedata?.subComedymovList[indexPath.row]
            {
               Movcategory = "healthcare-amp-remedies"
               MovSubcategory = ""
               passComedyMoviedata = data
               getcontentauthorised(movieid: data.movie_uniq_id ?? "")
            }
           case self.clipsCollectioV:
            if let data = clipsMoviedata?.subComedymovList[indexPath.row]
             {
               Movcategory =  "comedy"
               MovSubcategory = ""
               passComedyMoviedata = data
               getcontentauthorised(movieid: data.movie_uniq_id ?? "")
             }
           case self.GameplaysCollectioV:
            if let data = GameplaysMoviedata?.subComedymovList[indexPath.row]
            {
               Movcategory = "gaming"
               MovSubcategory = "gameplay"
               passComedyMoviedata = data
               getcontentauthorised(movieid: data.movie_uniq_id ?? "")
            }
           case self.GameTrailersCollectioV:
            if let data = GameTrailersMoviedata?.subComedymovList[indexPath.row]
            {
               Movcategory = "gaming"
               MovSubcategory = "game-trailers"
               passComedyMoviedata = data
               getcontentauthorised(movieid: data.movie_uniq_id ?? "")
             }
           default:
           print("default")
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
    
