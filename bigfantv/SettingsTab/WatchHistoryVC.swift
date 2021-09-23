
//
//  WatchHistoryVC.swift
//  bigfantv
//
//  Created by Ganesh on 28/07/20.
//  Copyright © 2020 Ganesh. All rights reserved.
//

import UIKit
import MaterialComponents.MaterialDialogs
class WatchHistoryVC: UIViewController
{
    @IBOutlet var ComedyCollectionV: UICollectionView!
    private var WatchhistoryListdata:WatchhistoryList?

      private var ComedyMoviedata:newFilteredComedyMovieList?
      private var Successdata:SuccessResponse?
      private var authorizeddata:Authorizescontent?
     private var  passComedyMoviedata:newFilteredSubComedymovieList?
     private var comedydata = [Watchhistorydeatails]()
    var index = 1
    var isloading:Bool?
    var totalconents = 0
    var Movcategory = ""
    var MovSubcategory = ""
     let cellIdentifier = "cell"
     var selftitle = ""
    
    
     var contentdata:contentdetails?
    var PPVdata:PPVplans?
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
    
     var Isfavourite = 0
     var WatchDuration = 0
     var newperma = ""
     var contenttypesid  = ""
    override func viewDidLoad() {
        super.viewDidLoad()
        
       // self.title = selftitle
           self.ComedyCollectionV.register(UINib(nibName:"MyCell", bundle:nil), forCellWithReuseIdentifier: cellIdentifier)
    
        Timer.scheduledTimer(withTimeInterval: 0.1, repeats: false) { (t) in
            if Connectivity.isConnectedToInternet()
            {
                self.viewfavorites(offset: 1)
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
    override func viewDidAppear(_ animated: Bool) {

                    
              }
    
    func viewfavorites(offset:Int)
    {
                        Utility.ShowLoader(vc: self)
        
        Api.GetWatchhistoryinmylibraries(ApiEndPoints.watchhistory, offset: offset, limit: 20, vc: self)   { (res, err) -> (Void) in
                  do
                  {
                    Utility.hideLoader(vc: self)
                    
                    
                        let decoder = JSONDecoder()
                      self.WatchhistoryListdata = try decoder.decode(WatchhistoryList.self, from: res ?? Data() )
                  
                    if let total = Int(self.WatchhistoryListdata?.total_content ?? "")
                    {
                        self.totalconents = total
                        print("total ---- \(self.totalconents) ")
                    }
                    for item in self.WatchhistoryListdata?.subComedymovList ?? [Watchhistorydeatails]()
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
                    Utility.showAlert(vc: self, message:"\(error.localizedDescription ?? "")", titelstring: Appcommon.Appname)
                 }
              }
        
     
     

    }
      /*
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
 
 */

}
extension WatchHistoryVC:UICollectionViewDelegate,UICollectionViewDataSource
{
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if comedydata.count <= 0
        {
            self.ComedyCollectionV.setEmptyViewnew1(title: "No Watch History found")
        }else
        {
            self.ComedyCollectionV.restore()
        }
        return self.comedydata.count
          
       
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
    
       
      let Comedycell = collectionView.dequeueReusableCell(withReuseIdentifier: cellIdentifier, for: indexPath) as! MyCell
            let item = comedydata[indexPath.row]
        Comedycell.ImgSample.sd_setImage(with: URL(string: "\(item.poster ?? "")"), completed: nil)
        Comedycell.LbName.text = item.title
        Comedycell.btnCounter.isHidden = true
        Comedycell.btnCounter.tag = indexPath.row
        Comedycell.btnCounter.addTarget(self, action: #selector(self.buttonClicked), for: .touchUpInside)
                        
        if item.is_fav_status == 0
        {
            Comedycell.btnCounter.setBackgroundImage(UIImage(named: "like"), for: .normal)
        }else if item.is_fav_status == 1
        {
            Comedycell.btnCounter.setBackgroundImage(UIImage(named: "liked"), for: .normal)
        }
                return Comedycell
          
   
        
    }
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath)
    {
           // passComedyMoviedata  = comedydata[indexPath.row]
        getcontentauthorized(movieid: WatchhistoryListdata?.subComedymovList?[indexPath.row].movie_uniq_id ?? "", planurls:"", index: indexPath.row, permad: WatchhistoryListdata?.subComedymovList?[indexPath.row].c_permalink ?? "", isbanner: 3)
    }
    func getcontentauthorized(movieid:String,planurls:String,index:Int,permad:String,isbanner:Int)
    {
 
        Api.IsContentAuthorised(movieid, endpoint: ApiEndPoints.isContentAuthorized, vc: self) { (res, err) -> (Void) in
                             
            do{
                                 
                let decoder = JSONDecoder()
                self.authorizeddata = try decoder.decode(Authorizescontent.self, from: res  ?? Data())
                                
                if self.authorizeddata?.status == "OK"
                {
                   if isbanner == 3
                    {
                        let item = self.WatchhistoryListdata?.subComedymovList?[index]
                        self.imagename = item?.poster ?? ""
                        self.moviename = item?.title ?? ""
                        self.movietype = item?.poster ?? ""
                        self.movdescription = item?.poster ?? ""
                      //  imdbId = item?.custom?.customimdb?.field_value ?? ""
                        self.movieuniqid = item?.movie_uniq_id ?? ""
                        self.perma = item?.c_permalink ?? ""
                        //newperma = item?.permalink ?? ""
                        self.Isfavourite = item?.is_fav_status ?? 0
                        self.WatchDuration = item?.watch_duration_in_seconds ?? 0
                        self.contenttypesid = item?.content_types_id ?? ""
                       let movieid = item?.movie_uniq_id ?? ""
                     
                    //passarray?.contents?.remove(at: index)
                        self.getcontentauthorised(movieid: movieid)
                    }else if isbanner == 4
                    {
                        self.getcontentauthorised(movieid: movieid)
                    }
                    
                    /*
                    let storyBoard: UIStoryboard = UIStoryboard(name: "Main", bundle: nil)
                    let secondViewController =  storyBoard.instantiateViewController(withIdentifier: "FeaturedHomeDetails") as! FeaturedHomeDetails
                         secondViewController.imagename = self.imagename
                         secondViewController.moviename = self.moviename
                         secondViewController.movietype = self.movietype
                         secondViewController.timereleasedate = self.timereleasedate
                         secondViewController.language = self.language
                         secondViewController.perma = self.perma
                         secondViewController.Movcategory = "movies-on-rent"
                         secondViewController.MovSubcategory = ""
                        // secondViewController.passarray = self.passarray
                         secondViewController.movieuniqid = self.movieuniqid
                         secondViewController.contenttypesid = self.contenttypesid
                       
                       self.present(secondViewController, animated: true)
                */
                }
                                
                else
                {
                    if isbanner == 3
                     {
                         let item = self.WatchhistoryListdata?.subComedymovList?[index]
                         self.imagename = item?.poster ?? ""
                         self.moviename = item?.title ?? ""
                         self.movietype = item?.poster ?? ""
                         self.movdescription = item?.poster ?? ""
                       //  imdbId = item?.custom?.customimdb?.field_value ?? ""
                         self.movieuniqid = item?.movie_uniq_id ?? ""
                         self.perma = item?.c_permalink ?? ""
                         //newperma = item?.permalink ?? ""
                         self.Isfavourite = item?.is_fav_status ?? 0
                         self.WatchDuration = item?.watch_duration_in_seconds ?? 0
                         self.contenttypesid = item?.content_types_id ?? ""
                        let movieid = item?.movie_uniq_id ?? ""
                      
                     //passarray?.contents?.remove(at: index)
                         self.getcontentunauthorised(movieid: movieid)
                     }else if isbanner == 4
                     {
                         self.getcontentunauthorised(movieid: movieid)
                     }
                     
                    
                    
 
                    /*
                    let alertController = MDCAlertController(title: "BigFan TV", message:  "Purchase the movie for 9.99$")
                    let action = MDCAlertAction(title:"Continue")
                                                    { (action) in
                        let storyBoard: UIStoryboard = UIStoryboard(name: "Main", bundle: nil)
                        let VC1 = storyBoard.instantiateViewController(withIdentifier: "BuyPlanVC") as! BuyPlanVC
                                      
                        VC1.planurl = planurls
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
                                       
                */
                }
                             }
                             catch let error
                             {
                            //     Utility.showAlert(vc: self, message:"\(error)", titelstring: Appcommon.Appname)
                             }
                         }
    }
    
      func getcontendeatils(permaa:String)
         {
          
             Api.getcontentdetails(permaa, endpoint: ApiEndPoints.getcontentdetails, vc: self) { (res, err) -> (Void) in
                 do
                 {
                    let decoder = JSONDecoder()
                    self.contentdata = try decoder.decode(contentdetails.self, from: res  ?? Data())
             
                    if self.contentdata != nil
                    {
                      //  self.getPPVplans(movieuniqids: self.contentdata?.submovie?.muvi_uniq_id ?? "", planid: self.contentdata?.submovie?.ppv_plan_id  ?? "")
                        
                    }
                    
                 }
                 catch let error
                 {
                     Utility.showAlert(vc: self, message:"\(error)", titelstring: Appcommon.Appname)
                 }
             }
         }
    
      func getcontendeatilsbannerfor (permaas:String)
         {
          
             Api.getcontentdetails(permaas, endpoint: ApiEndPoints.getcontentdetails, vc: self) { (res, err) -> (Void) in
                 do
                 {
                    let decoder = JSONDecoder()
                    self.contentdata = try decoder.decode(contentdetails.self, from: res  ?? Data())
             
                    if self.contentdata != nil
                    {
                        self.getcontentauthorized(movieid: self.contentdata?.submovie?.muvi_uniq_id ?? "", planurls: "", index: 0, permad: permaas, isbanner: 1)

                       // self.getPPVplans(movieuniqids: self.contentdata?.submovie?.muvi_uniq_id ?? "", planid: self.contentdata?.submovie?.ppv_plan_id  ?? "")
                        
                    }
                    
                 }
                 catch let error
                 {
                     Utility.showAlert(vc: self, message:"\(error)", titelstring: Appcommon.Appname)
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
                        ///self.RadioView.isHidden = true
                    }
                }
                
            }catch
            {
                print(error.localizedDescription)
            }
        }
        
     }
 */
    func getcontentunauthorised(movieid:String)
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
            secondViewController.WatchDuration = self.WatchDuration
             // secondViewController.passarray = self.passarray
              secondViewController.movieuniqid = self.movieuniqid
              secondViewController.contenttypesid = self.contenttypesid
            secondViewController.IsAuthorizedContent = 0
            self.present(secondViewController, animated: true)
        }
    }
    func getcontentauthorised(movieid:String)
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
            secondViewController.WatchDuration = self.WatchDuration
             // secondViewController.passarray = self.passarray
              secondViewController.movieuniqid = self.movieuniqid
              secondViewController.contenttypesid = self.contenttypesid
            
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
     func collectionView(_ collectionView: UICollectionView, willDisplay cell: UICollectionViewCell, forItemAt indexPath: IndexPath)
     {
        if comedydata.count < totalconents
            {
       
                if indexPath.row == comedydata.count - 1 && !(isloading ?? false)
                {  //numberofitem count
                    isloading = true
                   index = index + 1
                   self.viewfavorites(offset: index)
                    
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
   
extension WatchHistoryVC: UICollectionViewDelegateFlowLayout
{
        func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
            /*
            if UIDevice.current.userInterfaceIdiom == .pad
            {
                return CGSize(width: 200, height:collectionView.frame.size.height)
            }
            else if UIDevice.current.userInterfaceIdiom == .phone
            {
                return CGSize(width: collectionView.frame.size.width/2 - 5, height:160)
                     
                   }
            */
             return CGSize(width: collectionView.frame.size.width/2 - 5, height:160)
        }
     
   
    }
 


//fspager

 
