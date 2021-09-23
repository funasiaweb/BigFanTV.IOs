//
//  PodcastLstVC.swift
//  bigfantv
//
//  Created by Ganesh on 30/07/20.
//  Copyright © 2020 Ganesh. All rights reserved.
//

import UIKit
import Alamofire
import MaterialComponents.MaterialDialogs
class PodcastLstVC: UIViewController {
  
    
        private var podcastedata:PodcastData?
        private var Newpodcastedata:NewPodcastData?
        private var Newpodcastelist = [NewPodcastDataListDetails]()
       private var Newpodcastelistnew = [NewPodcastDataList]()
    
     private var VODpodcastedata:PodcastData?
     private var VODNewpodcastedata:NewPodcastData?
     private var VODNewpodcastelist = [NewPodcastDataListDetails]()
    private var VODNewpodcastelistnew = [NewPodcastDataList]()
        
       private var authorizeddata:Authorizescontent?
    private var audiopodcastdata:AudioPodcastDataList?
    private var VODdata:AudioPodcastDataList?
    private var subcatdata:SubcategoryData?
    
    
    var Audiolist = [MainAudiopodcastDataList]()
    
     private var Mainpodcastedata:MainAudiopodcastData?
    var tappedCell:AudioPodcastDataListDetails?
        @IBOutlet var ComedyCollectionV: UICollectionView!
        
        @IBOutlet var ThrillerCollectionV: UICollectionView!
        
        @IBOutlet var ActionCollectioV: UICollectionView!
     @IBOutlet var VODCollectioV: UICollectionView!
        
        
    @IBOutlet var AudiopodCollectionV: UICollectionView!
    private let semaphore = DispatchSemaphore(value: 0)
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
           var movieuiqid = ""
    var playerurls = ""
    var selftitle = ""
    var timed = ""
    var pubdate = ""
    var isfrom = "0"
    var muvititle = ""
     var isaudioorvide0 = ""
    @IBOutlet var Collectionheight: NSLayoutConstraint!
    
    @IBOutlet var Tablevheight: NSLayoutConstraint!
    @IBOutlet var TableV: UITableView!
    @IBOutlet var tableView: UITableView!
    let manager: Alamofire.SessionManager = {
        let configuration = URLSessionConfiguration.default
         configuration.timeoutIntervalForRequest = TimeInterval(60)
        configuration.timeoutIntervalForResource = TimeInterval(60)
        return  Alamofire.SessionManager(configuration: configuration)
    }()
    var PodcastRssData:PodcastRssfeeddata?
    override func viewDidLoad() {
               super.viewDidLoad()
             let cellNib = UINib(nibName: "podcastTableViewCell", bundle: nil)
             self.TableV?.register(cellNib, forCellReuseIdentifier: "tableviewcellid")

             TableV?.backgroundColor = Appcolor.backgorund4
            // tableView?.isScrollEnabled = false
             TableV?.allowsMultipleSelection = true
             self.TableV?.delegate = self
             self.TableV?.dataSource = self
         
        
        self.ComedyCollectionV.register(UINib(nibName:"Radiocell", bundle:nil), forCellWithReuseIdentifier: cellIdentifier)
        self.AudiopodCollectionV.register(UINib(nibName:"Radiocell", bundle:nil), forCellWithReuseIdentifier: cellIdentifier)
       self.VODCollectioV.register(UINib(nibName:"Radiocell", bundle:nil), forCellWithReuseIdentifier: cellIdentifier)
               
        Timer.scheduledTimer(withTimeInterval: 0.01, repeats: false) { (t) in
            if Connectivity.isConnectedToInternet()
            {
                    //  self.loadallpodcasts()
                     
                self.getsubcategorylist()
                self.Loadalldata()
                    
                    // self.loadallvideopodcasts()
 /*
                    Common.getpodcastdata(category: "audio-podcast", subcategory: "", vc: self) { (data, err) -> (Void) in
                     
                        do
                        {
                        let decoder = JSONDecoder()
                            self.audiopodcastdata = try decoder.decode(AudioPodcastDataList.self, from:  data ?? Data())
                            if self.audiopodcastdata?.status == "OK"
                            {
                                self.AudiopodCollectionV.delegate = self
                                self.AudiopodCollectionV.dataSource = self
                                DispatchQueue.main.async {
                                    self.AudiopodCollectionV.reloadData()
                                }
                        
                                
                            }
                            
                    }catch
                    {
                        print(err?.localizedDescription ?? "")
                        }
                    }
                      */
                   }else
                   {
                       Utility.Internetconnection(vc: self)
                   }
               }
                  
             
        }
        override func viewDidAppear(_ animated: Bool) {

        }
    func Loadalldata()
           {
                guard let parameters =
                    [
                        "userId":UserDefaults.standard.string(forKey: "id") ?? "",
                        "AccessToken":UserDefaults.standard.string(forKey: "AccessToken") ?? "",
                        "offset":"1"
                    ] as? [String:Any] else { return  }
                  print(parameters)
            
        let url:URL = URL(string: "https://funasia.net/bigfantv.funasia.net/service/getAllPodcastList.html")!
                    
                     
                   manager.request(url, method: .post, parameters: parameters, encoding: JSONEncoding.default, headers: nil).responseJSON { (response) in
                 
                    print("podcastresponse = \(response)")
                        switch response.result
                        {

                   
                        case .success(_):
                       
                            if response.value != nil
                            {
                               do
                                {
                                   let decoder = JSONDecoder()
                                   self.PodcastRssData = try decoder.decode(PodcastRssfeeddata.self, from: response.data ?? Data())
                                   
                                   if  self.PodcastRssData?.success == 1
                                   {
                                    
                                    
                                    if self.PodcastRssData?.podcastList?.count ?? 0 > 0
                                    {
                                       self.ComedyCollectionV.delegate = self
                                       self.ComedyCollectionV.dataSource = self
                                        DispatchQueue.main.async {
                                            self.ComedyCollectionV.reloadData()
                                        // self.VODCollectioV.reloadData()
                                         
                                        }
                                        
                                        if self.PodcastRssData?.podcastList?.count ?? 0 >= 2
                                        {

                                        self.VODCollectioV.delegate = self
                                      self.VODCollectioV.dataSource = self
                                       DispatchQueue.main.async {
                                         //  self.ComedyCollectionV.reloadData()
                                        self.VODCollectioV.reloadData()
                                        
                                       }
                                        }
                                    }
                                       
                                   }
                                   
                                }
                                catch let error
                                {
                                   print(error.localizedDescription)
                                }
                        }
                        break
                    case .failure(let error):
                        print(error)
                        break
                    }
                }
               
           }
           
