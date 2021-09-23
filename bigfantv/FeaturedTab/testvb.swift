//
//  testvb.swift
//  bigfantv
//
//  Created by Ganesh on 29/10/20.
//  Copyright © 2020 Ganesh. All rights reserved.
//

import UIKit
import FSPagerView
import MaterialComponents.MaterialDialogs
import AVKit
import SDWebImage
class testvb: UIViewController, UITableViewDelegate, UITableViewDataSource,FSPagerViewDataSource,FSPagerViewDelegate,UIPopoverPresentationControllerDelegate {
//
    //FSPagerview
    
    fileprivate var imageNames = [String]()
    fileprivate let pageControlStyles = ["Default", "Ring", "UIImage", "UIBezierPath - Star", "UIBezierPath - Heart"]
    fileprivate let pageControlAlignments = ["Right", "Center", "Left"]
    fileprivate let sectionTitles = ["Style", "Item Spacing", "Interitem Spacing", "Horizontal Alignment"]
    
    fileprivate var styleIndex = 0 {
        didSet {
            // Clean up
            self.pageControl.setStrokeColor(nil, for: .normal)
            self.pageControl.setStrokeColor(nil, for: .selected)
            self.pageControl.setFillColor(nil, for: .normal)
            self.pageControl.setFillColor(nil, for: .selected)
            self.pageControl.setImage(nil, for: .normal)
            self.pageControl.setImage(nil, for: .selected)
            self.pageControl.setPath(nil, for: .normal)
            self.pageControl.setPath(nil, for: .selected)
            switch self.styleIndex {
            case 0:
                // Default
                break
            case 1:
                // Ring
                self.pageControl.setStrokeColor(.green, for: .normal)
                self.pageControl.setStrokeColor(.green, for: .selected)
                self.pageControl.setFillColor(.green, for: .selected)
            case 2:
                // Image
                self.pageControl.setImage(UIImage(named:"icon_footprint"), for: .normal)
                self.pageControl.setImage(UIImage(named:"icon_cat"), for: .selected)
            
            default:
                break
            }
        }
    }
    fileprivate var alignmentIndex = 1 {
        didSet {
            self.pageControl.contentHorizontalAlignment = [.right,.center,.left][self.alignmentIndex]
        }
    }
    
    // ⭐️
    
    @IBOutlet weak var pagerView: FSPagerView! {
        didSet {
            self.pagerView.register(FSPagerViewCell.self, forCellWithReuseIdentifier: "cell")
           self.pagerView.automaticSlidingInterval = 2.0
//           self.pagerView.delegate = self
//            self.pagerView.dataSource = self
               self.typeIndex = 1
            
        }
    }
    fileprivate let transformerTypes: [FSPagerViewTransformerType] = [.crossFading,
                                                                      .zoomOut,
                                                                      .depth,
                                                                      .linear,
                                                                      .overlap,
                                                                      .ferrisWheel,
                                                                      .invertedFerrisWheel,
                                                                      .coverFlow,
                                                                      .cubic]
    fileprivate var typeIndex = 0 {
        didSet {
            let type = self.transformerTypes[typeIndex]
            self.pagerView.transformer = FSPagerViewTransformer(type:type)
            switch type {
            case .crossFading, .zoomOut, .depth:
                self.pagerView.itemSize = FSPagerView.automaticSize
                self.pagerView.decelerationDistance = 1
            case .linear, .overlap:
                let transform = CGAffineTransform(scaleX: 0.6, y: 0.75)
                self.pagerView.itemSize = self.pagerView.frame.size.applying(transform)
                self.pagerView.decelerationDistance = FSPagerView.automaticDistance
            case .ferrisWheel, .invertedFerrisWheel:
                self.pagerView.itemSize = CGSize(width: 180, height: 140)
                self.pagerView.decelerationDistance = FSPagerView.automaticDistance
            case .coverFlow:
                self.pagerView.itemSize = CGSize(width: 220, height: 170)
                self.pagerView.decelerationDistance = FSPagerView.automaticDistance
            case .cubic:
                let transform = CGAffineTransform(scaleX: 0.9, y: 0.9)
                self.pagerView.itemSize = self.pagerView.frame.size.applying(transform)
                self.pagerView.decelerationDistance = 1
            }
        }
    }
    
    @IBOutlet weak var pageControl: FSPageControl! {
        didSet {
            self.pageControl.numberOfPages = self.imageNames.count
           self.pageControl.backgroundColor = .clear
            self.pageControl.contentHorizontalAlignment = .center
            self.pageControl.contentInsets = UIEdgeInsets(top: 0, left: 20, bottom: 0, right: 20)
            self.pageControl.hidesForSinglePage = true
        }
    }
    
    // MARK:- UITableViewDataSource
    
    

