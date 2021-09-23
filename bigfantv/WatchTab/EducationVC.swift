//
//  PodcastLstVC.swift
//  bigfantv
//
//  Created by Ganesh on 30/07/20.
//  Copyright © 2020 Ganesh. All rights reserved.
//

import UIKit
import MaterialComponents.MaterialDialogs
class EducationVC: UIViewController {
        private var ComedyMoviedata:newFilteredComedyMovieList?
        private var passComedyMoviedata:newFilteredSubComedymovieList?
        private var ThrillerMoviedata:newFilteredComedyMovieList?
        private var ActionMoviedata:newFilteredComedyMovieList?
        private var CompMoviedata:newFilteredComedyMovieList?
        private var  Successdata:SuccessResponse?
        
        @IBOutlet var ComedyCollectionV: UICollectionView!
        
        @IBOutlet var ThrillerCollectionV: UICollectionView!
        
        @IBOutlet var ActionCollectioV: UICollectionView!
        @IBOutlet var  CompCollectioV: UICollectionView!
    
    
    @IBOutlet var myScrollingView: UIScrollView!
     private let serialDispatchQueue = DispatchQueue(label: "serial-dispatch-queue")
    var Isfavourite = 0
   static var isfrom = 0

   static var toviewall = 0
    var imagename = ""
    var moviename = ""
    var movietype = ""
    var timereleasedate  = ""
    var language = ""
    var movdescription: String = ""
    var totalcount = 0
    
    let cellIdentifier = "cell"
    var Movcategory = ""
    var MovSubcategory = ""
    var perma = ""
    var movieuniqid = ""
    var WatchDuration = 0
     var newperma = ""
      var selftitle  = ""
     private var authorizeddata:Authorizescontent?
    var collectionarray =  [UICollectionView]()
    override func viewDidLoad() {
           super.viewDidLoad()

        collectionarray = [ComedyCollectionV,ThrillerCollectionV, ActionCollectioV ,CompCollectioV]
        
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
         myScrollingView.refreshControl?.addTarget(self, action: #selector(handleRefreshControl), for: .valueChanged)
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
        DispatchQueue.main.async
            {
                self.myScrollingView.refreshControl?.endRefreshing()
            }
     }
       func LoadallData()
       {
        Utility.ShowLoader(vc: self)
          
         
                                    
            Common.shared.getfeiltereddata(category: "education-learn-with-us", subcategory: "music") { (data, err) -> (Void) in
                                       
                self.ThrillerMoviedata = data
 
                DispatchQueue.main.async {
                    self.ThrillerCollectionV.reloadData()
                  }
             }
          
         
                                 
            Common.shared.getfeiltereddata(category: "education-learn-with-us", subcategory: "engineering-concepts") { (data, err) -> (Void) in
                         
                self.ComedyMoviedata = data
 
                DispatchQueue.main.async {
                    self.ComedyCollectionV.reloadData()
                 }
             }
          
         
                                  
            Common.shared.getfeiltereddata(category: "education-learn-with-us", subcategory: "school-education") { (data, err) -> (Void) in
               
                self.ActionMoviedata = data
 
                DispatchQueue.main.async {
                    Utility.hideLoader(vc: self)
                    self.ActionCollectioV.reloadData()
               }
             }
          
                                    
         
                                        
            Common.shared.getfeiltereddata(category: "education-learn-with-us", subcategory: "computer-amp-it") { (data, err) -> (Void) in
                 
                self.CompMoviedata = data
 
                DispatchQueue.main.async {
                    Utility.hideLoader(vc: self)
                    self.CompCollectioV.reloadData()
                 }
             }
       
        
    }
    
    /*
    func LoadallData()
    {
        Utility.ShowLoader(vc: self)
            let serialQueue = DispatchQueue(label: "mySerialQueue", attributes: [], target: nil)
          serialQueue.async
            {
                Api.Getconent2("education-learn-with-us", subCat: "music", endpoint: ApiEndPoints.getFilteredContent, vc: self, offset: 1) { (res, err) -> (Void) in
                                do
                                {
                                    let decoder = JSONDecoder()
                                    self.ThrillerMoviedata = try decoder.decode(newFilteredComedyMovieList.self, from: res  ?? Data())
                                    self.ThrillerCollectionV.delegate = self
                                    self.ThrillerCollectionV.dataSource  = self
                                    DispatchQueue.main.async
                                        {
                                        self.ThrillerCollectionV.reloadData()
                                        }
                                   
                                }
                                catch let error
                                {
                                //    Utility.showAlert(vc: self, message:"\(error)", titelstring: Appcommon.Appname)
                                }
                            }
            }
        serialQueue.async
            {
                Api.Getconent2("education-learn-with-us", subCat: "engineering-concepts", endpoint: ApiEndPoints.getFilteredContent, vc: self, offset: 1) { (res, err) -> (Void) in
                do
                {
                      let decoder = JSONDecoder()
                    self.ComedyMoviedata = try decoder.decode(newFilteredComedyMovieList.self, from: res ?? Data() )
                      self.ComedyCollectionV.delegate = self
                      self.ComedyCollectionV.dataSource  = self
                      DispatchQueue.main.async {
                            self.ComedyCollectionV.reloadData()
                      }
                }
                catch let error
               {
               // Utility.showAlert(vc: self, message:"\(err ?? "")", titelstring: Appcommon.Appname)
               }
           }
        }
        serialQueue.async
           {
            Api.Getconent2("education-learn-with-us", subCat: "school-education", endpoint: ApiEndPoints.getFilteredContent, vc: self, offset: 1) { (res, err) -> (Void) in
                            do
                            {
                                let decoder = JSONDecoder()
                                self.ActionMoviedata = try decoder.decode(newFilteredComedyMovieList.self, from: res  ?? Data())
                                self.ActionCollectioV.delegate = self
                                self.ActionCollectioV.dataSource  = self
                                DispatchQueue.main.async
                                    {
                                    self.ActionCollectioV.reloadData()
                                        Utility.hideLoader(vc: self)
                                    }
                               
                            }
                            catch let error
                            {
                                Utility.hideLoader(vc: self)
                              //  Utility.showAlert(vc: self, message:"\(error)", titelstring: Appcommon.Appname)
                            }
                        }
           }
        serialQueue.async {
            Api.Getconent2("education-learn-with-us", subCat: "computer-amp-it", endpoint: ApiEndPoints.getFilteredContent, vc: self, offset: 1) { (res, err) -> (Void) in
                            do
                            {
                                let decoder = JSONDecoder()
                                self.CompMoviedata = try decoder.decode(newFilteredComedyMovieList.self, from: res  ?? Data())
                                self.CompCollectioV.delegate = self
                                self.CompCollectioV.dataSource  = self
                                DispatchQueue.main.async
                                    {
                                    self.CompCollectioV.reloadData()
                                        Utility.hideLoader(vc: self)
                                    }
                               
                            }
                            catch let error
                            {
                                Utility.hideLoader(vc: self)
                               // Utility.showAlert(vc: self, message:"\(error)", titelstring: Appcommon.Appname)
                            }
                        }
             
        }
        
        
        
    }
    
    */
       
    

        
    
        
        @IBAction func ViewAllcomedyBtTapped(_ sender: UIButton) {
                  if sender.tag == 2
                  {
                      Movcategory = "education-learn-with-us"
                      MovSubcategory = "engineering-concepts"
                    selftitle = "Engineering-concepts"

                  }else if sender.tag == 3
                  {
                      Movcategory = "education-learn-with-us"
                      MovSubcategory = "school-education"
                    selftitle = "School-education"
                  }else if sender.tag == 4
                  {
                      Movcategory = "education-learn-with-us"
                      MovSubcategory = "computer-amp-it"
                    selftitle = "Computer-amp-it"
                  }else if sender.tag == 1
                  {
                    Movcategory = "education-learn-with-us"
                    MovSubcategory = "music"
                     selftitle = "Music"

                  }
                  
                let storyBoard : UIStoryboard = UIStoryboard(name: "Main", bundle: nil)
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

    extension EducationVC:UICollectionViewDelegate,UICollectionViewDataSource
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
            } else if collectionView == CompCollectioV
            {
                return CompMoviedata?.subComedymovList.count ?? 0
            }
            return 0
        }
        