    func getsubcategorylist()
    {
        Api.Getsubcategory(endpoint: ApiEndPoints.getSubcategoryList, vc: self) { (data, err) -> (Void) in
            let decoder = JSONDecoder()
            do
            {
                self.subcatdata = try decoder.decode(SubcategoryData.self, from: data ?? Data())
                if self.subcatdata?.status == "OK"
                {
                    guard let count = self.subcatdata?.subCategoryList?.count else{return}
                    for i in 0..<count
                    {
                        Common.getpodcastdata(category: "audio-podcast", subcategory: self.subcatdata?.subCategoryList?[i].permalink ?? "", vc: self) { (data, err) -> (Void) in
                       do
                        {
                        let decoder = JSONDecoder()
                            self.audiopodcastdata = try decoder.decode(AudioPodcastDataList.self, from:  data ?? Data())
                            if self.audiopodcastdata?.status == "OK"
                            {
                                var r = [AudioPodcastDataListDetails]()
                                if self.audiopodcastdata?.list?.count ?? 0 > 0
                                {
                                    for id in self.audiopodcastdata?.list ?? [AudioPodcastDataListDetails]()
                                    {
                                        let u = AudioPodcastDataListDetails(title: id.title, itunesimage: id.itunesimage, c_permalink: id.c_permalink)
                                        r.append(u)
                                    }
                                    let audiodata = MainAudiopodcastDataList(permalink: "", title: self.subcatdata?.subCategoryList?[i].subcatName, contents: r)
                                    self.Audiolist.append(audiodata)
                                    
                                    let maindata = MainAudiopodcastData(code: 0, status: "ok", subComedymovList: self.Audiolist)
                                    self.Mainpodcastedata = maindata
                                    
                                    DispatchQueue.main.async
                                        {
                                            self.TableV.reloadData()
                                            self.Tablevheight.constant = CGFloat(160 * (self.Mainpodcastedata?.subComedymovList?.count ?? 0) ) + 50
                                            self.view.layoutIfNeeded()
                                    }
                                }
                            }
                       }catch
                       {
                        print(err?.localizedDescription ?? "")
                        }
                    }
                }
                
/*
                 //for i in self.subcatdata?.subCategoryList ?? [SubCategoryList]()
                //{
                    Common.getfeiltereddata(category:"audio-podcast", subcategory: "comedy1") { (data, err) -> (Void) in
                        
 
                        print(data?.subComedymovList.count)
                        
                        let audiodata = MainAudiopodcastDataList(title: "comedy1", contents: data?.subComedymovList)
                        self.Audiolist.append(audiodata)
 let maindata = MainAudiopodcastData(code: 0, status: "ok", subComedymovList: self.Audiolist)
 
 self.Mainpodcastedata = maindata
 
 print("count===\(self.Mainpodcastedata?.subComedymovList?.count)")
                    }
                
              //  }
                
*/

                
         
            }
            }catch
            {
                print("error.localizedDescription \(error.localizedDescription)")
            }
            }
    }
    
    
     
