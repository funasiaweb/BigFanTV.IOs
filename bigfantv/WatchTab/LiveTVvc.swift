//
//  LiveTVvc.swift
//  bigfantv
//
//  Created by Ganesh on 24/07/20.
//  Copyright © 2020 Ganesh. All rights reserved.
//

import UIKit
import Alamofire
import SwiftyJSON
import MaterialComponents.MaterialDialogs


class LiveTVvc: UIViewController {
    private var sportsdata:newFilteredComedyMovieList?
    private var spirtualdata:newFilteredComedyMovieList?
    private var musicdata:newFilteredComedyMovieList?
    private var newsdata:newFilteredComedyMovieList?
    private var entertainmentdata:newFilteredComedyMovieList?
      private var Successdata:SuccessResponse?
     var passarray:LiveTvCategoriesList?
    var livetvid = ""
    static var isfrom = 0
 
    @IBOutlet var TableV: UITableView!
    static var toviewall = 0
    var tappedCell:LiveTvListdetails?
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
     var Movcategory = ""
     var MovSubcategory = ""
     var Isfavourite = "0"
     var WatchDuration = 0
     var newperma = ""
     var contenttypesid  = ""
    var livetvcategoryid = ""
    
    @IBOutlet var SportCollection: UICollectionView!
    
    
    @IBOutlet var SpirtualCollection: UICollectionView!
    
    @IBOutlet var MusicCollection: UICollectionView!
    
    
    @IBOutlet var NewsCollection: UICollectionView!
    
    @IBOutlet var EntertainmentCollection: UICollectionView!
    
    var Livetv:LiveTVData?
    let cellIdentifier = "cell"
    
    var selftitle = ""
    
