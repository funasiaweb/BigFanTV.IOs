//
//  ViewAllhomeVC.swift
//  bigfantv
//
//  Created by Ganesh on 12/11/20.
//  Copyright © 2020 Ganesh. All rights reserved.
//

import UIKit
import MaterialComponents.MaterialDialogs
class ViewAllhomeVC: UIViewController {

    @IBOutlet var CollectionV: UICollectionView!
    private var Successdata:SuccessResponse?
        private var authorizeddata:Authorizescontent?
    var comedydata = [FeaturedDatadetails]()
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
        var isloading:Bool?
       var imdbId = ""
       var totalcount = 0
       var movieuniqid = ""
       var perma = ""
    var sectionnumber = 0
        var featuredarray:FeaturedData?
       var Isfavourite = 0
       var WatchDuration = 0
    var Loadhomedata:FeaturedDataList?
    var contenttypeid = ""
    var newperma = ""
    override func viewDidLoad() {
        super.viewDidLoad()

        
        for i in Loadhomedata?.contents ?? [FeaturedDatadetails]()
        {
            comedydata.append(i)
        }
       
        self.CollectionV.delegate = self
        self.CollectionV.dataSource = self
        self.CollectionV.reloadData()
       self.CollectionV.register(UINib(nibName:"MyCell", bundle:nil), forCellWithReuseIdentifier: cellIdentifier)
             
         }
    
    
    
    
         override func viewWillAppear(_ animated: Bool) {
             Keycenter.limit = 24
         }
         override func viewWillDisappear(_ animated: Bool) {
             Keycenter.limit = 10
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
    func GetFeatureddata(offset:Int)
           {
               Api.Getfeatureddata(ApiEndPoints.loadFeaturedSections, vc: self, offset: offset) { (res, err) -> (Void) in
                      do
                      {
                       
                          let decoder = JSONDecoder()
                          self.featuredarray = try decoder.decode(FeaturedData.self, from: res  ?? Data())
                        
                        self.totalconents = self.featuredarray?.subComedymovList?[self.sectionnumber].total ?? 0
                        
                        for i in self.featuredarray?.subComedymovList?[self.sectionnumber].contents ?? [FeaturedDatadetails]()
                        {
                            self.comedydata.append(i)
                        }
                      
                        self.isloading = false
                      }
                       catch let error
                       {
                           Utility.showAlert(vc: self, message:"\(error)", titelstring: Appcommon.Appname)
                             
                      }
                         }
    }
    

}
extension ViewAllhomeVC:UICollectionViewDelegate,UICollectionViewDataSource
{
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if Loadhomedata?.contents?.count ?? 0 <= 0
        {
            self.CollectionV.setEmptyViewnew1(title: "No contents found")
        }else
        {
            self.CollectionV.restore()
        }
        return self.comedydata.count ?? 0
          
       
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
    
       
      let Comedycell = collectionView.dequeueReusableCell(withReuseIdentifier: cellIdentifier, for: indexPath) as! MyCell
            let item = comedydata[indexPath.row]
        Comedycell.ImgSample.sd_setImage(with: URL(string: "\(item.poster ?? "")"), completed: nil)
        Comedycell.LbName.text = item.title
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
                  contenttypeid  = item?.content_types_id ?? ""
                   newperma = item?.permalink ?? ""
                getcontentauthorized(movieid: movieuniqid, planurls: "", index: 0, permad: perma)
    }
    func collectionView(_ collectionView: UICollectionView, willDisplay cell: UICollectionViewCell, forItemAt indexPath: IndexPath)
      {
         if comedydata.count < totalconents
             {
        
                 if indexPath.row == comedydata.count - 1 && !(isloading ?? false)
                 {  //numberofitem count
                     isloading = true
                    index = index + 1
                    self.GetFeatureddata(offset: index)
                     
                 }
            }
       
      }
    func getcontentauthorised(movieid:String)
     {
         
         /*
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
                                    displayVC.contenttypeid = self.contenttypeid
                                    
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
    func getcontentauthorized(movieid:String,planurls:String,index:Int,permad:String)
    {
 
        Utility.ShowLoader(vc:self)
        Api.IsContentAuthorised(movieid, endpoint: ApiEndPoints.isContentAuthorized, vc: UIViewController()) { (res, err) -> (Void) in
                             
            do{
                                 
                let decoder = JSONDecoder()
                self.authorizeddata = try decoder.decode(Authorizescontent.self, from: res  ?? Data())
                                
                if self.authorizeddata?.status == "OK"
                {
                    Utility.hideLoader(vc: self)

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
                        displayVC.contenttypeid = self.contenttypeid
                    displayVC.IsAuthorizedContent = 1
                    displayVC.playerurlstr = self.newperma
                        
                   self.present(displayVC, animated: true, completion: nil)
                    
                }
                                
                else
                {
                    Utility.hideLoader(vc: self)
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
                        displayVC.contenttypeid = self.contenttypeid
                    displayVC.IsAuthorizedContent = 0
                    displayVC.playerurlstr = self.newperma

                   self.present(displayVC, animated: true, completion: nil)

                     
                
                }
                
            }
                
            catch let error
            {
                Utility.hideLoader(vc: self)
             }
            
        }
    }
    
     
    
    @objc func buttonClicked(_ sender: UIButton) {
           //Here sender.tag will give you the tapped Button index from the cell
           //You can identify the button from the tag
         
        if Loadhomedata?.contents?[sender.tag].is_fav_status == 0
           {
           Api.Addtofavourite(UserDefaults.standard.string(forKey: "id") ?? "", movie_uniq_id: Loadhomedata?.contents?[sender.tag].movie_uniq_id ?? "", lang_code: "en", content_type: 0, endpoint: ApiEndPoints.AddToFavlist, vc: self)  { (res, err) -> (Void) in
                               do
                               {
                                   let decoder = JSONDecoder()
                                   self.Successdata = try decoder.decode(SuccessResponse.self, from: res  ?? Data())
                                   if self.Successdata?.code == 200
                                   {
                                     
                                       sender.setBackgroundImage(UIImage(named: "liked"), for: .normal)
                                    //self.GetComedyMovielist(offset: self.index, category: self.Movcategory, subcategory: self.MovSubcategory)
                                   }
                                  
                               }
                               catch let error
                               {
                                   Utility.showAlert(vc: self, message:"\(error)", titelstring: Appcommon.Appname)
                               }
                           }
           }else if Loadhomedata?.contents?[sender.tag].is_fav_status == 1
           {
               Api.Addtofavourite(UserDefaults.standard.string(forKey: "id") ?? "", movie_uniq_id: Loadhomedata?.contents?[sender.tag].movie_uniq_id ?? "", lang_code: "en", content_type: 0, endpoint: ApiEndPoints.DeleteFavLIst, vc: self)  { (res, err) -> (Void) in
                                          do
                                          {
                                              let decoder = JSONDecoder()
                                              self.Successdata = try decoder.decode(SuccessResponse.self, from: res  ?? Data())
                                           
                                              if self.Successdata?.code == 200
                                              {
                                                
                                                  sender.setBackgroundImage(UIImage(named: "like"), for: .normal)
                                                
                                              // self.GetComedyMovielist(offset: self.index, category: self.Movcategory, subcategory: self.MovSubcategory)
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
   
extension ViewAllhomeVC: UICollectionViewDelegateFlowLayout
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

 

