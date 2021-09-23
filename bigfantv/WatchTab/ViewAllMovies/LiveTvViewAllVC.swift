
//
//  ComedyViewAllVC.swift
//  bigfantv
//
//  Created by Ganesh on 28/07/20.
//  Copyright © 2020 Ganesh. All rights reserved.
//

import UIKit
import MaterialComponents.MaterialDialogs
class LiveTvViewAllVC: UIViewController {
    @IBOutlet var ComedyCollectionV: UICollectionView!
  
     var Loadhomedata:FeaturedDataList?
    var ComedyMoviedata:newFilteredComedyMovieList?
    var ThrillerMoviedata:newFilteredComedyMovieList?
    var ActionMoviedata:newFilteredComedyMovieList?
    var comedydata = [newFilteredSubComedymovieList]()
    var thrillerdata = [newFilteredSubComedymovieList]()
    var actiondata = [newFilteredSubComedymovieList]()
    var isloading:Bool?
    var spcfcLivetvData:SpecififcLiveTVData?
    var deailspeciflivetvdata = [SpecificCategoryWiseLiveTv]()
    var livetvcategoryid = ""
     private var Successdata:SuccessResponse?
     private var authorizeddata:Authorizescontent?
    var index = 1
    var totalconents = 0
    var Movcategory = ""
    var MovSubcategory = ""
     let cellIdentifier = "cell"
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
    var selftitle = ""
    
    var livetvid = ""
    var Isfavourite = "0"
    var WatchDuration = 0
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.title = selftitle
           self.ComedyCollectionV.register(UINib(nibName:"MyCell", bundle:nil), forCellWithReuseIdentifier: cellIdentifier)
        Timer.scheduledTimer(withTimeInterval: 0.1, repeats: false) { (t) in
            if Connectivity.isConnectedToInternet()
            {
                self.getsimilarcontents(tvid: self.livetvcategoryid, offset: 1)
              
             }
            else
            {
                Utility.Internetconnection(vc: self)
            }
        }
    }
    override func viewWillAppear(_ animated: Bool) {
        Keycenter.limit = 24
    }
    override func viewWillDisappear(_ animated: Bool) {
        Keycenter.limit = 10
    }
    override func viewDidAppear(_ animated: Bool)
    {
          let flowLayout = UICollectionViewFlowLayout()
          flowLayout.scrollDirection = .vertical
        let width = (ComedyCollectionV.frame.size.width - 10)/2
        let height = (width * 156)/280
        flowLayout.itemSize = CGSize(width: width, height: height + 18)
         flowLayout.minimumLineSpacing = 10
         flowLayout.minimumInteritemSpacing = 2
         self.ComedyCollectionV.collectionViewLayout = flowLayout
          self.ComedyCollectionV.showsHorizontalScrollIndicator = false
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

    func getsimilarcontents(tvid:String,offset:Int)
          {
            Utility.ShowLoader(vc: self)
              
            guard let parameters =
                [
                    "userId":UserDefaults.standard.string(forKey: "id") ?? "",
                    "AccessToken":UserDefaults.standard.string(forKey:"AccessToken") ?? "",
                    "offset":offset,
                    "liveTvCategroryId":tvid,
                    "longitude":UserDefaults.standard.string(forKey: "Longitude") ?? "",
                    "latitude":UserDefaults.standard.string(forKey: "Latitude") ?? ""
                ]as? [String:Any] else{return}
  
              Common.shared.Commonapi(parameters: parameters, urlString: CommonApiEndPoints.getSpecificCategoryLiveTv) { (data, err) -> (Void) in
                  do
                  {
                    Utility.hideLoader(vc: self)
                      let deode = JSONDecoder()
                      self.spcfcLivetvData = try deode.decode(SpecififcLiveTVData.self, from: data ?? Data())
                    if self.spcfcLivetvData?.specificCategoryWiseLiveTv?.count ?? 0 > 0
                      {
                        if let total = Int(self.spcfcLivetvData?.totalLiveTVUnderCategory ?? "")
                        {
                            self.totalconents = total
                        }
                        for i  in self.spcfcLivetvData?.specificCategoryWiseLiveTv ?? [SpecificCategoryWiseLiveTv]()
                        {
                            self.deailspeciflivetvdata.append(i)
                        }
                          self.ComedyCollectionV.delegate = self
                          self.ComedyCollectionV.dataSource = self
                          DispatchQueue.main.async {
                            self.isloading = false
                              self.ComedyCollectionV.reloadData()
                          }
                      }
                  }catch
                  {
                    Utility.hideLoader(vc: self)
                      print(error.localizedDescription)
                  }
              }
          }
      
    func GetComedyMovielist(offset:Int,category:String,subcategory:String)
        {
            Utility.ShowLoader(vc: self)
            Api.Getconent(category, subCat: subcategory,endpoint: ApiEndPoints.getFilteredContent, vc: self, offset: offset) { (res, err) -> (Void) in
              do
              {
                Utility.hideLoader(vc: self)
                    let decoder = JSONDecoder()
                  self.ComedyMoviedata = try decoder.decode(newFilteredComedyMovieList.self, from: res ?? Data() )
              
                if let total = Int(self.ComedyMoviedata?.total_content ?? "")
                {
                    
                    self.totalconents = total
                    print(self.totalconents)
                }
                for item in self.ComedyMoviedata?.subComedymovList ?? [newFilteredSubComedymovieList]()
                {
                    self.comedydata.append(item)
                }
                    self.ComedyCollectionV.delegate = self
                    self.ComedyCollectionV.dataSource  = self
                    DispatchQueue.main.async {
                          self.ComedyCollectionV.reloadData()
                        self.isloading = false
                    }
              }
              catch let error
             {
              Utility.showAlert(vc: self, message:"\(err ?? "")", titelstring: Appcommon.Appname)
             }
          }
    }
   
    }
       
    
    
 


