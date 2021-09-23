//
//  SearchVC.swift
//  bigfantv
//
//  Created by Ganesh on 19/08/20.
//  Copyright © 2020 Ganesh. All rights reserved.
//

import UIKit
import MaterialComponents.MaterialDialogs
class SearchVC: UIViewController {
    @IBOutlet var CollectionV: UICollectionView!
    @IBOutlet var tfSearch: UITextField!
     var searchdata:searchList?
    var contentdata:contentdetails?
     private var passComedyMoviedata:newFilteredSubComedymovieList?
        private var authorizeddata:Authorizescontent?
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
    let cellIdentifier = "cell"
    override func viewDidLoad() {
        super.viewDidLoad()
 self.CollectionV.register(UINib(nibName:"MyCell", bundle:nil), forCellWithReuseIdentifier: cellIdentifier)
         
    }
    override func viewWillAppear(_ animated: Bool) {
        //tfSearch.text = "golmaal"
        
         tfSearch.attributedPlaceholder = NSAttributedString(string: "Search",
                                                                   attributes: [NSAttributedString.Key.foregroundColor:Appcolor.textcolor])
    }
     
    
    @IBAction func BtBackTapped(_ sender: UIButton) {
                                  self.dismiss(animated: true, completion: nil)
    }
    @objc func close()
                           {

                           }
    
    @IBAction func BtSearchTapped(_ sender: UIButton) {
        
        if !(tfSearch.text?.isEmpty ?? false)
        {
            tfSearch.resignFirstResponder()
            getsearchresponse(query: tfSearch.text ?? "")
        }
        
    }
    
    func getsearchresponse(query:String)
    {
        Api.Searchdata(query, endpoint: ApiEndPoints.searchData, vc: self)  { (res, err) -> (Void) in
                               do
                               {
                                   let decoder = JSONDecoder()
                                   self.searchdata = try decoder.decode(searchList.self, from: res  ?? Data())
                                      
                                self.CollectionV.delegate  = self
                                self.CollectionV.dataSource =  self
                                   
                                   DispatchQueue.main.async
                                       {
                                       self.CollectionV.reloadData()
                                }
                                  
                               }
                               catch let error
                               {
                                   Utility.showAlert(vc: self, message:"\(error)", titelstring: Appcommon.Appname)
                               }
                           }
    }
    

}
extension SearchVC:UICollectionViewDelegate,UICollectionViewDataSource
{
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        
        
            return searchdata?.subComedymovList.count ?? 0
        
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
            
           let Comedycell = collectionView.dequeueReusableCell(withReuseIdentifier: cellIdentifier, for: indexPath) as! MyCell
            let item = searchdata?.subComedymovList[indexPath.row]
        Comedycell.ImgSample.sd_setImage(with: URL(string: "\(item?.poster ?? "")"), completed: nil)
        Comedycell.LbName.text = item?.title
             Comedycell.btnCounter.tag = indexPath.row
             
        if item?.is_fav_status == 0
             {
                 Comedycell.btnCounter.setBackgroundImage(UIImage(named: "like"), for: .normal)
        }else if item?.is_fav_status == 1
             {
                 Comedycell.btnCounter.setBackgroundImage(UIImage(named: "liked"), for: .normal)
             }
                     return Comedycell
               
        
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
            
