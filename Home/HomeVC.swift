//
//  HomeVC.swift
//  bigfantv
//
//  Created by Ganesh on 23/12/20.
//  Copyright © 2020 Ganesh. All rights reserved.
//
import Foundation
import UIKit
import MaterialComponents.MaterialDialogs
import AVKit
import SDWebImage
import FirebaseFirestore
class HomeVC: UIViewController {
 var controller_5: StaticMovies = StaticMovies.create()


    @IBOutlet var Lbtext1: UILabel!
    
    @IBOutlet var Lbtext2: UILabel!
    
    @IBOutlet var Btsaubmit: UIButton!
    
    @IBOutlet var Visample: UIView!
    
    @IBOutlet var Outletc: NSLayoutConstraint!
    
    
    @IBOutlet var Vistaticmovies: UIView!
     @IBOutlet var BTWathcnow: UIButton!
    
    
    @IBOutlet var Tableviewheight: NSLayoutConstraint!
    
    @IBOutlet var ViDynamic: UIView!
    
    
    //Dynamc data
    @IBOutlet public var tableView: UITableView?
    
    var counts: Int = 10
    var colors: [UIColor] = []
        var newFeaturedList:FeaturedData?
        var tappedCell:FeaturedDatadetails?
        var featuredarray:FeaturedData?
        var featuredsd = [FeaturedDataList]()
         var passarray:FeaturedDataList?
    var sectioncounter = 0
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
        private var authorizeddata:Authorizescontent?
    
//radio
    
        var Radioid = [String]()
    let RadioListdata:[RadioData] = [
        
           RadioData(Icon:"Funasia 104.9", Url: "https://ott.streann.com/loadbalancer/services/public/radios-secure/5b6e1d3a2cdc525067391d78/playlist.m3u8", Title: "Funasia 104.9"),
           RadioData(Icon: "Big FM 106.2", Url: "https://eu1.fastcast4u.com/proxy/dzcwbfih_eu?mp=/1", Title: "Big FM 106.2"),
           RadioData(Icon:"CHILLED LUV", Url: "http://funasia.streamguys1.com:80/live7", Title: "CHILLED LUV"),
           
           RadioData(Icon: "BEAT FM 97.8", Url: "https://funasia.streamguys1.com/live3", Title: "BEAT FM 97.8"),
           RadioData(Icon: "BEAT ANTHEMS", Url: "http://funasia.streamguys1.com:80/live5", Title: "BEAT ANTHEMS"),
          
           
           RadioData(Icon: "BIG MELODIES", Url: "https://funasia.streamguys1.com/live9", Title: "BIG MELODIES"),
            RadioData(Icon: "Radio Azad", Url: "https://usa2.fastcast4u.com/proxy/jgivvimk?mp=/1", Title: "Radio Azad"),
             RadioData(Icon:  "LUV LEGENDS", Url: "http://funasia.streamguys1.com:80/live8", Title: "LUV LEGENDS"),
          
           RadioData(Icon: "LUV FM 107.1", Url: "https://funasia.streamguys1.com/live3", Title: "LUV FM 107.1"),
           RadioData(Icon: "URBAN BEAT", Url: "http://funasia.streamguys1.com:80/live6", Title: "URBAN BEAT"),
           RadioData(Icon:"Radio Mirchi", Url: "https://streams.radio.co/s8d06d0298/listen", Title: "Radio Mirchi")
         
                     ]
    var filteredArray = [RadioData]()
    
    struct Favorite {
      let name: String
    }
     var finalradio = [Favorite]()
    
    let cellIdentifier = "cell"
    var category = ""
    var subcategory = ""
    var Radiotitle = ""
    var Radiourl = ""
    @IBOutlet var CollectionV: UICollectionView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Visample.isHidden = true
        //Visample.translatesAutoresizingMaskIntoConstraints = true
       // Visample.frame.size.height = 300
        BTWathcnow.roundCorners([.topLeft, .bottomRight], radius: 5, borderColor: nil, borderWidth: nil)
        Outletc.constant = 1800
        addViewControllerAsChildViewController(childViewController: controller_5)
        
           let cellNib = UINib(nibName: "TableViewCell", bundle: nil)
         self.tableView?.register(cellNib, forCellReuseIdentifier: "tableviewcellid")

         tableView?.backgroundColor = Appcolor.backgorund3
        // tableView?.isScrollEnabled = false
         tableView?.allowsMultipleSelection = true
         