    // MARK:- FSPagerViewDataSource
    
    func numberOfItems(in pagerView: FSPagerView) -> Int {
        return self.imageNames.count
    }
    
    public func pagerView(_ pagerView: FSPagerView, cellForItemAt index: Int) -> FSPagerViewCell {
        let cell = pagerView.dequeueReusableCell(withReuseIdentifier: "cell", at: index)
             cell.imageView?.sd_setImage(with: URL(string: imageNames[index]), completed: nil)
                // cell.imageView?.image = UIImage(named: imageNames[index])
        cell.imageView?.contentMode = .scaleAspectFill
       
        return cell
        
    }
    func pagerView(_ pagerView: FSPagerView, didSelectItemAt index: Int) {
           pagerView.deselectItem(at: index, animated: true)
           pagerView.scrollToItem(at: index, animated: true)
       }
       
       func pagerViewWillEndDragging(_ pagerView: FSPagerView, targetIndex: Int) {
           self.pageControl.currentPage = targetIndex
       }
       
       func pagerViewDidEndScrollAnimation(_ pagerView: FSPagerView) {
           self.pageControl.currentPage = pagerView.currentIndex
       }

   
     private var Bannerdata:BannerList?
       var newFeaturedList:FeaturedData?
     var tappedCell:FeaturedDatadetails?
     var featuredarray:FeaturedData?
    
    var filterPlayers : [AVPlayer?] = []
    var currentPage: Int = 0
    var filterScrollView : UIScrollView?
    var player: AVPlayer?
    var playerController : AVPlayerViewController?
    var avPlayerLayer : AVPlayerLayer!
    
    @IBOutlet var Vinew: UIView!

    
    var feature1 = [
    "titleimage":"mirchi1","isimage":"0","videourl":"https://d73o4i22vgk5h.cloudfront.net/45921/RawVideo/uploads/videobanner/21/breaking_news_intro_maker_featuring_an_animated_logo_729.mp4"]
        
        var feature2 = ["titleimage":"azad1","isimage":"0","videourl":"https://d73o4i22vgk5h.cloudfront.net/45921/RawVideo/uploads/videobanner/21/intro_maker_with_a_logo_reveal_in_a_magical_girly_animation_2266.mp4"]
        var feature3 = ["titleimage":"azad1","isimage":"0","videourl":"https://d73o4i22vgk5h.cloudfront.net/45921/RawVideo/uploads/videobanner/21/breaking_news_intro_maker_featuring_an_animated_logo_729.mp4"]
        var feature4 = ["titleimage":"azad1","isimage":"0","videourl":"https://d73o4i22vgk5h.cloudfront.net/45921/RawVideo/uploads/videobanner/21/breaking_news_intro_maker_featuring_an_animated_logo_729.mp4"]
  
    var muted = false
    var banerdata = [Dictionary<String,String>]()
    @IBOutlet var scrollView: UIScrollView!
    
    @IBOutlet var tableView: UITableView!
    @IBOutlet var headerView: UIView!
    @IBOutlet weak var tableViewHeight: NSLayoutConstraint!
    @IBOutlet var Btwatch: UIButton!
    @IBOutlet var vired: UIView!
    private var ThrillerMoviedata:newFilteredComedyMovieList?
    
    private var ForyouCollectiondata:FavouriteList?
     private var WatchhistoryListdata:WatchhistoryList?
    
    @IBOutlet var ViHide: UIView!
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
       var Isfavourite = 0
       var WatchDuration = 0
     private var authorizeddata:Authorizescontent?
    
    var featuredsd = [FeaturedDataList]()
    @IBOutlet var Visubscribe: UIView!
    override func viewDidLoad() {
    super.viewDidLoad()
        
      if Connectivity.isConnectedToInternet()
      {
        Getimagelist()
      }else
      {
        Utility.Internetconnection(vc: self)
      }
     //  banerdata = [feature1,feature2]
        
    //           NotificationCenter.default.addObserver(self, selector: #selector(playerItemDidReachEnd), name: NSNotification.Name.AVPlayerItemDidPlayToEndTime, object: nil)
           
    
    }
     override func viewWillAppear(_ animated: Bool)
     {
         if UserDefaults.standard.bool(forKey: "isSubscribed") == true
        {
             Visubscribe.isHidden = true
        }else if UserDefaults.standard.bool(forKey: "isSubscribed") == false
        {
            Visubscribe.isHidden = false
        }

     }
    override func viewDidAppear(_ animated: Bool) {
           
       
        let cellNib = UINib(nibName: "TableViewCell", bundle: nil)
        self.tableView.register(cellNib, forCellReuseIdentifier: "tableviewcellid")

        tableView.backgroundColor = Appcolor.backgorund3
        tableView.isScrollEnabled = false
        tableView.allowsMultipleSelection = true
        scrollView.delegate = self
        if Connectivity.isConnectedToInternet()
                   {
              
                   GetFeatureddata()
                    
                   }else
                   {
                       Utility.Internetconnection(vc: self)
                   }
       
    }
    override func viewWillDisappear(_ animated: Bool)
    {
       
        if filterPlayers.count > 0
        {
            for i in 0...filterPlayers.count - 1
            {
                if i == currentPage
                {
                    (filterPlayers[i])!.isMuted = true
                    
                }else
                {
                     (filterPlayers[i])!.isMuted = true
                }
                }
                          }
        }
     
