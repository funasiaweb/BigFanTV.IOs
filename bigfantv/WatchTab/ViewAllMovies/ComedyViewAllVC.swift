
//
//  ComedyViewAllVC.swift
//  bigfantv
//
//  Created by Ganesh on 28/07/20.
//  Copyright © 2020 Ganesh. All rights reserved.
//

import UIKit
import MaterialComponents.MaterialDialogs
class ComedyViewAllVC: UIViewController
{
    @IBOutlet var ComedyCollectionV: UICollectionView!
   
      private var ComedyMoviedata:newFilteredComedyMovieList?
      private var Successdata:SuccessResponse?
      private var authorizeddata:Authorizescontent?
     private var  passComedyMoviedata:newFilteredSubComedymovieList?
     private var comedydata = [newFilteredSubComedymovieList]()
    var index = 1
    var isloading:Bool?
    var totalconents = 0
    var Movcategory = ""
    var MovSubcategory = ""
     let cellIdentifier = "cell"
     var selftitle = ""
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.title = selftitle
           self.ComedyCollectionV.register(UINib(nibName:"MyCell", bundle:nil), forCellWithReuseIdentifier: cellIdentifier)
    
        Timer.scheduledTimer(withTimeInterval: 0.1, repeats: false) { (t) in
            if Connectivity.isConnectedToInternet()
            {
                self.GetComedyMovielist(offset: 1, category: self.Movcategory, subcategory: self.MovSubcategory)
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
 
 

}
extension ComedyViewAllVC:UICollectionViewDelegate,UICollectionViewDataSource
{
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if comedydata.count <= 0
        {
            self.ComedyCollectionV.setEmptyViewnew1(title: "No contents found")
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
        if UserDefaults.standard.bool(forKey: "isLoggedin") == true
        {
            passComedyMoviedata  = comedydata[indexPath.row]
            getcontentauthorised(movieid: passComedyMoviedata?.movie_uniq_id ?? "")
        }else
        {
            self.checkLogin()
        }
    
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
    func getcontentauthorised(movieid:String)
    {
     Utility.ShowLoader(vc: self)
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
               if let item = self.passComedyMoviedata
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
                    
               self.present(displayVC, animated: true, completion: nil)
               
              
            
            }
            }else
            {
                Utility.hideLoader(vc: self)

               let storyBoard: UIStoryboard = UIStoryboard(name: "Main", bundle: nil)
                let displayVC = storyBoard.instantiateViewController(withIdentifier: "MoviesDetailsVC") as! MoviesDetailsVC
                   displayVC.modalPresentationStyle = .fullScreen
               if let item = self.passComedyMoviedata
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
                   displayVC.IsAuthorizedContent = 0
                displayVC.playerurlstr = item.permalink ?? ""

               self.present(displayVC, animated: true, completion: nil)
               }
                
            }
             
         }
         catch let error
         {
             Utility.hideLoader(vc: self)

         }
                      
     }
   
         
    }
     
     func collectionView(_ collectionView: UICollectionView, willDisplay cell: UICollectionViewCell, forItemAt indexPath: IndexPath)
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
   
extension ComedyViewAllVC: UICollectionViewDelegateFlowLayout
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

 