    var collectionarray =  [UICollectionView]()
    override func viewDidLoad() {
           super.viewDidLoad()
/*
        collectionarray = [SportCollection,SpirtualCollection, MusicCollection ,NewsCollection,EntertainmentCollection]
        
        for i in collectionarray
        {
 
            i.delegate = self
            i.dataSource = self
           i.register(UINib(nibName:"MyCell", bundle:nil), forCellWithReuseIdentifier: cellIdentifier)
        }
 */
        
        let cellNib = UINib(nibName: "LiveTVTableViewCell", bundle: nil)
        self.TableV.register(cellNib, forCellReuseIdentifier: "tableviewcellid")

        TableV.backgroundColor = Appcolor.backgorund4
        TableV.estimatedRowHeight = 160
        TableV.allowsMultipleSelection = true
 
        if Connectivity.isConnectedToInternet()
        {
            Getalllivetvchannels()
        }
        else
        {
            Utility.Internetconnection(vc: self)
        }
      
    }
    
 
    override func viewDidAppear(_ animated: Bool)
    {
        /*
        let heightcollection = SportCollection.frame.size.height
        let widthcollection = (( heightcollection * 280)/156) - 18
      
        for i in collectionarray
        {
              let flowLayout = UICollectionViewFlowLayout()
              flowLayout.scrollDirection = .horizontal
            
              flowLayout.itemSize = CGSize(width: widthcollection , height: heightcollection)
              flowLayout.minimumLineSpacing = 10
              flowLayout.minimumInteritemSpacing = 10.0
        
              i.collectionViewLayout = flowLayout
  
        }
        */
    }
    
    
    @IBAction func ViewAllcomedyBtTapped(_ sender: UIButton) {
              if sender.tag == 1
              {
                Movcategory = "live-tv"
                MovSubcategory = "sports1"
               selftitle = "Sports"
               }else if sender.tag == 2
              {
                   Movcategory = "live-tv"
                   MovSubcategory = "spiritual"
                  selftitle = "Spirtual"

              }else if sender.tag == 3
              {
                   Movcategory = "live-tv"
                   MovSubcategory = "music"
                  selftitle = "Music"
              }else if sender.tag == 4
              {
                   Movcategory = "live-tv"
                   MovSubcategory = "news1"
                  selftitle = "News"
              }else if sender.tag == 5
              {
                   Movcategory = "live-tv"
                   MovSubcategory = "entertainment"
                  selftitle = "Entertainment"
              }
              
            let storyBoard : UIStoryboard = UIStoryboard(name: "Main", bundle: nil)
              let VC1 = storyBoard.instantiateViewController(withIdentifier: "LiveTvViewAllVC") as! LiveTvViewAllVC
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
    func Getalllivetvchannels()
    {
        guard let parameters =
              [
                "userId":UserDefaults.standard.string(forKey: "id") ?? "",
                "AccessToken":UserDefaults.standard.string(forKey:"AccessToken") ?? "",
                "offset":"1",
                "longitude":UserDefaults.standard.string(forKey: "Longitude") ?? "",
                "latitude":UserDefaults.standard.string(forKey: "Latitude") ?? ""
              ] as? [String:Any] else { return  }
       
        Utility.ShowLoader(vc: self)
        Common.shared.Commonapi(parameters: parameters, urlString: CommonApiEndPoints.getlivetvList) { (data, err) -> (Void) in
            do
            {
                
                  
                Utility.hideLoader(vc: self)
                
                let decoder = JSONDecoder()
                self.Livetv = try decoder.decode(LiveTVData.self, from: data ?? Data())
                if self.Livetv?.success == 1
                {
                    if self.Livetv?.liveTvCategoriesList?.count ?? 0 > 0
                    {
                        self.TableV.delegate = self
                        self.TableV.dataSource = self
                        DispatchQueue.main.async {
                            self.TableV.reloadData()
                        }
 
                    }
                }
                
            }catch
            {
                Utility.hideLoader(vc: self)
                print(error.localizedDescription)
            }
        }
    }
 
      func LoadallData()
          {
           
             
            let dispatchGroups = DispatchGroup()
                 dispatchGroups.enter()
            
               Common.shared.getfeiltereddataw(category: "live-tv", subcategory: "sports1") { (data, err) -> (Void) in
                    
                self.sportsdata = data
      
                DispatchQueue.main.async
                    {
                        dispatchGroups.leave()
                       self.SportCollection.reloadData()
                     }
                }
            dispatchGroups.enter()
            
               Common.shared.getfeiltereddataw(category: "live-tv", subcategory: "spiritual") { (data, err) -> (Void) in
                            
                   self.spirtualdata = data
    
                   DispatchQueue.main.async
                    {
                        dispatchGroups.leave()
                       self.SpirtualCollection.reloadData()
                    }
                }
             
            
                   dispatchGroups.enter()
               Common.shared.getfeiltereddataw(category: "live-tv", subcategory: "music") { (data, err) -> (Void) in
                  
                   self.musicdata = data
  
                Utility.hideLoader(vc: self)
                   DispatchQueue.main.async
                    {
                                    dispatchGroups.leave()
                       self.MusicCollection.reloadData()
                  }
                }
             
                                       
            
                   dispatchGroups.enter()
               Common.shared.getfeiltereddataw(category: "live-tv", subcategory: "entertainment") { (data, err) -> (Void) in
                     Utility.hideLoader(vc: self)
                   self.entertainmentdata = data
 
                   DispatchQueue.main.async {
                                   dispatchGroups.leave()
                       self.EntertainmentCollection.reloadData()
                    }
            }
            
             dispatchGroups.enter()
                       Common.shared.getfeiltereddataw(category: "live-tv", subcategory: "news1") { (data, err) -> (Void) in
                           Utility.hideLoader(vc: self)
                        self.newsdata = data
 
                           DispatchQueue.main.async {
                            dispatchGroups.leave()
                               self.NewsCollection.reloadData()
                            }
                    }
            dispatchGroups.notify(queue: .main) {
                // whatever you want to do when both are done
                print("completed///")
            }
            
    }
  
    
        
        override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
                  
                  
                             if segue.identifier == "tolivetv"
                             {
                              guard let navController = segue.destination as? UINavigationController,
                                  let displayVC = navController.topViewController as? LiveTvDetailsVC else {
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
                                displayVC.WatchDuration = WatchDuration
                                       
                             }
                  
                
                  }
   
    

 }