        func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell
        {
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
                      Loaddataincell(maincell: maincell, data: data, ind: indexPath.row, tag: "adventureCollectioV")
                  }
                  
                  Cell = maincell
                
            case self.ActionCollectioV:
               
                let maincell = collectionView.dequeueReusableCell(withReuseIdentifier: cellIdentifier, for: indexPath) as! MyCell
                
                  if let data = ActionMoviedata
                  {
                      Loaddataincell(maincell: maincell, data: data, ind: indexPath.row, tag: "fantasyCollectioV")
                  }
                  
                  Cell = maincell
            case self.CompCollectioV:
                
                let maincell = collectionView.dequeueReusableCell(withReuseIdentifier: cellIdentifier, for: indexPath) as! MyCell
                
                  if let data = CompMoviedata
                  {
                      Loaddataincell(maincell: maincell, data: data, ind: indexPath.row, tag: "romanceCollectioV")
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
                 
            case self.ComedyCollectionV:
                
                 if let data = ActionMoviedata?.subComedymovList[indexPath.row]
                 {
                    Movcategory = "education-learn-with-us"
                    MovSubcategory = "engineering-concepts"
                    passComedyMoviedata = data
                    getcontentauthorised(movieid: data.movie_uniq_id ?? "")
                }
            case self.ThrillerCollectionV:
                if let data = ThrillerMoviedata?.subComedymovList[indexPath.row]
                {
                    Movcategory = "education-learn-with-us"
                     MovSubcategory =  "music"
                    passComedyMoviedata = data
                    getcontentauthorised(movieid: data.movie_uniq_id ?? "")
                }
             case self.ActionCollectioV:
                 
                if let data = ActionMoviedata?.subComedymovList[indexPath.row]
                   {
                    Movcategory = "education-learn-with-us"
                     MovSubcategory = "school-education"
                    passComedyMoviedata = data
                    getcontentauthorised(movieid: data.movie_uniq_id ?? "")
                   }
                
                case self.CompCollectioV:
                    
                   if let data = CompMoviedata?.subComedymovList[indexPath.row]
                      {
                       Movcategory = "education-learn-with-us"
                       MovSubcategory = "computer-amp-it"
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
       
     