    func loadallpodcasts()
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
           
                 self.VODCollectioV.delegate = self
                 self.VODCollectioV.dataSource = self
                
                 DispatchQueue.main.async
                     {
                    self.VODCollectioV.reloadData()
 
                       
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
    func loadallvideopodcasts()
       {
            
        let myGroup = DispatchGroup()

        for i in 2 ..< 8
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
              
                    self.ComedyCollectionV.delegate = self
                    self.ComedyCollectionV.dataSource = self
                    Utility.hideLoader(vc: self)
                    DispatchQueue.main.async
                        {
                       self.ComedyCollectionV.reloadData()
                         if i == 5 || i == 6
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
      
    
     func secondsToHoursMinutesSeconds (seconds : Int) -> (Int, Int, Int) {
       return (seconds / 3600, (seconds % 3600) / 60, (seconds % 3600) % 60)
     }
   
        
        @IBAction func ViewAllcomedyBtTapped(_ sender: UIButton) {
                  if sender.tag == 1
                  {
                    isfrom = "5"
                    selftitle = "BigFan Originals"
                    muvititle = "Audio"
                    isaudioorvide0 = "1"
                  }else if sender.tag == 2
                  {
                      Movcategory = "audio-podcast"
                      MovSubcategory = ""
                    isfrom = "2"
                    selftitle = "Audio Podcast"
                  }else if sender.tag == 3
                     {
                       isfrom = "5"
                       selftitle = "Video on demand"
                        muvititle = "Video"
                        isaudioorvide0 = "2"

                     }
                  
                let storyBoard : UIStoryboard = UIStoryboard(name: "Main", bundle: nil)
                  let VC1 = storyBoard.instantiateViewController(withIdentifier: "PodcastViewAllVC") as! PodcastViewAllVC
                   VC1.Movcategory = Movcategory
                   VC1.MovSubcategory = MovSubcategory
                    VC1.selftitle = selftitle
                    VC1.isfrom = isfrom
                    VC1.muvititle = muvititle
                   VC1.isaudioorvide0 = isaudioorvide0
            
                  let navController = UINavigationController(rootViewController: VC1) // Creating a navigation controller with VC1 at the root of the navigation stack.
                 navController.navigationBar.barTintColor = Appcolor.backgorund3
                 let textAttributes = [NSAttributedString.Key.foregroundColor:UIColor.white,NSAttributedString.Key.font: UIFont(name: "Muli-ExtraBold", size: 19)!]
                 navController.navigationBar.titleTextAttributes = textAttributes
                   navController.navigationBar.isTranslucent = false
                 navController.modalPresentationStyle = .fullScreen
                  self.present(navController, animated:true, completion: nil)
              }
      
        
    }



extension PodcastLstVC:UICollectionViewDelegate,UICollectionViewDataSource
{
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
       if collectionView == AudiopodCollectionV
       {
         
        return self.PodcastRssData?.podcastList?[0].podcast?.count ?? 0
        }
       else if collectionView == VODCollectioV
       {
        return self.PodcastRssData?.podcastList?[0].podcast?.count ?? 0
       }else if collectionView == ComedyCollectionV
       {
        return self.PodcastRssData?.podcastList?[1].podcast?.count ?? 0
        }
         return 0
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        if collectionView == AudiopodCollectionV
        {
            let Comedycell = collectionView.dequeueReusableCell(withReuseIdentifier: cellIdentifier, for: indexPath) as! Radiocell
          
            Comedycell.ImgSample.sd_setImage(with: URL(string: "\(self.PodcastRssData?.podcastList?[0].podcast?[indexPath.row].image ?? "")"), completed: nil)
             Comedycell.LbName.text = self.PodcastRssData?.podcastList?[0].podcast?[indexPath.row].title ?? ""
             
            return Comedycell
            
        }else if collectionView == ComedyCollectionV
        {
                let Comedycell = collectionView.dequeueReusableCell(withReuseIdentifier: cellIdentifier, for: indexPath) as! Radiocell
                  
                    Comedycell.ImgSample.sd_setImage(with: URL(string: "\(self.PodcastRssData?.podcastList?[1].podcast?[indexPath.row].image ?? "")"), completed: nil)
                     Comedycell.LbName.text = self.PodcastRssData?.podcastList?[1].podcast?[indexPath.row].title ?? ""
                     
                    return Comedycell
                    
        }else if collectionView == VODCollectioV
        {
                let Comedycell = collectionView.dequeueReusableCell(withReuseIdentifier: cellIdentifier, for: indexPath) as! Radiocell
            
            Comedycell.ImgSample.sd_setImage(with: URL(string: "\(self.PodcastRssData?.podcastList?[0].podcast?[indexPath.row].image ?? "")"), completed: nil)
             Comedycell.LbName.text = self.PodcastRssData?.podcastList?[0].podcast?[indexPath.row].title ?? ""
                 
                return Comedycell
        }
        return UICollectionViewCell()
    }
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
 
        if collectionView == AudiopodCollectionV
        {
                let storyBoard : UIStoryboard = UIStoryboard(name: "Main", bundle: nil)
                  let VC1 = storyBoard.instantiateViewController(withIdentifier: "PodcastViewAllVC") as! PodcastViewAllVC
                  
                    VC1.Movcategory = "audio-podcast"
                     VC1.MovSubcategory = self.subcatdata?.subCategoryList?[indexPath.row].permalink ?? ""
                    VC1.selftitle = self.subcatdata?.subCategoryList?[indexPath.row].subcatName ?? ""
                    VC1.isfrom =  "2"
            
                  let navController = UINavigationController(rootViewController: VC1) // Creating a navigation controller with VC1 at the root of the navigation stack.
                 navController.navigationBar.barTintColor = Appcolor.backgorund3
                 let textAttributes = [NSAttributedString.Key.foregroundColor:UIColor.white,NSAttributedString.Key.font: UIFont(name: "Muli-ExtraBold", size: 19)!]
                 navController.navigationBar.titleTextAttributes = textAttributes
                   navController.navigationBar.isTranslucent = false
                 navController.modalPresentationStyle = .fullScreen
                  self.present(navController, animated:true, completion: nil)
        }else if collectionView == VODCollectioV
            
            {
            let storyBoard: UIStoryboard = UIStoryboard(name: "Main", bundle: nil)
            let displayVC = storyBoard.instantiateViewController(withIdentifier: "PodcastListdetails") as! PodcastListdetails
               displayVC.modalPresentationStyle = .fullScreen
            
            if let item = self.PodcastRssData?.podcastList?[0].podcast?[indexPath.row]
                {
                
                if let str = item.podcastURL
                {
                 
                 if str.contains("www.youtube.com")
                  {
                     print("this is youtube video")
                     let snippet = item.podcastURL

                     
                     if let range = snippet?.range(of: "list=") {
                         let phone = snippet?[range.upperBound...]
                         //print(phone) // prints "123.456.7891"
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
                }
                self.present(displayVC, animated: true, completion: nil)
        }else
        
        {
         let storyBoard: UIStoryboard = UIStoryboard(name: "Main", bundle: nil)
                   let displayVC = storyBoard.instantiateViewController(withIdentifier: "PodcastListdetails") as! PodcastListdetails
                      displayVC.modalPresentationStyle = .fullScreen
                   
                   if let item = self.PodcastRssData?.podcastList?[1].podcast?[indexPath.row]
                       {
                        displayVC.podcasturl = item.podcastURL ?? ""
                           displayVC.isfrom = "2"
                          displayVC.isfromaudiopodcast = "2"
                           displayVC.podcasttitle = item.title ?? ""
                           displayVC.podcastimage = item.image ?? ""
                       }
                       self.present(displayVC, animated: true, completion: nil)
    }
    }
    
    
}
extension PodcastLstVC: UICollectionViewDelegateFlowLayout
   {
           func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
               /*
               if UIDevice.current.userInterfaceIdiom == .pad
               {
                   return CGSize(width: collectionView.frame.size.height + 40, height:collectionView.frame.size.height)
               }
               else if UIDevice.current.userInterfaceIdiom == .phone
               {
                if collectionView == AudiopodCollectionV
                {
                    return CGSize(width: collectionView.frame.size.width/2 - 5, height:140 )
                }else
                {
                let width = collectionView.frame.size.width / 1.6
                return CGSize(width:width, height:collectionView.frame.size.height )
                }
            }
               */
                        if collectionView == AudiopodCollectionV
               {
                   return CGSize(width: collectionView.frame.size.width/2 - 5, height:140 )
               }else
               {
               let width = collectionView.frame.size.width / 1.6
               return CGSize(width:width, height:collectionView.frame.size.height )
               }
           }
        
      
       }
    


extension PodcastLstVC:UITableViewDelegate,UITableViewDataSource
{
    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        //Tablevheight.constant = TableV.contentSize.height
    }
    public func numberOfSections(in tableView: UITableView) -> Int {
        return Mainpodcastedata?.subComedymovList?.count ?? 0
               }
    
    public func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
                   return 1
               }
               
    public func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
                return   160
               }
 
