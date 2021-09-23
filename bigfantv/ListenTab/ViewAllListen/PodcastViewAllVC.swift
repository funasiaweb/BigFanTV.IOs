//
//  PodcastViewAllVC.swift
//  bigfantv
//
//  Created by Ganesh on 30/07/20.
//  Copyright © 2020 Ganesh. All rights reserved.
//

import UIKit
import Alamofire
import MaterialComponents.MaterialDialogs
class PodcastViewAllVC: UIViewController {
   private var VODpodcastedata:PodcastData?
   private var VODNewpodcastedata:NewPodcastData?
   private var VODNewpodcastelist = [NewPodcastDataListDetails]()
  private var VODNewpodcastelistnew = [NewPodcastDataList]()
     private var podcastedata:PodcastData?
     private var Newpodcastedata:NewPodcastData?
     private var Newpodcastelist = [NewPodcastDataListDetails]()
    private var Newpodcastelistnew = [NewPodcastDataList]()
     var tappedCell:NewPodcastDataListDetails?
    private var authorizeddata:Authorizescontent?
 private var audiopodcastdata:AudioPodcastDataList?
    
    var ComedyMoviedata:newFilteredComedyMovieList?
    var actiondata = [newFilteredSubComedymovieList]()
    var podcastcategoryid = ""
      var PodcastRssData:CategoryPodcastdata?
    var maindata = [PodcastList]()
    var index = 1
    var isloading:Bool?
    var totalconents = 0
    var Movcategory = ""
    var MovSubcategory = ""
   var selftitle = ""
  var comedydata = [newFilteredSubComedymovieList]()
    var isfrom = "0"
    var Muvipodcastdata = [PodcastRssfeeddatadetails]()
    var muvititle = ""
    var total = 0
    let manager: Alamofire.SessionManager = {
          let configuration = URLSessionConfiguration.default
           configuration.timeoutIntervalForRequest = TimeInterval(60)
          configuration.timeoutIntervalForResource = TimeInterval(60)
          return  Alamofire.SessionManager(configuration: configuration)
      }()
    @IBOutlet var CollectionV: UICollectionView!
   var cellIdentifier = "cell"
     private let semaphore = DispatchSemaphore(value: 0)
    
    var isaudioorvide0 = ""
    override func viewDidLoad() {
        super.viewDidLoad()
         
        self.title = selftitle
       let cellNib = UINib(nibName: "CollectionViewCellnew", bundle: nil)
    
         self.CollectionV.register(UINib(nibName:"Radiocell", bundle:nil), forCellWithReuseIdentifier: cellIdentifier)
        if isfrom == "1"
        {
            self.loadallpodcasts()
        }else if isfrom == "2"
        {
            self.GetComedyMovielist(offset:1,category:Movcategory,subcategory:MovSubcategory)
        }else if isfrom == "3"
        {
            self.loadallvideopodcasts()
        }else if isfrom == "5"
        {
            self.loadallMuvidata(offset: 1)
        }else
        {
            self.loadallMuvidata(offset: 1)

        }
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        Keycenter.limit = 24
    }
    override func viewWillDisappear(_ animated: Bool) {
        Keycenter.limit = 6
    }
    