extension LiveTvViewAllVC:UICollectionViewDelegate,UICollectionViewDataSource
{
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if deailspeciflivetvdata.count <= 0
        {
            self.ComedyCollectionV.setEmptyViewnew1(title: "No contents found")
        }else
        {
            self.ComedyCollectionV.restore()
        }
        return self.deailspeciflivetvdata.count
          
       
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
    
       
      let Comedycell = collectionView.dequeueReusableCell(withReuseIdentifier: cellIdentifier, for: indexPath) as! MyCell
                
        let item = deailspeciflivetvdata[indexPath.row]
             
        Comedycell.ImgSample.sd_setImage(with: URL(string:item.tvImage ?? ""), completed: nil)
         
        Comedycell.LbName.text = item.title ?? ""
       
        let image = item.isFavourite == "1" ? UIImage(named: "liked") : UIImage(named: "like")
         Comedycell.btnCounter.setBackgroundImage(image, for: .normal)
                   
        Comedycell.actionBlock =
            { () in
                if item.isFavourite == "0"
                {
                    Comedycell.btnCounter.setBackgroundImage(UIImage(named: "liked"), for: .normal)
                    guard let parameters = [
                        "userId":UserDefaults.standard.string(forKey: "id") ?? ""  ,
                        "AccessToken":UserDefaults.standard.string(forKey:"AccessToken") ?? "" ,
                        "liveTvId": item.liveTvID ?? "",
                        "isFavourite":"1"
                        ] as? [String:Any] else {
                        return
                    }
                    Common.shared.Commonapi(parameters: parameters, urlString: CommonApiEndPoints.saveFavouriteLiveTv) { (data, err) -> (Void) in
                        if data != nil
                        {
                            self.spcfcLivetvData?.specificCategoryWiseLiveTv?[indexPath.row].isFavourite = "1"
                            Comedycell.btnCounter.setBackgroundImage(UIImage(named: "liked"), for: .normal)
                            
                        }
                    }
                }else if item.isFavourite == "1"
                {
                     Comedycell.btnCounter.setBackgroundImage(UIImage(named: "like"), for: .normal)
                     guard let parameters = [
                         "userId":UserDefaults.standard.string(forKey: "id") ?? ""  ,
                         "AccessToken":UserDefaults.standard.string(forKey:"AccessToken") ?? "" ,
                         "liveTvId": item.liveTvID ?? "",
                         "isFavourite":"0"
                         ] as? [String:Any] else {
                         return
                     }
                     Common.shared.Commonapi(parameters: parameters, urlString: CommonApiEndPoints.saveFavouriteLiveTv) { (data, err) -> (Void) in
                         if data != nil
                         {
                            self.spcfcLivetvData?.specificCategoryWiseLiveTv?[indexPath.row].isFavourite = "0"
                             Comedycell.btnCounter.setBackgroundImage(UIImage(named: "like"), for: .normal)
                             
                         }
                     }
                }
                      
                   }
                return Comedycell
          
   
        
    }
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath)
    {
        let item = deailspeciflivetvdata[indexPath.row]
        movietype = item.source ?? ""
        moviename = item.title ?? ""
        Isfavourite = item.isFavourite ?? ""
        livetvid = item.liveTvID ?? ""
        getcontentauthorised(movieid: "")
    }
    func getcontentauthorised(movieid:String)
     {
           let storyBoard: UIStoryboard = UIStoryboard(name: "Main", bundle: nil)
           let secondViewController =  storyBoard.instantiateViewController(withIdentifier: "LiveTvDetailsVC") as! LiveTvDetailsVC
           
            secondViewController.moviename = self.moviename
            secondViewController.movietype = self.movietype
           secondViewController.Isfavourite = self.Isfavourite
           secondViewController.livetvCategoryid = self.livetvcategoryid
           secondViewController.livetvid = self.livetvid
          // secondViewController.livetvid = self.livetvid
          self.present(secondViewController, animated: true)
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
                                        displayVC.imagename = self.imagename
                                        displayVC.moviename = self.moviename
                                        displayVC.movietype = self.movietype
                                        displayVC.timereleasedate = self.timereleasedate
                                        displayVC.language = self.language
                                        displayVC.movdescription = self.movdescription
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
        */
     }
     func collectionView(_ collectionView: UICollectionView, willDisplay cell: UICollectionViewCell, forItemAt indexPath: IndexPath)
     {
        if deailspeciflivetvdata.count < totalconents
            {
       
                if indexPath.row == deailspeciflivetvdata.count - 1 && !(isloading ?? false)
                {  //numberofitem count
                    isloading = true
                   index = index + 1
                   self.getsimilarcontents(tvid: livetvcategoryid, offset: index)
                    
                }
           }
      
     }
    
    @objc func buttonClicked(_ sender: UIButton) {
           //Here sender.tag will give you the tapped Button index from the cell
           //You can identify the button from the tag
         
        if ComedyMoviedata?.subComedymovList[sender.tag].is_fav_status == 0
           {
           Api.Addtofavourite(UserDefaults.standard.string(forKey: "id") ?? "", movie_uniq_id: ComedyMoviedata?.subComedymovList[sender.tag].movie_uniq_id ?? "", lang_code: "en", content_type: 0, endpoint: ApiEndPoints.AddToFavlist, vc: self)  { (res, err) -> (Void) in
                               do
                               {
                                   let decoder = JSONDecoder()
                                   self.Successdata = try decoder.decode(SuccessResponse.self, from: res  ?? Data())
                                   if self.Successdata?.code == 200
                                   {
                                     
                                       sender.setBackgroundImage(UIImage(named: "liked"), for: .normal)
                                //    self.GetComedyMovielist(offset: self.index, category: self.Movcategory, subcategory: self.MovSubcategory)
                                   }
                                  
                               }
                               catch let error
                               {
                                   Utility.showAlert(vc: self, message:"\(error)", titelstring: Appcommon.Appname)
                               }
                           }
           }else if ComedyMoviedata?.subComedymovList[sender.tag].is_fav_status == 1
           {
               Api.Addtofavourite(UserDefaults.standard.string(forKey: "id") ?? "", movie_uniq_id: ComedyMoviedata?.subComedymovList[sender.tag].movie_uniq_id ?? "", lang_code: "en", content_type: 0, endpoint: ApiEndPoints.DeleteFavLIst, vc: self)  { (res, err) -> (Void) in
                                          do
                                          {
                                              let decoder = JSONDecoder()
                                              self.Successdata = try decoder.decode(SuccessResponse.self, from: res  ?? Data())
                                           
                                              if self.Successdata?.code == 200
                                              {
                                                
                                                  sender.setBackgroundImage(UIImage(named: "like"), for: .normal)
                                             //  self.GetComedyMovielist(offset: self.index, category: self.Movcategory, subcategory: self.MovSubcategory)
                                              }
                                             
                                          }
                                          catch let error
                                          {
                                              Utility.showAlert(vc: self, message:"\(error)", titelstring: Appcommon.Appname)
                                          }
                                      }
           }
       }
}
 

//fspager

 
