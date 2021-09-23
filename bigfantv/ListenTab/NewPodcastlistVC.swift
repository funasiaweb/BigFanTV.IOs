//
//  NewPodcastlistVC.swift
//  bigfantv
//
//  Created by iOS on 16/07/2021.
//  Copyright © 2021 Ganesh. All rights reserved.
//

import UIKit
import Alamofire
class NewPodcastlistVC: UIViewController {

    @IBOutlet var Tablevheight: NSLayoutConstraint!
    @IBOutlet var TableV: UITableView!
    private var Mainpodcastedata:MainAudiopodcastData?
    private var subcatdata:SubcategoryData?
    private var audiopodcastdata:AudioPodcastDataList?
    var Audiolist = [MainAudiopodcastDataList]()
    var tappedCell:AudioPodcastDataListDetails?


    
    @IBOutlet var podcastTableHeight: NSLayoutConstraint!
    @IBOutlet var PodcastTableV: UITableView!
    var PodcastData:PodcastRssfeeddata?

    
    
    let manager: Alamofire.SessionManager =
    {
        let configuration = URLSessionConfiguration.default
        return  Alamofire.SessionManager(configuration: configuration)
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        //Muvi podcast data
        let cellNib = UINib(nibName: "podcastTableViewCell", bundle: nil)
        self.TableV?.register(cellNib, forCellReuseIdentifier: "tableviewcellid")

        TableV?.backgroundColor = Appcolor.backgorund4
       // tableView?.isScrollEnabled = false
        TableV?.allowsMultipleSelection = true
        self.TableV?.delegate = self
        self.TableV?.dataSource = self
        
        let podcellNib = UINib(nibName: "HomepodcastTableViewCell", bundle: nil)
         self.PodcastTableV.register(podcellNib, forCellReuseIdentifier: "tableviewcellid")

        PodcastTableV.backgroundColor = Appcolor.backgorund4
        PodcastTableV.estimatedRowHeight = 160
    
        // tableView?.isScrollEnabled = false
        PodcastTableV.allowsMultipleSelection = true

        if Connectivity.isConnectedToInternet()
        {
            Loadallpodcastdata()
            getsubcategorylist()
        }else
        {
            Utility.Internetconnection(vc: self)
        }
     }
    
    func Loadallpodcastdata()
           