    public func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
                 let headerView = UIView()
                 headerView.backgroundColor = Appcolor.backgorund4
                 
                 let whiteview = UIView(frame: CGRect(x: 16, y: 14, width: 4, height: 16))
                     whiteview.backgroundColor = UIColor.white
                  headerView.addSubview(whiteview)
                 
             let button = UIButton(frame: CGRect(x: ((self.TableV?.frame.size.width ?? 414) - 26)  , y: 10, width: 22, height: 22))
                 button.tag = section
                 button.addTarget(self, action: #selector(loaddata(_:)), for: .touchUpInside)
                 button.setBackgroundImage(UIImage(named: "viewall"), for: .normal)
                // headerView.addSubview(button)
                 
                 let titleLabel = UILabel(frame: CGRect(x: 32, y: 0, width: 200, height: 44))
                 headerView.addSubview(titleLabel)
                 titleLabel.textColor = UIColor.white
                 titleLabel.font =  UIFont(name: "Muli-SemiBold", size: 17)!
                titleLabel.text = Mainpodcastedata?.subComedymovList?[section].title
                // titleLabel.text = Mainpodcastedata?.List?[section].headertitle
                 return headerView
             }
    
    @objc func loaddata(_ sender:UIButton)
    {
        /*
        let storyBoard: UIStoryboard = UIStoryboard(name: "Main", bundle: nil)
        let VC1 = storyBoard.instantiateViewController(withIdentifier: "ViewAllhomeVC") as! ViewAllhomeVC
                VC1.Loadhomedata = newFeaturedList?.subComedymovList?[sender.tag]
        VC1.sectionnumber = sender.tag
        VC1.totalconents = newFeaturedList?.subComedymovList?[sender.tag].total ?? 0
          let navController = UINavigationController(rootViewController: VC1) // Creating a navigation controller with VC1 at the root of the navl,jidcmkdsjadioejfcljjcnmigation stack.
         navController.navigationBar.barTintColor = Appcolor.backgorund3
         navController.modalPresentationStyle = .fullScreen
         self.present(navController, animated:true, completion: nil)
        */
    }
             
