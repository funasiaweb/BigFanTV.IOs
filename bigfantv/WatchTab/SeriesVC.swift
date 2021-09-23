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
class SeriesVC: UIViewController {
    
       var sportsdata:newFilteredComedyMovieList?
       var spirtualdata:newFilteredComedyMovieList?
      
    
       private var Successdata:SuccessResponse?
    private var authorizeddata:Authorizescontent?

    
      
    @IBOutlet var TVSHOWCollectionV: UICollectionView!
    
    @IBOutlet var DocumentryCollectionV: UICollectionView!
    
    @IBOutlet var RadioCollecionV: UICollectionView!
     static var toviewall = 0
    static var isfrom = 0
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
     var Isfavourite = 0
     var movieuniqid = ""
    var contenttypesid = ""
    var WatchDuration = 0
     var newperma = ""
    var selftitle = ""
    @IBOutlet var myScrollingView: UIScrollView!
    
      private let serialDispatchQueue = DispatchQueue(label: "serial-dispatch-queue")
    
    var collectionarray =  [UICollectionView]()
    override func viewDidLoad() {
           super.viewDidLoad()

        collectionarray = [TVSHOWCollectionV,DocumentryCollectionV ]
        
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

 
       
            if Connectivity.isConnectedToInternet()
            {
                self.LoadallData()
            }else
            {
                Utility.Internetconnection(vc: self)
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
                     
                        Common.shared.getfeiltereddata(category: "tv-shows", subcategory: "full-shows") { (data, err) -> (Void) in
           
                         self.sportsdata = data
                          
                         DispatchQueue.main.async {
                            Utility.hideLoader(vc: self)
                             self.TVSHOWCollectionV.reloadData()
                              
                         }
                     }
                      
                        
                          Common.shared.getfeiltereddata(category: "documentary", subcategory: "") { (data, err) -> (Void) in
           
                            self.spirtualdata = data
                             
                            DispatchQueue.main.async {
                                Utility.hideLoader(vc: self)
                                self.DocumentryCollectionV.reloadData()
                                
                            }
                         
                     }
    
            
        
        
        }
    
    
    
           //toviewall
      
       @IBAction func ViewAllsportsBtTapped(_ sender: UIButton) {
                  
                  performSegue(withIdentifier: "viewallmovie", sender: self)
              }
              
              @IBAction func ViewAllspirtualBtTapped(_ sender: UIButton) {
                  
                  performSegue(withIdentifier: "viewallmovie", sender: self)
              }
              
              @IBAction func ViewAllmusicBtTapped(_ sender: UIButton) {
                 
                  performSegue(withIdentifier: "viewallmovie", sender: self)
              }
            
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
           
           
                      if segue.identifier == "toseries"
                      {
                       guard let navController = segue.destination as? UINavigationController,
                           let displayVC = navController.topViewController as? SerirsDetailsVC else {
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
                      }else if segue.identifier == "viewallmovie"
                        {
                       guard let navController = segue.destination as? UINavigationController,
                                            let displayVC = navController.topViewController as? SeriesViewAllVC else {
                                                return
                                        }
                              
                                displayVC.Movcategory = Movcategory
                                displayVC.MovSubcategory = MovSubcategory
                                displayVC.selftitle = selftitle
                                 
                         
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
                 Movcategory = "tv-shows"
                 MovSubcategory = "full-shows"
                selftitle = "Tv Shows"
             }else if sender.tag == 2
             {
                 Movcategory = "documentary"
                 MovSubcategory = ""
                selftitle = "Documentary"
             }else if sender.tag == 3
             {
                 Movcategory = "Radio Shows"
                 MovSubcategory = ""
             }
        SeriesVC.isfrom = 1
            performSegue(withIdentifier: "viewallmovie", sender: self)
         }
    }

