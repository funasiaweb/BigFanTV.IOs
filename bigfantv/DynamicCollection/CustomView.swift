//
//  CustomView.swift
//  UICollectionViewInUIView
//
//  Created by michal on 31/05/2019.
//  Copyright © 2019 borama. All rights reserved.
//

import UIKit
import SDWebImage
import Alamofire
import MaterialComponents.MaterialDialogs

@IBDesignable
class CustomView: UIView {

     var Muvidata:newFilteredComedyMovieList?
    @IBOutlet var LbTitle: UILabel!
    @IBOutlet var contentView: UIView!
    @IBOutlet weak var collectionView: UICollectionView!
      private var  Successdata:SuccessResponse?
    var array = [String]()
    var tapviewall = ""
    var Movcategory = ""
    var MovSubcategory = ""
    var selftitle = ""
    var Isfrom = ""
    private var authorizeddata:Authorizescontent?
    var contentdata:contentdetails?
    var PPVdata:PPVplans?
    override init(frame: CGRect) {
        super.init(frame: frame)
        commonInit()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        commonInit()
    }
    
    private func commonInit() {
        let bundle = Bundle(for: type(of: self))
        bundle.loadNibNamed("CustomView", owner: self, options: nil)
        addSubview(contentView)
        contentView.frame = bounds
        contentView.autoresizingMask = [.flexibleWidth, .flexibleHeight]
    //    contentView.backgroundColor = .red
        initCollectionView()
    }
    
    private func initCollectionView()
    {
        let nib = UINib(nibName: "CustomCell", bundle: nil)
          collectionView.register(nib, forCellWithReuseIdentifier: "CustomCell")
        
        collectionView.translatesAutoresizingMaskIntoConstraints = false
          collectionView.dataSource = self

    }
    
    func loadallcontents(muvcategory:String,muvsubcategory:String,title:String)
    {
        self.Movcategory = muvcategory
        self.MovSubcategory = muvsubcategory
        self.selftitle = title
        guard let parameters =
            [
                "authToken" : "57b8617205fa3446ba004d583284f475",
                "category" : muvcategory,
                "subcategory" : muvsubcategory,
                "limit" :4,
                "offset" : 1,
                 
                "user_id":UserDefaults.standard.string(forKey: "id") ?? "",
               "is_episode":0
                ] as? [String:Any] else { return  }
           
            let url:URL = URL(string: "https://bigfantv.com/en/rest/getFilteredContent")!
        Alamofire.request(url, method: .post, parameters: parameters, encoding: JSONEncoding.default, headers: nil).responseJSON { (data) in
            if data.data != nil
            {
                do
                {
                    let decoder = JSONDecoder()
                    self.Muvidata = try decoder.decode(newFilteredComedyMovieList.self, from: data.data ?? Data())
                     
                    DispatchQueue.main.async {
                        self.collectionView.reloadData()
                    }
                }
                catch{

                }
            }
        }
 
    }
    func reloadata()
    {
        DispatchQueue.main.async {
            self.collectionView.reloadData()
        }
    }
    @IBAction func BtViewAlltapped(_ sender: UIButton) {
           
        
        if Isfrom == "othervideos"
        {
                let currentController = self.getCurrentViewController()
                let storyBoard: UIStoryboard = UIStoryboard(name: "Main", bundle: nil)
            
               let VC1 = storyBoard.instantiateViewController(withIdentifier: "OtherVidViewAll") as! OtherVidViewAll
                 VC1.Movcategory = Movcategory
                 VC1.MovSubcategory = MovSubcategory
                VC1.selftitle = selftitle
               let navController = UINavigationController(rootViewController: VC1) // Creating a navigation controller with VC1 at the root of the navigation stack.
               navController.navigationBar.barTintColor = Appcolor.backgorund4
               navController.modalPresentationStyle = .fullScreen
               let textAttributes = [NSAttributedString.Key.foregroundColor:UIColor.white,NSAttributedString.Key.font: UIFont(name: "Muli-ExtraBold", size: 19)!]
               navController.navigationBar.titleTextAttributes = textAttributes
                
                currentController?.present(navController, animated: false, completion: nil)
            
        }else
        {
        let currentController = self.getCurrentViewController()
        let storyBoard: UIStoryboard = UIStoryboard(name: "Main", bundle: nil)
    
       let VC1 = storyBoard.instantiateViewController(withIdentifier: "ComedyViewAllVC") as! ComedyViewAllVC
         VC1.Movcategory = Movcategory
         VC1.MovSubcategory = MovSubcategory
        VC1.selftitle = selftitle
       let navController = UINavigationController(rootViewController: VC1) // Creating a navigation controller with VC1 at the root of the navigation stack.
       navController.navigationBar.barTintColor = Appcolor.backgorund4
       navController.modalPresentationStyle = .fullScreen
       let textAttributes = [NSAttributedString.Key.foregroundColor:UIColor.white,NSAttributedString.Key.font: UIFont(name: "Muli-ExtraBold", size: 19)!]
       navController.navigationBar.titleTextAttributes = textAttributes
        
        currentController?.present(navController, animated: false, completion: nil)
    }
    }
    func getCurrentViewController() -> UIViewController? {

        if let rootController = UIApplication.shared.keyWindow?.rootViewController {
            var currentController: UIViewController! = rootController
            while( currentController.presentedViewController != nil ) {
                currentController = currentController.presentedViewController
            }
            return currentController
        }
        return nil

    }
}