         func Getimagelist()
       {
           Api.GetBanners(ApiEndPoints.GetBannerSectionList, vc: self) { (res, err) -> (Void) in
                  do
                  {
                      let decoder = JSONDecoder()
                      self.Bannerdata = try decoder.decode(BannerList.self, from: res  ?? Data())
                   for i in self.Bannerdata?.subComedymovList ?? [BannerListdeatails]()
                      {
                        if i.banner_type == "1"
                        {
                            let feature12 = [  "titleimage":"\(i.mobile_view ?? "")","isimage":"1","videourl":"https://d73o4i22vgk5h.cloudfront.net/45921/RawVideo/uploads/videobanner/21/breaking_news_intro_maker_featuring_an_animated_logo_729.mp4"]
                            self.banerdata.append(feature12)
                           self.imageNames.append(i.mobile_view ?? "")
                        }else if i.banner_type == "0"
                        {
                            let feature12 = [  "titleimage":"https://user-images.githubusercontent.com/1282364/37314715-9a60a95a-2623-11e8-93d8-6a9e8eec6a08.png","isimage":"0","videourl":i.video_remote_url ?? ""]
                            self.banerdata.append(feature12)
                             
                            self.imageNames.append(i.video_placeholder_img ?? "")
                        }
                        
                      
                   }
                   // self.setupFilterWith(size: self.Vinew!.bounds.size)
                     
                  }
                  catch let error
                  {
                      Utility.showAlert(vc: self, message:"\(error)", titelstring: Appcommon.Appname)
                  }
              }
    
        }
    func GetFeatureddata()
        {
            Api.Getfeatureddata(ApiEndPoints.loadFeaturedSections, vc: self, offset: 10) { (res, err) -> (Void) in
                   do
                   {
                    
                       let decoder = JSONDecoder()
                       self.featuredarray = try decoder.decode(FeaturedData.self, from: res  ?? Data())
                    
                  
                    
                    self.featuredsd.removeAll()
                    for il in self.featuredarray?.subComedymovList ?? [FeaturedDataList]()
                    {
                       
                        if il.contents?.count ?? 0 > 0
                        {
                          
                           // let f = FeaturedDataList(title: il.title, contents: il.contents)
                            //self.featuredsd.append(f)
                        }
                        
                    }
                    self.newFeaturedList = FeaturedData(code: 200, status: "OK", subComedymovList: self.featuredsd )
                    
                    DispatchQueue.main.async {
                        print(self.newFeaturedList?.subComedymovList?.count ?? "")
                                           self.tableView.delegate = self
                                           self.tableView.dataSource = self
                                           self.tableView.reloadData()
                    }
                   }
                    catch let error
                    {
                        Utility.showAlert(vc: self, message:"\(error)", titelstring: Appcommon.Appname)
                          
                   }
                      }
            
            /*
            
                    Api.GetWatchhistory(ApiEndPoints.watchhistory, vc: self)  { (res, err) -> (Void) in
                        do
                        {
                            let decoder = JSONDecoder()
                            self.WatchhistoryListdata = try decoder.decode(WatchhistoryList.self, from: res  ?? Data())
                          
                            var data1 = [FeaturedDatadetails]()
                           for i in self.WatchhistoryListdata?.subComedymovList ?? [Watchhistorydeatails]()
                           {
                               let data =   FeaturedDatadetails(title: i.title, poster: i.poster, movie_uniq_id: i.movie_uniq_id, c_permalink: i.c_permalink, custom: i.custom, is_fav_status: i.is_fav_status, watch_duration_in_seconds: i.watch_duration_in_seconds)
                               data1.append(data)
                           }
                           
                            
                               let dat = FeaturedDataList(title: "Watch History", contents: data1)
                           self.featuredarray?.subComedymovList?.append(dat)
                         
                        }
                        catch let error
                        {
                            Utility.showAlert(vc: self, message:"\(error)", titelstring: Appcommon.Appname)
                        }
                    }
                    Api.Viewfavourite(UserDefaults.standard.string(forKey: "id") ?? "", endpoint: ApiEndPoints.ViewFavourite, vc: self)  { (res, err) -> (Void) in
                                           do
                                           {
                                               let decoder = JSONDecoder()
                                               self.ForyouCollectiondata = try decoder.decode(FavouriteList.self, from: res  ?? Data())
                                             
                                               var data1 = [FeaturedDatadetails]()
                                              for i in self.ForyouCollectiondata?.subComedymovList ?? [SubFavouriteList]()
                                              {
                                                  let data =   FeaturedDatadetails(title: i.title, poster: i.poster, movie_uniq_id: i.movie_uniq_id, c_permalink: "", custom: nil, is_fav_status: i.is_fav_status, watch_duration_in_seconds: 0)
                                                  data1.append(data)
                                              }
                                              
                                               
                                                  let dat = FeaturedDataList(title: "Favorites", contents: data1)
                                              self.featuredarray?.subComedymovList?.append(dat)
                                            
                                           }
                                           catch let error
                                           {
                                               Utility.showAlert(vc: self, message:"\(error)", titelstring: Appcommon.Appname)
                                           }
                                       }
                    
                  
            
                    Api.Getconent1("movies", subCat: "romance", endpoint: ApiEndPoints.getFilteredContent, vc: self, offset: 1) { (res, err) -> (Void) in
                                                   do
                                                   {
                                                       let decoder = JSONDecoder()
                                                       self.ThrillerMoviedata = try decoder.decode(newFilteredComedyMovieList.self, from: res  ?? Data())
                                                      var data1 = [FeaturedDatadetails]()
                                                      for i in self.ThrillerMoviedata?.subComedymovList ?? [newFilteredSubComedymovieList]()
                                                      {
                                                          let data =   FeaturedDatadetails(title: i.title, poster: i.poster, movie_uniq_id: i.movie_uniq_id, c_permalink: i.c_permalink, custom: i.custom, is_fav_status: i.is_fav_status, watch_duration_in_seconds: i.watch_duration_in_seconds)
                                                          data1.append(data)
                                                      }
                                                      
                                                       
                                                          let dat = FeaturedDataList(title: "Romance", contents: data1)
                                                      self.featuredarray?.subComedymovList?.append(dat)
                                                     
                                                      
                                                   }
                                                   catch let error
                                                   {
                                                       Utility.showAlert(vc: self, message:"\(error)", titelstring: Appcommon.Appname)
                                                   }
                                               }
                    Api.Getconent1("movies", subCat: "horror", endpoint: ApiEndPoints.getFilteredContent, vc: self, offset: 1) { (res, err) -> (Void) in
                                                   do
                                                   {
                                                       let decoder = JSONDecoder()
                                                       self.ThrillerMoviedata = try decoder.decode(newFilteredComedyMovieList.self, from: res  ?? Data())
                                                      var data1 = [FeaturedDatadetails]()
                                                      for i in self.ThrillerMoviedata?.subComedymovList ?? [newFilteredSubComedymovieList]()
                                                      {
                                                          let data =   FeaturedDatadetails(title: i.title, poster: i.poster, movie_uniq_id: i.movie_uniq_id, c_permalink: i.c_permalink, custom: i.custom, is_fav_status: i.is_fav_status, watch_duration_in_seconds: i.watch_duration_in_seconds)
                                                          data1.append(data)
                                                      }
                                                      
                                                       
                                                          let dat = FeaturedDataList(title: "Horror", contents: data1)
                                                      self.featuredarray?.subComedymovList?.append(dat)
                                                     
                                                   }
                                                   catch let error
                                                   {
                                                       Utility.showAlert(vc: self, message:"\(error)", titelstring: Appcommon.Appname)
                                                   }
                                               }
                    
                    
                            Api.Getconent1("movies", subCat: "adventure", endpoint: ApiEndPoints.getFilteredContent, vc: self, offset: 1) { (res, err) -> (Void) in
                                            do
                                            {
                                                let decoder = JSONDecoder()
                                                self.ThrillerMoviedata = try decoder.decode(newFilteredComedyMovieList.self, from: res  ?? Data())
                                               var data1 = [FeaturedDatadetails]()
                                               for i in self.ThrillerMoviedata?.subComedymovList ?? [newFilteredSubComedymovieList]()
                                               {
                                                   let data =   FeaturedDatadetails(title: i.title, poster: i.poster, movie_uniq_id: i.movie_uniq_id, c_permalink: i.c_permalink, custom: i.custom, is_fav_status: i.is_fav_status, watch_duration_in_seconds: i.watch_duration_in_seconds)
                                                   data1.append(data)
                                               }
                                               
                                                
                                                   let dat = FeaturedDataList(title: "Adventure", contents: data1)
                                               self.featuredarray?.subComedymovList?.append(dat)
                                           
                                            }
                                            catch let error
                                            {
                                                Utility.showAlert(vc: self, message:"\(error)", titelstring: Appcommon.Appname)
                                            }
                                        }
                    
                    
                             Api.Getconent1("movies", subCat: "fantasy", endpoint: ApiEndPoints.getFilteredContent, vc: self, offset: 1) { (res, err) -> (Void) in
                                             do
                                             {
                                                 let decoder = JSONDecoder()
                                                 self.ThrillerMoviedata = try decoder.decode(newFilteredComedyMovieList.self, from: res  ?? Data())
                                                var data1 = [FeaturedDatadetails]()
                                                for i in self.ThrillerMoviedata?.subComedymovList ?? [newFilteredSubComedymovieList]()
                                                {
                                                    let data =   FeaturedDatadetails(title: i.title, poster: i.poster, movie_uniq_id: i.movie_uniq_id, c_permalink: i.c_permalink, custom: i.custom, is_fav_status: i.is_fav_status, watch_duration_in_seconds: i.watch_duration_in_seconds)
                                                    data1.append(data)
                                                }
                                                
                                                 
                                                    let dat = FeaturedDataList(title: "Fantasy", contents: data1)
                                                self.featuredarray?.subComedymovList?.append(dat)
                                               
                                             }
                                             catch let error
                                             {
                                                 Utility.showAlert(vc: self, message:"\(error)", titelstring: Appcommon.Appname)
                                             }
                                         }
                    Api.Getconent1("movies", subCat: "action", endpoint: ApiEndPoints.getFilteredContent, vc: self, offset: 1) { (res, err) -> (Void) in
                                                    do
                                                    {
                                                        let decoder = JSONDecoder()
                                                        self.ThrillerMoviedata = try decoder.decode(newFilteredComedyMovieList.self, from: res  ?? Data())
                                                       var data1 = [FeaturedDatadetails]()
                                                       for i in self.ThrillerMoviedata?.subComedymovList ?? [newFilteredSubComedymovieList]()
                                                       {
                                                           let data =   FeaturedDatadetails(title: i.title, poster: i.poster, movie_uniq_id: i.movie_uniq_id, c_permalink: i.c_permalink, custom: i.custom, is_fav_status: i.is_fav_status, watch_duration_in_seconds: i.watch_duration_in_seconds)
                                                           data1.append(data)
                                                       }
                                                       
                                                        
                                                           let dat = FeaturedDataList(title: "Action", contents: data1)
                                                       self.featuredarray?.subComedymovList?.append(dat)
                                                       
                                                    }
                                                    catch let error
                                                    {
                                                        Utility.showAlert(vc: self, message:"\(error)", titelstring: Appcommon.Appname)
                                                    }
                                                }
                    Api.Getconent1("movies", subCat: "mystery", endpoint: ApiEndPoints.getFilteredContent, vc: self, offset: 1) { (res, err) -> (Void) in
                                                do
                                                {
                                                    let decoder = JSONDecoder()
                                                    self.ThrillerMoviedata = try decoder.decode(newFilteredComedyMovieList.self, from: res  ?? Data())
                                                   var data1 = [FeaturedDatadetails]()
                                                   for i in self.ThrillerMoviedata?.subComedymovList ?? [newFilteredSubComedymovieList]()
                                                   {
                                                       let data =   FeaturedDatadetails(title: i.title, poster: i.poster, movie_uniq_id: i.movie_uniq_id, c_permalink: i.c_permalink, custom: i.custom, is_fav_status: i.is_fav_status, watch_duration_in_seconds: i.watch_duration_in_seconds)
                                                       data1.append(data)
                                                   }
                                                   
                                                    
                                                       let dat = FeaturedDataList(title: "Mystery", contents: data1)
                                                   self.featuredarray?.subComedymovList?.append(dat)
                                                   
                                                }
                                                catch let error
                                                {
                                                    Utility.showAlert(vc: self, message:"\(error)", titelstring: Appcommon.Appname)
                                                }
                                            }
                    
                        Api.Getconent1("movies", subCat: "sci-fi", endpoint: ApiEndPoints.getFilteredContent, vc: self, offset: 1) { (res, err) -> (Void) in
                                        do
                                        {
                                            let decoder = JSONDecoder()
                                            self.ThrillerMoviedata = try decoder.decode(newFilteredComedyMovieList.self, from: res  ?? Data())
                                           var data1 = [FeaturedDatadetails]()
                                           for i in self.ThrillerMoviedata?.subComedymovList ?? [newFilteredSubComedymovieList]()
                                           {
                                               let data =   FeaturedDatadetails(title: i.title, poster: i.poster, movie_uniq_id: i.movie_uniq_id, c_permalink: i.c_permalink, custom: i.custom, is_fav_status: i.is_fav_status, watch_duration_in_seconds: i.watch_duration_in_seconds)
                                               data1.append(data)
                                           }
                                           
                                            
                              let dat = FeaturedDataList(title: "Sci-fi", contents: data1)
                                self.featuredarray?.subComedymovList?.append(dat)
                                      
                                            self.tableView.reloadData()
                                        } catch let error
                                        {
                                            Utility.showAlert(vc: self, message:"\(error)", titelstring: Appcommon.Appname)
                                            
                            }
                                    
            }
            */
            
            
           /*
                    guard let cell = self.newFeaturedList?.subComedymovList?.count else {return}
                    print("cell=\(cell)")
                   var finalHeight = CGFloat()
                    for i in 0..<cell
                   {
                    let row = 1
                       let tableFinalHeight = (140 * row) + 50
                       finalHeight = finalHeight + CGFloat(tableFinalHeight)
                   }
            */
                      //self.tableViewHeight.constant = finalHeight
               
                       
                    
                 
                      
                      
               
    }
   