    extension SeriesVC:UICollectionViewDelegate,UICollectionViewDataSource
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
                       // self.loadallapis(tag: tag)
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
        func loadallapis(tag:String)
        {
            if tag == "ActionCollectioV"
            {
                Common.shared.getfeiltereddata(category: "tv-shows", subcategory: "full-shows") { (data, err) -> (Void) in
                
                              self.sportsdata = data
                              self.TVSHOWCollectionV.delegate = self
                              self.TVSHOWCollectionV.dataSource = self
                              DispatchQueue.main.async {
                                 Utility.hideLoader(vc: self)
                                  self.TVSHOWCollectionV.reloadData()
                                   
                              }
                          }
            }
            else if tag == "adventureCollectioV"
            {
                Common.shared.getfeiltereddata(category: "documentary", subcategory: "") { (data, err) -> (Void) in
                
                                 self.spirtualdata = data
                                 self.DocumentryCollectionV.delegate = self
                                 self.DocumentryCollectionV.dataSource = self
                                 DispatchQueue.main.async {
                                     Utility.hideLoader(vc: self)
                                     self.DocumentryCollectionV.reloadData()
                                     
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
            if UserDefaults.standard.bool(forKey: "isLoggedin") == true
            {
            if collectionView == TVSHOWCollectionV
           {
            
            Movcategory = "tv-shows"
            MovSubcategory = "full-shows"
            newperma = sportsdata?.subComedymovList[indexPath.row].permalink ?? ""
             perma = sportsdata?.subComedymovList[indexPath.row].c_permalink ?? ""
            movieuniqid = sportsdata?.subComedymovList[indexPath.row].movie_uniq_id ?? ""
           contenttypesid  = sportsdata?.subComedymovList[indexPath.row].content_types_id ?? ""
                self.getcontentauthorized(movieid: movieuniqid, planurls: "", index: 0, permad: perma)

            }
           else if collectionView == DocumentryCollectionV
           {
            Movcategory = "documentary"
            MovSubcategory = ""
             newperma = spirtualdata?.subComedymovList[indexPath.row].permalink ?? ""
             perma = spirtualdata?.subComedymovList[indexPath.row].c_permalink ?? ""
             movieuniqid = spirtualdata?.subComedymovList[indexPath.row].movie_uniq_id ?? ""
            contenttypesid  = spirtualdata?.subComedymovList[indexPath.row].content_types_id ?? ""
            self.getcontentauthorized(movieid: movieuniqid, planurls: "", index: 0, permad: perma)

             
            }
            }else
            {
                let alertController = MDCAlertController(title: "BigFan TV", message:  "First Login or Register to favorite this content.")
                let action = MDCAlertAction(title:"Continue")
                                                { (action) in
                    let storyBoard: UIStoryboard = UIStoryboard(name: "Main", bundle: nil)
                     let displayVC = storyBoard.instantiateViewController(withIdentifier: "LaunchVC") as! LaunchVC
                                      
                    displayVC.modalPresentationStyle = .fullScreen
                                        
                  

                    

                   self.present(displayVC, animated: false, completion: nil)

                }
                let cancelaction = MDCAlertAction(title:"Cancel")
                { (cancelaction) in}
                                    
                alertController.addAction(action)
                                        
                alertController.addAction(cancelaction)

            self.present(alertController, animated: true, completion: nil)
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
                         let displayVC = storyBoard.instantiateViewController(withIdentifier: "SerirsDetailsVC") as! SerirsDetailsVC
                            displayVC.modalPresentationStyle = .fullScreen
                             
                            displayVC.perma = self.perma
                            displayVC.movieuniqid = self.movieuniqid
                            displayVC.Movcategory = self.Movcategory
                            displayVC.MovSubcategory = self.MovSubcategory
                            displayVC.playerurlstr = self.newperma
                            displayVC.contenttypesid = self.contenttypesid
 
                        self.present(displayVC, animated: true, completion: nil)

                    }
                                    
                    else
                    {
                        let storyBoard: UIStoryboard = UIStoryboard(name: "Main", bundle: nil)
                         let displayVC = storyBoard.instantiateViewController(withIdentifier: "SerirsDetailsVC") as! SerirsDetailsVC
                            displayVC.modalPresentationStyle = .fullScreen
                             
                            displayVC.perma = self.perma
                            displayVC.movieuniqid = self.movieuniqid
                            displayVC.Movcategory = self.Movcategory
                            displayVC.MovSubcategory = self.MovSubcategory
                            displayVC.playerurlstr = self.newperma
                            displayVC.contenttypesid = self.contenttypesid
 
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
        
            
    }
       
   
     
