
//
//  ComedyViewAllVC.swift
//  bigfantv
//
//  Created by Ganesh on 28/07/20.
//  Copyright © 2020 Ganesh. All rights reserved.
//

import UIKit
import MaterialComponents.MaterialDialogs
class MusicViewAllVC: UIViewController {
    @IBOutlet var ComedyCollectionV: UICollectionView!
  
    
    var ComedyMoviedata:newFilteredComedyMovieList?
    var ThrillerMoviedata:newFilteredComedyMovieList?
    var ActionMoviedata:newFilteredComedyMovieList?
    var comedydata = [newFilteredSubComedymovieList]()
    var thrillerdata = [newFilteredSubComedymovieList]()
    var actiondata = [newFilteredSubComedymovieList]()
    var isloading:Bool?
     private var Successdata:SuccessResponse?
     private var authorizeddata:Authorizescontent?
    var index = 1
    var totalconents = 0
    var Movcategory = ""
    var MovSubcategory = ""
     let cellIdentifier = "cell"
    static var isfrom = 0
    static var IsFrommovie = 0
    var playerurlstr = ""
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
 
    var Isfavourite = 0
    var WatchDuration = 0
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.title = selftitle
           self.ComedyCollectionV.register(UINib(nibName:"MusicCell", bundle:nil), forCellWithReuseIdentifier: cellIdentifier)
        
    }
    override func viewWillAppear(_ animated: Bool) {
        Keycenter.limit = 24
    }
    override func viewWillDisappear(_ animated: Bool) {
        Keycenter.limit = 10
    }
    override func viewDidAppear(_ animated: Bool) {
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
            Api.Getconent(category, subCat: subcategory,endpoint: ApiEndPoints.getFilteredContent, vc: self, offset: offset) { (res, err) -> (Void) in
              do
              {
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
  override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
       
       
                  if segue.identifier == "tomoviedetails"
                  {
                   guard let navController = segue.destination as? UINavigationController,
                       let displayVC = navController.topViewController as? MoviesDetailsVC else {
                           return
                   }
                    
                           displayVC.imagename = imagename
                           displayVC.moviename = moviename
                           displayVC.movietype = movietype
                           displayVC.timereleasedate = timereleasedate
                           displayVC.language = language
                           displayVC.movdescription = movdescription
                           displayVC.ComedyMoviedata = ComedyMoviedata
                           displayVC.ThrillerMoviedata = ThrillerMoviedata
                           
                   
                           displayVC.imdbID = imdbId
                           displayVC.perma = perma
                           displayVC.Movcategory = Movcategory
                           displayVC.MovSubcategory = MovSubcategory
                           displayVC.movieuniqid = movieuniqid
                           displayVC.Isfavourite = Isfavourite
                          displayVC.WatchDuration = WatchDuration
                           
                   
                  }else if segue.identifier == "tosubscribe"
                    {
                     guard let navController = segue.destination as? UINavigationController,
                                                         let displayVC = navController.topViewController as? MyplansVC else {
                                                             return
                                                     }
                                           
                            displayVC.movieuniqid = movieuniqid
                                             
                     
                  }else if segue.identifier == "toothervideos"
                  {
                   guard let navController = segue.destination as? UINavigationController,
                       let displayVC = navController.topViewController as? OtherVideosVCDetails else {
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
                           
                   
                  }else if segue.identifier == "toseries"
                  {
                   guard let navController = segue.destination as? UINavigationController,
                       let displayVC = navController.topViewController as? SerirsDetailsVC else {
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
                  } else if segue.identifier == "toothervideos"
                                   {
                                    guard let navController = segue.destination as? UINavigationController,
                                        let displayVC = navController.topViewController as? OtherVideosVCDetails else {
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
       
    
    
 

}
extension MusicViewAllVC:UICollectionViewDelegate,UICollectionViewDataSource
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
    
       
      let Comedycell = collectionView.dequeueReusableCell(withReuseIdentifier: cellIdentifier, for: indexPath) as! MusicCell
            let item = comedydata[indexPath.row]
        Comedycell.ImgSample.sd_setImage(with: URL(string: "\(item.poster ?? "")"), completed: nil)
        Comedycell.LbName.text = item.title
       // Comedycell.btnCounter.tag = indexPath.row
       // Comedycell.btnCounter.addTarget(self, action: #selector(self.buttonClicked), for: .touchUpInside)
                        
        if item.is_fav_status == 0
        {
          //  Comedycell.btnCounter.setBackgroundImage(UIImage(named: "like"), for: .normal)
        }else if item.is_fav_status == 1
        {
          //  Comedycell.btnCounter.setBackgroundImage(UIImage(named: "liked"), for: .normal)
        }
                return Comedycell
          
   
        
    }
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
                   
                 //  imagename = ComedyMoviedata?.subComedymovList[indexPath.row].poster ?? ""
                   moviename = ComedyMoviedata?.subComedymovList[indexPath.row].title ?? ""
        playerurlstr = ComedyMoviedata?.subComedymovList[indexPath.row].permalink ?? ""
                 //  movietype = ComedyMoviedata?.subComedymovList[indexPath.row].poster ?? ""
                 //  imdbId = ComedyMoviedata?.subComedymovList[indexPath.row].custom?.customimdb?.field_value ?? ""
                  // movieuniqid =  ComedyMoviedata?.subComedymovList[indexPath.row].movie_uniq_id ?? ""
                   perma = ComedyMoviedata?.subComedymovList[indexPath.row].c_permalink ?? ""
                   //Isfavourite = ComedyMoviedata?.subComedymovList[indexPath.row].is_fav_status ?? 0
                  // WatchDuration = ComedyMoviedata?.subComedymovList[indexPath.row].watch_duration_in_seconds ?? 0
                  getcontentauthorised(movieid: ComedyMoviedata?.subComedymovList[indexPath.row].movie_uniq_id ?? "")
    }
   func getcontentauthorised(movieid:String)
           {
    
           Api.IsContentAuthorised(movieid, endpoint: ApiEndPoints.isContentAuthorized, vc: self) { (res, err) -> (Void) in
                                
               do{
                                    
                   let decoder = JSONDecoder()
                   self.authorizeddata = try decoder.decode(Authorizescontent.self, from: res  ?? Data())
                                   
                   if self.authorizeddata?.status == "OK"
                   {
                       let storyBoard: UIStoryboard = UIStoryboard(name: "Main", bundle: nil)
                       let displayVC = storyBoard.instantiateViewController(withIdentifier: "SongsDetailsVC") as! SongsDetailsVC
                          displayVC.modalPresentationStyle = .fullScreen
                           displayVC.permalink = self.perma
                      displayVC.songtitle = self.moviename
                       displayVC.IsAuthorizedContent = 1
                    displayVC.playerurlstr = self.playerurlstr
                      self.present(displayVC, animated: true, completion: nil)
                        
                   }
                                   
                   else
                   {
                       
                       
                       let storyBoard: UIStoryboard = UIStoryboard(name: "Main", bundle: nil)
                       let displayVC = storyBoard.instantiateViewController(withIdentifier: "SongsDetailsVC") as! SongsDetailsVC
                          displayVC.modalPresentationStyle = .fullScreen
                     displayVC.permalink = self.perma
                      displayVC.songtitle = self.moviename
                       displayVC.IsAuthorizedContent = 0
                    displayVC.playerurlstr = self.playerurlstr

                      self.present(displayVC, animated: true, completion: nil)
                   }
                                }
                                catch let error
                                {
                               //     Utility.showAlert(vc: self, message:"\(error)", titelstring: Appcommon.Appname)
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
                                  //  self.GetComedyMovielist(offset: self.index, category: self.Movcategory, subcategory: self.MovSubcategory)
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
   
extension MusicViewAllVC: UICollectionViewDelegateFlowLayout
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
 
  