         override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
                  
                  
                             if segue.identifier == "todetails"
                             {
                              guard let navController = segue.destination as? UINavigationController,
                                  let displayVC = navController.topViewController as? testdetaisVC else {
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
                                      
                              
                             }
           }
          
    
    @IBAction func BtSubscribetapped(_ sender: UIButton) {
        self.performSegue(withIdentifier: "tosubscribe", sender: self)
    }
    func numberOfSections(in tableView: UITableView) -> Int {
               return newFeaturedList?.subComedymovList?.count ?? 0
           }
           
           func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
               return 1
           }
           
           func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
            return   160
           }
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
             let headerView = UIView()
             headerView.backgroundColor = Appcolor.backgorund3
             
             let whiteview = UIView(frame: CGRect(x: 10, y: 14, width: 4, height: 16))
                 whiteview.backgroundColor = UIColor.white
              headerView.addSubview(whiteview)
             
        let button = UIButton(frame: CGRect(x: self.tableView.frame.size.width - 24, y: 10, width: 24, height: 24))
             button.setBackgroundImage(UIImage(named: "viewall"), for: .normal)
             headerView.addSubview(button)
             
             let titleLabel = UILabel(frame: CGRect(x: 24, y: 0, width: 200, height: 44))
             headerView.addSubview(titleLabel)
             titleLabel.textColor = UIColor.white
             titleLabel.font =  UIFont(name: "Muli-SemiBold", size: 17)!
             titleLabel.text = newFeaturedList?.subComedymovList?[section].title
             return headerView
         }
         
         func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
             return 44
         }
  func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
             if let cell = tableView.dequeueReusableCell(withIdentifier: "tableviewcellid", for: indexPath) as? TableViewCell {
                 // Show SubCategory Title
             //    let subCategoryTitle = colorsArray.objectsArray[indexPath.section].subcategory
              //   cell.subCategoryLabel.text = subCategoryTitle[indexPath.row]

                 // Pass the data to colletionview inside the tableviewcell
                // let rowArray = (newFeaturedList?.subComedymovList?[indexPath.section].contents)!
                // cell.updateCellWith(row: rowArray)

                 // Set cell's delegate
                // cell.cellDelegate = self
                 
                 cell.selectionStyle = .none
                 return cell
            }
             return UITableViewCell()
         }

   
}
 /*
extension testvb: CollectionViewCellDelegate {
     func collectionView(collectionviewcell: CollectionViewCell?, index: Int, didTappedInTableViewCell: TableViewCell) {
         if let colorsRow = didTappedInTableViewCell.rowWithColors {
             self.tappedCell = colorsRow[index]
             imagename = tappedCell?.poster ?? ""
            moviename = tappedCell?.title ?? ""
            movietype = tappedCell?.poster ?? ""
      
            
            movdescription = tappedCell?.poster ?? ""
            imdbId = tappedCell?.custom?.customimdb?.field_value ?? ""
            movieuniqid = tappedCell?.movie_uniq_id ?? ""
             perma = tappedCell?.c_permalink ?? ""
                  Isfavourite = tappedCell?.is_fav_status ?? 0
             WatchDuration = tappedCell?.watch_duration_in_seconds ?? 0
            getcontentauthorised(movieid: tappedCell?.movie_uniq_id ?? "")
             // performSegue(withIdentifier: "todetails", sender: self)
             // You can also do changes to the cell you tapped using the 'collectionviewcell'
         }
     }
    func getcontentauthorised(movieid:String)
    {
        
        Api.IsContentAuthorised(movieid, endpoint: ApiEndPoints.isContentAuthorized, vc: self) { (res, err) -> (Void) in
                             do
                             {
                                 let decoder = JSONDecoder()
                                 self.authorizeddata = try decoder.decode(Authorizescontent.self, from: res  ?? Data())
                                
                                if self.authorizeddata?.status == "OK"
                                {
                                    self.performSegue(withIdentifier: "todetails", sender: self)
                                }
                                else
                                {
                                    
                                    let alertController = MDCAlertController(title: "BigFan TV", message:  "Subscribe to a plan to view this content")
                                           let action = MDCAlertAction(title:"OK")
                                           { (action) in
                                               self.performSegue(withIdentifier: "tosubscribe", sender: self)
                                           }
                                    let cancelaction = MDCAlertAction(title:"Cancel")
                                    { (cancelaction) in
                                         
                                    }
                                    alertController.addAction(action)
                                    alertController.addAction(cancelaction)
                                  self.present(alertController, animated: true, completion: nil)
                                   // self.performSegue(withIdentifier: "tomoviedetails", sender: self)
                                       
                                }
                             }
                             catch let error
                             {
                                 Utility.showAlert(vc: self, message:"\(error)", titelstring: Appcommon.Appname)
                             }
                         }
    }
 }

extension testvb: UIScrollViewDelegate {
     
    func setupFilterWith(size: CGSize)  {
        currentPage = 0
        filterPlayers.removeAll()
        filterScrollView = UIScrollView(frame: Vinew.bounds)
        
        let count = banerdata.count
        if count > 0
        {
        for i in 0...count-1 {
            //Adding image to scroll view
            let imgView : UIView = UIView.init(frame: CGRect(x: CGFloat(i) * size.width, y: 0, width: size.width, height: size.height))
            let imgViewThumbnail: UIImageView = UIImageView.init(frame: imgView.bounds)
            
            //imgView.image =
            imgView.backgroundColor = .clear
            imgViewThumbnail.contentMode = .scaleAspectFit
            imgView.addSubview(imgViewThumbnail)
            
           
           // imgView.bringSubviewToFront(imgView)
            if let url:URL = URL(string: banerdata[i]["titleimage"] ?? "")
            {
               imgViewThumbnail.sd_setImage(with: url, completed: nil)
            }
            
            filterScrollView?.addSubview(imgView)
           
            
            //For Multiple player
            
            let player = AVPlayer(url: URL(string: banerdata[i]["videourl"] ?? "")!)
             let avPlayerLayer = AVPlayerLayer(player: player)
             avPlayerLayer.videoGravity = .resizeAspect
             avPlayerLayer.masksToBounds = true
             avPlayerLayer.cornerRadius = 5
             avPlayerLayer.frame = imgView.layer.bounds
             player.isMuted = true
             imgView.layer.addSublayer(avPlayerLayer)
           
            let button = UIButton(frame: CGRect(x: 30, y: self.Vinew.frame.size.height - 30, width: 20, height: 20))
                      // button.setTitle("mute", for: .normal)
                       button.setBackgroundImage(UIImage(named: "unmute"), for: .normal)
                       button.setTitleColor(.red, for: .normal)
                       button.tag = i
                       button.addTarget(self, action: #selector(mutevideo(_:)), for: .touchUpInside)
                       
                        imgView.addSubview(button)
            
            if banerdata[i]["isimage"] == "1"
            {
                button.isHidden = true
                avPlayerLayer.isHidden = true
                imgView.superview?.bringSubviewToFront(imgViewThumbnail)
            }else if banerdata[i]["isimage"] == "0"
            {
                 button.isHidden = false
                avPlayerLayer.isHidden = false
                imgView.superview?.sendSubviewToBack(imgViewThumbnail)
            }
            
                       imgView.superview?.bringSubviewToFront(button)
             filterPlayers.append(player)
            
        }
      
        filterScrollView?.isPagingEnabled = true
        filterScrollView?.contentSize = CGSize.init(width: CGFloat(banerdata.count) * size.width, height: size.height)
        filterScrollView?.backgroundColor = Appcolor.backgorund3
        filterScrollView?.delegate = self
        Vinew.addSubview(filterScrollView!)
         
        playVideos()
        }
    }
    @objc func mutevideo( _ sender:UIButton)
    {
        for i in 0...filterPlayers.count - 1 {
                           if i == currentPage
                           {
                            if (filterPlayers[i])!.isMuted == true
                            {
                                sender.setBackgroundImage(UIImage(named: "unmute"), for: .normal)
                                (filterPlayers[i])!.isMuted = false
                            }else
                            {
                                sender.setBackgroundImage(UIImage(named: "mute"), for: .normal)
                                (filterPlayers[i])!.isMuted = true
                            }
                               
                                
                           }
                       }
    }
    func getThumbnailImage(forUrl url: URL) -> UIImage? {
        let asset: AVAsset = AVAsset(url: url)
        let imageGenerator = AVAssetImageGenerator(asset: asset)
        imageGenerator.appliesPreferredTrackTransform = true
        
        do {
            let thumbnailImage = try imageGenerator.copyCGImage(at: CMTimeMake(value: 1, timescale: 60) , actualTime: nil)
            return UIImage(cgImage: thumbnailImage)
        } catch let error {
            print(error)
        }
        
        return nil
    }
    
    func playVideos() {
        for i in 0...filterPlayers.count - 1 {
            playVideoWithPlayer((filterPlayers[i])!)
        }

        for i in 0...filterPlayers.count - 1 {
            if i != currentPage {
                (filterPlayers[i])!.pause()
            }
        }
    }
    
    func playVideoWithPlayer(_ player: AVPlayer) {
        player.playImmediately(atRate: 1.0)
       // player.play()
    }
   
   
    func scrollViewWillBeginDragging(_ scrollView: UIScrollView) {
       
    }
    
    //For Single player
    func scrollViewDidEndDecelerating(_ scrollView: UIScrollView) {
       
    }
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        
        if scrollView == filterScrollView
        {
        let pageWidth : CGFloat = (filterScrollView?.frame.size.width)!
        let fractionalPage : Float = Float((filterScrollView?.contentOffset.x)! / pageWidth)
        let targetPage : NSInteger = lroundf(fractionalPage)
        
        if targetPage != currentPage {
            currentPage = targetPage
      
            for i in 0...filterPlayers.count - 1
            {
                if i == currentPage {
                    (filterPlayers[i])!.playImmediately(atRate: 1.0)
                } else {
                    (filterPlayers[i])!.pause()
                }
            }
        }
        }else   if scrollView == self.scrollView {
                      let offset = scrollView.contentOffset.y
                      var headerTransform = CATransform3DIdentity
                      if scrollView == self.scrollView {
                          if offset < 0 {
                              let headerScaleFactor:CGFloat = -(offset) / headerView.bounds.height
                              let headerSizevariation = ((headerView.bounds.height * (1.0 + headerScaleFactor)) - headerView.bounds.height)/2.5
                              headerTransform = CATransform3DTranslate(headerTransform, 0, headerSizevariation, 0)
                              headerTransform = CATransform3DScale(headerTransform, 1.0 + headerScaleFactor, 1.0 + headerScaleFactor, 0)
                          }else {
                              if view.frame.size.height == 812 || view.frame.size.height == 896 {
                                  headerTransform = CATransform3DTranslate(headerTransform, 0, max(-(self.headerView.frame.size.height - 85), -offset), 0)
                                  if offset > (self.headerView.frame.size.height - 85)
                                  {
                                      self.ViHide.isHidden = true
                                       self.pagerView.isHidden = true
                                      self.Vinew.isHidden = true
                                     // self.gradientImg.isHidden = true
                                  }else {
                                      self.ViHide.isHidden = false
                                       self.pagerView.isHidden = false
                                     self.Vinew.isHidden = false
                                     // self.gradientImg.isHidden = false
                                  }
                              }else {
                                  headerTransform = CATransform3DTranslate(headerTransform, 0, max(-(self.headerView.frame.size.height - 65), -offset), 0)
                                  if offset > (self.headerView.frame.size.height - 65) {
                                      self.ViHide.isHidden = true
                                      self.pagerView.isHidden = true
                                    self.Vinew.isHidden = true
                                     // self.gradientImg.isHidden = true
                                  }else {
                                      self.ViHide.isHidden = false
                                       self.pagerView.isHidden = false
                                    self.Vinew.isHidden = false
                                     // self.gradientImg.isHidden = false
                                  }
                              }
                          }
                          headerView.layer.transform = headerTransform
                      }
                  }
        
    }
    
    func playVideoWithPlayer(_ player: AVPlayer, video:AVURLAsset, filterName:String) {
        
        let  avPlayerItem = AVPlayerItem(asset: video)
        
        if (filterName != "NoFilter") {
            let avVideoComposition = AVVideoComposition(asset: video, applyingCIFiltersWithHandler: { request in
                let source = request.sourceImage.clampedToExtent()
                let filter = CIFilter(name:filterName)!
                filter.setDefaults()
                filter.setValue(source, forKey: kCIInputImageKey)
                let output = filter.outputImage!
                request.finish(with:output, context: nil)
            })
            avPlayerItem.videoComposition = avVideoComposition
        }
        
        player.replaceCurrentItem(with: avPlayerItem)
        player.playImmediately(atRate: 1.0)
    }
    
    @objc func playerItemDidReachEnd(_ notification: Notification) {
 
                for i in 0...filterPlayers.count - 1 {
                    if i == currentPage {
                         
                        (filterPlayers[i])!.seek(to: CMTime.zero)
                        (filterPlayers[i])!.playImmediately(atRate: 1.0)
                    }
                }
    }
    
 }*/