    override func viewDidAppear(_ animated: Bool)
      {
       let viewright = UIView(frame: CGRect(x:  0, y: 0, width: 50,height: 30))
                            viewright.backgroundColor = UIColor.clear
                       let  button4 = UIButton(frame: CGRect(x: 0,y: 0, width: 30, height: 30))
                            button4.setImage(UIImage(named: "backarrow"), for: UIControl.State.normal)
                            button4.setTitle("close", for: .normal)
                            button4.addTarget(self, action: #selector(close), for: UIControl.Event.touchUpInside)
                        viewright.addSubview(button4)
                        let leftbuttton = UIBarButtonItem(customView: viewright)
                        self.navigationItem.leftBarButtonItem = leftbuttton
               }
     
               @objc func close()
               {
                   self.dismiss(animated: true, completion: nil)
               }
    
    func loadallMuvidata(offset:Int)
    {
        guard let parameters =
            [
                "podcastCategoryId":podcastcategoryid,
                "offset":"\(offset)"
                ] as? [String:Any] else { return  }
                       print(parameters)
        Common.shared.Commonapi(parameters: parameters, urlString: CommonApiEndPoints.getSpecificCategoryWisePodcast) { (response, err) -> (Void) in
                                                 
            do
             {
                let decoder = JSONDecoder()
                self.PodcastRssData = try decoder.decode(CategoryPodcastdata.self, from: response ?? Data())
                
                if  self.PodcastRssData?.success == 1
                {
                    if self.PodcastRssData?.podcastList.count ?? 0 > 0
                    {
                        let t = self.PodcastRssData?.podcastCount
                        self.total = Int("\(t ?? "0")") ?? 0
                        for i in self.PodcastRssData?.podcastList ?? [PodcastList]()
                        {
                            self.maindata.append(i)
                        }
                        print(self.maindata.count)
                        self.CollectionV.delegate = self
                        self.CollectionV.dataSource = self
                        DispatchQueue.main.async {
                            self.CollectionV.reloadData()
                        }
                        
                        self.isloading = false
                    }else
                    {
                        self.isloading = false
                    }
                    
                    
                  
                }
                
             }
             catch let error
             {
                print(error.localizedDescription)
             }
        }
                      
       
                   
    }
    func GetComedyMovielist(offset:Int,category:String,subcategory:String)
           {
            Common.getpodcastdata(category: "audio-podcast", subcategory: subcategory, vc: self) { (data, err) -> (Void) in
                
                   do
                   {
                   let decoder = JSONDecoder()
                       self.audiopodcastdata = try decoder.decode(AudioPodcastDataList.self, from:  data ?? Data())
                       if self.audiopodcastdata?.status == "OK"
                       {
                        
                           self.CollectionV.delegate = self
                           self.CollectionV.dataSource = self
                           DispatchQueue.main.async {
                               self.CollectionV.reloadData()
                           }
                   
                           
                       }
                       
               }catch
               {
                   print(err?.localizedDescription ?? "")
                   }
               }
       }
    func loadallvideopodcasts()
       {
           Utility.ShowLoader(vc: self)
        let myGroup = DispatchGroup()

        for i in 45 ..< 79
        {
             myGroup.enter()
                let url = "https://funasia-recast.streamguys1.com/api/sgrecast/podcasts/\(i)/5ff373805f760?format=json"
           Alamofire.request(url, parameters: [:]).responseData { response in
           
           
                do
                {
                   if let data = response.data
                   {
                    let decoder = JSONDecoder()
                   self.VODpodcastedata = try decoder.decode(PodcastData.self, from:data)
                   self.VODNewpodcastelist.removeAll()
                  

                   for i in self.VODpodcastedata?.channel?.list ?? [PodcastDataListDetails]()
                   {
                       print(i.title)
                       let myString: String = i.pubDate ?? ""
                       let myStringArr = myString.components(separatedBy: " ")
                       let fr = "\(myStringArr[0]) \(myStringArr[1]) \(myStringArr[2]) \(myStringArr[3])"
                       
                       
                       let myString1: String = i.duration ?? ""
                       let myStringArr1 = myString1.components(separatedBy: ":")
                       let fr1 = "\(myStringArr1[0]) Hr \(myStringArr1[1]) Min \(myStringArr1[2]) Sec"
                       
                       
                       let dt = NewPodcastDataListDetails(title: i.title, itunesimage: i.itunesimage, description:fr, url: i.url, pubDate: fr, duration: fr1)
                       self.VODNewpodcastelist.append(dt)
                   }
                   let titled = self.VODpodcastedata?.channel?.title
                   let itunesimaged = self.VODpodcastedata?.channel?.itunesimage
                   let descriptiond = self.VODpodcastedata?.channel?.description
                   
                   
                   let li = NewPodcastDataList(title: titled, itunesimage: itunesimaged, description: descriptiond, language: "", list: self.VODNewpodcastelist)
                   self.VODNewpodcastedata?.channel?.append(li)
                   
                   self.VODNewpodcastelistnew.append(li)
                 
                   let fv = NewPodcastData(channel: self.VODNewpodcastelistnew)
                   
                   self.VODNewpodcastedata = fv
              
                    self.CollectionV.delegate = self
                    self.CollectionV.dataSource = self
                   
                    DispatchQueue.main.async
                        {
                       self.CollectionV.reloadData()
    
                          self.self.semaphore.signal()
                        }
               }
                }
                catch let error
                {
                    self.semaphore.signal()
                  //  Utility.showAlert(vc: self, message:"\(error)", titelstring: Appcommon.Appname)
                }
                 myGroup.leave()
               Utility.hideLoader(vc: self)
            }
        }

        myGroup.notify(queue: .main) {
            print("Finished all requests.")
        }
       }
    func loadallpodcasts()
       {
           Utility.ShowLoader(vc: self)
        let myGroup = DispatchGroup()

        for i in 2 ..< 42
        {
             myGroup.enter()
               let url = "https://funasia-recast.streamguys1.com/api/sgrecast/podcasts/\(i)/5a8354846ffc8?format=json"
           Alamofire.request(url, parameters: [:]).responseData { response in
           
              // print(response)
                do
                {
                    guard let podcastttdata = response.data else { return }
                    let decoder = JSONDecoder()
                   self.podcastedata = try decoder.decode(PodcastData.self, from:podcastttdata )
                   self.Newpodcastelist.removeAll()
                  

                   for i in self.podcastedata?.channel?.list ?? [PodcastDataListDetails]()
                   {
                       let myString: String = i.pubDate ?? ""
                       let myStringArr = myString.components(separatedBy: " ")
                       let fr = "\(myStringArr[0]) \(myStringArr[1]) \(myStringArr[2]) \(myStringArr[3])"
                       
                       
                       let myString1: String = i.duration ?? ""
                       let myStringArr1 = myString1.components(separatedBy: ":")
                       let fr1 = "\(myStringArr1[0]) Hr \(myStringArr1[1]) Min \(myStringArr1[2]) Sec"
                       
                       
                       let dt = NewPodcastDataListDetails(title: i.title, itunesimage: i.itunesimage, description:fr, url: i.url, pubDate: fr, duration: fr1)
                       self.Newpodcastelist.append(dt)
                   }
                   let titled = self.podcastedata?.channel?.title
                   let itunesimaged = self.podcastedata?.channel?.itunesimage
                   let descriptiond = self.podcastedata?.channel?.description
                   
                   
                   let li = NewPodcastDataList(title: titled, itunesimage: itunesimaged, description: descriptiond, language: "", list: self.Newpodcastelist)
                   self.Newpodcastedata?.channel?.append(li)
                   
                   self.Newpodcastelistnew.append(li)
                 
                   let fv = NewPodcastData(channel: self.Newpodcastelistnew)
                   
                   self.Newpodcastedata = fv
              
                    self.CollectionV.delegate = self
                    self.CollectionV.dataSource = self
                    DispatchQueue.main.async
                        {
                       self.CollectionV.reloadData()
                         if i == 6 || i == 7 || i == 8 || i == 9
                         {
                           Utility.hideLoader(vc: self)
                           }
                          self.self.semaphore.signal()
                        }
                   
                }
                catch let error
                {
                    self.semaphore.signal()
                  //  Utility.showAlert(vc: self, message:"\(error)", titelstring: Appcommon.Appname)
                }
                 myGroup.leave()
               Utility.hideLoader(vc: self)
            }
        }

        myGroup.notify(queue: .main) {
            print("Finished all requests.")
        }
       }
       
    
   

}

extension PodcastViewAllVC:UICollectionViewDelegate,UICollectionViewDataSource
{
     func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if isfrom == "1"
        {
            return Newpodcastedata?.channel?.count ?? 0
        }
        else if isfrom == "2"
        {
            if self.audiopodcastdata?.list?.count ?? 0 <= 0
            {
                self.CollectionV.setEmptyViewnew1(title: "No Podcast available")
            }else
            {
                self.CollectionV.restore()
            }
            return self.audiopodcastdata?.list?.count ?? 0
        }
        else if isfrom == "3"
        {
            return VODNewpodcastedata?.channel?.count ?? 0
        } else if isfrom == "5"
        {
            return Muvipodcastdata.count
        }else
        {
            return self.maindata.count ?? 0
        }
        return 0
        
     }
     
