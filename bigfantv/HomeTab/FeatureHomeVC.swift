//
//  FeatureHomeVC.swift
//  bigfantv
//
//  Created by Ganesh on 29/01/21.
//  Copyright © 2021 Ganesh. All rights reserved.
//

import UIKit
import GoogleMobileAds
import Alamofire
import CoreLocation
import AVKit
import MaterialComponents.MaterialDialogs
import PassKit
import MuviAudioPlayer
import FSPagerView
import SDWebImage
class FeatureHomeVC: UIViewController,CLLocationManagerDelegate ,UIPopoverPresentationControllerDelegate{

    @IBOutlet weak var sliderCollectionView: UICollectionView!
    @IBOutlet weak var pageView: UIPageControl!
     
    
    var timernew = Timer()
    var counter = 0
    
    //Banners
     @IBOutlet var Vinew: UIView!
    private var Bannerdata:NewBannerList?
    private var banerdata = [Dictionary<String,String>]()
    var filterPlayers : [AVPlayer?] = []
    var currentPage: Int = 0
    var filterScrollView : UIScrollView?
    var player: AVPlayer?
    var playerController : AVPlayerViewController?
    var avPlayerLayer : AVPlayerLayer!
    var timer:Timer!
    
    let manager: Alamofire.SessionManager =
    {
        let configuration = URLSessionConfiguration.default
        return  Alamofire.SessionManager(configuration: configuration)
    }()
    //Paid content
    private var  Successdata:SuccessResponse?

    @IBOutlet var MovieByRentCollectionV:UICollectionView!
    private var  MoviesbyRentdata:newFilteredComedyMovieList?

    private var authorizeddata:Authorizescontent?
    var contentdata:contentdetails?
    var PPVdata:PPVplans?
    var ppvPlanId = ""
    var MovieUniqueId = ""
    @IBOutlet var ViMoviesonRent:UIView!
   
    
    //Language
    @IBOutlet var LanguageCollectionV: UICollectionView!
    
     let imagearray =
        ["lang1","lang8", "lang11", "lang10", "lang9", "lang5", "lang7", "lang8","lang4","lang2","lang6","lang12","lang8","lang13","lang8"]
    let newarray =
        ["English","Hindi", "Punjabi", "Tamil", "Telugu", "Marathi", "Malayalam", "Bhojpuri","Gujarati","Bengali","Kannada","Odiya","Haryanvi","Urdu","Nepali"]
     let subcatearray = ["english","hindi", "punjabi4", "tamil", "telugu", "marathi", "malyalam", "bhojpuri","gujarati","bengali","kannada","odiya","haryanvi","urdu","nepali"]
    
    //Static movies
     @IBOutlet var ActionCustomV: CustomView!
     @IBOutlet var adventureCustomV: CustomView!
     @IBOutlet var fantasyCustomV: CustomView!
     @IBOutlet var romanceCustomV: CustomView!
     @IBOutlet var horrorCustomV: CustomView!
     @IBOutlet var mysteryCustomV: CustomView!
     @IBOutlet var scifiCustomV: CustomView!
     @IBOutlet var comedy1CustomV: CustomView!
     @IBOutlet var thrillerCustomV: CustomView!
    var selftitle = ""
     
    //Favourite videos
    @IBOutlet var FavCollectionV: UICollectionView!
     
    @IBOutlet var FavoritedView: UIView!
    private var passComedyMoviedata:newFilteredSubComedymovieList?
    private var  FavsMoviedata:FavouriteList?
    
    //favourted Live tv
    
    @IBOutlet var LiveTvView: UIView!
    @IBOutlet var LiveTvCollectionV: UICollectionView!
    private var favouriteLivetv:FavLiveTVData?
    
    //Appversion
    private var appversionupdate:Appversion?
    
    
    //AllRadio section
    @IBOutlet var allRadioView: UIView!

    @IBOutlet var AllRadioCollectionV: UICollectionView!
    private var AllRadiodata:FavRadiodata?
    var muviPlayer = MuviAudioMiniView()
    var managers = MuviAudioPlayerManager()
    @IBOutlet var MuviPLayerView: UIView!

    
    
    
    //Watch live
    @IBOutlet var WatchliveRadioView: UIView!

    @IBOutlet var WatchliveRadioCollectionV:UICollectionView!
    private var  WatchliveRadiodata:newFilteredComedyMovieList?

    //Podcast data
    var PodcastData:PodcastRssfeeddata?
    @IBOutlet var PodcastTableV: UITableView!
    @IBOutlet weak var podcastTableHeight: NSLayoutConstraint!
    

    //Featured Section
    
    @IBOutlet var TableV: UITableView!
    @IBOutlet var FeturesectionTableHeight: NSLayoutConstraint!
    
    var newFeaturedList:FeaturedData?
    var passarray:FeaturedDataList?
    var featuredarray:FeaturedData?
    var featuredsd = [FeaturedDataList]()
    var tappedCell:FeaturedDatadetails?
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
     var newperma = ""
     var contenttypesid  = ""
    
    //Radio
     @IBOutlet var RadioCollectionV: UICollectionView!
     @IBOutlet var RadioView: UIView!
    let cellIdentifier = "cell"
    var Radiodynamicdata:FavouriteRadioData?
    
    //Watch History
    private var WatchhistoryListdata:WatchhistoryList?
    @IBOutlet var watchHistoryCollectionV: UICollectionView!
    @IBOutlet var watchhistoryView: UIView!

    
    //Admob
     @IBOutlet var AdMobBannerview: GADBannerView!
    
    //update location
    var currentLocation: CLLocation!
    let locationManager = CLLocationManager() // create Location Manager object
    var latitude : Double?
    var longitude : Double?
    
    //Subscription
    var playerurlstr = ""

    var productsArray = [SKProduct]()
    override func viewDidLoad()
    {
        super.viewDidLoad()
       
        
        //AdMob
        AdMobBannerview.adUnitID = "ca-app-pub-1674419588268922/4399319289"
        AdMobBannerview.rootViewController = self
        AdMobBannerview.load(GADRequest())
        AdMobBannerview.delegate = self
       
    
        
        //Language
       self.LanguageCollectionV.register(UINib(nibName:"LnagCellFeatured", bundle:nil), forCellWithReuseIdentifier: cellIdentifier)
          
       // UserDefaults.standard.set("\(32.779167)", forKey: "Latitude")
      // UserDefaults.standard.set("\(-96.808891)",class forKey: "Longitude")
        //Get current location
 
       self.locationManager.requestAlwaysAuthorization()

       // For use in foreground
       // You will need to update your .plist file to request the authorization
       self.locationManager.requestWhenInUseAuthorization()

       if CLLocationManager.locationServicesEnabled()
       {
           locationManager.delegate = self      
           locationManager.desiredAccuracy = kCLLocationAccuracyNearestTenMeters
           locationManager.startUpdatingLocation()
       }


        //Featured section
        let cellNib = UINib(nibName: "TableViewCell", bundle: nil)
         self.TableV.register(cellNib, forCellReuseIdentifier: "tableviewcellid")

         TableV.backgroundColor = Appcolor.backgorund4
         TableV.estimatedRowHeight = 160
    
        // tableView?.isScrollEnabled = false
         TableV.allowsMultipleSelection = true
        
        //podcast section
        let podcellNib = UINib(nibName: "HomepodcastTableViewCell", bundle: nil)
         self.PodcastTableV.register(podcellNib, forCellReuseIdentifier: "tableviewcellid")

        PodcastTableV.backgroundColor = Appcolor.backgorund4
        PodcastTableV.estimatedRowHeight = 160
    
        // tableView?.isScrollEnabled = false
        PodcastTableV.allowsMultipleSelection = true
        
        //Load data
        if Connectivity.isConnectedToInternet()
        {
            self.Getimagelist() // Loads banners
            self.MoviesByrent()  //Loads movies by rent
            self.GetFeatureddata() //Loads fetured section data
            // self.Loaddata() //Loads Static movies
            self.ShowalertForUpdate() //Update version
            self.GetAllradios() //Loads all radios
            self.Getwatchliveradio() //Loads watch live radio
            self.Loadallpodcastdata() //Loads all podcasts
            self.LoadwatchHistory() // Loads watch history
            
        }else
        {
            Utility.Internetconnection(vc: self)
        }
        
    }
    override func viewWillAppear(_ animated: Bool)
    {
        //Hide Ads for subscribed users
        
        //Hide favrite and wathc history for non logged users
        if UserDefaults.standard.bool(forKey: "isLoggedin") != true
        {
            self.FavoritedView.isHidden = true
            self.watchhistoryView.isHidden = true
        }
        //Load data
        if Connectivity.isConnectedToInternet()
        {
            // self.LoadfavouritedRadios() //Loads every time to refresh the favourited radio list
             self.LoadfavouritedLivetv() //Loads favourited Livetv
             self.GetFavoritedvideoslist() //Loads favorited videos
        }else
        {
            Utility.Internetconnection(vc: self)
        }
        MuviAudioPlayerManager.shared.playbackDelegate = self

    }
    
    override func viewDidAppear(_ animated: Bool) {
        
        let sliderflowLayout = UICollectionViewFlowLayout()
        sliderflowLayout.scrollDirection = .horizontal
        let size = sliderCollectionView.frame.size
        sliderflowLayout.itemSize = CGSize(width: size.width, height: size.height)
        sliderflowLayout.minimumLineSpacing = 0
        sliderflowLayout.minimumInteritemSpacing = 0
         sliderCollectionView.collectionViewLayout = sliderflowLayout
        sliderCollectionView.showsHorizontalScrollIndicator = false
        
         //RadioCell
         self.RadioCollectionV.register(UINib(nibName:"LnagCellFeatured", bundle:nil), forCellWithReuseIdentifier: cellIdentifier)
         let flowLayout = UICollectionViewFlowLayout()
          flowLayout.scrollDirection = .horizontal
          flowLayout.itemSize = CGSize(width: RadioCollectionV.frame.size.height, height: RadioCollectionV.frame.size.height)
          flowLayout.minimumLineSpacing = 4
          flowLayout.minimumInteritemSpacing = 4
          RadioCollectionV.collectionViewLayout = flowLayout
          RadioCollectionV.showsHorizontalScrollIndicator = false
        
        
        //MoviesByRent
        let FavCollectionVflowLayout = UICollectionViewFlowLayout()
            FavCollectionVflowLayout.scrollDirection = .horizontal
        let width = (FavCollectionV.frame.size.height * 280)/156
          
        FavCollectionVflowLayout.itemSize = CGSize(width: width, height: FavCollectionV.frame.size.height)
        FavCollectionVflowLayout.minimumLineSpacing = 10
        FavCollectionVflowLayout.minimumInteritemSpacing = 10.0
        FavCollectionV.collectionViewLayout = FavCollectionVflowLayout
        FavCollectionV.showsHorizontalScrollIndicator = false
        FavCollectionV.register(UINib(nibName:"MyCell", bundle:nil), forCellWithReuseIdentifier: cellIdentifier)
        
        //Watch history
        let watchhistoryflowLayout = UICollectionViewFlowLayout()
        watchhistoryflowLayout.scrollDirection = .horizontal
  
        let widths = (watchHistoryCollectionV.frame.size.height * 280)/156
      
        watchhistoryflowLayout.itemSize = CGSize(width: widths, height: watchHistoryCollectionV.frame.size.height)
        watchhistoryflowLayout.minimumLineSpacing = 10
        watchhistoryflowLayout.minimumInteritemSpacing = 10.0
        watchHistoryCollectionV.collectionViewLayout = watchhistoryflowLayout
        watchHistoryCollectionV.showsHorizontalScrollIndicator = false
        watchHistoryCollectionV.register(UINib(nibName:"MyCell", bundle:nil), forCellWithReuseIdentifier: cellIdentifier)
    

        //All Radio section
        self.AllRadioCollectionV.register(UINib(nibName:"LnagCellFeatured", bundle:nil), forCellWithReuseIdentifier: cellIdentifier)
        let AllradioflowLayout = UICollectionViewFlowLayout()
        AllradioflowLayout.scrollDirection = .horizontal
        AllradioflowLayout.itemSize = CGSize(width: AllRadioCollectionV.frame.size.height, height: AllRadioCollectionV.frame.size.height)
        AllradioflowLayout.minimumLineSpacing = 4
        AllradioflowLayout.minimumInteritemSpacing = 4
        AllRadioCollectionV.collectionViewLayout = AllradioflowLayout
        AllRadioCollectionV.showsHorizontalScrollIndicator = false
       
        //Language item size
        let LanguageflowLayout = UICollectionViewFlowLayout()
         LanguageflowLayout.scrollDirection = .horizontal
         LanguageflowLayout.itemSize = CGSize(width: LanguageCollectionV.frame.size.height, height: LanguageCollectionV.frame.size.height)
         LanguageflowLayout.minimumLineSpacing = 4
         LanguageflowLayout.minimumInteritemSpacing = 4
         LanguageCollectionV.collectionViewLayout = LanguageflowLayout
         LanguageCollectionV.showsHorizontalScrollIndicator = false
        
        //MOvies on rent Videos item size
        
        let MovieByRentCollectionVflowLayout = UICollectionViewFlowLayout()
        MovieByRentCollectionVflowLayout.scrollDirection = .horizontal
        let width1 = (MovieByRentCollectionV.frame.size.height * 280)/156
          
        MovieByRentCollectionVflowLayout.itemSize = CGSize(width: width1, height: MovieByRentCollectionV.frame.size.height)
        MovieByRentCollectionVflowLayout.minimumLineSpacing = 10
        MovieByRentCollectionVflowLayout.minimumInteritemSpacing = 10.0
        MovieByRentCollectionV.collectionViewLayout = MovieByRentCollectionVflowLayout
        MovieByRentCollectionV.showsHorizontalScrollIndicator = false
        MovieByRentCollectionV.register(UINib(nibName:"MyCell", bundle:nil), forCellWithReuseIdentifier: cellIdentifier)
        
        
        //Favourited Videos item size
        
        let LiveTvCollectionVflowLayout = UICollectionViewFlowLayout()
            LiveTvCollectionVflowLayout.scrollDirection = .horizontal
        let LiveTvwidth = (LiveTvCollectionV.frame.size.height * 280)/156
          
        LiveTvCollectionVflowLayout.itemSize = CGSize(width: LiveTvwidth, height: LiveTvCollectionV.frame.size.height)
        LiveTvCollectionVflowLayout.minimumLineSpacing = 10
        LiveTvCollectionVflowLayout.minimumInteritemSpacing = 10.0
        LiveTvCollectionV.collectionViewLayout = LiveTvCollectionVflowLayout
        LiveTvCollectionV.showsHorizontalScrollIndicator = false
        LiveTvCollectionV.register(UINib(nibName:"MyCell", bundle:nil), forCellWithReuseIdentifier: cellIdentifier)
        
        //Watch live radio
        let watchliveradioflowLayout = UICollectionViewFlowLayout()
        watchliveradioflowLayout.scrollDirection = .horizontal
        let width5 = (WatchliveRadioCollectionV.frame.size.height * 280)/156
          
        watchliveradioflowLayout.itemSize = CGSize(width: width5, height: WatchliveRadioCollectionV.frame.size.height)
        watchliveradioflowLayout.minimumLineSpacing = 10
        watchliveradioflowLayout.minimumInteritemSpacing = 10.0
        WatchliveRadioCollectionV.collectionViewLayout = watchliveradioflowLayout
        WatchliveRadioCollectionV.showsHorizontalScrollIndicator = false
        WatchliveRadioCollectionV.register(UINib(nibName:"MyCell", bundle:nil), forCellWithReuseIdentifier: cellIdentifier)
        
    }
    