extension CustomView: UICollectionViewDataSource,UICollectionViewDelegateFlowLayout,UICollectionViewDelegate {
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let width = ((collectionView.frame.size.height - 18) * 280)/156
        return CGSize(width: width  , height: collectionView.frame.size.height)
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return 10
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 10
    }
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        
        return self.Muvidata?.subComedymovList.count ?? 0
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "CustomCell", for: indexPath) as? CustomCell else {
            fatalError("can't dequeue CustomCell")
        }
        let item = Muvidata?.subComedymovList[indexPath.row]
        cell.label.text = item?.title ?? ""
        cell.ImgSample.sd_setImage(with:URL(string:Muvidata?.subComedymovList[indexPath.row].poster ?? ""), completed: nil)
        let image = item?.is_fav_status == 1 ? UIImage(named: "liked") : UIImage(named: "like")
         cell.BtFavourite.setBackgroundImage(image, for: .normal)
        cell.actionBlock = {
            () in
            if UserDefaults.standard.bool(forKey: "isLoggedin") == true
            {
                
                if item?.is_fav_status == 0
                {
                     cell.BtFavourite.setBackgroundImage(UIImage(named: "liked"), for: .normal)
                    self.AddtoFav(movieuniqidx: item?.movie_uniq_id ?? "", endpoint: ApiEndPoints.AddToFavlist) { (true) in
                    cell.BtFavourite.setBackgroundImage(UIImage(named: "liked"), for: .normal)
                        
                        self.Muvidata?.subComedymovList[indexPath.row].is_fav_status = 1
                       
                }
                }else if item?.is_fav_status == 1
                {
                    cell.BtFavourite.setBackgroundImage(UIImage(named: "like"), for: .normal)
                    self.AddtoFav(movieuniqidx: item?.movie_uniq_id ?? "", endpoint: ApiEndPoints.DeleteFavLIst) { (true) in
                    cell.BtFavourite.setBackgroundImage(UIImage(named: "like"), for: .normal)
                        self.Muvidata?.subComedymovList[indexPath.row].is_fav_status = 0
                     
                }
            }
            }else
            {
                let alertController = MDCAlertController(title: "BigFan TV", message:  "First Login or Register to favorite this content.")
                let action = MDCAlertAction(title:"Continue")
                                                { (action) in
                    let storyBoard: UIStoryboard = UIStoryboard(name: "Main", bundle: nil)
                     let displayVC = storyBoard.instantiateViewController(withIdentifier: "LaunchVC") as! LaunchVC
                                      
                    displayVC.modalPresentationStyle = .fullScreen
                                        
                  

                    
                    let currentController = self.getCurrentViewController()

                    currentController?.present(displayVC, animated: false, completion: nil)

                }
                let cancelaction = MDCAlertAction(title:"Cancel")
                { (cancelaction) in}
                                    
                alertController.addAction(action)
                                        
                alertController.addAction(cancelaction)
                let currentController = self.getCurrentViewController()

            currentController?.present(alertController, animated: true, completion: nil)
            }

            }
           
        
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath)
    {
        
        if Connectivity.isConnectedToInternet()
        {
            if UserDefaults.standard.bool(forKey: "isLoggedin") == true
            {

            
                let item = self.Muvidata?.subComedymovList[indexPath.row]
            
                self.getcontentauthorized(movieid: item?.movie_uniq_id ?? "", planurls: "", index: indexPath.row, permad: item?.c_permalink ?? "")
            }else
            {
                let alertController = MDCAlertController(title: "BigFan TV", message:  "First Login or Register to watch this content.")
                let action = MDCAlertAction(title:"Ok")
                                                { (action) in
                    let storyBoard: UIStoryboard = UIStoryboard(name: "Main", bundle: nil)
                     let displayVC = storyBoard.instantiateViewController(withIdentifier: "LaunchVC") as! LaunchVC
                                      
                    displayVC.modalPresentationStyle = .fullScreen
                                        
                  
                    let currentController = self.getCurrentViewController()

                    currentController?.present(displayVC, animated: false, completion: nil)
                                      
                }
                let cancelaction = MDCAlertAction(title:"Cancel")
                { (cancelaction) in}
                                    
                alertController.addAction(action)
                                        
                alertController.addAction(cancelaction)
                let currentController = self.getCurrentViewController()

            currentController?.present(alertController, animated: true, completion: nil)
            }
        }else
        {
            Utility.Internetconnection(vc: UIViewController())
        }
         
    }
    func getcontentauthorized(movieid:String,planurls:String,index:Int,permad:String)
    {
 
        Utility.ShowLoader(vc: getCurrentViewController()!)
        Api.IsContentAuthorised(movieid, endpoint: ApiEndPoints.isContentAuthorized, vc: UIViewController()) { (res, err) -> (Void) in
                             
            do{
                                 
                let decoder = JSONDecoder()
                self.authorizeddata = try decoder.decode(Authorizescontent.self, from: res  ?? Data())
                                
                if self.authorizeddata?.status == "OK"
                {
                    Utility.hideLoader(vc: self.getCurrentViewController()!)

                    if self.Isfrom == "othervideos"
                    {
                        
                        if self.Muvidata?.subComedymovList[index].content_types_id == "3"
                        {
                             let currentController = self.getCurrentViewController()
                             let storyBoard: UIStoryboard = UIStoryboard(name: "Main", bundle: nil)
                              let displayVC = storyBoard.instantiateViewController(withIdentifier: "SerirsDetailsVC") as! SerirsDetailsVC
                                               
                             displayVC.modalPresentationStyle = .fullScreen
                                                 
                            if let item = self.Muvidata?.subComedymovList[index]
                             {
                                 displayVC.perma = item.c_permalink ?? ""
                                displayVC.movieuniqid = item.movie_uniq_id ?? ""
                                 displayVC.Movcategory = self.Movcategory
                                 displayVC.MovSubcategory = self.MovSubcategory
                                displayVC.playerurlstr = item.permalink ?? ""
                                displayVC.contenttypesid = item.content_types_id ?? ""
                             }
                            
                              
                             currentController?.present(displayVC, animated: false, completion: nil)
                            
                        }else
                        {
                        
                        
                         let currentController = self.getCurrentViewController()
                         let storyBoard: UIStoryboard = UIStoryboard(name: "Main", bundle: nil)
                         let displayVC = storyBoard.instantiateViewController(withIdentifier: "OtherVideosVCDetails") as! OtherVideosVCDetails
                                           
                         displayVC.modalPresentationStyle = .fullScreen
                                             
                            if let item = self.Muvidata?.subComedymovList[index]
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
                                displayVC.IsAuthorizedContent = 1

                         }
                        
                          
                         currentController?.present(displayVC, animated: false, completion: nil)
                        }
                    }
                    else
                    {
                    let currentController = self.getCurrentViewController()
                    let storyBoard: UIStoryboard = UIStoryboard(name: "Main", bundle: nil)
                    let displayVC = storyBoard.instantiateViewController(withIdentifier: "MoviesDetailsVC") as! MoviesDetailsVC
                                      
                    displayVC.modalPresentationStyle = .fullScreen
                                        
                        if let item = self.Muvidata?.subComedymovList[index]
                    {
                        displayVC.imagename = item.poster ?? ""
                        displayVC.moviename = item.title ?? ""
                        displayVC.imdbID = item.custom?.customimdb?.field_value ?? ""
                        displayVC.perma = item.c_permalink ?? ""
                        displayVC.Movcategory = self.Movcategory
                        displayVC.MovSubcategory = self.MovSubcategory
                        displayVC.movieuniqid = item.movie_uniq_id ?? ""
                        displayVC.Isfavourite = item.is_fav_status ?? 0
                        displayVC.WatchDuration = item.watch_duration_in_seconds ?? 0
                        displayVC.contenttypeid = item.content_types_id ?? ""
                        displayVC.playerurlstr = item.permalink ?? ""
                        displayVC.IsAuthorizedContent = 1

                    }
                     
                   currentController?.present(displayVC, animated: false, completion: nil)
                    
                }
                }
                                
                else
                {
                    Utility.hideLoader(vc: self.getCurrentViewController()!)
                    
                    if self.Isfrom == "othervideos"
                    {
                        
                        if self.Muvidata?.subComedymovList[index].content_types_id == "3"
                        {
                             let currentController = self.getCurrentViewController()
                             let storyBoard: UIStoryboard = UIStoryboard(name: "Main", bundle: nil)
                              let displayVC = storyBoard.instantiateViewController(withIdentifier: "SerirsDetailsVC") as! SerirsDetailsVC
                                               
                             displayVC.modalPresentationStyle = .fullScreen
                                                 
                            if let item = self.Muvidata?.subComedymovList[index]
                             {
                                 displayVC.perma = item.c_permalink ?? ""
                                displayVC.movieuniqid = item.movie_uniq_id ?? ""
                                 displayVC.Movcategory = self.Movcategory
                                 displayVC.MovSubcategory = self.MovSubcategory
                                displayVC.playerurlstr = item.permalink ?? ""
                                displayVC.contenttypesid = item.content_types_id ?? ""
                             }
                            
                              
                             currentController?.present(displayVC, animated: false, completion: nil)
                            
                        }else
                        {
                        
                        
                         let currentController = self.getCurrentViewController()
                         let storyBoard: UIStoryboard = UIStoryboard(name: "Main", bundle: nil)
                         let displayVC = storyBoard.instantiateViewController(withIdentifier: "OtherVideosVCDetails") as! OtherVideosVCDetails
                                           
                         displayVC.modalPresentationStyle = .fullScreen
                                             
                            if let item = self.Muvidata?.subComedymovList[index]
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
                                displayVC.IsAuthorizedContent = 0

                         }
                        
                          
                         currentController?.present(displayVC, animated: false, completion: nil)
                        }
                    }
                    else
                    {
                    let currentController = self.getCurrentViewController()
                    let storyBoard: UIStoryboard = UIStoryboard(name: "Main", bundle: nil)
                    let displayVC = storyBoard.instantiateViewController(withIdentifier: "MoviesDetailsVC") as! MoviesDetailsVC
                                      
                    displayVC.modalPresentationStyle = .fullScreen
                                        
                        if let item = self.Muvidata?.subComedymovList[index]
                    {
                        displayVC.imagename = item.poster ?? ""
                        displayVC.moviename = item.title ?? ""
                        displayVC.imdbID = item.custom?.customimdb?.field_value ?? ""
                        displayVC.perma = item.c_permalink ?? ""
                        displayVC.Movcategory = self.Movcategory
                        displayVC.MovSubcategory = self.MovSubcategory
                        displayVC.movieuniqid = item.movie_uniq_id ?? ""
                        displayVC.Isfavourite = item.is_fav_status ?? 0
                        displayVC.WatchDuration = item.watch_duration_in_seconds ?? 0
                        displayVC.contenttypeid = item.content_types_id ?? ""
                        displayVC.playerurlstr = item.permalink ?? ""
                            displayVC.IsAuthorizedContent = 0
                    }
                     
                   currentController?.present(displayVC, animated: false, completion: nil)
                    
                }
                   // self.getcontendeatils(permaa:permad)
                    
                
                }
                             }
                             catch let error
                             {
                                Utility.hideLoader(vc: self.getCurrentViewController()!)

                            //     Utility.showAlert(vc: self, message:"\(error)", titelstring: Appcommon.Appname)
                             }
                         }
    }
    
      func getcontendeatils(permaa:String)
         {
          
             Api.getcontentdetails(permaa, endpoint: ApiEndPoints.getcontentdetails, vc: UIViewController()) { (res, err) -> (Void) in
                 do
                 {
                    let decoder = JSONDecoder()
                    self.contentdata = try decoder.decode(contentdetails.self, from: res  ?? Data())
             
                    if self.contentdata != nil
                    {
                       // self.getPPVplans(movieuniqids: self.contentdata?.submovie?.muvi_uniq_id ?? "", planid: self.contentdata?.submovie?.ppv_plan_id  ?? "")
                        
                    }
                    
                 }
                 catch let error
                 {
                    Utility.showAlert(vc: self.getCurrentViewController()!, message:"\(error)", titelstring: Appcommon.Appname)
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
        let currentController = self.getCurrentViewController()

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
                                                             
                                    currentController?.present(navController, animated:true, completion: nil)
                                                      
                                }
                                let cancelaction = MDCAlertAction(title:"Cancel")
                                { (cancelaction) in}
                                                    
                                alertController.addAction(action)
                                                        
                                alertController.addAction(cancelaction)
                                currentController?.present(alertController, animated: true, completion: nil)
                                
                            }
                        }
                     
                    }else
                    {
                       // self.RadioView.isHidden = true
                    }
                }
                
            }catch
            {
                print(error.localizedDescription)
            }
        }
        
     }
    
    */
    
    
    
    
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
    
}