    {
        Utility.ShowLoader(vc: self)
        guard let parameters =
                    [
                        "userId":UserDefaults.standard.string(forKey: "id") ?? "",
                        "AccessToken":UserDefaults.standard.string(forKey: "AccessToken") ?? "",
                        "offset":"1"
                    ] as? [String:Any] else { return  }
 
        print(parameters)
        let url:URL = URL(string: "https://funasia.net/bigfantv.funasia.net/service/getAllAudioVideoPodcastList.html")!
                   
        manager.request(url, method: .post, parameters: parameters, encoding: JSONEncoding.default, headers: nil).responseJSON { (response) in
                 print(response)
            switch response.result
            {
            case .success(_):
                if response.value != nil
                            
                {
                    do
                    {
                        Utility.hideLoader(vc: self)
   
                        let decoder = JSONDecoder()
                       self.PodcastData = try decoder.decode(PodcastRssfeeddata.self, from: response.data ?? Data())
                                  
                        if  self.PodcastData?.success == 1
                        {
                            DispatchQueue.main.async
                            {
                                
                                    self.PodcastTableV.delegate = self
                                    self.PodcastTableV.dataSource = self
                                    self.PodcastTableV.reloadData()
                                    self.podcastTableHeight.constant = self.PodcastTableV.contentSize.height //Dynamic tableview height
                            //print(self.FeturesectionTableHeight.constant)
                            
                                UIView.animate(withDuration: 0.1)
                                {
                                   self.view.layoutIfNeeded()
                                }
                            }
                        }
                        
                    }
                    catch let error
                                {
                        Utility.hideLoader(vc: self)

                                   print("podcast error = \(error.localizedDescription)")
                                }
                        }
                        break
                    case .failure(let error):
                        print(error)
                        Utility.hideLoader(vc: self)

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
                    let myGroup = DispatchGroup()

                    guard let count = self.subcatdata?.subCategoryList?.count else{return}
                    for i in 0..<count
                    {
                      //  myGroup.enter()

                        Common.getpodcastdata(category: "audio-podcast", subcategory: self.subcatdata?.subCategoryList?[i].permalink ?? "", vc: self) { (data, err) -> (Void) in
                       do
                        {
                       //     myGroup.leave()

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
                                    let audiodata = MainAudiopodcastDataList(permalink: self.subcatdata?.subCategoryList?[i].permalink, title:self.subcatdata?.subCategoryList?[i].subcatName , contents: r)
                                    self.Audiolist.append(audiodata)
                                    
                                    let maindata = MainAudiopodcastData(code: 0, status: "ok", subComedymovList: self.Audiolist)
                                    self.Mainpodcastedata = maindata
                                    DispatchQueue.main.async
                                        {
                                       // print("count = \(self.Mainpodcastedata?.subComedymovList?.count)")
                                            self.TableV.reloadData()
                                        self.Tablevheight.constant =  self.TableV.contentSize.height
                                            self.Tablevheight.constant = CGFloat(200 * (self.Mainpodcastedata?.subComedymovList?.count ?? 0) ) + 100
                                            self.view.layoutIfNeeded()
                                    }
                                    
                                    /*
                                    DispatchQueue.main.async
                                        {
                                           // self.TableV.reloadData()
                                       // self.Tablevheight.constant = self.TableV.contentSize.height + 100 //Dynamic tableview height
                                       // self.Tablevheight.constant = CGFloat(160 * (self.Mainpodcastedata?.subComedymovList?.count ?? 0) ) + 100
                                       
                                        UIView.animate(withDuration: 0.1)
                                        {
                                           self.view.layoutIfNeeded()
                                        }


                                    }
                                    */
                                }
                              //  self.TableV.reloadData()
                           // self.Tablevheight.constant = self.TableV.contentSize.height + 100
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
    

}
extension NewPodcastlistVC : UITableViewDelegate,UITableViewDataSource
{
    func numberOfSections(in tableView: UITableView) -> Int
    {
        if tableView == TableV
        {
            return Mainpodcastedata?.subComedymovList?.count ?? 0
        }else
        {
            return PodcastData?.podcastList?.count ?? 0
        }
    }
     
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int
    {
        return 1
    }
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView?
    {
        let headerView = UIView()
        headerView.backgroundColor = Appcolor.backgorund4
              
        let whiteview = UIView(frame: CGRect(x: 16, y: 14, width: 4, height: 16))
        whiteview.backgroundColor = UIColor.white
        headerView.addSubview(whiteview)
            
        let button = UIButton(frame: CGRect(x: ((self.TableV.frame.size.width) - 26)  , y: 10, width: 22, height: 22))
        button.tag = section
        if tableView == TableV
        {
            button.addTarget(self, action: #selector(loaddata(_:)), for: .touchUpInside)
        }else
        {
            button.addTarget(self, action: #selector(loaddata1(_:)), for: .touchUpInside)
  
        }
        button.setBackgroundImage(UIImage(named: "viewall"), for: .normal)
        headerView.addSubview(button)
 
        let titleLabel = UILabel(frame: CGRect(x: 32, y: 0, width: 200, height: 44))
        headerView.addSubview(titleLabel)
        titleLabel.textColor = UIColor.white
        titleLabel.font =  UIFont(name: "Muli-SemiBold", size: 17)!
        if tableView == TableV
        {
        titleLabel.text = Mainpodcastedata?.subComedymovList?[section].title
        }else
        {
            titleLabel.text = PodcastData?.podcastList?[section].title
        }
        return headerView
        
    }
    
    @objc func loaddata(_ sender:UIButton)
    {
        let storyBoard : UIStoryboard = UIStoryboard(name: "Main", bundle: nil)
        let VC1 = storyBoard.instantiateViewController(withIdentifier: "PodcastViewAllVC") as! PodcastViewAllVC
        // VC1.Movcategory = Movcategory
        print(Mainpodcastedata?.subComedymovList?[sender.tag].title ?? "")
         VC1.MovSubcategory = Mainpodcastedata?.subComedymovList?[sender.tag].permalink ?? ""
        VC1.selftitle = Mainpodcastedata?.subComedymovList?[sender.tag].title ?? ""
          VC1.isaudioorvide0 = "1"
          VC1.isfrom = "2"
        

         // VC1.podcastcategoryid = PodcastData?.podcastList?[sender.tag].podcastCategoryID ?? ""
          /*
           
             isfrom = "5"
             selftitle = "BigFan Originals"
             muvititle = "Audio"
             isaudioorvide0 = "1"
           */
  
        let navController = UINavigationController(rootViewController: VC1) // Creating a navigation controller with VC1 at the root of the navigation stack.
       navController.navigationBar.barTintColor = Appcolor.backgorund4
       let textAttributes = [NSAttributedString.Key.foregroundColor:UIColor.white,NSAttributedString.Key.font: UIFont(name: "Muli-ExtraBold", size: 19)!]
       navController.navigationBar.titleTextAttributes = textAttributes
         navController.navigationBar.isTranslucent = false
       navController.modalPresentationStyle = .fullScreen
        self.present(navController, animated:true, completion: nil)
        
    }
    
    @objc func loaddata1(_ sender:UIButton)
    {
        let storyBoard : UIStoryboard = UIStoryboard(name: "Main", bundle: nil)
        let VC1 = storyBoard.instantiateViewController(withIdentifier: "PodcastViewAllVC") as! PodcastViewAllVC
        // VC1.Movcategory = Movcategory
        // VC1.MovSubcategory = MovSubcategory
          VC1.selftitle = PodcastData?.podcastList?[sender.tag].title ?? ""
          VC1.isaudioorvide0 = "1"
          VC1.isfrom = "6"

          VC1.podcastcategoryid = PodcastData?.podcastList?[sender.tag].podcastCategoryID ?? ""
          /*
           
             isfrom = "5"
             selftitle = "BigFan Originals"
             muvititle = "Audio"
             isaudioorvide0 = "1"
           */
  
        let navController = UINavigationController(rootViewController: VC1) // Creating a navigation controller with VC1 at the root of the navigation stack.
       navController.navigationBar.barTintColor = Appcolor.backgorund4
       let textAttributes = [NSAttributedString.Key.foregroundColor:UIColor.white,NSAttributedString.Key.font: UIFont(name: "Muli-ExtraBold", size: 19)!]
       navController.navigationBar.titleTextAttributes = textAttributes
         navController.navigationBar.isTranslucent = false
       navController.modalPresentationStyle = .fullScreen
        self.present(navController, animated:true, completion: nil)

        /*
        
        if PodcastData?.podcastList?[sender.tag].type == "Audio"
        {
          let storyBoard : UIStoryboard = UIStoryboard(name: "Main", bundle: nil)
          let VC1 = storyBoard.instantiateViewController(withIdentifier: "PodcastViewAllVC") as! PodcastViewAllVC
          // VC1.Movcategory = Movcategory
          // VC1.MovSubcategory = MovSubcategory
            VC1.selftitle = "BigFan Originals"
            VC1.isfrom = "5"
            VC1.muvititle = "Audio"
            VC1.isaudioorvide0 = "1"
            VC1.podcastcategoryid = PodcastData?.podcastList?[sender.tag].podcastCategoryID ?? ""
            /*
             
               isfrom = "5"
               selftitle = "BigFan Originals"
               muvititle = "Audio"
               isaudioorvide0 = "1"
             */
    
          let navController = UINavigationController(rootViewController: VC1) // Creating a navigation controller with VC1 at the root of the navigation stack.
         navController.navigationBar.barTintColor = Appcolor.backgorund4
         let textAttributes = [NSAttributedString.Key.foregroundColor:UIColor.white,NSAttributedString.Key.font: UIFont(name: "Muli-ExtraBold", size: 19)!]
         navController.navigationBar.titleTextAttributes = textAttributes
           navController.navigationBar.isTranslucent = false
         navController.modalPresentationStyle = .fullScreen
          self.present(navController, animated:true, completion: nil)
        }else
        {
            let storyBoard : UIStoryboard = UIStoryboard(name: "Main", bundle: nil)
            let VC1 = storyBoard.instantiateViewController(withIdentifier: "PodcastViewAllVC") as! PodcastViewAllVC
            // VC1.Movcategory = Movcategory
            // VC1.MovSubcategory = MovSubcategory
              VC1.selftitle =  "Video on demand"
              VC1.isfrom = "5"
              VC1.muvititle = "Video"
             VC1.isaudioorvide0 = "2"
            VC1.podcastcategoryid = PodcastData?.podcastList?[sender.tag].podcastCategoryID ?? ""

              /*
               
                 isfrom = "5"
                 selftitle = "BigFan Originals"
                 muvititle = "Audio"
                 isaudioorvide0 = "1"
               */
      
            let navController = UINavigationController(rootViewController: VC1) // Creating a navigation controller with VC1 at the root of the navigation stack.
           navController.navigationBar.barTintColor = Appcolor.backgorund4
           let textAttributes = [NSAttributedString.Key.foregroundColor:UIColor.white,NSAttributedString.Key.font: UIFont(name: "Muli-ExtraBold", size: 19)!]
           navController.navigationBar.titleTextAttributes = textAttributes
             navController.navigationBar.isTranslucent = false
           navController.modalPresentationStyle = .fullScreen
            self.present(navController, animated:true, completion: nil)
        }
        */
        
    }
    /*
    public func tableView(_ tableView: UITableView, estimatedHeightForRowAt indexPath: IndexPath) -> CGFloat
    {
        return 160
    }
    */
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat
    {
        44
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat
    {
         return 160
    }
    public func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell
    {
        if tableView == TableV
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
     }else
        {
            if let cell = tableView.dequeueReusableCell(withIdentifier: "tableviewcellid", for: indexPath) as? HomepodcastTableViewCell
        {
          if  let rowArray = PodcastData?.podcastList?[indexPath.section].podcast //(newFeaturedList?.subComedymovList?[indexPath.section].contents)!
                
          {
            cell.updateCellWith(row: rowArray, rowindex: indexPath.section)
            cell.cellDelegate = self
            cell.selectionStyle = .none
          }
            return cell
         }
    return UITableViewCell()
        }
    }
    }

extension NewPodcastlistVC:CollectionViewCellDelegate11
{
    func collectionView(collectionviewcell: CollectionViewCell?, index: Int, rowindex: Int, didTappedInTableViewCell: HomepodcastTableViewCell) {
        print("done")
        if let colorsRow = didTappedInTableViewCell.rowWithColors
        {
          //  print(PodcastData?.podcastList?[index].title)
         //   print(PodcastData?.podcastList?[rowindex].title)

            let item = PodcastData?.podcastList?[rowindex]
            print(item?.type)
            if item?.type == "Audio"
            {
                let item = colorsRow[index]
                let storyBoard: UIStoryboard = UIStoryboard(name: "Main", bundle: nil)
                let displayVC = storyBoard.instantiateViewController(withIdentifier: "PodcastListdetails") as! PodcastListdetails
                   displayVC.modalPresentationStyle = .fullScreen
                
                displayVC.podcasturl = item.podcastURL ?? ""
                displayVC.isfrom = "2"
                displayVC.isfromaudiopodcast = "2"
                displayVC.podcasttitle = item.title ?? ""
                displayVC.podcastimage = item.image ?? ""
                    
                self.present(displayVC, animated: true, completion: nil)
            }else if item?.type == "Video"
            {
                
                let item = colorsRow[index]
                
                
                let storyBoard: UIStoryboard = UIStoryboard(name: "Main", bundle: nil)
                let displayVC = storyBoard.instantiateViewController(withIdentifier: "PodcastListdetails") as! PodcastListdetails
                   displayVC.modalPresentationStyle = .fullScreen
               
               if let str = item.podcastURL
               {
                
                if str.contains("www.youtube.com")
                 {
                    print("this is youtube video")
                    let snippet = item.podcastURL

                    
                    if let range = snippet?.range(of: "list=") {
                        let phone = snippet?[range.upperBound...]
                        print(phone) // prints "123.456.7891"
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
                
                let navController = UINavigationController(rootViewController: displayVC) // Creating a navigation controller with VC1 at the root of the navigation stack.
                navController.navigationBar.barTintColor = Appcolor.backgorund3
               navController.modalPresentationStyle = .fullScreen
                 let textAttributes = [NSAttributedString.Key.foregroundColor:UIColor.white,NSAttributedString.Key.font: UIFont(name: "Muli-ExtraBold", size: 19)!]
                 navController.navigationBar.titleTextAttributes = textAttributes
                self.present(navController, animated:true, completion: nil)
               // self.present(displayVC, animated: true)

            }
        }

    }
    
}
extension NewPodcastlistVC: CollectionViewCellDelegate1
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