    //Update version :
    func ShowalertForUpdate()
    {
        do
        {
            guard let parameters =
                [
                    "OSType":"I",
 
                ] as? [String:Any] else { return  }
            print(parameters)
            //https://funasia.net/bigfantv.funasia.net/service/getBannerList.html
            let url:URL = URL(string: "https://funasia.net/bigfantv.funasia.net/service/getAppVersion.html")!
            self.manager.request(url, method: .post, parameters:parameters, encoding: JSONEncoding.default, headers: nil).responseJSON { (response) in
                 print("response =\(response)")
                switch response.result
                {
                case .success(_):
                    
                    if response.value != nil
                    {
                        do
                        {
                            let decoder = JSONDecoder()
                            self.appversionupdate = try decoder.decode(Appversion.self, from: response.data ?? Data())
                           
                            if self.appversionupdate?.success == 1
                            {
                        
                                guard  let localappVersion = Bundle.main.infoDictionary?["CFBundleShortVersionString"] else {return}
                                guard let appversion = self.appversionupdate?.deviceVersion else {return}
                                 let v1 = "\(appversion)"
                                if v1.compare("\(localappVersion)", options: .numeric, range: nil, locale: .current) == .orderedDescending {
                                    //https://apps.apple.com/app/id620324506
                                    
                                    
                                    let alertController = MDCAlertController(title: "BigFan TV", message:  "New version is Available!!!Please update the app")
                                          let action = MDCAlertAction(title:"Update")
                                                    { (action) in
                                            guard let url = URL(string: "https://apps.apple.com/app/id620324506") else { return }
                                            UIApplication.shared.open(url)
                                          }
                                             let cancelaction = MDCAlertAction(title:"Cancel")
                                             { (cancelaction) in
                                                  
                                             }
                                             alertController.addAction(action)
                                             alertController.addAction(cancelaction)
                                           self.present(alertController, animated: true, completion: nil)
                                    print("working fine")
                                   // print("\(v1) is greater than \(v2)")
                                }
                                
                              // print("localappVersion \(appVersion)")
                                //print("appversion = \(self.appversionupdate?.deviceVersion)")
                            }

                        }
                        catch let error
                        {
                            print("error.localizedDescription  \(error.localizedDescription)")
                        }
                    }
                    break
                case .failure(let error):
                    print("failure\(error)")
                    break
                }
            }
        }
        catch let error
        {
            //  Utility.showAlert(vc: self, message:"\(error)", titelstring: Appcommon.Appname)
        }

        
        
        
    
    }
    //Location
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        guard let location: CLLocationCoordinate2D = manager.location?.coordinate else { return }
        // set the value of lat and long
        latitude = location.latitude
        longitude = location.longitude
        UserDefaults.standard.set("\(latitude ?? 0)", forKey: "Latitude")
        UserDefaults.standard.set("\(longitude ?? 0)", forKey: "Longitude")
        

    }
    //Load Banners :
         func Getimagelist()
       {
        do
        {
            guard let parameters =
                [
                    "userId":UserDefaults.standard.string(forKey: "id") ?? "",
                    "AccessToken":UserDefaults.standard.string(forKey:"AccessToken") ?? "",
                    "offset":"1"

                ] as? [String:Any] else { return  }
            print(parameters)
            // https://funasia.net/bigfantv.funasia.net/service/getBannerList.html
            let url:URL = URL(string: "https://funasia.net/bigfantv.funasia.net/service/getBannerList.html")!
            self.manager.request(url, method: .post, parameters:parameters, encoding: JSONEncoding.default, headers: nil).responseJSON { (response) in
                 print("response =\(response)")
                switch response.result
                {
                case .success(_):
                    
                    if response.value != nil
                    {
                        do
                        {
                            let decoder = JSONDecoder()
                            self.Bannerdata = try decoder.decode(NewBannerList.self, from: response.data  ?? Data())
                            for i in self.Bannerdata?.subComedymovList ?? [NewBannerListdeatails]()
                            {
                                let feature12 = [  "titleimage":"\(i.bannerImage ?? "")","isimage":"1","videourl":"\(i.action ?? "")","actionurl":"\(i.bannerURL ?? "")","permalink":"\(i.permalink ?? "")"]
                                self.banerdata.append(feature12)
                            }
                            print("count = \(self.banerdata.count)")
                            self.sliderCollectionView.delegate = self
                            self.sliderCollectionView.dataSource = self
                            self.pageView.numberOfPages = self.banerdata.count
                            self.pageView.currentPage = 0
                            DispatchQueue.main.async {
                                self.sliderCollectionView.reloadData()
                            }
                            DispatchQueue.main.async {
                                self.timernew = Timer.scheduledTimer(timeInterval: 2.0, target: self, selector: #selector(self.changeImage), userInfo: nil, repeats: true)
                            }
                            
                            //self.setupFilterWith(size: self.Vinew!.bounds.size)
                        }
                        catch let error
                        {
                            print("error.localizedDescription  \(error.localizedDescription)")
                        }
                    }
                    break
                case .failure(let error) :
                    print("failure\(error)")
                    break
                }
            }
        }
        catch let error
        {
            //  Utility.showAlert(vc: self, message:"\(error)", titelstring: Appcommon.Appname)
        }
    }
    @objc func changeImage() {
     
        if counter < self.banerdata.count {
         let index = IndexPath.init(item: counter, section: 0)
         self.sliderCollectionView.scrollToItem(at: index, at: .centeredHorizontally, animated: true)
         pageView.currentPage = counter
         counter += 1
     } else {
         counter = 0
         let index = IndexPath.init(item: counter, section: 0)
         self.sliderCollectionView.scrollToItem(at: index, at: .left, animated: true)
         pageView.currentPage = counter
         counter = 1
     }
         
     }
    @objc func animateScrollView()
    {
        let scrollWidth = filterScrollView?.bounds.width ?? 0
        let currentXOffset = filterScrollView?.contentOffset.x ?? 0

            let lastXPos = currentXOffset + scrollWidth
        if lastXPos != filterScrollView?.contentSize.width
        {
                print("Scroll")
                filterScrollView?.setContentOffset(CGPoint(x: lastXPos, y: 0), animated: true)
        }else
        {
                print("Scroll to start")
                filterScrollView?.setContentOffset(CGPoint(x: 0, y: 0), animated: true)
        }
        
    }

    func scheduledTimerWithTimeInterval(){
            // Scheduling timer to Call the function "updateCounting" with the interval of 1 seconds
            timer = Timer.scheduledTimer(timeInterval: 2, target: self, selector: #selector(self.animateScrollView), userInfo: nil, repeats: true)
        }
    
    /*
//Favourited Radio Channels
     
    func LoadfavouritedRadios()
    {
        guard let parameters =
            [
                "userId":UserDefaults.standard.string(forKey: "id") ?? "",
                "AccessToken":UserDefaults.standard.string(forKey:"AccessToken") ?? ""
            ]
                as? [String:Any] else { return  }
        
        Common1.Commonapi(parameters: parameters, urlString: CommonApiEndPoints.getRadioFavourite) { (data, err) -> (Void) in
            do
            {
                let decoder = JSONDecoder()
                self.Radiodynamicdata = try decoder.decode(FavouriteRadioData.self, from: data ?? Data())
                if self.Radiodynamicdata?.success == 1
                {
                    if self.Radiodynamicdata?.favouriteRadioList.count ?? 0 > 0
                    {
                        self.RadioView.isHidden = false
                         
                        DispatchQueue.main.async
                            {
                                self.RadioCollectionV.delegate = self
                                self.RadioCollectionV.dataSource = self
                                self.RadioCollectionV.reloadData()
                            }
                     }else
                    {
                        self.RadioView.isHidden = true
                    }
                }
                
            }catch
            {
                print(error.localizedDescription)
            }
        }
        
    }
    */
    //Load watch history
    func LoadwatchHistory()
    {
        Api.GetWatchhistory(ApiEndPoints.watchhistory, vc: self)  { (res, err) -> (Void) in
            do
            {
                let decoder = JSONDecoder()
                self.WatchhistoryListdata = try decoder.decode(WatchhistoryList.self, from: res  ?? Data())
              
                if self.WatchhistoryListdata?.subComedymovList?.count ?? 0 > 0
                {
                    self.watchHistoryCollectionV.isHidden = false
                    self.watchHistoryCollectionV.delegate = self
                    self.watchHistoryCollectionV.dataSource = self
                    DispatchQueue.main.async
                    {
                        self.watchHistoryCollectionV.reloadData()
                    }
                }else
                {
                    self.watchHistoryCollectionV.isHidden = true
                }
            }
            catch let error
            {
               // Utility.showAlert(vc: self, message:"\(error)", titelstring: Appcommon.Appname)
            }
        }
    }
    
    //Favourited Live-TV Channels
    
    func LoadfavouritedLivetv()
    {
        guard let parameters =
            [
                "userId":UserDefaults.standard.string(forKey: "id") ?? "",
                "AccessToken":UserDefaults.standard.string(forKey:"AccessToken") ?? "",
                "offset":"1"
            ]
                as? [String:Any] else { return  }
        
        Common1.Commonapi(parameters: parameters, urlString: CommonApiEndPoints.getFavouriteLiveTv) { (data, err) -> (Void) in
            do
            {
                let decoder = JSONDecoder()
                self.favouriteLivetv = try decoder.decode(FavLiveTVData.self, from: data ?? Data())
                if self.favouriteLivetv?.success == 1
                {
                    if self.favouriteLivetv?.liveTvFavouriteCategoriesList.count ?? 0 > 0
                    {
                        self.LiveTvView.isHidden = false
                        
                        DispatchQueue.main.async
                            {
                                self.LiveTvCollectionV.delegate = self
                                self.LiveTvCollectionV.dataSource = self
                                self.LiveTvCollectionV.reloadData()
                            }
                     }  else
                    {
                        self.LiveTvView.isHidden = true
                    }
                }
            }catch
            {
                print(error.localizedDescription)
            }
        }
        
    }
    //Load movies on rent :
    
    func MoviesByrent()
    {
        Common1.getfeiltereddata(category: "movies-on-rent", subcategory: "") { (data, err) -> (Void) in
            if data?.subComedymovList.count ?? 0 > 0
            {
                self.MoviesbyRentdata = data
            
                DispatchQueue.main.async
                {
                    
                    self.ViMoviesonRent.isHidden = false
                    self.MovieByRentCollectionV.delegate = self
                    self.MovieByRentCollectionV.dataSource = self
                    self.MovieByRentCollectionV.reloadData()
                }
            }
            else
            {
                self.ViMoviesonRent.isHidden = true
            }
         }
    }
    
    func Getwatchliveradio()
    {
        Common1.getfeiltereddata(category: "video-channels", subcategory: "") { (data, err) -> (Void) in
            if data?.subComedymovList.count ?? 0 > 0
            {
                self.WatchliveRadioView.isHidden = false
                self.WatchliveRadiodata = data
            
                DispatchQueue.main.async
                {
                    self.WatchliveRadioCollectionV.delegate = self
                    self.WatchliveRadioCollectionV.dataSource = self
                    self.WatchliveRadioCollectionV.reloadData()
                }
            }else
            {
                    self.WatchliveRadioView.isHidden = true
            }
         }
    }
    
    //Load All radios
    func GetAllradios()
    {
  
        do
 {
        guard let parameters =
                    [
                        "userId":UserDefaults.standard.string(forKey: "id") ?? "",
                        "AccessToken":UserDefaults.standard.string(forKey:"AccessToken") ?? ""
                     ] as? [String:Any] else { return  }
                
        let url:URL = URL(string: "https://funasia.net/bigfantv.funasia.net/service/getAllRadioList.html")!
               
        self.manager.request(url, method: .post, parameters: parameters, encoding: JSONEncoding.default, headers: nil).responseJSON { (response) in
                                 
            switch response.result
            {
            case .success(_):
                if response.value != nil

                {
                    do
                    {
                        let decoder = JSONDecoder()
                        self.AllRadiodata = try decoder.decode(FavRadiodata.self, from: response.data  ?? Data())
                        if self.AllRadiodata?.favouriteRadioList.count ?? 0 > 0
                        {
                            self.allRadioView.isHidden = false

                            self.AllRadioCollectionV.delegate = self
                            self.AllRadioCollectionV.dataSource = self
     
                            DispatchQueue.main.async
                           {
                              self.AllRadioCollectionV.reloadData()
                            }
                        }else
                        {
                            self.allRadioView.isHidden = true
                        }
                        
                    }
                    catch let error
                    {
                        print("error.localizedDescription  \(error.localizedDescription)")
                    }
                    
                }
                break
            case .failure(let error):
                               
                print("failure\(error)")
                               break
                
            }
            
        }
        
     }
        catch let error
                    {
                      //  Utility.showAlert(vc: self, message:"\(error)", titelstring: Appcommon.Appname)
                    }
                
      
          }
    
//Load Featured section Data
    
    func GetFeatureddata()
    {
       // Utility.ShowLoader(vc: self)
        guard let parameters =
            [
                "authToken" : Keycenter.authToken,
                "user_id": UserDefaults.standard.string(forKey: "id") ?? ""
                ] as? [String:Any] else { return  }
                   
        let url:URL = URL(string: "https://bigfantv.com/en/rest/loadFeaturedSections")!
                 
        Alamofire.request(url, method: .post, parameters: parameters, encoding: JSONEncoding.default, headers: nil).responseJSON { (response) in
             
            switch response.result
            {
            case .success(_):
                if response.value != nil
                {
                    Utility.hideLoader(vc: self)
                    do
                    {
                        let decoder = JSONDecoder()
                        self.featuredarray = try decoder.decode(FeaturedData.self, from: response.data  ?? Data())
                        self.featuredsd.removeAll()
                        for il in self.featuredarray?.subComedymovList ?? [FeaturedDataList]()
                        {
                            if il.contents?.count ?? 0 > 0
                            {
                                let f = FeaturedDataList(title: il.title, contents: il.contents, total: il.total)
                                self.featuredsd.append(f)
                                
                            }
                        }
                        self.newFeaturedList = FeaturedData(code: 200, status: "OK", subComedymovList: self.featuredsd )
                                      
                        DispatchQueue.main.async
                            {
                                self.TableV.delegate = self
                                self.TableV.dataSource = self
                                self.TableV.reloadData()
                                self.FeturesectionTableHeight.constant = self.TableV.contentSize.height //Dynamic tableview height
                                UIView.animate(withDuration: 0.1) {
                                    self.view.layoutIfNeeded()
                                }
                            }
                     }
                    catch let error
                    {
                        Utility.hideLoader(vc: self)
                        print(error.localizedDescription)
                    }
                    
                }
                break
            case .failure(let error):
                 Utility.hideLoader(vc: self)
                  print(error)
                        break
                    }
                }
                   
       }
       
    
    
    //Load favorited videos
    func GetFavoritedvideoslist()
    {
 
        Api.Viewfavourite(UserDefaults.standard.string(forKey: "id") ?? "", endpoint: ApiEndPoints.ViewFavourite, vc: self)   { (res, err) -> (Void) in
            do
            {
                let decoder = JSONDecoder()
                self.FavsMoviedata = try decoder.decode(FavouriteList.self, from: res  ?? Data())
                if self.FavsMoviedata?.subComedymovList?.count ?? 0 > 0
                {
                    self.FavoritedView.isHidden = false
                    self.FavCollectionV.delegate = self
                    self.FavCollectionV.dataSource  = self
                    DispatchQueue.main.async
                    {
                        self.FavCollectionV.reloadData()
                    }
                }else
                {
                    self.FavoritedView.isHidden = true
                }
            }
            catch let error
            {
               // Utility.showAlert(vc: self, message:"\(error)", titelstring: Appcommon.Appname)
            }
            
        }
        }
    
    //Load all podcasts
    func Loadallpodcastdata()
           
    {guard let parameters =
                    [
                        "userId":UserDefaults.standard.string(forKey: "id") ?? "",
                        "AccessToken":UserDefaults.standard.string(forKey: "AccessToken") ?? "",
                        "offset":"1"
                    ] as? [String:Any] else { return  }
 
        print(parameters)
        let url:URL = URL(string: "https://funasia.net/bigfantv.funasia.net/service/getAllAudioVideoPodcastList.html")!
                   
        manager.request(url, method: .post, parameters: parameters, encoding: JSONEncoding.default, headers: nil).responseJSON { (response) in
                 print(response)
            switch response.result
            {
            case .success(_):
                if response.value != nil
                            
                {
                    do
                    {
   
                        let decoder = JSONDecoder()
                       self.PodcastData = try decoder.decode(PodcastRssfeeddata.self, from: response.data ?? Data())
                                  
                        if  self.PodcastData?.success == 1
                        {
                            DispatchQueue.main.async
                            {
                                
                                    self.PodcastTableV.delegate = self
                                    self.PodcastTableV.dataSource = self
                                    self.PodcastTableV.reloadData()
                                    self.podcastTableHeight.constant = self.PodcastTableV.contentSize.height //Dynamic tableview height
                            //print(self.FeturesectionTableHeight.constant)
                            
                                UIView.animate(withDuration: 0.1)
                                {
                                   self.view.layoutIfNeeded()
                                }
                            }
                        }
                        
                    }
                    catch let error
                                {
                                   print("podcast error = \(error.localizedDescription)")
                                }
                        }
                        break
                    case .failure(let error):
                        print(error)
                        break
                    }
                }
               
           }
    
    //Static Movies
    
    func Loaddata()
    {
        Common1.getfeiltereddata(category: "movies", subcategory: "action") { (data, err) -> (Void) in
             self.ActionCustomV.Movcategory = "movies"
             self.ActionCustomV.selftitle = "Action Movies"
             self.ActionCustomV.MovSubcategory = "action"
             self.ActionCustomV.isHidden = false
             self.ActionCustomV.Muvidata = data
             self.ActionCustomV.reloadata()
         }
         Common1.getfeiltereddata(category: "movies", subcategory: "adventure") { (data, err) -> (Void) in
             self.adventureCustomV.Movcategory = "movies"
             self.adventureCustomV.MovSubcategory = "adventure"
             self.adventureCustomV.selftitle = "Adventure Movies"
             self.adventureCustomV.isHidden = false
             self.adventureCustomV.Muvidata = data
             self.adventureCustomV.reloadata()
         }
         Common1.getfeiltereddata(category: "movies", subcategory: "fantasy") { (data, err) -> (Void) in
             self.fantasyCustomV.Movcategory = "movies"
             self.fantasyCustomV.MovSubcategory = "fantasy"
             self.fantasyCustomV.selftitle = "Fantasy Movies"
             self.fantasyCustomV.isHidden = false
             self.fantasyCustomV.Muvidata = data
             self.fantasyCustomV.reloadata()
        }
         Common1.getfeiltereddata(category: "movies", subcategory: "romance") { (data, err) -> (Void) in
             self.romanceCustomV.Movcategory = "movies"
             self.romanceCustomV.MovSubcategory = "romance"
             self.romanceCustomV.selftitle = "Romance Movies"
             self.romanceCustomV.isHidden = false
             self.romanceCustomV.Muvidata = data
             self.romanceCustomV.reloadata()
         }
         Common1.getfeiltereddata(category: "movies", subcategory: "horror") { (data, err) -> (Void) in
             self.horrorCustomV.Movcategory = "movies"
             self.horrorCustomV.MovSubcategory = "horror"
             self.horrorCustomV.selftitle = "Horror Movies"
             self.horrorCustomV.isHidden = false
             self.horrorCustomV.Muvidata = data
             self.horrorCustomV.reloadata()
         }
         Common1.getfeiltereddata(category: "movies", subcategory: "mystery") { (data, err) -> (Void) in
             self.mysteryCustomV.Movcategory = "movies"
             self.mysteryCustomV.MovSubcategory = "mystery"
             self.mysteryCustomV.selftitle = "Mystery Movies"
             self.mysteryCustomV.isHidden = false
             self.mysteryCustomV.Muvidata = data
             self.mysteryCustomV.reloadata()
         }
         Common1.getfeiltereddata(category: "movies", subcategory: "sci-fi") { (data, err) -> (Void) in
             self.scifiCustomV.Movcategory = "movies"
             self.scifiCustomV.MovSubcategory = "sci-fi"
             self.scifiCustomV.selftitle = "Sci-Fi Movies"
             self.scifiCustomV.isHidden = false
             self.scifiCustomV.Muvidata = data
             self.scifiCustomV.reloadata()
         }
         Common1.getfeiltereddata(category: "movies", subcategory: "comedy1") { (data, err) -> (Void) in
             self.comedy1CustomV.Movcategory = "movies"
             self.comedy1CustomV.MovSubcategory = "comedy1"
             self.comedy1CustomV.selftitle = "Comedy Movies"
             self.comedy1CustomV.isHidden = false
             self.comedy1CustomV.Muvidata = data
             self.comedy1CustomV.reloadata()
         }
        Common1.getfeiltereddata(category: "movies", subcategory: "thriller") { (data, err) -> (Void) in
            self.thrillerCustomV.Movcategory = "movies"
            self.thrillerCustomV.MovSubcategory = "thriller"
            self.thrillerCustomV.selftitle = "Thriller Movies"
            self.thrillerCustomV.isHidden = false
            self.thrillerCustomV.Muvidata = data
            self.thrillerCustomV.reloadata()
        }
    }
}


//Collection Data source and delegate

extension FeatureHomeVC:UICollectionViewDataSource,UICollectionViewDelegate
{
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if collectionView == RadioCollectionV
        {
            return Radiodynamicdata?.favouriteRadioList.count ?? 0
        }else if collectionView == sliderCollectionView
        {
            return self.banerdata.count
        }
        else if collectionView == LanguageCollectionV
        {
            return 15
        }
        else if collectionView == LiveTvCollectionV
        {
            if favouriteLivetv?.liveTvFavouriteCategoriesList.count ?? 0 > 0
            {
                self.LiveTvView.isHidden  = false
            }else
            {
                self.LiveTvView.isHidden  = true
            }
            return favouriteLivetv?.liveTvFavouriteCategoriesList.count ?? 0
        }
        else if collectionView == FavCollectionV
        {
            return FavsMoviedata?.subComedymovList?.count ?? 0
        }else if collectionView == MovieByRentCollectionV
        {
            
                if MoviesbyRentdata?.subComedymovList.count ?? 0 > 0
                {
                    self.ViMoviesonRent.isHidden  = false
                }else
                {
                    self.ViMoviesonRent.isHidden  = true
                }
            return MoviesbyRentdata?.subComedymovList.count ?? 0
        }else if collectionView == AllRadioCollectionV
        {
            return self.AllRadiodata?.favouriteRadioList.count ?? 0
        }else if collectionView == WatchliveRadioCollectionV
        {
            return WatchliveRadiodata?.subComedymovList.count ?? 0
        }else if collectionView == watchHistoryCollectionV
        {
            return WatchhistoryListdata?.subComedymovList?.count ?? 0
        }
        return 0
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
          
        if collectionView == RadioCollectionV
        {
            let Comedycell = collectionView.dequeueReusableCell(withReuseIdentifier: cellIdentifier, for: indexPath) as! LnagCellFeatured
            
            Comedycell.ImgLang.sd_setImage(with: URL(string: Radiodynamicdata?.favouriteRadioList[indexPath.row].radioImage ?? ""), completed: nil)
            Comedycell.LbLang.text = Radiodynamicdata?.favouriteRadioList[indexPath.row].title
          
            return Comedycell
        }else if collectionView == sliderCollectionView{
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cell", for: indexPath)
            if let vc = cell.viewWithTag(111) as? UIImageView {
                vc.sd_setImage(with: URL(string: banerdata[indexPath.row]["titleimage"] ?? ""), completed: nil)
            }
            return cell
        }
        else if collectionView == LiveTvCollectionV
        {
            let Comedycell = collectionView.dequeueReusableCell(withReuseIdentifier: cellIdentifier, for: indexPath) as! MyCell
            let item = favouriteLivetv?.liveTvFavouriteCategoriesList[indexPath.row]
            Comedycell.ImgSample.sd_setImage(with: URL(string: "\(item?.tvImage ?? "")"), completed: nil)
            Comedycell.LbName.text = item?.title
            Comedycell.btnCounter.setBackgroundImage(UIImage(named: "liked"), for: .normal)
            Comedycell.actionBlock =
                { () in
                    if item?.isFavourite == "1"
                    {
                        guard let parameters =
                            [
                                "userId":UserDefaults.standard.string(forKey: "id") ?? ""  ,
                                "AccessToken":UserDefaults.standard.string(forKey:"AccessToken") ?? "" ,
                                "liveTvId": item?.liveTvID ?? "",
                                "isFavourite":"0"
                             ] as? [String:Any] else { return }
                         
                        Common1.Commonapi(parameters: parameters, urlString: CommonApiEndPoints.saveFavouriteLiveTv) { (data, err) -> (Void) in
                            if data != nil
                            {
                                self.LoadfavouritedLivetv()
                            }
                        }
                    }
            }
            return Comedycell
       }
        else if collectionView == FavCollectionV
        {
            let Comedycell = collectionView.dequeueReusableCell(withReuseIdentifier: cellIdentifier, for: indexPath) as! MyCell
            Comedycell.ImgSample.sd_setImage(with: URL(string: "\(FavsMoviedata?.subComedymovList?[indexPath.row].poster ?? "")"), completed: nil)
            Comedycell.LbName.text = FavsMoviedata?.subComedymovList?[indexPath.row].title
            Comedycell.btnCounter.tag = indexPath.row
              // Comedycell.btnCounter.addTarget(self, action: #selector(self.buttonClicked), for: .touchUpInside)
            Comedycell.btnCounter.setBackgroundImage(UIImage(named: "liked"), for: .normal)
            return Comedycell
        }else if collectionView == MovieByRentCollectionV
        {
            let Comedycell = collectionView.dequeueReusableCell(withReuseIdentifier: cellIdentifier, for: indexPath) as! MyCell
            Comedycell.ImgSample.sd_setImage(with: URL(string: "\(MoviesbyRentdata?.subComedymovList[indexPath.row].poster ?? "")"), completed: nil)
            Comedycell.LbName.text = MoviesbyRentdata?.subComedymovList[indexPath.row].title
            Comedycell.btnCounter.tag = indexPath.row
            let item = MoviesbyRentdata?.subComedymovList[indexPath.row]
            let image = item?.is_fav_status == 1 ? UIImage(named: "liked") : UIImage(named: "like")
            Comedycell.btnCounter.setBackgroundImage(image, for: .normal)
            Comedycell.actionBlock = {
                () in
                if UserDefaults.standard.bool(forKey: "isLoggedin") == true
                {
                    
                    if item?.is_fav_status == 0
                    {
                        Comedycell.btnCounter.setBackgroundImage(UIImage(named: "liked"), for: .normal)
                        self.AddtoFav(movieuniqidx: item?.movie_uniq_id ?? "", endpoint: ApiEndPoints.AddToFavlist) { (true) in
                            Comedycell.btnCounter.setBackgroundImage(UIImage(named: "liked"), for: .normal)
                            
                            self.MoviesbyRentdata?.subComedymovList[indexPath.row].is_fav_status = 1
                           
                    }
                    }else if item?.is_fav_status == 1
                    {
                        Comedycell.btnCounter.setBackgroundImage(UIImage(named: "like"), for: .normal)
                        self.AddtoFav(movieuniqidx: item?.movie_uniq_id ?? "", endpoint: ApiEndPoints.DeleteFavLIst) { (true) in
                            Comedycell.btnCounter.setBackgroundImage(UIImage(named: "like"), for: .normal)
                            self.MoviesbyRentdata?.subComedymovList[indexPath.row].is_fav_status = 0
                         
                    }
                }
                }else
                {
                    self.checkLogintofavorite()
                }

                }
               

              // Comedycell.btnCounter.addTarget(self, action: #selector(self.buttonClicked), for: .touchUpInside)
          //  Comedycell.btnCounter.setBackgroundImage(UIImage(named: "liked"), for: .normal)
            return Comedycell
        }else if collectionView == WatchliveRadioCollectionV
        {
            let Comedycell = collectionView.dequeueReusableCell(withReuseIdentifier: cellIdentifier, for: indexPath) as! MyCell
            Comedycell.ImgSample.sd_setImage(with: URL(string: "\(WatchliveRadiodata?.subComedymovList[indexPath.row].poster ?? "")"), completed: nil)
            Comedycell.LbName.text = WatchliveRadiodata?.subComedymovList[indexPath.row].title
            Comedycell.btnCounter.tag = indexPath.row
            let item = WatchliveRadiodata?.subComedymovList[indexPath.row]
            let image = item?.is_fav_status == 1 ? UIImage(named: "liked") : UIImage(named: "like")
            Comedycell.btnCounter.setBackgroundImage(image, for: .normal)
            Comedycell.actionBlock = {
                () in
                if UserDefaults.standard.bool(forKey: "isLoggedin") == true
                {
                    
                    if item?.is_fav_status == 0
                    {
                        Comedycell.btnCounter.setBackgroundImage(UIImage(named: "liked"), for: .normal)
                        self.AddtoFav(movieuniqidx: item?.movie_uniq_id ?? "", endpoint: ApiEndPoints.AddToFavlist) { (true) in
                            Comedycell.btnCounter.setBackgroundImage(UIImage(named: "liked"), for: .normal)
                            
                            self.WatchliveRadiodata?.subComedymovList[indexPath.row].is_fav_status = 1
                           
                    }
                    }else if item?.is_fav_status == 1
                    {
                        Comedycell.btnCounter.setBackgroundImage(UIImage(named: "like"), for: .normal)
                        self.AddtoFav(movieuniqidx: item?.movie_uniq_id ?? "", endpoint: ApiEndPoints.DeleteFavLIst) { (true) in
                            Comedycell.btnCounter.setBackgroundImage(UIImage(named: "like"), for: .normal)
                            self.WatchliveRadiodata?.subComedymovList[indexPath.row].is_fav_status = 0
                         
                    }
                }
                }else
                {
                    self.checkLogintofavorite()
                }

                }
              // Comedycell.btnCounter.addTarget(self, action: #selector(self.buttonClicked), for: .touchUpInside)
          //  Comedycell.btnCounter.setBackgroundImage(UIImage(named: "liked"), for: .normal)
            return Comedycell
        }
        else if collectionView == LanguageCollectionV
        {
            let Comedycell = collectionView.dequeueReusableCell(withReuseIdentifier: cellIdentifier, for: indexPath) as! LnagCellFeatured
            Comedycell.ImgLang.image = UIImage(named: imagearray[indexPath.row])
            Comedycell.LbLang.text = newarray[indexPath.row]
               
            return Comedycell
        }else if collectionView == AllRadioCollectionV
        {
            
                let Comedycell = collectionView.dequeueReusableCell(withReuseIdentifier: cellIdentifier, for: indexPath) as! LnagCellFeatured
                
                Comedycell.ImgLang.sd_setImage(with: URL(string: AllRadiodata?.favouriteRadioList[indexPath.row].radioImage ?? ""), completed: nil)
                Comedycell.LbLang.text = AllRadiodata?.favouriteRadioList[indexPath.row].title
              
                return Comedycell
        }else if collectionView == watchHistoryCollectionV
        {
            let Comedycell = collectionView.dequeueReusableCell(withReuseIdentifier: cellIdentifier, for: indexPath) as! MyCell
            Comedycell.ImgSample.sd_setImage(with: URL(string: "\(WatchhistoryListdata?.subComedymovList?[indexPath.row].poster ?? "")"), completed: nil)
            Comedycell.LbName.text = WatchhistoryListdata?.subComedymovList?[indexPath.row].title
            Comedycell.btnCounter.tag = indexPath.row
              // Comedycell.btnCounter.addTarget(self, action: #selector(self.buttonClicked), for: .touchUpInside)
          //  Comedycell.btnCounter.setBackgroundImage(UIImage(named: "liked"), for: .normal)
            return Comedycell
        }
        
        return UICollectionViewCell()
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath)
    {
        MuviAudioPlayerManager.shared.pause()
        if collectionView == RadioCollectionV
        {
            let storyBoard: UIStoryboard = UIStoryboard(name: "Main", bundle: nil)
            let displayVC = storyBoard.instantiateViewController(withIdentifier: "RadioDetailsVC") as! RadioDetailsVC
               displayVC.modalPresentationStyle = .fullScreen
           
            if let item = Radiodynamicdata?.favouriteRadioList[indexPath.row]
            {
                displayVC.Videourl = item.radioURL
                displayVC.Videotitle = item.title
                displayVC.isfavourite  = item.isFavourite
                displayVC.radioid =  item.radioID
             
                self.present(displayVC, animated: true, completion: nil)
            }
        }else if collectionView == sliderCollectionView
        {
            if  banerdata[indexPath.row]["videourl"] == "1"
            {        guard let url = URL(string: banerdata[indexPath.row]["actionurl"] ?? "") else { return }
                UIApplication.shared.open(url)
               
              
            }
            else if  banerdata[indexPath.row]["videourl"] == "3"
            {
            //  self.getcontendeatilsbannerfor(permaas: banerdata[sender.view.tag]["permalink"] ?? "")
            }
            else if banerdata[indexPath.row]["videourl"] == "2"
            {
              let storyBoard: UIStoryboard = UIStoryboard(name: "Main", bundle: nil)
                        let VC1 = storyBoard.instantiateViewController(withIdentifier: "FeedbackVC") as! FeedbackVC
                      //https://funasia.net/bigfantvfeedback.funasia.net/addfeedback.html?
                      
                      //https://bigfantv.funasia.net/
                      //https://funasia.net/bigfantv.funasia.net/
                     VC1.planurl = banerdata[indexPath.row]["actionurl"] ?? ""
                         
                      let navController = UINavigationController(rootViewController: VC1) // Creating a navigation controller with VC1 at the root of the navigation stack.
                      navController.navigationBar.barTintColor = Appcolor.backgorund3
                      navController.modalPresentationStyle = .fullScreen
                       let textAttributes = [NSAttributedString.Key.foregroundColor:UIColor.white,NSAttributedString.Key.font: UIFont(name: "Muli-ExtraBold", size: 19)!]
                       navController.navigationBar.titleTextAttributes = textAttributes
                      self.present(navController, animated:true, completion: nil)
              }
        }
        else if collectionView == LanguageCollectionV
        {
            let storyBoard: UIStoryboard = UIStoryboard(name: "Main", bundle: nil)
            let VC1 = storyBoard.instantiateViewController(withIdentifier: "ComedyViewAllVC") as! ComedyViewAllVC
            VC1.Movcategory = "language-1"
            VC1.MovSubcategory = subcatearray[indexPath.row]
               
            let navController = UINavigationController(rootViewController: VC1) // Creating a navigation controller with VC1 at the root of the navigation stack.
               navController.navigationBar.barTintColor = Appcolor.backgorund4
               //navController.title = "\(newarray[indexPath.row]) Movies"
               navController.modalPresentationStyle = .fullScreen
               let textAttributes = [NSAttributedString.Key.foregroundColor:UIColor.white,NSAttributedString.Key.font: UIFont(name: "Muli-ExtraBold", size: 19)!]
              navController.navigationBar.titleTextAttributes = textAttributes
               self.present(navController, animated:true, completion: nil)
        }
        else if collectionView == LiveTvCollectionV
        {
             let storyBoard: UIStoryboard = UIStoryboard(name: "Main", bundle: nil)
             let secondViewController =  storyBoard.instantiateViewController(withIdentifier: "LiveTvDetailsVC") as! LiveTvDetailsVC
            let item = favouriteLivetv?.liveTvFavouriteCategoriesList[indexPath.row]
            secondViewController.moviename = item?.title ?? ""
            secondViewController.movietype = item?.source ?? ""
            secondViewController.Isfavourite = item?.isFavourite ?? ""
            secondViewController.livetvid = item?.liveTvID ?? ""
            secondViewController.livetvCategoryid = item?.liveTvCategroryID ?? ""
            self.present(secondViewController, animated: true)
        }else if collectionView == MovieByRentCollectionV
        {
            if UserDefaults.standard.bool(forKey: "isLoggedin") == true
            {

            
                let item = MoviesbyRentdata?.subComedymovList[indexPath.row]
                imagename = item?.poster ?? ""
                moviename = item?.title ?? ""
                movietype = item?.poster ?? ""
                movdescription = item?.poster ?? ""
                imdbId = item?.custom?.customimdb?.field_value ?? ""
                movieuniqid = item?.movie_uniq_id ?? ""
                perma = item?.c_permalink ?? ""
                newperma = item?.permalink ?? ""
                Isfavourite = item?.is_fav_status ?? 0
                WatchDuration = item?.watch_duration_in_seconds ?? 0
                contenttypesid = item?.content_types_id ?? ""
                playerurlstr = item?.permalink ?? ""
                getcontentauthorized(movieid: MoviesbyRentdata?.subComedymovList[indexPath.row].movie_uniq_id ?? "", planurls: item?.permalink ?? "", index: indexPath.row, permad: MoviesbyRentdata?.subComedymovList[indexPath.row].c_permalink ?? "", isbanner: 0)
            }else
            {
                self.checkLogin()
            }

        }else if collectionView == AllRadioCollectionV
        {
            let storyBoard: UIStoryboard = UIStoryboard(name: "Main", bundle: nil)
            let displayVC = storyBoard.instantiateViewController(withIdentifier: "RadioDetailsVC") as! RadioDetailsVC
               displayVC.modalPresentationStyle = .fullScreen
           
            if let item = AllRadiodata?.favouriteRadioList[indexPath.row]
            {
                 
            UIView.animate(withDuration: 0.1) {
                
                self.MuviPLayerView.isHidden = false
            }
            let Radiotitle = AllRadiodata?.favouriteRadioList[indexPath.row].title ?? ""
          //  Videotitle = Radiodynamicdata?.favouriteRadioList[indexPath.row].title ?? ""
          // isfavourite  = Radiodynamicdata?.favouriteRadioList[indexPath.row].isFavourite ?? ""
          //  radioid =  Radiodynamicdata?.favouriteRadioList[indexPath.row].radioID ?? ""
            var MuviPlayerV =    MuviAudioPlayerManager.shared.muviAudioMiniView!

           // let theHeight = view.frame.size.height //grabs the height of your view

           // self.muviPlayer.audioTitleLabel.adjustsFontSizeToFitWidth = true
           // self.muviPlayer.audioSubTitleLabel.adjustsFontSizeToFitWidth = true

            MuviPlayerV.audioTitleLabel.textColor = UIColor.black
            MuviPlayerV.audioSubTitleLabel.textColor = UIColor.black

                //[NSAttributedString.Key.font: UIFont(name: "Muli-Bold", size: 16)!,NSAttributedString.Key.foregroundColor : UIColor.white], for: .normal
            MuviPlayerV.layer.backgroundColor = UIColor.white.cgColor
            MuviPlayerV.frame = CGRect(x: 0, y: 0, width: MuviPLayerView.frame.size.width, height: MuviPLayerView.frame.size.height)
            self.MuviPLayerView.addSubview(MuviPlayerV)

            //self.myScrollingView.bringSubviewToFront(MuviPlayerV)

                guard let songurl = URL(string: item.radioURL) else {return}
                guard let songImageurl = URL(string:  item.radioImage ) else {return}

          //  print("name === \(self.contentdata?.submovie?.name)")
          //  print("titlename === \(self.contentdata?.submovie?.custom3)")

               // print(songurl)
            //print(Radiotitle)
               // print(songImageurl)
            let song = MuviAudioPlayerItemInfo(id: "",
                                                        url: songurl,
                                                        title:Radiotitle,
                                                        albumTitle: "",
                                                        coverImageURL: songImageurl)
            //MuviAudioPlayerManager.shared.setup(with:[song])
            var playeritems: [MuviAudioPlayerItemInfo] = []
            playeritems.append(song)
            for i in AllRadiodata?.favouriteRadioList ?? [FavouriteRadioList]()
            {
                if i.title != Radiotitle
                {
                    guard let songurl = URL(string: i.radioURL ) else {return}
                    guard let songImageurl = URL(string:  i.radioImage ) else {return}
                    playeritems.append(MuviAudioPlayerItemInfo(id: "",
                                                               url: songurl,
                                                               title:i.title ,
                                                               albumTitle: "",
                                                               coverImageURL: songImageurl))
                }
            }
            
         
            MuviAudioPlayerManager.shared.setup(with: playeritems)
            }
        }else if collectionView == WatchliveRadioCollectionV
        {
            getcontentauthorized(movieid: WatchliveRadiodata?.subComedymovList[indexPath.row].movie_uniq_id ?? "", planurls:"", index: indexPath.row, permad: WatchliveRadiodata?.subComedymovList[indexPath.row].c_permalink ?? "", isbanner: 2)
            // let currentController = self.getCurrentViewController()
           
        }else if collectionView == watchHistoryCollectionV
        {
            getcontentauthorized(movieid: WatchhistoryListdata?.subComedymovList?[indexPath.row].movie_uniq_id ?? "", planurls:"", index: indexPath.row, permad: WatchhistoryListdata?.subComedymovList?[indexPath.row].c_permalink ?? "", isbanner: 3)
    
        }else if collectionView == FavCollectionV
        {
            if FavsMoviedata?.subComedymovList?[indexPath.row].content_types_id == "5"
            {
                self.playmusic(permaa: FavsMoviedata?.subComedymovList?[indexPath.row].c_permalink ?? "")
            }else
            {
            getcontentauthorized(movieid: FavsMoviedata?.subComedymovList?[indexPath.row].movie_uniq_id ?? "", planurls:"", index: indexPath.row, permad: FavsMoviedata?.subComedymovList?[indexPath.row].c_permalink ?? "", isbanner: 5)
            }
            
        }
    }
    func AddtoFav(movieuniqidx:String,endpoint:String, completionBlock: @escaping (Bool) -> Void) -> Void
    {
        
        
        Api.Addtofav(movie_uniq_id: movieuniqidx, endpoint: endpoint, vc: UIViewController()) { (res, err) -> (Void) in
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
    func checkLogintofavorite()
    {
        let alertController = MDCAlertController(title: "BigFan TV", message:  "First Login or Register to favorite this content.")
        let action = MDCAlertAction(title:"Ok")
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
    func checkLogin()
    {
        let alertController = MDCAlertController(title: "BigFan TV", message:  "First Login or Register to watch this content.")
        let action = MDCAlertAction(title:"Ok")
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
    func playmusic(permaa:String)
       {
        Utility.ShowLoader(vc: self)
           Api.getcontentdetails(permaa, endpoint: ApiEndPoints.getcontentdetails, vc: UIViewController()) { (res, err) -> (Void) in
               do
               {
                  let decoder = JSONDecoder()
                  self.contentdata = try decoder.decode(contentdetails.self, from: res  ?? Data())
                Utility.hideLoader(vc: self)

                if self.contentdata?.msg == "Ok"
                  {
                      //self.getPPVplans(movieuniqids: self.contentdata?.submovie?.muvi_uniq_id ?? "", planid: self.contentdata?.submovie?.ppv_plan_id  ?? "")
                    UIView.animate(withDuration: 0.1) {
                        
                        self.MuviPLayerView.isHidden = false
                    }
                    let Radiotitle = self.contentdata?.submovie?.name ??  ""
                  //  Videotitle = Radiodynamicdata?.favouriteRadioList[indexPath.row].title ?? ""
                  // isfavourite  = Radiodynamicdata?.favouriteRadioList[indexPath.row].isFavourite ?? ""
                  //  radioid =  Radiodynamicdata?.favouriteRadioList[indexPath.row].radioID ?? ""
                    var MuviPlayerV =    MuviAudioPlayerManager.shared.muviAudioMiniView!

                   // let theHeight = view.frame.size.height //grabs the height of your view

                   // self.muviPlayer.audioTitleLabel.adjustsFontSizeToFitWidth = true
                   // self.muviPlayer.audioSubTitleLabel.adjustsFontSizeToFitWidth = true

                    MuviPlayerV.audioTitleLabel.textColor = UIColor.black
                    MuviPlayerV.audioSubTitleLabel.textColor = UIColor.black

                        //[NSAttributedString.Key.font: UIFont(name: "Muli-Bold", size: 16)!,NSAttributedString.Key.foregroundColor : UIColor.white], for: .normal
                    MuviPlayerV.layer.backgroundColor = UIColor.white.cgColor
                    MuviPlayerV.frame = CGRect(x: 0, y: 0, width: self.MuviPLayerView.frame.size.width, height: self.MuviPLayerView.frame.size.height)
                    self.MuviPLayerView.addSubview(MuviPlayerV)

                    //self.myScrollingView.bringSubviewToFront(MuviPlayerV)

                        guard let songurl = URL(string: self.contentdata?.submovie?.movieUrl ?? "") else {return}
                        guard let songImageurl = URL(string:  self.contentdata?.submovie?.poster ?? "" ) else {return}

                  //  print("name === \(self.contentdata?.submovie?.name)")
                  //  print("titlename === \(self.contentdata?.submovie?.custom3)")

                        print(songurl)
                        print(Radiotitle)
                        print(songImageurl)
                    let song = MuviAudioPlayerItemInfo(id: "",
                                                                url: songurl,
                                                                title:Radiotitle,
                                                                albumTitle: "",
                                                                coverImageURL: songImageurl)
                    //MuviAudioPlayerManager.shared.setup(with:[song])
                    var playeritems: [MuviAudioPlayerItemInfo] = []
                    playeritems.append(song)
                    
                 
                    MuviAudioPlayerManager.shared.setup(with: playeritems)
                      
                  }
                  
               }
               catch let error
               {
                Utility.hideLoader(vc: self)

                  /// Utility.showAlert(vc: UIViewController(), message:"\(error)", titelstring: Appcommon.Appname)
               }
           }
       }
    
    func getcontentauthorized(movieid:String,planurls:String,index:Int,permad:String,isbanner:Int)
    {
 
        Api.IsContentAuthorised(movieid, endpoint: ApiEndPoints.isContentAuthorized, vc: self) { (res, err) -> (Void) in
                             
            do{
                                 
                let decoder = JSONDecoder()
                self.authorizeddata = try decoder.decode(Authorizescontent.self, from: res  ?? Data())
                       
               // print("status === \(self.authorizeddata?.status)")
                if self.authorizeddata?.status == "OK"
                {
                    if isbanner == 1
                    {
                        let storyBoard: UIStoryboard = UIStoryboard(name: "Main", bundle: nil)
                        let displayVC = storyBoard.instantiateViewController(withIdentifier: "SongsDetailsVC") as! SongsDetailsVC
                            displayVC.modalPresentationStyle = .fullScreen
                       // print("perma - \(banerdata[sender.view.tag]["permalink"])")
                        print(permad)
                        displayVC.IsAuthorizedContent = 1
                        displayVC.playerurlstr = self.playerurlstr
                            displayVC.permalink = permad
                           // displayVC.songtitle = self.moviename
                        
                        self.present(displayVC, animated: true, completion: nil)
                        
                    }else if isbanner == 2
                    {
                        let storyBoard: UIStoryboard = UIStoryboard(name: "Main", bundle: nil)
                        let displayVC = storyBoard.instantiateViewController(withIdentifier: "OtherVideosVCDetails") as! OtherVideosVCDetails
                                          
                        displayVC.modalPresentationStyle = .fullScreen
                                            
                        if let item = self.WatchliveRadiodata?.subComedymovList[index]
                        {
                             
                            displayVC.imagename = item.poster ?? ""
                            displayVC.moviename = item.title ?? ""
                            displayVC.perma = item.c_permalink ?? ""
                            displayVC.Movcategory =  "video-channels"
                            displayVC.MovSubcategory = ""
                            displayVC.movieuniqid = item.movie_uniq_id ?? ""
                            displayVC.Isfavourite = item.is_fav_status ?? 0
                            displayVC.WatchDuration = item.watch_duration_in_seconds ?? 0
                            displayVC.playerurlstr = item.permalink ?? ""
                            displayVC.contenttypesid = "4"
                            displayVC.IsAuthorizedContent = 1
                        }
                       
                         
                
                        self.present(displayVC, animated: false, completion: nil)
                    }else if isbanner == 3
                    {
                        let item = self.WatchhistoryListdata?.subComedymovList?[index]
                        self.imagename = item?.poster ?? ""
                        self.moviename = item?.title ?? ""
                        self.movietype = item?.poster ?? ""
                        self.movdescription = item?.poster ?? ""
                      //  imdbId = item?.custom?.customimdb?.field_value ?? ""
                        self.movieuniqid = item?.movie_uniq_id ?? ""
                        self.perma = item?.c_permalink ?? ""
                        self.playerurlstr = item?.permalink ?? ""
                        self.Isfavourite = item?.is_fav_status ?? 0
                        self.WatchDuration = item?.watch_duration_in_seconds ?? 0
                        self.contenttypesid = item?.content_types_id ?? ""
                       let movieid = item?.movie_uniq_id ?? ""
                     
                    //passarray?.contents?.remove(at: index)
                        self.getcontentauthorisedverified(movieid: movieid)
                     }else if isbanner == 4
                    {
                        self.getcontentauthorisedverified(movieid: movieid)
                    }else if isbanner == 5
                    {
                        
                            let item = self.FavsMoviedata?.subComedymovList?[index]
                            self.imagename = item?.poster ?? ""
                            self.moviename = item?.title ?? ""
                            self.movietype = item?.poster ?? ""
                            self.movdescription = item?.poster ?? ""
                          //  imdbId = item?.custom?.customimdb?.field_value ?? ""
                            self.movieuniqid = item?.movie_uniq_id ?? ""
                            self.perma = item?.c_permalink ?? ""
                        self.playerurlstr = item?.permalink ?? ""
                            self.Isfavourite = item?.is_fav_status ?? 0
                            self.WatchDuration = item?.watch_duration_in_seconds ?? 0
                            self.contenttypesid = item?.content_types_id ?? ""
                           let movieid = item?.movie_uniq_id ?? ""
                         
                        //passarray?.contents?.remove(at: index)
                        self.getcontentauthorisedverified(movieid: movieid)
                    }
                    else
                    {
                    let storyBoard: UIStoryboard = UIStoryboard(name: "Main", bundle: nil)
                    let displayVC = storyBoard.instantiateViewController(withIdentifier: "MoviesDetailsVC") as! MoviesDetailsVC
                                      
                    displayVC.modalPresentationStyle = .fullScreen
                                        
                    if let item = self.MoviesbyRentdata?.subComedymovList[index]
                    {
                        displayVC.imagename = item.poster ?? ""
                        displayVC.moviename = item.title ?? ""
                        displayVC.imdbID = item.custom?.customimdb?.field_value ?? ""
                        displayVC.perma = item.c_permalink ?? ""
                        displayVC.Movcategory = "movies-on-rent"
                        displayVC.MovSubcategory = ""
                        displayVC.movieuniqid = item.movie_uniq_id ?? ""
                        displayVC.Isfavourite = item.is_fav_status ?? 0
                        displayVC.WatchDuration = item.watch_duration_in_seconds ?? 0
                        displayVC.contenttypeid = item.content_types_id ?? ""
                        displayVC.playerurlstr = item.permalink ?? ""
                        displayVC.IsAuthorizedContent = 1
                    }
                     
                   self.present(displayVC, animated: false, completion: nil)
                    }
                }
                                
                else
                {
                    if isbanner == 1
                    {
                        let storyBoard: UIStoryboard = UIStoryboard(name: "Main", bundle: nil)
                        let displayVC = storyBoard.instantiateViewController(withIdentifier: "SongsDetailsVC") as! SongsDetailsVC
                            displayVC.modalPresentationStyle = .fullScreen
                       // print("perma - \(banerdata[sender.view.tag]["permalink"])")
                        print(permad)
                        displayVC.IsAuthorizedContent = 0
                            displayVC.permalink = permad
                        displayVC.playerurlstr = self.playerurlstr
                           // displayVC.songtitle = self.moviename
                        
                        self.present(displayVC, animated: true, completion: nil)
                        
                    }else if isbanner == 2
                    {
                        let storyBoard: UIStoryboard = UIStoryboard(name: "Main", bundle: nil)
                        let displayVC = storyBoard.instantiateViewController(withIdentifier: "OtherVideosVCDetails") as! OtherVideosVCDetails
                                          
                        displayVC.modalPresentationStyle = .fullScreen
                                            
                        if let item = self.WatchliveRadiodata?.subComedymovList[index]
                        {
                             
                            displayVC.imagename = item.poster ?? ""
                            displayVC.moviename = item.title ?? ""
                            displayVC.perma = item.c_permalink ?? ""
                            displayVC.Movcategory =  "video-channels"
                            displayVC.MovSubcategory = ""
                            displayVC.movieuniqid = item.movie_uniq_id ?? ""
                            displayVC.Isfavourite = item.is_fav_status ?? 0
                            displayVC.WatchDuration = item.watch_duration_in_seconds ?? 0
                            displayVC.playerurlstr = item.permalink ?? ""
                            displayVC.contenttypesid = "4"
                            displayVC.IsAuthorizedContent = 0
                        }
                       
                         
                
                        self.present(displayVC, animated: false, completion: nil)
                    }else if isbanner == 3
                    {
                        let item = self.WatchhistoryListdata?.subComedymovList?[index]
                        self.imagename = item?.poster ?? ""
                        self.moviename = item?.title ?? ""
                        self.movietype = item?.poster ?? ""
                        self.movdescription = item?.poster ?? ""
                      //  imdbId = item?.custom?.customimdb?.field_value ?? ""
                        self.movieuniqid = item?.movie_uniq_id ?? ""
                        self.perma = item?.c_permalink ?? ""
                        self.playerurlstr = item?.permalink ?? ""
                        self.Isfavourite = item?.is_fav_status ?? 0
                        self.WatchDuration = item?.watch_duration_in_seconds ?? 0
                        self.contenttypesid = item?.content_types_id ?? ""
                       let movieid = item?.movie_uniq_id ?? ""
                     
                    //passarray?.contents?.remove(at: index)
                        self.getcontentauthorisedUnverified(movieid: movieid)
                    }else if isbanner == 4
                    {
                        self.getcontentauthorisedUnverified(movieid: movieid)
                    }else if isbanner == 5
                    {
                        
                            let item = self.FavsMoviedata?.subComedymovList?[index]
                            self.imagename = item?.poster ?? ""
                            self.moviename = item?.title ?? ""
                            self.movietype = item?.poster ?? ""
                            self.movdescription = item?.poster ?? ""
                          //  imdbId = item?.custom?.customimdb?.field_value ?? ""
                            self.movieuniqid = item?.movie_uniq_id ?? ""
                            self.perma = item?.c_permalink ?? ""
                        self.playerurlstr = item?.permalink ?? ""
                            self.Isfavourite = item?.is_fav_status ?? 0
                            self.WatchDuration = item?.watch_duration_in_seconds ?? 0
                            self.contenttypesid = item?.content_types_id ?? ""
                           let movieid = item?.movie_uniq_id ?? ""
                         
                        //passarray?.contents?.remove(at: index)
                        self.getcontentauthorisedUnverified(movieid: movieid)
                    }
                    else
                    {
                    let storyBoard: UIStoryboard = UIStoryboard(name: "Main", bundle: nil)
                    let displayVC = storyBoard.instantiateViewController(withIdentifier: "MoviesDetailsVC") as! MoviesDetailsVC
                                      
                    displayVC.modalPresentationStyle = .fullScreen
                                        
                    if let item = self.MoviesbyRentdata?.subComedymovList[index]
                    {
                        displayVC.imagename = item.poster ?? ""
                        displayVC.moviename = item.title ?? ""
                        displayVC.imdbID = item.custom?.customimdb?.field_value ?? ""
                        displayVC.perma = item.c_permalink ?? ""
                        displayVC.Movcategory = "movies-on-rent"
                        displayVC.MovSubcategory = ""
                        displayVC.movieuniqid = item.movie_uniq_id ?? ""
                        displayVC.Isfavourite = item.is_fav_status ?? 0
                        displayVC.WatchDuration = item.watch_duration_in_seconds ?? 0
                        displayVC.contenttypeid = item.content_types_id ?? ""
                        displayVC.playerurlstr = item.permalink ?? ""
                        displayVC.IsAuthorizedContent = 0
                    }
                     
                   self.present(displayVC, animated: false, completion: nil)
                    }
                    
                    /*
                    if isbanner == 1
                    {
                        self.getPPVplans(movieuniqids: self.movieuniqid, planid: self.ppvPlanId)
                    }else
                    {
                    
                    self.getcontendeatils(permaa:self.perma)
                    
                    }
                    */
                }
                             }
                             catch let error
                             {
                               //  Utility.showAlert(vc: self, message:"\(error)", titelstring: Appcommon.Appname)
                             }
                         }
    }
    /*
      func getcontendeatils(permaa:String)
         {
          
             Api.getcontentdetails(permaa, endpoint: ApiEndPoints.getcontentdetails, vc: self) { (res, err) -> (Void) in
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
                     Utility.showAlert(vc: self, message:"\(error)", titelstring: Appcommon.Appname)
                 }
             }
         }
    */
      func getcontendeatilsbannerfor (permaas:String)
         {
          
             Api.getcontentdetails(permaas, endpoint: ApiEndPoints.getcontentdetails, vc: self) { (res, err) -> (Void) in
                 do
                 {
                    let decoder = JSONDecoder()
                    self.contentdata = try decoder.decode(contentdetails.self, from: res  ?? Data())
             
                    if self.contentdata != nil
                    {
                        print("movie id = \(self.contentdata?.submovie?.muvi_uniq_id)")
                        print("perma =\(permaas)")
                        self.movieuniqid = self.contentdata?.submovie?.muvi_uniq_id ?? ""
                    
                        self.ppvPlanId  = self.contentdata?.submovie?.ppv_plan_id  ?? ""
                        self.getcontentauthorized(movieid: self.contentdata?.submovie?.muvi_uniq_id ?? "", planurls: "", index: 0, permad: permaas, isbanner: 1)

                       // self.getPPVplans(movieuniqids: self.contentdata?.submovie?.muvi_uniq_id ?? "", planid: self.contentdata?.submovie?.ppv_plan_id  ?? "")
                        
                    }
                    
                 }
                 catch let error
                 {
                   //  Utility.showAlert(vc: self, message:"\(error)", titelstring: Appcommon.Appname)
                 }
             }
         }
    /*
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
                        self.RadioView.isHidden = true
                    }
                }
                
            }catch
            {
                print(error.localizedDescription)
            }
        }
        
     }
 */
}

//Featured Data

extension FeatureHomeVC : UITableViewDelegate,UITableViewDataSource
{
    func numberOfSections(in tableView: UITableView) -> Int
    {
        if tableView == TableV
        {
          return  newFeaturedList?.subComedymovList?.count ?? 0
        }else
        {
            return PodcastData?.podcastList?.count ?? 0
        }
    }
     
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
        if tableView == TableV
        {
            button.addTarget(self, action: #selector(loaddata(_:)), for: .touchUpInside)
        }else
        {
            button.addTarget(self, action: #selector(loaddata1(_:)), for: .touchUpInside)
  
        }
        button.setBackgroundImage(UIImage(named: "viewall"), for: .normal)
        headerView.addSubview(button)
 
        let titleLabel = UILabel(frame: CGRect(x: 32, y: 0, width: 200, height: 44))
        headerView.addSubview(titleLabel)
        titleLabel.textColor = UIColor.white
        titleLabel.font =  UIFont(name: "Muli-SemiBold", size: 17)!
        if tableView == TableV
        {
        titleLabel.text = newFeaturedList?.subComedymovList?[section].title
        }else
        {
            titleLabel.text = PodcastData?.podcastList?[section].title
        }
        return headerView
        
    }
    
    @objc func loaddata(_ sender:UIButton)
    {
        let storyBoard: UIStoryboard = UIStoryboard(name: "Main", bundle: nil)
        let VC1 = storyBoard.instantiateViewController(withIdentifier: "ViewAllhomeVC") as! ViewAllhomeVC
        VC1.Loadhomedata = newFeaturedList?.subComedymovList?[sender.tag]
        VC1.sectionnumber = sender.tag
        VC1.totalconents = newFeaturedList?.subComedymovList?[sender.tag].total ?? 0
         
        let navController = UINavigationController(rootViewController: VC1) // Creating a navigation controller with VC1 at the root of the navigation stack.
         navController.navigationBar.barTintColor = Appcolor.backgorund3
         navController.modalPresentationStyle = .fullScreen
         self.present(navController, animated:true, completion: nil)
        
    }
    
    @objc func loaddata1(_ sender:UIButton)
    {
        let storyBoard : UIStoryboard = UIStoryboard(name: "Main", bundle: nil)
        let VC1 = storyBoard.instantiateViewController(withIdentifier: "PodcastViewAllVC") as! PodcastViewAllVC
        // VC1.Movcategory = Movcategory
        // VC1.MovSubcategory = MovSubcategory
          VC1.selftitle = PodcastData?.podcastList?[sender.tag].title ?? ""
          VC1.isaudioorvide0 = "1"
          VC1.isfrom = "6"

          VC1.podcastcategoryid = PodcastData?.podcastList?[sender.tag].podcastCategoryID ?? ""
          /*
           
             isfrom = "5"
             selftitle = "BigFan Originals"
             muvititle = "Audio"
             isaudioorvide0 = "1"
           */
  
        let navController = UINavigationController(rootViewController: VC1) // Creating a navigation controller with VC1 at the root of the navigation stack.
       navController.navigationBar.barTintColor = Appcolor.backgorund4
       let textAttributes = [NSAttributedString.Key.foregroundColor:UIColor.white,NSAttributedString.Key.font: UIFont(name: "Muli-ExtraBold", size: 19)!]
       navController.navigationBar.titleTextAttributes = textAttributes
         navController.navigationBar.isTranslucent = false
       navController.modalPresentationStyle = .fullScreen
        self.present(navController, animated:true, completion: nil)
        /*
        
        if PodcastData?.podcastList?[sender.tag].type == "Audio"
        {
          let storyBoard : UIStoryboard = UIStoryboard(name: "Main", bundle: nil)
          let VC1 = storyBoard.instantiateViewController(withIdentifier: "PodcastViewAllVC") as! PodcastViewAllVC
          // VC1.Movcategory = Movcategory
          // VC1.MovSubcategory = MovSubcategory
            VC1.selftitle = "BigFan Originals"
            VC1.isfrom = "5"
            VC1.muvititle = "Audio"
            VC1.isaudioorvide0 = "1"
            VC1.podcastcategoryid = PodcastData?.podcastList?[sender.tag].podcastCategoryID ?? ""
            /*
             
               isfrom = "5"
               selftitle = "BigFan Originals"
               muvititle = "Audio"
               isaudioorvide0 = "1"
             */
    
          let navController = UINavigationController(rootViewController: VC1) // Creating a navigation controller with VC1 at the root of the navigation stack.
         navController.navigationBar.barTintColor = Appcolor.backgorund4
         let textAttributes = [NSAttributedString.Key.foregroundColor:UIColor.white,NSAttributedString.Key.font: UIFont(name: "Muli-ExtraBold", size: 19)!]
         navController.navigationBar.titleTextAttributes = textAttributes
           navController.navigationBar.isTranslucent = false
         navController.modalPresentationStyle = .fullScreen
          self.present(navController, animated:true, completion: nil)
        }else
        {
            let storyBoard : UIStoryboard = UIStoryboard(name: "Main", bundle: nil)
            let VC1 = storyBoard.instantiateViewController(withIdentifier: "PodcastViewAllVC") as! PodcastViewAllVC
            // VC1.Movcategory = Movcategory
            // VC1.MovSubcategory = MovSubcategory
              VC1.selftitle =  "Video on demand"
              VC1.isfrom = "5"
              VC1.muvititle = "Video"
             VC1.isaudioorvide0 = "2"
            VC1.podcastcategoryid = PodcastData?.podcastList?[sender.tag].podcastCategoryID ?? ""

              /*
               
                 isfrom = "5"
                 selftitle = "BigFan Originals"
                 muvititle = "Audio"
                 isaudioorvide0 = "1"
               */
      
            let navController = UINavigationController(rootViewController: VC1) // Creating a navigation controller with VC1 at the root of the navigation stack.
           navController.navigationBar.barTintColor = Appcolor.backgorund4
           let textAttributes = [NSAttributedString.Key.foregroundColor:UIColor.white,NSAttributedString.Key.font: UIFont(name: "Muli-ExtraBold", size: 19)!]
           navController.navigationBar.titleTextAttributes = textAttributes
             navController.navigationBar.isTranslucent = false
           navController.modalPresentationStyle = .fullScreen
            self.present(navController, animated:true, completion: nil)
        }
        */
        
    }
    /*
    public func tableView(_ tableView: UITableView, estimatedHeightForRowAt indexPath: IndexPath) -> CGFloat
    {
        return 160
    }
    */
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat
    {
        44
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat
    {
         return 160
    }
    public func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell
    {
        if tableView == TableV
        {
            if let cell = tableView.dequeueReusableCell(withIdentifier: "tableviewcellid", for: indexPath) as? TableViewCell
            {
                let rowArray = (newFeaturedList?.subComedymovList?[indexPath.section].contents)!
                    
           
                cell.updateCellWith(row: rowArray, rowindex: indexPath.section)
                cell.cellDelegate = self
                cell.selectionStyle = .none
           
                return cell
             }
        return UITableViewCell()
     }else
        {
            
                if let cell = tableView.dequeueReusableCell(withIdentifier: "tableviewcellid", for: indexPath) as? HomepodcastTableViewCell
                {
                  if  let rowArray = PodcastData?.podcastList?[indexPath.section].podcast //(newFeaturedList?.subComedymovList?[indexPath.section].contents)!
                        
                  {
                    cell.updateCellWith(row: rowArray, rowindex: indexPath.section)
                    cell.cellDelegate = self
                    cell.selectionStyle = .none
                  }
                    return cell
                 }
            return UITableViewCell()
        }
    }
    }

extension FeatureHomeVC:CollectionViewCellDelegate11
{
    func collectionView(collectionviewcell: CollectionViewCell?, index: Int, rowindex: Int, didTappedInTableViewCell: HomepodcastTableViewCell) {
        print("done")
        if let colorsRow = didTappedInTableViewCell.rowWithColors
        {
          //  print(PodcastData?.podcastList?[index].title)
         //   print(PodcastData?.podcastList?[rowindex].title)

            let item = PodcastData?.podcastList?[rowindex]
            print(item?.type)
            if item?.type == "Audio"
            {
                let item = colorsRow[index]
                let storyBoard: UIStoryboard = UIStoryboard(name: "Main", bundle: nil)
                let displayVC = storyBoard.instantiateViewController(withIdentifier: "PodcastListdetails") as! PodcastListdetails
                   displayVC.modalPresentationStyle = .fullScreen
                
                displayVC.podcasturl = item.podcastURL ?? ""
                displayVC.isfrom = "2"
                displayVC.isfromaudiopodcast = "2"
                displayVC.podcasttitle = item.title ?? ""
                displayVC.podcastimage = item.image ?? ""
                    
                self.present(displayVC, animated: true, completion: nil)
            }else if item?.type == "Video"
            {
                
                let item = colorsRow[index]
                
                
                let storyBoard: UIStoryboard = UIStoryboard(name: "Main", bundle: nil)
                let displayVC = storyBoard.instantiateViewController(withIdentifier: "PodcastListdetails") as! PodcastListdetails
                   displayVC.modalPresentationStyle = .fullScreen
               
               if let str = item.podcastURL
               {
                
                if str.contains("www.youtube.com")
                 {
                    print("this is youtube video")
                    let snippet = item.podcastURL

                    
                    if let range = snippet?.range(of: "list=") {
                        let phone = snippet?[range.upperBound...]
                        print(phone) // prints "123.456.7891"
                        displayVC.podcasturl = item.podcastURL ?? ""
                        displayVC.isfrom = "4"
                        displayVC.isfromaudiopodcast = "4"
                        displayVC.youtubeId = "\(phone ?? "")"
                        displayVC.podcasttitle = item.title ?? ""
                        displayVC.podcastimage = item.image ?? ""
                    }

                 }else
                {
                    displayVC.podcasturl = item.podcastURL ?? ""
                    displayVC.isfrom = "3"
                    displayVC.isfromaudiopodcast = "2"
                    displayVC.podcasttitle = item.title ?? ""
                    displayVC.podcastimage = item.image ?? ""
                }
               }
                
                let navController = UINavigationController(rootViewController: displayVC) // Creating a navigation controller with VC1 at the root of the navigation stack.
                navController.navigationBar.barTintColor = Appcolor.backgorund3
               navController.modalPresentationStyle = .fullScreen
                 let textAttributes = [NSAttributedString.Key.foregroundColor:UIColor.white,NSAttributedString.Key.font: UIFont(name: "Muli-ExtraBold", size: 19)!]
                 navController.navigationBar.titleTextAttributes = textAttributes
                self.present(navController, animated:true, completion: nil)
               // self.present(displayVC, animated: true)

            }
        }

    }
    
}
     
    extension FeatureHomeVC: CollectionViewCellDelegate
    {
        func collectionView(collectionviewcell: CollectionViewCell?, index: Int, rowindex: Int, didTappedInTableViewCell: TableViewCell) {

                
               if let colorsRow = didTappedInTableViewCell.rowWithColors
                      {
                           passarray = newFeaturedList?.subComedymovList?[rowindex]

                if passarray?.title == "Latest News" || passarray?.title == "Daily News" || passarray?.title == "Weather Reports"
                {
                    self.tappedCell = colorsRow[index]
                    imagename = tappedCell?.poster ?? ""
                    moviename = tappedCell?.title ?? ""
                    movietype = tappedCell?.poster ?? ""
                    movdescription = tappedCell?.poster ?? ""
                    imdbId = tappedCell?.custom?.customimdb?.field_value ?? ""
                    movieuniqid = tappedCell?.movie_uniq_id ?? ""
                    perma = tappedCell?.c_permalink ?? ""
                    newperma = tappedCell?.permalink ?? ""
                    Isfavourite = tappedCell?.is_fav_status ?? 0
                    WatchDuration = tappedCell?.watch_duration_in_seconds ?? 0
                    contenttypesid = tappedCell?.content_types_id ?? ""
                   let movieid = tappedCell?.movie_uniq_id ?? ""
                 
                    passarray?.contents?.remove(at: index)
                  // getcontentauthorised(movieid: movieid)
         
         self.getcontentauthorized(movieid: tappedCell?.movie_uniq_id ?? "", planurls: "", index: index, permad: tappedCell?.c_permalink ?? "", isbanner: 4)
                }else
                {
                    if UserDefaults.standard.bool(forKey: "isLoggedin") == true
                    {
                        self.tappedCell = colorsRow[index]
                        imagename = tappedCell?.poster ?? ""
                        moviename = tappedCell?.title ?? ""
                        movietype = tappedCell?.poster ?? ""
                        movdescription = tappedCell?.poster ?? ""
                        imdbId = tappedCell?.custom?.customimdb?.field_value ?? ""
                        movieuniqid = tappedCell?.movie_uniq_id ?? ""
                        perma = tappedCell?.c_permalink ?? ""
                        newperma = tappedCell?.permalink ?? ""
                        Isfavourite = tappedCell?.is_fav_status ?? 0
                        WatchDuration = tappedCell?.watch_duration_in_seconds ?? 0
                        contenttypesid = tappedCell?.content_types_id ?? ""
                       let movieid = tappedCell?.movie_uniq_id ?? ""
                     
                        passarray?.contents?.remove(at: index)
                      // getcontentauthorised(movieid: movieid)
             
             self.getcontentauthorized(movieid: tappedCell?.movie_uniq_id ?? "", planurls: "", index: index, permad: tappedCell?.c_permalink ?? "", isbanner: 4)
                
                    }else
                    {
                        self.checkLogin()
                    }
                }

                       
               }

            
            
        }
        /*
         func collectionView(collectionviewcell: CollectionViewCell?, index: Int, didTappedInTableViewCell: TableViewCell) {
            
            if let colorsRow = didTappedInTableViewCell.rowWithColors
            {
                print(index)
                
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
              //   getcontentauthorised(movieid: tappedCell?.movie_uniq_id ?? "")
                  
             }
         }
        */
        func getcontentauthorisedverified(movieid:String)
        {
            
            
            if contenttypesid == "3"
            {
                let storyBoard: UIStoryboard = UIStoryboard(name: "Main", bundle: nil)
                 let displayVC = storyBoard.instantiateViewController(withIdentifier: "SerirsDetailsVC") as! SerirsDetailsVC
                    displayVC.modalPresentationStyle = .fullScreen
                     
                    displayVC.perma = self.perma
                    displayVC.movieuniqid = self.movieuniqid
                   // displayVC.Movcategory = self.Movcategory
                  //  displayVC.MovSubcategory = self.MovSubcategory
                    displayVC.playerurlstr = self.newperma
                    displayVC.contenttypesid = self.contenttypesid
 
                self.present(displayVC, animated: true, completion: nil)
                
            }else
            {
                 let storyBoard: UIStoryboard = UIStoryboard(name: "Main", bundle: nil)
                 let secondViewController =  storyBoard.instantiateViewController(withIdentifier: "FeaturedHomeDetails") as! FeaturedHomeDetails
                  secondViewController.imagename = self.imagename
                  secondViewController.moviename = self.moviename
                  secondViewController.movietype = self.movietype
                  secondViewController.timereleasedate = self.timereleasedate
                  secondViewController.language = self.language
                  secondViewController.perma = self.perma
                  secondViewController.Movcategory = self.Movcategory
                  secondViewController.MovSubcategory = self.MovSubcategory
                  secondViewController.passarray = self.passarray
                  secondViewController.movieuniqid = self.movieuniqid
                  secondViewController.contenttypesid = self.contenttypesid
                   secondViewController.IsAuthorizedContent = 1
                secondViewController.playerurlstr = self.playerurlstr
                
                self.present(secondViewController, animated: true)
            }
            /*
            Api.IsContentAuthorised(movieid, endpoint: ApiEndPoints.isContentAuthorized, vc: self) { (res, err) -> (Void) in
                                 do
                                 {
                                     let decoder = JSONDecoder()
                                     self.authorizeddata = try decoder.decode(Authorizescontent.self, from: res  ?? Data())
                                    
                                    if self.authorizeddata?.status == "OK"
                                    {
                                         let storyBoard: UIStoryboard = UIStoryboard(name: "Main", bundle: nil)
                                         let secondViewController =  storyBoard.instantiateViewController(withIdentifier: "testdetaisVC") as! testdetaisVC
                                          secondViewController.imagename = self.imagename
                                          secondViewController.moviename = self.moviename
                                          secondViewController.movietype = self.movietype
                                          secondViewController.timereleasedate = self.timereleasedate
                                          secondViewController.language = self.language
                                          secondViewController.perma = self.perma
                                          secondViewController.Movcategory = self.Movcategory
                                          secondViewController.MovSubcategory = self.MovSubcategory
                                        
                                          secondViewController.passarray = self.passarray
                                    
                                        
                                        secondViewController.movieuniqid = self.movieuniqid
                                        secondViewController.contenttypesid = self.contenttypesid
                                        self.present(secondViewController, animated: true)
                                        //self.performSegue(withIdentifier: "todetails", sender: self)
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
                                //     Utility.showAlert(vc: self, message:"\(error)", titelstring: Appcommon.Appname)
                                 }
                             }
            */
        }
        func getcontentauthorisedUnverified(movieid:String)
        {
            
            
            if contenttypesid == "3"
            {
                let storyBoard: UIStoryboard = UIStoryboard(name: "Main", bundle: nil)
                 let displayVC = storyBoard.instantiateViewController(withIdentifier: "SerirsDetailsVC") as! SerirsDetailsVC
                    displayVC.modalPresentationStyle = .fullScreen
                     
                    displayVC.perma = self.perma
                    displayVC.movieuniqid = self.movieuniqid
                   // displayVC.Movcategory = self.Movcategory
                  //  displayVC.MovSubcategory = self.MovSubcategory
                    displayVC.playerurlstr = self.newperma
                    displayVC.contenttypesid = self.contenttypesid
 
                self.present(displayVC, animated: true, completion: nil)
                
            }else
            {
                 let storyBoard: UIStoryboard = UIStoryboard(name: "Main", bundle: nil)
                 let secondViewController =  storyBoard.instantiateViewController(withIdentifier: "FeaturedHomeDetails") as! FeaturedHomeDetails
                  secondViewController.imagename = self.imagename
                  secondViewController.moviename = self.moviename
                  secondViewController.movietype = self.movietype
                  secondViewController.timereleasedate = self.timereleasedate
                  secondViewController.language = self.language
                  secondViewController.perma = self.perma
                  secondViewController.Movcategory = self.Movcategory
                  secondViewController.MovSubcategory = self.MovSubcategory
                  secondViewController.passarray = self.passarray
                  secondViewController.movieuniqid = self.movieuniqid
                  secondViewController.contenttypesid = self.contenttypesid
                 secondViewController.IsAuthorizedContent = 0
                secondViewController.playerurlstr = self.playerurlstr

                self.present(secondViewController, animated: true)
            }
            /*
            Api.IsContentAuthorised(movieid, endpoint: ApiEndPoints.isContentAuthorized, vc: self) { (res, err) -> (Void) in
                                 do
                                 {
                                     let decoder = JSONDecoder()
                                     self.authorizeddata = try decoder.decode(Authorizescontent.self, from: res  ?? Data())
                                    
                                    if self.authorizeddata?.status == "OK"
                                    {
                                         let storyBoard: UIStoryboard = UIStoryboard(name: "Main", bundle: nil)
                                         let secondViewController =  storyBoard.instantiateViewController(withIdentifier: "testdetaisVC") as! testdetaisVC
                                          secondViewController.imagename = self.imagename
                                          secondViewController.moviename = self.moviename
                                          secondViewController.movietype = self.movietype
                                          secondViewController.timereleasedate = self.timereleasedate
                                          secondViewController.language = self.language
                                          secondViewController.perma = self.perma
                                          secondViewController.Movcategory = self.Movcategory
                                          secondViewController.MovSubcategory = self.MovSubcategory
                                        
                                          secondViewController.passarray = self.passarray
                                    
                                        
                                        secondViewController.movieuniqid = self.movieuniqid
                                        secondViewController.contenttypesid = self.contenttypesid
                                        self.present(secondViewController, animated: true)
                                        //self.performSegue(withIdentifier: "todetails", sender: self)
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
                                //     Utility.showAlert(vc: self, message:"\(error)", titelstring: Appcommon.Appname)
                                 }
                             }
            */
        }
     }







//AdMob
extension FeatureHomeVC:GADBannerViewDelegate
{
    func adViewDidReceiveAd(_ bannerView: GADBannerView) {
        print("GADBannerView Add received")
    }
    func adView(_ bannerView: GADBannerView, didFailToReceiveAdWithError error: GADRequestError) {
        print("GADBannerView error: \(error)")
    }
}

extension FeatureHomeVC: UIScrollViewDelegate {
     
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
                print(url)
               imgViewThumbnail.sd_setImage(with: url, completed: nil)
               // imgViewThumbnail.image = UIImage(named: "newlogo")
            }
            let tap = UITapGestureRecognizer(target: self, action: #selector(cellTappedMethod(_:)))
            imgViewThumbnail.isUserInteractionEnabled = true
             imgViewThumbnail.tag = i
             imgViewThumbnail.addGestureRecognizer(tap)
            
            
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
            }else if banerdata[i]["isimage"] == "3"
            {
                button.isHidden = true
                avPlayerLayer.isHidden = true
                imgView.superview?.bringSubviewToFront(imgViewThumbnail)
            }
            else if banerdata[i]["isimage"] == "0"
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
            self.scheduledTimerWithTimeInterval()

        playVideos()
        }
    }
    @objc func cellTappedMethod(_ sender:AnyObject){
         print("you tap image number: \(sender.view.tag)")
      if  banerdata[sender.view.tag]["videourl"] == "1"
      {        guard let url = URL(string: banerdata[sender.view.tag]["actionurl"] ?? "") else { return }
          UIApplication.shared.open(url)
         
        
      }
      else if  banerdata[sender.view.tag]["videourl"] == "3"
      {
      //  self.getcontendeatilsbannerfor(permaas: banerdata[sender.view.tag]["permalink"] ?? "")
      }
      else if banerdata[sender.view.tag]["videourl"] == "2"
      {
        let storyBoard: UIStoryboard = UIStoryboard(name: "Main", bundle: nil)
                  let VC1 = storyBoard.instantiateViewController(withIdentifier: "FeedbackVC") as! FeedbackVC
                //https://funasia.net/bigfantvfeedback.funasia.net/addfeedback.html?
                
                //https://bigfantv.funasia.net/
                //https://funasia.net/bigfantv.funasia.net/
               VC1.planurl = banerdata[sender.view.tag]["actionurl"] ?? ""
                   
                let navController = UINavigationController(rootViewController: VC1) // Creating a navigation controller with VC1 at the root of the navigation stack.
                navController.navigationBar.barTintColor = Appcolor.backgorund3
                navController.modalPresentationStyle = .fullScreen
                 let textAttributes = [NSAttributedString.Key.foregroundColor:UIColor.white,NSAttributedString.Key.font: UIFont(name: "Muli-ExtraBold", size: 19)!]
                 navController.navigationBar.titleTextAttributes = textAttributes
                self.present(navController, animated:true, completion: nil)
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
   
   
   
    
    public func scrollViewDidScroll(_ scrollView: UIScrollView) {
        
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
    
}
extension FeatureHomeVC:MuviAudioPlayerDelegate
{
    func muviAudioPlayerManager(_ playerManager: MuviAudioPlayerManager,
    progressDidUpdate percentage: Double) {
       print("percentage: \(percentage * 100)")
    }
    func muviAudioPlayerManager(_ playerManager: MuviAudioPlayerManager,
    itemDidChange itemIndex: Int) {
        print("itemIndex: \(itemIndex)")
    }
    func muviAudioPlayerManager(_ playerManager: MuviAudioPlayerManager,
    statusDidChange status: MuviAudioPlayerStatus) {
       print("status: \(status)")
    }
    func getCoverImage(_ player: MuviAudioPlayerManager, _ callBack: @escaping
    (UIImage?) -> Void) {
    }
    func muviAudioPlayerAuthentication(code: Int, message: String) {
        print("Code: \(code) ::: \(message)")
    }
}
 
