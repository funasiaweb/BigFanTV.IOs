//  ScrollingStackController
//  Efficient Scrolling Container for UIViewControllers
//
//  Created by Daniele Margutti.
//  Copyright © 2017 Daniele Margutti. All rights reserved.
//
//	Web: http://www.danielemargutti.com
//	Email: hello@danielemargutti.com
//	Twitter: @danielemargutti
//
//
//	Permission is hereby granted, free of charge, to any person obtaining a copy
//	of this software and associated documentation files (the "Software"), to deal
//	in the Software without restriction, including without limitation the rights
//	to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
//	copies of the Software, and to permit persons to whom the Software is
//	furnished to do so, subject to the following conditions:
//
//	The above copyright notice and this permission notice shall be included in
//	all copies or substantial portions of the Software.
//
//	THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
//	IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
//	FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
//	AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
//	LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
//	OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN
//	THE SOFTWARE.

import Foundation
import UIKit
import MaterialComponents.MaterialDialogs
import AVKit
import SDWebImage
import Alamofire
extension UIColor {
	
	static func random() -> UIColor {
  let hue : CGFloat = CGFloat(arc4random() % 256) / 256 // use 256 to get full range from 0.0 to 1.0
  let saturation : CGFloat = CGFloat(arc4random() % 128) / 256 + 0.5 // from 0.5 to 1.0 to stay away from white
  let brightness : CGFloat = CGFloat(arc4random() % 128) / 256 + 0.5 // from 0.5 to 1.0 to stay away from black
		
  return UIColor(hue: hue, saturation: saturation, brightness: brightness, alpha: 1)
	}
	
}

public class ContainerListCell: UITableViewCell {
	@IBOutlet public var titleLabel: UILabel?
}

public class ContainerList: UIViewController, StackContainable, UITableViewDataSource, UITableViewDelegate {
	
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
    var newperma = ""
      var contenttypesid  = ""
        private var authorizeddata:Authorizescontent?
    var callback : ((Bool?) -> Void)?
    let manager: Alamofire.SessionManager = {
          let configuration = URLSessionConfiguration.default
           configuration.httpMaximumConnectionsPerHost = 50
           configuration.timeoutIntervalForRequest = TimeInterval(60)
          configuration.timeoutIntervalForResource = TimeInterval(60)
          return  Alamofire.SessionManager(configuration: configuration)
      }()
       
    var beatCount : Bool?

   
    var isloaded = false
	public static func create() -> ContainerList {
		return UIStoryboard(name: "Containers", bundle: Bundle.main).instantiateViewController(withIdentifier: "ContainerList") as! ContainerList
	}
	
	public override func viewDidLoad() {
		super.viewDidLoad()
             
          
           let cellNib = UINib(nibName: "TableViewCell", bundle: nil)
         self.tableView?.register(cellNib, forCellReuseIdentifier: "tableviewcellid")

         tableView?.backgroundColor = Appcolor.backgorund4
        // tableView?.isScrollEnabled = false
         tableView?.allowsMultipleSelection = true
         self.tableView?.delegate = self
         self.tableView?.dataSource = self
         if Connectivity.isConnectedToInternet()
         {
            Timer.scheduledTimer(withTimeInterval: 0.01, repeats: false) { (t) in
               
                self.GetFeatureddata()
            }
         }else
         {
             Utility.Internetconnection(vc: self)
             
         }
        
	}
 
    func GetFeatureddata()
           {
            guard let parameters =
                [
                    "authToken" : Keycenter.authToken,
                    
                    "user_id": UserDefaults.standard.string(forKey: "id") ?? ""
                    ] as? [String:Any] else { return  }
                 let url:URL = URL(string: "https://bigfantv.com/en/rest/loadFeaturedSections")!
                 
                 
                 
                  print(parameters)
                // manager.session.configuration.httpMaximumConnectionsPerHost = 50
                 Alamofire.request(url, method: .post, parameters: parameters, encoding: JSONEncoding.default, headers: nil).responseJSON { (response) in
              
                     switch response.result
                     {

                
                     case .success(_):
                    
                         if response.value != nil
                         {
                             do
                             {
                                      let decoder = JSONDecoder()
                                self.featuredarray = try decoder.decode(FeaturedData.self, from: response.data  ?? Data())
                                   
                                 
                                   
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
                                    print("found featurd")
                                   DispatchQueue.main.async {
                                   
                                     

                                    self.tableView?.reloadData()
                                    self.isloaded = true
                                    print("uploaded")
                                    
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
	
 
	
	public func preferredAppearanceInStack() -> ScrollingStackController.ItemAppearance {
	    let _ = self.view // force load of the view
          return .scroll(self.tableView!, insets: UIEdgeInsets(top:0, left: 0, bottom: 0, right: 0))
        
    }
}


extension ContainerList
{
    public func numberOfSections(in tableView: UITableView) -> Int    {
                   return  newFeaturedList?.subComedymovList?.count ?? 0
               }
    
    public func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
                   return 1
               }
               
  
 
    public func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
                 let headerView = UIView()
                 headerView.backgroundColor = Appcolor.backgorund4
                 
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
    public func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        190
    }
 
    public func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell
    {
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

     
    extension ContainerList: CollectionViewCellDelegate
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
                           newperma = tappedCell?.permalink ?? ""
                           Isfavourite = tappedCell?.is_fav_status ?? 0
                           WatchDuration = tappedCell?.watch_duration_in_seconds ?? 0
                           contenttypesid = tappedCell?.content_types_id ?? ""
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
     }