 extension LiveTVvc:UICollectionViewDelegate,UICollectionViewDataSource,UICollectionViewDelegateFlowLayout
 {

    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
         
         if collectionView == SportCollection
         {
             return sportsdata?.subComedymovList.count ?? 0
         }
         else if collectionView == SpirtualCollection
         {
            return spirtualdata?.subComedymovList.count ?? 0
         }
        else if collectionView == MusicCollection
        {
           return musicdata?.subComedymovList.count ?? 0
        }
        else if collectionView == NewsCollection
        {
           return newsdata?.subComedymovList.count ?? 0
        }
        else if collectionView == EntertainmentCollection
        {
           
           return entertainmentdata?.subComedymovList.count ?? 0
        }
         return 0
     }
     
     func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell
     {
        let Cell   = collectionView.dequeueReusableCell(withReuseIdentifier: cellIdentifier, for: indexPath) as! MyCell

        
        
        if collectionView == SportCollection
        {
          let  maincell  = collectionView.dequeueReusableCell(withReuseIdentifier: cellIdentifier, for: indexPath) as! MyCell
            let item = sportsdata?.subComedymovList[indexPath.row]
                    
                   if let url = URL(string: item?.poster ?? "")
                   {
            
                       maincell.ImgSample.sd_setImage(with: url, completed: nil)
            
                   }
            maincell.LbName.text = item?.title ?? ""
            let image = item?.is_fav_status == 1 ? UIImage(named: "liked") : UIImage(named: "like")
            maincell.btnCounter.setBackgroundImage(image, for: .normal)
            maincell.actionBlock = {
                () in
                if item?.is_fav_status == 0
                {
                    maincell.btnCounter.setBackgroundImage(UIImage(named: "liked"), for: .normal)
                    self.AddtoFav(movieuniqidx: item?.movie_uniq_id ?? "", endpoint: ApiEndPoints.AddToFavlist) { (true) in
                    maincell.btnCounter.setBackgroundImage(UIImage(named: "liked"), for: .normal)
                        
                        self.sportsdata?.subComedymovList[indexPath.row].is_fav_status = 1
                       // self.loadallapis(tag: tag)
                }
                }else if item?.is_fav_status == 1
                {
                    maincell.btnCounter.setBackgroundImage(UIImage(named: "like"), for: .normal)
                    self.AddtoFav(movieuniqidx: item?.movie_uniq_id ?? "", endpoint: ApiEndPoints.DeleteFavLIst) { (true) in
                    maincell.btnCounter.setBackgroundImage(UIImage(named: "like"), for: .normal)
                        self.sportsdata?.subComedymovList[indexPath.row].is_fav_status = 0
                     
                }
                }
               
            }
            return maincell
        }
        else if collectionView ==  SpirtualCollection
        {
                      let  maincell  = collectionView.dequeueReusableCell(withReuseIdentifier: cellIdentifier, for: indexPath) as! MyCell
              let item = spirtualdata?.subComedymovList[indexPath.row]
                      
                     if let url = URL(string: item?.poster ?? "")
                     {
              
                         maincell.ImgSample.sd_setImage(with: url, completed: nil)
              
                     }
              maincell.LbName.text = item?.title ?? ""
              let image = item?.is_fav_status == 1 ? UIImage(named: "liked") : UIImage(named: "like")
              maincell.btnCounter.setBackgroundImage(image, for: .normal)
              maincell.actionBlock = {
                  () in
                  if item?.is_fav_status == 0
                  {
                      maincell.btnCounter.setBackgroundImage(UIImage(named: "liked"), for: .normal)
                      self.AddtoFav(movieuniqidx: item?.movie_uniq_id ?? "", endpoint: ApiEndPoints.AddToFavlist) { (true) in
                      maincell.btnCounter.setBackgroundImage(UIImage(named: "liked"), for: .normal)
                          
                          self.spirtualdata?.subComedymovList[indexPath.row].is_fav_status = 1
                         // self.loadallapis(tag: tag)
                  }
                  }else if item?.is_fav_status == 1
                  {
                      maincell.btnCounter.setBackgroundImage(UIImage(named: "like"), for: .normal)
                      self.AddtoFav(movieuniqidx: item?.movie_uniq_id ?? "", endpoint: ApiEndPoints.DeleteFavLIst) { (true) in
                      maincell.btnCounter.setBackgroundImage(UIImage(named: "like"), for: .normal)
                          self.spirtualdata?.subComedymovList[indexPath.row].is_fav_status = 0
                       
                  }
                  }
                 
              }
              return maincell
        }
       else if collectionView == MusicCollection
        {
                     let  maincell  = collectionView.dequeueReusableCell(withReuseIdentifier: cellIdentifier, for: indexPath) as! MyCell
              let item = musicdata?.subComedymovList[indexPath.row]
                      
                     if let url = URL(string: item?.poster ?? "")
                     {
              
                         maincell.ImgSample.sd_setImage(with: url, completed: nil)
              
                     }
              maincell.LbName.text = item?.title ?? ""
              let image = item?.is_fav_status == 1 ? UIImage(named: "liked") : UIImage(named: "like")
              maincell.btnCounter.setBackgroundImage(image, for: .normal)
              maincell.actionBlock = {
                  () in
                if UserDefaults.standard.bool(forKey: "isLoggedin") == true
                {
                    if item?.is_fav_status == 0
                    {
                        maincell.btnCounter.setBackgroundImage(UIImage(named: "liked"), for: .normal)
                        self.AddtoFav(movieuniqidx: item?.movie_uniq_id ?? "", endpoint: ApiEndPoints.AddToFavlist) { (true) in
                        maincell.btnCounter.setBackgroundImage(UIImage(named: "liked"), for: .normal)
                            
                            self.musicdata?.subComedymovList[indexPath.row].is_fav_status = 1
                           // self.loadallapis(tag: tag)
                    }
                    }else if item?.is_fav_status == 1
                    {
                        maincell.btnCounter.setBackgroundImage(UIImage(named: "like"), for: .normal)
                        self.AddtoFav(movieuniqidx: item?.movie_uniq_id ?? "", endpoint: ApiEndPoints.DeleteFavLIst) { (true) in
                        maincell.btnCounter.setBackgroundImage(UIImage(named: "like"), for: .normal)
                            self.musicdata?.subComedymovList[indexPath.row].is_fav_status = 0
                         
                    }
                    }
                }else
                {
                    
                }
                  
                 
              }
              return maincell
        }
       else if collectionView == NewsCollection
        {
                     let  maincell  = collectionView.dequeueReusableCell(withReuseIdentifier: cellIdentifier, for: indexPath) as! MyCell
              let item = newsdata?.subComedymovList[indexPath.row]
                      
                     if let url = URL(string: item?.poster ?? "")
                     {
              
                         maincell.ImgSample.sd_setImage(with: url, completed: nil)
              
                     }
              maincell.LbName.text = item?.title ?? ""
              let image = item?.is_fav_status == 1 ? UIImage(named: "liked") : UIImage(named: "like")
              maincell.btnCounter.setBackgroundImage(image, for: .normal)
              maincell.actionBlock = {
                  () in
                  if item?.is_fav_status == 0
                  {
                      maincell.btnCounter.setBackgroundImage(UIImage(named: "liked"), for: .normal)
                      self.AddtoFav(movieuniqidx: item?.movie_uniq_id ?? "", endpoint: ApiEndPoints.AddToFavlist) { (true) in
                      maincell.btnCounter.setBackgroundImage(UIImage(named: "liked"), for: .normal)
                          
                          self.newsdata?.subComedymovList[indexPath.row].is_fav_status = 1
                         // self.loadallapis(tag: tag)
                  }
                  }else if item?.is_fav_status == 1
                  {
                      maincell.btnCounter.setBackgroundImage(UIImage(named: "like"), for: .normal)
                      self.AddtoFav(movieuniqidx: item?.movie_uniq_id ?? "", endpoint: ApiEndPoints.DeleteFavLIst) { (true) in
                      maincell.btnCounter.setBackgroundImage(UIImage(named: "like"), for: .normal)
                          self.newsdata?.subComedymovList[indexPath.row].is_fav_status = 0
                       
                  }
                  }
                 
              }
              return maincell
        }
       else if collectionView == EntertainmentCollection
        {
                     let  maincell  = collectionView.dequeueReusableCell(withReuseIdentifier: cellIdentifier, for: indexPath) as! MyCell
              let item = entertainmentdata?.subComedymovList[indexPath.row]
                      
                     if let url = URL(string: item?.poster ?? "")
                     {
              
                         maincell.ImgSample.sd_setImage(with: url, completed: nil)
              
                     }
              maincell.LbName.text = item?.title ?? ""
              let image = item?.is_fav_status == 1 ? UIImage(named: "liked") : UIImage(named: "like")
              maincell.btnCounter.setBackgroundImage(image, for: .normal)
              maincell.actionBlock = {
                  () in
                  if item?.is_fav_status == 0
                  {
                      maincell.btnCounter.setBackgroundImage(UIImage(named: "liked"), for: .normal)
                      self.AddtoFav(movieuniqidx: item?.movie_uniq_id ?? "", endpoint: ApiEndPoints.AddToFavlist) { (true) in
                      maincell.btnCounter.setBackgroundImage(UIImage(named: "liked"), for: .normal)
                          
                          self.entertainmentdata?.subComedymovList[indexPath.row].is_fav_status = 1
                         // self.loadallapis(tag: tag)
                  }
                  }else if item?.is_fav_status == 1
                  {
                      maincell.btnCounter.setBackgroundImage(UIImage(named: "like"), for: .normal)
                      self.AddtoFav(movieuniqidx: item?.movie_uniq_id ?? "", endpoint: ApiEndPoints.DeleteFavLIst)
                      { (true) in
                      maincell.btnCounter.setBackgroundImage(UIImage(named: "like"), for: .normal)
                          self.entertainmentdata?.subComedymovList[indexPath.row].is_fav_status = 0
                       
                  }
                  }
                 
              }
              return maincell
         
            
            
        }
        return Cell
     }
     func Loaddataincell(maincell:MyCell,data:newFilteredComedyMovieList,ind:Int)
            {
                       let item = data.subComedymovList[ind]
                        
                       if let url = URL(string: item.poster ?? "")
                       {
                
                           maincell.ImgSample.sd_setImage(with: url, completed: nil)
                
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
        if collectionView == SportCollection
         {
           
            Movcategory = "live-tv"
            MovSubcategory = "sports1"
           
          imagename = sportsdata?.subComedymovList[indexPath.row].poster ?? ""
          moviename = sportsdata?.subComedymovList[indexPath.row].title ?? ""
           movieuniqid = sportsdata?.subComedymovList[indexPath.row].movie_uniq_id ?? ""
            perma = sportsdata?.subComedymovList[indexPath.row].c_permalink ?? ""
             WatchDuration = sportsdata?.subComedymovList[indexPath.row].watch_duration_in_seconds ?? 0
          }
         else if collectionView == SpirtualCollection
         {
            Movcategory = "live-tv"
            MovSubcategory = "spiritual"
             perma = spirtualdata?.subComedymovList[indexPath.row].c_permalink ?? ""
           imagename = spirtualdata?.subComedymovList[indexPath.row].poster ?? ""
           moviename = spirtualdata?.subComedymovList[indexPath.row].title ?? ""
            movieuniqid = spirtualdata?.subComedymovList[indexPath.row].movie_uniq_id ?? ""
           WatchDuration = spirtualdata?.subComedymovList[indexPath.row].watch_duration_in_seconds ?? 0
           
        
          }
        else if collectionView == MusicCollection
        {
            Movcategory = "live-tv"
            MovSubcategory = "music"
             perma = musicdata?.subComedymovList[indexPath.row].c_permalink ?? ""
            imagename = musicdata?.subComedymovList[indexPath.row].poster ?? ""
            movieuniqid = musicdata?.subComedymovList[indexPath.row].movie_uniq_id ?? ""
            moviename = musicdata?.subComedymovList[indexPath.row].title ?? ""
          WatchDuration = newsdata?.subComedymovList[indexPath.row].watch_duration_in_seconds ?? 0
             
       
        }else if collectionView == NewsCollection
         {
            Movcategory = "live-tv"
            MovSubcategory = "news1"
             perma = newsdata?.subComedymovList[indexPath.row].c_permalink ?? ""
            movieuniqid = newsdata?.subComedymovList[indexPath.row].movie_uniq_id ?? ""
           imagename = newsdata?.subComedymovList[indexPath.row].poster ?? ""
           moviename = newsdata?.subComedymovList[indexPath.row].title ?? ""
          WatchDuration = newsdata?.subComedymovList[indexPath.row].watch_duration_in_seconds ?? 0
           
           }
        else if collectionView == EntertainmentCollection
        {
            Movcategory = "live-tv"
            MovSubcategory = "entertainment"
             perma = entertainmentdata?.subComedymovList[indexPath.row].c_permalink ?? ""
            movieuniqid = entertainmentdata?.subComedymovList[indexPath.row].movie_uniq_id ?? ""
            imagename = entertainmentdata?.subComedymovList[indexPath.row].poster ?? ""
            moviename = entertainmentdata?.subComedymovList[indexPath.row].title ?? ""
          WatchDuration = entertainmentdata?.subComedymovList[indexPath.row].watch_duration_in_seconds ?? 0
            
         
        }
          
              let storyBoard: UIStoryboard = UIStoryboard(name: "Main", bundle: nil)
              let secondViewController =  storyBoard.instantiateViewController(withIdentifier: "LiveTvDetailsVC") as! LiveTvDetailsVC
               secondViewController.imagename = self.imagename
               secondViewController.moviename = self.moviename
               secondViewController.movietype = self.movietype
               secondViewController.timereleasedate = self.timereleasedate
               secondViewController.language = self.language
               secondViewController.perma = self.perma
               secondViewController.Movcategory = self.Movcategory
               secondViewController.MovSubcategory = self.MovSubcategory
              secondViewController.movieuniqid = self.movieuniqid
               
             self.present(secondViewController, animated: true)
     }
     
 }
    
 

extension LiveTVvc : UITableViewDelegate,UITableViewDataSource
{
    func numberOfSections(in tableView: UITableView) -> Int
    {
        return  Livetv?.liveTvCategoriesList?.count ?? 0    }
     
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int
    {
        return 1
    }
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView?
    {
        let headerView = UIView()
        headerView.backgroundColor = Appcolor.backgorund4
              
        let whiteview = UIView(frame: CGRect(x: 16, y: 14, width: 4, height: 16))
        whiteview.backgroundColor = UIColor.white
        headerView.addSubview(whiteview)
            
        let button = UIButton(frame: CGRect(x: ((self.TableV.frame.size.width) - 26)  , y: 10, width: 22, height: 22))
        button.tag = section
        button.addTarget(self, action: #selector(loaddata(_:)), for: .touchUpInside)
        button.setBackgroundImage(UIImage(named: "viewall"), for: .normal)
        headerView.addSubview(button)
 
        let titleLabel = UILabel(frame: CGRect(x: 32, y: 0, width: 200, height: 44))
        headerView.addSubview(titleLabel)
        titleLabel.textColor = UIColor.white
        titleLabel.font =  UIFont(name: "Muli-SemiBold", size: 17)!
        
        titleLabel.text = Livetv?.liveTvCategoriesList?[section].title ?? ""
                 
        return headerView
        
    }
    
    @objc func loaddata(_ sender:UIButton)
    {
        let storyBoard: UIStoryboard = UIStoryboard(name: "Main", bundle: nil)
        let VC1 = storyBoard.instantiateViewController(withIdentifier: "LiveTvViewAllVC") as! LiveTvViewAllVC
       // VC1.Loadhomedata = Livetv?.liveTvCategoriesList?[sender.tag]
        VC1.livetvcategoryid =  Livetv?.liveTvCategoriesList?[sender.tag].liveTvCategroryID ?? ""
      //  VC1.totalconents = newFeaturedList?.subComedymovList?[sender.tag].total ?? 0
         
        let navController = UINavigationController(rootViewController: VC1) // Creating a navigation controller with VC1 at the root of the navigation stack.
         navController.navigationBar.barTintColor = Appcolor.backgorund4
         navController.modalPresentationStyle = .fullScreen
         self.present(navController, animated:true, completion: nil)
        
    }
    /*
    public func tableView(_ tableView: UITableView, estimatedHeightForRowAt indexPath: IndexPath) -> CGFloat
    {
        return 160
    }
    */
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        44
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat
    {
         return 160
    }
    public func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell
    {
        if let cell = tableView.dequeueReusableCell(withIdentifier: "tableviewcellid", for: indexPath) as? LiveTVTableViewCell
        {
           
            let rowArray =  Livetv?.liveTvCategoriesList?[indexPath.section].liveTvList ?? [LiveTvListdetails]()
                    
            cell.updateCellWith(row: rowArray, rowindex: indexPath.section)
            cell.cellDelegate = self
            cell.selectionStyle = .none
                     
            return cell
            
        }
        return UITableViewCell()
        
    }

       
    }
extension LiveTVvc: CollectionViewCellDelegate2
{
    func collectionView(collectionviewcell: CollectionViewCellnew?, index: Int, rowindex: Int, didTappedInTableViewCell: LiveTVTableViewCell)
    {
        if let colorsRow = didTappedInTableViewCell.rowWithColors
        {
 
            livetvcategoryid =  Livetv?.liveTvCategoriesList?[rowindex].liveTvCategroryID ?? ""
            passarray = Livetv?.liveTvCategoriesList?[rowindex]
            self.tappedCell = colorsRow[index]
            imagename = tappedCell?.tvImage ?? ""
            moviename = tappedCell?.title ?? ""
            movietype = tappedCell?.source ?? ""
            livetvid = tappedCell?.liveTvID ?? ""
            Isfavourite = tappedCell?.isFavourite ?? "0"
                    
            getcontentauthorised()
            
        }
    }
    func getcontentauthorised()
    {
         let storyBoard: UIStoryboard = UIStoryboard(name: "Main", bundle: nil)
         let secondViewController =  storyBoard.instantiateViewController(withIdentifier: "LiveTvDetailsVC") as! LiveTvDetailsVC
          secondViewController.imagename = self.imagename
          secondViewController.moviename = self.moviename
          secondViewController.movietype = self.movietype
          secondViewController.timereleasedate = self.timereleasedate
          secondViewController.language = self.language
          secondViewController.perma = self.perma
          secondViewController.Movcategory = self.Movcategory
          secondViewController.MovSubcategory = self.MovSubcategory
          secondViewController.movieuniqid = self.movieuniqid
          secondViewController.Isfavourite = self.Isfavourite
          secondViewController.livetvid = self.livetvid
          secondViewController.livetvCategoryid = self.livetvcategoryid
        self.present(secondViewController, animated: true)
    }
    
    
       
       }