    public func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
                 return 44
             }
    public func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell
    {
                 if let cell = tableView.dequeueReusableCell(withIdentifier: "tableviewcellid", for: indexPath) as? podcastTableViewCell {
                   if let rowarra = Mainpodcastedata?.subComedymovList?[indexPath.section].contents
                       //let rowArray = (newFeaturedList?.subComedymovList?[indexPath.section].contents)!
                   {
                    cell.updateCellWith(row: rowarra, rowindex: indexPath.section)
 
                    cell.cellDelegate = self
                     
                     cell.selectionStyle = .none
                     return cell
                }
        }
                 return UITableViewCell()
             }

       
    }
extension PodcastLstVC: CollectionViewCellDelegate1
{
    func collectionView(collectionviewcell: CollectionViewCellnew?, index: Int, rowindex: Int, didTappedInTableViewCell: podcastTableViewCell) {
        if let colorsRow = didTappedInTableViewCell.rowWithColors
                {
                     
                    
                    self.tappedCell = colorsRow[index]
                    let storyBoard: UIStoryboard = UIStoryboard(name: "Main", bundle: nil)
                    let displayVC = storyBoard.instantiateViewController(withIdentifier: "PodcastListdetails") as! PodcastListdetails
                       displayVC.modalPresentationStyle = .fullScreen
                         
                   
            
                  
                    displayVC.permalink = tappedCell?.c_permalink ?? ""
                            displayVC.isfromaudiopodcast = "1"
                    displayVC.podcasttitle = tappedCell?.title ?? ""
                           displayVC.podcastimage = tappedCell?.itunesimage ?? ""
                        
                        self.present(displayVC, animated: true, completion: nil)
                    
        }
    }
    
     
    }