        passComedyMoviedata = searchdata?.subComedymovList[indexPath.row]
         getFavcontentauthorised(movieid: passComedyMoviedata?.movie_uniq_id ?? "", contenttypesid: passComedyMoviedata?.content_types_id ?? "")
                    
                
                
                
            }
            func getFavcontentauthorised(movieid:String,contenttypesid:String)
            {
                    if contenttypesid == "1"
                    {
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
                    }
                    self.present(displayVC, animated: true, completion: nil)
                    }else if  contenttypesid == "3"
                    {
                        let storyBoard: UIStoryboard = UIStoryboard(name: "Main", bundle: nil)
                         let displayVC = storyBoard.instantiateViewController(withIdentifier: "SerirsDetailsVC") as! SerirsDetailsVC
                            displayVC.modalPresentationStyle = .fullScreen
                             
                            displayVC.perma = self.passComedyMoviedata?.c_permalink ?? ""
                            displayVC.movieuniqid = self.passComedyMoviedata?.movie_uniq_id ?? ""
                         //   displayVC.Movcategory = self.Movcategory
                         //   displayVC.MovSubcategory = self.MovSubcategory
                        displayVC.playerurlstr = self.passComedyMoviedata?.permalink ?? ""
                           
                        self.present(displayVC, animated: true, completion: nil)
                    }else if  contenttypesid == "5"
                    {
                         let storyBoard: UIStoryboard = UIStoryboard(name: "Main", bundle: nil)
                         let displayVC = storyBoard.instantiateViewController(withIdentifier: "SongsDetailsVC") as! SongsDetailsVC
                            displayVC.modalPresentationStyle = .fullScreen
                             
                        displayVC.permalink = self.passComedyMoviedata?.c_permalink ?? ""
                             
                        self.present(displayVC, animated: true, completion: nil)
                    }
                /*
                Api.IsContentAuthorised(movieid, endpoint: ApiEndPoints.isContentAuthorized, vc: self) { (res, err) -> (Void) in
                               
                    do
                    {
                        let decoder = JSONDecoder()
                        self.authorizeddata = try decoder.decode(Authorizescontent.self, from: res  ?? Data())
                       
                        if self.authorizeddata?.status == "OK"
                        {
                            if contenttypesid == "1"
                            {
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
                            }
                            self.present(displayVC, animated: true, completion: nil)
                            }else if  contenttypesid == "3"
                            {
                                let storyBoard: UIStoryboard = UIStoryboard(name: "Main", bundle: nil)
                                 let displayVC = storyBoard.instantiateViewController(withIdentifier: "SerirsDetailsVC") as! SerirsDetailsVC
                                    displayVC.modalPresentationStyle = .fullScreen
                                     
                                    displayVC.perma = self.passComedyMoviedata?.c_permalink ?? ""
                                    displayVC.movieuniqid = self.passComedyMoviedata?.movie_uniq_id ?? ""
                                 //   displayVC.Movcategory = self.Movcategory
                                 //   displayVC.MovSubcategory = self.MovSubcategory
                                displayVC.playerurlstr = self.passComedyMoviedata?.permalink ?? ""
                                   
                                self.present(displayVC, animated: true, completion: nil)
                            }else if  contenttypesid == "5"
                            {
                                 let storyBoard: UIStoryboard = UIStoryboard(name: "Main", bundle: nil)
                                 let displayVC = storyBoard.instantiateViewController(withIdentifier: "SongsDetailsVC") as! SongsDetailsVC
                                    displayVC.modalPresentationStyle = .fullScreen
                                     
                                displayVC.permalink = self.passComedyMoviedata?.c_permalink ?? ""
                                     
                                self.present(displayVC, animated: true, completion: nil)
                            }
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
                            { (cancelaction) in  }
                            alertController.addAction(action)
                            alertController.addAction(cancelaction)
                            self.present(alertController, animated: true, completion: nil)
                            
                        }
                        
                    }
                    catch let error
                    {
                      //  Utility.showAlert(vc: self, message:"\(error)", titelstring: Appcommon.Appname)
                     }
                    
                }
                */
            }
    func getcontentauthorised(movieid:String)
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
            
              
            secondViewController.movieuniqid = self.movieuniqid
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
                                            let secondViewController =  storyBoard.instantiateViewController(withIdentifier: "testdetaisVC") as! testdetaisVC
                                             secondViewController.imagename = self.imagename
                                             secondViewController.moviename = self.moviename
                                             secondViewController.movietype = self.movietype
                                             secondViewController.timereleasedate = self.timereleasedate
                                             secondViewController.language = self.language
                                             secondViewController.perma = self.perma
                                             secondViewController.Movcategory = self.Movcategory
                                             secondViewController.MovSubcategory = self.MovSubcategory
                                           
                                             
                                           secondViewController.movieuniqid = self.movieuniqid
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
                                        Utility.showAlert(vc: self, message:"\(error)", titelstring: Appcommon.Appname)
                                    }
                                }
            */
           }
    
    func getcontendeatils(perma:String)
    {
        Api.getcontentdetails(perma, endpoint: ApiEndPoints.getcontentdetails, vc: self) { (res, err) -> (Void) in
            do
            {
           
                let decoder = JSONDecoder()
                self.contentdata = try decoder.decode(contentdetails.self, from: res  ?? Data())
           
                
                if self.contentdata?.category_name == "Movies"
                {
                  self.performSegue(withIdentifier: "tomoviedetails", sender: self)
                }else if self.contentdata?.category_name == "LIVE TV"
                {
                     self.performSegue(withIdentifier: "tolivetv", sender: self)
                }else if self.contentdata?.category_name == "Web Series"
                {
                    self.performSegue(withIdentifier: "toseries", sender: self)
                }else if self.contentdata?.category_name == "Cover Songs"
                {
                    self.performSegue(withIdentifier: "tomusic", sender: self)
                }
            }
            catch let error
            {
                Utility.showAlert(vc: self, message:"\(error)", titelstring: Appcommon.Appname)
            }
        }
    }
    /*
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
                                  //displayVC.ComedyMoviedata = ComedyMoviedata
                                  //displayVC.ThrillerMoviedata = ThrillerMoviedata
                                 // displayVC.ActionMoviedata = ActionMoviedata
                                       
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
                         }else if segue.identifier == "tomusic"
                           {
                            guard let navController = segue.destination as? UINavigationController,
                                let displayVC = navController.topViewController as? SongsDetailsVC else {
                                    return
                            }
                                                 
                                  displayVC.permalink = permalink
                            }
                             else if segue.identifier == "toseries"
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
                          
                            }
              
            
              }
    */
    
}
    
extension SearchVC: UICollectionViewDelegateFlowLayout
{
        func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
            /*
            if UIDevice.current.userInterfaceIdiom == .pad
            {
                return CGSize(width:  collectionView.frame.size.width/5 - 5, height:160)
            }
            else if UIDevice.current.userInterfaceIdiom == .phone
            {
               return CGSize(width: collectionView.frame.size.width/2 - 5, height:160)
            }
            */
            return CGSize(width: collectionView.frame.size.width/2 - 5, height:160)
        }
     
   
    }
 