         if Connectivity.isConnectedToInternet()
         {
             GetFeatureddata()
             
         }else
         {
             Utility.Internetconnection(vc: self)
             
         }
    self.CollectionV.register(UINib(nibName:"LnagCellFeatured", bundle:nil), forCellWithReuseIdentifier: cellIdentifier)
                   customClassGetDocument()
           }
           private func customClassGetDocument() {
                                   
                          guard let userid = UserDefaults.standard.string(forKey: "id")    else {return}
                  let docRef = Firestore.firestore().collection("UserPreference").document(userid)

                     docRef.getDocument { (document, error) in
                      if let err = error
                      {
                            print("Error fetch document: \(err)")
                      }
                      else
                      {
                          guard let data = document?.data() else {return}
                       self.Radioid =  data["Radio"] as? [String] ?? [String]()
                           
                          for i in self.Radioid
                          {
                              let f = Favorite(name: i)
                              self.finalradio.append(f)
                          }
                          
             let favoriteNames = self.finalradio.map { $0.name }
                self.filteredArray = self.RadioListdata.filter {  favoriteNames.contains($0.Title) }

                                           
                                           
                                           
                                         self.CollectionV.delegate = self
                                         self.CollectionV.dataSource = self
                                          self.CollectionV.reloadData()
                                      
                                         Utility.hideLoader(vc: self)
                                         
                                        }

                             }
           }
    
       private func addViewControllerAsChildViewController(childViewController: UIViewController) {
    
           addChild(childViewController)
         self.Vistaticmovies.addSubview(childViewController.view)
         
         childViewController.view.frame = Vistaticmovies.bounds
         childViewController.view.autoresizingMask = [.flexibleWidth, .flexibleHeight]
         
         // Notify the childViewController, that you are going to add it into the Container-View -Controller
           childViewController.didMove(toParent: self)
         
       }
    func GetFeatureddata()
           {
               Api.Getfeatureddata(ApiEndPoints.loadFeaturedSections, vc: self, offset: 1) { (res, err) -> (Void) in
                      do
                      {
                       
                          let decoder = JSONDecoder()
                          self.featuredarray = try decoder.decode(FeaturedData.self, from: res  ?? Data())
                       
                     
                       
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
                       
                        //UserDefaults.standard.set(2, forKey: "dg")
                        self.tableView?.delegate = self
                        self.tableView?.dataSource = self
                        self.tableView?.reloadData()
                        guard let numbers = self.newFeaturedList?.subComedymovList?.count else {return}
                            self.Tableviewheight.constant = CGFloat((160 * numbers))
                       // UserDefaults.standard.set(true, forKey: "datafound")
                       }
                      }
                       catch let error
                       {
                          // Utility.showAlert(vc: self, message:"\(error)", titelstring: Appcommon.Appname)
                             
                      }
                         }
    }
    
    
}

extension HomeVC:  UITableViewDataSource, UITableViewDelegate
{
    public func numberOfSections(in tableView: UITableView) -> Int {
                   return  newFeaturedList?.subComedymovList?.count ?? 0
               }
    
    public func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
                   return 1
               }
               
    public func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
                return   160
               }
    public func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
                 let headerView = UIView()
                 headerView.backgroundColor = Appcolor.backgorund3
                 
                 let whiteview = UIView(frame: CGRect(x: 16, y: 14, width: 4, height: 16))
                     whiteview.backgroundColor = UIColor.white
                  headerView.addSubview(whiteview)
                 
             let button = UIButton(frame: CGRect(x: ((self.tableView?.frame.size.width ?? 414) - 26)  , y: 10, width: 22, height: 22))
                 button.tag = section
                 button.addTarget(self, action: #selector(loaddata(_:)), for: .touchUpInside)
                 button.setBackgroundImage(UIImage(named: "viewall"), for: .normal)
                 headerView.addSubview(button)
                 
                 let titleLabel = UILabel(frame: CGRect(x: 32, y: 0, width: 200, height: 44))
                 headerView.addSubview(titleLabel)
                 titleLabel.textColor = UIColor.white
                 titleLabel.font =  UIFont(name: "Muli-SemiBold", size: 17)!
                 titleLabel.text = newFeaturedList?.subComedymovList?[section].title
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
             
    public func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
                 return 44
             }
    public func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
                 if let cell = tableView.dequeueReusableCell(withIdentifier: "tableviewcellid", for: indexPath) as? TableViewCell {
                       let rowArray = (newFeaturedList?.subComedymovList?[indexPath.section].contents)!
                     
                    cell.updateCellWith(row: rowArray, rowindex: indexPath.section)
 
                    cell.cellDelegate = self
                     
                     cell.selectionStyle = .none
                     return cell
                }
                 return UITableViewCell()
             }

       
    }

     
    extension HomeVC: CollectionViewCellDelegate
    {
        func collectionView(collectionviewcell: CollectionViewCell?, index: Int, rowindex: Int, didTappedInTableViewCell: TableViewCell) {
              if let colorsRow = didTappedInTableViewCell.rowWithColors
                      {
                           passarray = newFeaturedList?.subComedymovList?[rowindex]
                          
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
                          let movieid = tappedCell?.movie_uniq_id ?? ""
                        
                           passarray?.contents?.remove(at: index)
                          getcontentauthorised(movieid: movieid)
                            
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
        }
     }

extension HomeVC:UICollectionViewDelegate,UICollectionViewDataSource
{
    public func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return filteredArray.count
    }
    public func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
       
             let Comedycell = collectionView.dequeueReusableCell(withReuseIdentifier: cellIdentifier, for: indexPath) as! LnagCellFeatured
        Comedycell.ImgLang.image = UIImage(named: filteredArray[indexPath.row].Icon)
        Comedycell.LbLang.text = filteredArray[indexPath.row].Title
         
             return Comedycell
    
          
    }
    
    
    public func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
       let storyBoard: UIStoryboard = UIStoryboard(name: "Main", bundle: nil)
                               
        let displayVC = storyBoard.instantiateViewController(withIdentifier: "RadioDetailsVC") as! RadioDetailsVC
           displayVC.modalPresentationStyle = .fullScreen
           displayVC.Videotitle = filteredArray[indexPath.row].Title
           displayVC.Videourl = filteredArray[indexPath.row].Url
           
            
          self.present(displayVC, animated: true, completion: nil)
                                
        
    }
    
}
extension HomeVC: UICollectionViewDelegateFlowLayout
{
    public func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
            
            if UIDevice.current.userInterfaceIdiom == .pad
            {
                return CGSize(width: collectionView.frame.size.height + 40, height:collectionView.frame.size.height)
            }
            else if UIDevice.current.userInterfaceIdiom == .phone
            {
                return CGSize(width: collectionView.frame.size.height, height: collectionView.frame.size.height)
             }
            
            return CGSize(width: 180, height: 280)
        }
     
   
    }
 