     func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
     
        if isfrom == "1"
        {
                   let Comedycell = collectionView.dequeueReusableCell(withReuseIdentifier: cellIdentifier, for: indexPath) as! Radiocell
               
                   Comedycell.ImgSample.sd_setImage(with: URL(string: "\(Newpodcastedata?.channel?[indexPath.row].itunesimage ?? "")"), completed: nil)
                       Comedycell.LbName.text = Newpodcastedata?.channel?[indexPath.row].title ?? ""
                   return Comedycell
            
        }else if isfrom == "2"
        {
                    let Comedycell = collectionView.dequeueReusableCell(withReuseIdentifier: cellIdentifier, for: indexPath) as! Radiocell
                
                Comedycell.ImgSample.sd_setImage(with: URL(string: "\(audiopodcastdata?.list?[indexPath.row].itunesimage ?? "")"), completed: nil)
             Comedycell.LbName.text = audiopodcastdata?.list?[indexPath.row].title ?? ""
                     
                    return Comedycell
        }else if isfrom == "3"
        {
                    let Comedycell = collectionView.dequeueReusableCell(withReuseIdentifier: cellIdentifier, for: indexPath) as! Radiocell
                
               Comedycell.ImgSample.sd_setImage(with: URL(string: "\(VODNewpodcastedata?.channel?[indexPath.row].itunesimage ?? "")"), completed: nil)
              Comedycell.LbName.text = VODNewpodcastedata?.channel?[indexPath.row].title ?? ""
            return Comedycell

        }else if isfrom == "5"
        {
            let Comedycell = collectionView.dequeueReusableCell(withReuseIdentifier: cellIdentifier, for: indexPath) as! Radiocell
            let item = Muvipodcastdata[indexPath.row]
            Comedycell.ImgSample.sd_setImage(with: URL(string: "\(item.image ?? "")"), completed: nil)
             Comedycell.LbName.text = item.title ?? ""
            return Comedycell

        }else
        {
            let Comedycell = collectionView.dequeueReusableCell(withReuseIdentifier: cellIdentifier, for: indexPath) as! Radiocell
            let item = maindata[indexPath.row]
            Comedycell.ImgSample.sd_setImage(with: URL(string: "\(item.image ?? "")"), completed: nil)
            Comedycell.LbName.text = item.title ?? ""
            return Comedycell
            
        }
        return UICollectionViewCell()
         
     }
     func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
                               
         if isfrom == "2"
         {
             let storyBoard: UIStoryboard = UIStoryboard(name: "Main", bundle: nil)
             let displayVC = storyBoard.instantiateViewController(withIdentifier: "PodcastListdetails") as! PodcastListdetails
                displayVC.modalPresentationStyle = .fullScreen
             
             if let item = self.audiopodcastdata?.list?[indexPath.row]
                 {
                     
                     displayVC.podcasttitle = item.title ?? ""
                     displayVC.podcastimage = item.itunesimage ?? ""
                     displayVC.permalink = item.c_permalink ?? ""
                     displayVC.isfromaudiopodcast = "1"
                 }
                 self.present(displayVC, animated: true, completion: nil)
         }else  if isfrom == "6"
         {

            let item = maindata[indexPath.row]
            if item.type == "0"
            {
                let storyBoard: UIStoryboard = UIStoryboard(name: "Main", bundle: nil)
                          let displayVC = storyBoard.instantiateViewController(withIdentifier: "PodcastListdetails") as! PodcastListdetails
                             displayVC.modalPresentationStyle = .fullScreen
                          
                          let item = maindata[indexPath.row]
                              
                               displayVC.podcasturl = item.podcastURL ?? ""
                                  displayVC.isfrom = "2"
                                 displayVC.isfromaudiopodcast = "2"
                                  displayVC.podcasttitle = item.title ?? ""
                                  displayVC.podcastimage = item.image ?? ""
                               
                              self.present(displayVC, animated: true, completion: nil)
            }else if item.type == "1"
            {
                let storyBoard: UIStoryboard = UIStoryboard(name: "Main", bundle: nil)
                let displayVC = storyBoard.instantiateViewController(withIdentifier: "PodcastListdetails") as! PodcastListdetails
                   displayVC.modalPresentationStyle = .fullScreen
                
                   let item = maindata[indexPath.row]
                    
                        displayVC.podcasturl = item.podcastURL ?? ""
                        displayVC.isfrom = "3"
                         displayVC.isfromaudiopodcast = "2"
                        displayVC.podcasttitle = item.title ?? ""
                        displayVC.podcastimage = item.image ?? ""
                   
                    self.present(displayVC, animated: true, completion: nil)
            }
             
         }else  if isfrom == "5"
         {

            if isaudioorvide0 == "1"
            {
                let storyBoard: UIStoryboard = UIStoryboard(name: "Main", bundle: nil)
                          let displayVC = storyBoard.instantiateViewController(withIdentifier: "PodcastListdetails") as! PodcastListdetails
                             displayVC.modalPresentationStyle = .fullScreen
                          
                          let item = Muvipodcastdata[indexPath.row]
                              
                               displayVC.podcasturl = item.podcastURL ?? ""
                                  displayVC.isfrom = "2"
                                 displayVC.isfromaudiopodcast = "2"
                                  displayVC.podcasttitle = item.title ?? ""
                                  displayVC.podcastimage = item.image ?? ""
                               
                              self.present(displayVC, animated: true, completion: nil)
                
            }else if isaudioorvide0 == "2"
            {
                let storyBoard: UIStoryboard = UIStoryboard(name: "Main", bundle: nil)
                let displayVC = storyBoard.instantiateViewController(withIdentifier: "PodcastListdetails") as! PodcastListdetails
                   displayVC.modalPresentationStyle = .fullScreen
                
                   let item = Muvipodcastdata[indexPath.row]
                    
                        displayVC.podcasturl = item.podcastURL ?? ""
                        displayVC.isfrom = "3"
                         displayVC.isfromaudiopodcast = "2"
                        displayVC.podcasttitle = item.title ?? ""
                        displayVC.podcastimage = item.image ?? ""
                   
                    self.present(displayVC, animated: true, completion: nil)
                
            }
         }else  if isfrom == "1"
         
         {
         let storyBoard: UIStoryboard = UIStoryboard(name: "Main", bundle: nil)
         let displayVC = storyBoard.instantiateViewController(withIdentifier: "PodcastListdetails") as! PodcastListdetails
            displayVC.modalPresentationStyle = .fullScreen
         
         if let item = self.Newpodcastedata?.channel?[indexPath.row].list
         {
                 
            
                 displayVC.podcastdata = item
                 displayVC.podcasttitle = self.Newpodcastedata?.channel?[indexPath.row].title ?? ""
                 displayVC.podcastimage = self.Newpodcastedata?.channel?[indexPath.row].itunesimage ?? ""
             }
             self.present(displayVC, animated: true, completion: nil)
     }else  if isfrom == "3"
         
         {
         let storyBoard: UIStoryboard = UIStoryboard(name: "Main", bundle: nil)
         let displayVC = storyBoard.instantiateViewController(withIdentifier: "PodcastListdetails") as! PodcastListdetails
            displayVC.modalPresentationStyle = .fullScreen
         
         if let item = self.VODNewpodcastedata?.channel?[indexPath.row].list
             {
                 displayVC.podcastdata = item
                 displayVC.podcasttitle = self.VODNewpodcastedata?.channel?[indexPath.row].title ?? ""
                 displayVC.podcastimage = self.VODNewpodcastedata?.channel?[indexPath.row].itunesimage ?? ""
             }
             self.present(displayVC, animated: true, completion: nil)
     }
     }
     
      func collectionView(_ collectionView: UICollectionView, willDisplay cell: UICollectionViewCell, forItemAt indexPath: IndexPath)
      {
         if isfrom == "6"
         {
            if maindata.count < self.total
            {
            if indexPath.row == maindata.count - 1 && !(isloading ?? false)
            {  //numberofitem count
                isloading = true
               index = index + 1
               self.loadallMuvidata(offset: index)
                
            }
            }
            
        }else
         {
         if comedydata.count < totalconents
             {
       
                 if indexPath.row == comedydata.count - 1 && !(isloading ?? false)
                 {  //numberofitem count
                     isloading = true
                    index = index + 1
                    self.GetComedyMovielist(offset: index, category: Movcategory, subcategory: MovSubcategory)
                     
                 }
            }
        }
      }
    /*
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
        let item = Loadhomedata?.contents?[indexPath.row]
                     
                   imagename = item?.poster ?? ""
                   moviename = item?.title ?? ""
                   movietype = item?.poster ?? ""
                   imdbId = item?.custom?.customimdb?.field_value ?? ""
                   movieuniqid =  item?.movie_uniq_id ?? ""
                   perma = item?.c_permalink ?? ""
                   Isfavourite = item?.is_fav_status ?? 0
                   WatchDuration = item?.watch_duration_in_seconds ?? 0
                  getcontentauthorised(movieid: item?.movie_uniq_id ?? "")
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
                                    // self.performSegue(withIdentifier: "tomoviedetails", sender: self)
                                        
                                 }
                              }
                              catch let error
                              {
                                  Utility.showAlert(vc: self, message:"\(error)", titelstring: Appcommon.Appname)
                              }
                          }
     }
     
    */
   
}
   
extension PodcastViewAllVC: UICollectionViewDelegateFlowLayout
{
        func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
            /*
            if UIDevice.current.userInterfaceIdiom == .pad
            {
                return CGSize(width: 200, height:collectionView.frame.size.height)
            }
            else if UIDevice.current.userInterfaceIdiom == .phone
            {
                let width = collectionView.frame.size.width/2 - 5
                return CGSize(width: width, height:140)
                     
                   }
            */
            let width = collectionView.frame.size.width/2 - 5
            return CGSize(width: width, height:140)
        }
     
   
    }
 


//fspager

 

