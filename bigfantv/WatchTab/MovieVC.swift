//
//  MovieVC.swift
//  bigfantv
//
//  Created by Ganesh on 23/07/20.
//  Copyright © 2020 Ganesh. All rights reserved.
//

import UIKit
import Alamofire
import SwiftyJSON
import SDWebImage
 
import MaterialComponents.MaterialDialogs
import AVKit
class MovieCell:UICollectionViewCell
{
 
    @IBOutlet var btnCounter: UIButton!
    @IBOutlet var ImgSample: UIImageView!
    
    @IBOutlet var LbName: UILabel!
    
    @IBOutlet var LbType: UILabel!
    
    @IBOutlet var LbDuration: UILabel!
}

 
class MovieVC: UIViewController ,UIPopoverPresentationControllerDelegate,MDCalertProtocol {
    
    private var  ComedyMoviedata:newFilteredComedyMovieList?
    private var  Successdata:SuccessResponse?
    private var  passComedyMoviedata:newFilteredSubComedymovieList?
    private var  ThrillerMoviedata:newFilteredComedyMovieList?
    private var  ActionMoviedata:newFilteredComedyMovieList?
    private var  fantasyMoviedata:newFilteredComedyMovieList?
    private var  adventureMoviedata:newFilteredComedyMovieList?
    private var  animationMoviedata:newFilteredComedyMovieList?
    private var  crimeMoviedata:newFilteredComedyMovieList?
    private var  mysteryMoviedata:newFilteredComedyMovieList?
    private var  dramaMoviedata:newFilteredComedyMovieList?
    private var  romanceMoviedata:newFilteredComedyMovieList?
    private var  horrorMoviedata:newFilteredComedyMovieList?
    private var  scifiMoviedata:newFilteredComedyMovieList?
    private var  tollywoodMoviedata:newFilteredComedyMovieList?
    private var  clipsMoviedata:newFilteredComedyMovieList?
    private var  authorizeddata:Authorizescontent?
   
     private var Bannerdata:NewBannerList?
    private let serialDispatchQueue = DispatchQueue(label: "serial-dispatch-queue")
    @IBOutlet var ViScroll: UIView!
     @IBOutlet var Vinew: UIView!
     @IBOutlet var ComedyCollectionV: UICollectionView!
     @IBOutlet var ThrillerCollectionV: UICollectionView!
     @IBOutlet var ActionCollectioV: UICollectionView!
    @IBOutlet var  fantasyCollectioV: UICollectionView!
    @IBOutlet var  adventureCollectioV: UICollectionView!
    @IBOutlet var  animationCollectioV: UICollectionView!
    @IBOutlet var  crimeCollectioV: UICollectionView!
    @IBOutlet var  mysteryCollectioV: UICollectionView!
    @IBOutlet var  dramaCollectioV: UICollectionView!
    @IBOutlet var  romanceCollectioV: UICollectionView!
    @IBOutlet var  horrorCollectioV: UICollectionView!
    @IBOutlet var  scifiCollectioV: UICollectionView!
    @IBOutlet var  tollywoodCollectioV: UICollectionView!
 let manager: Alamofire.SessionManager = {
     let configuration = URLSessionConfiguration.default
      configuration.timeoutIntervalForRequest = TimeInterval(60)
     configuration.timeoutIntervalForResource = TimeInterval(60)
     return  Alamofire.SessionManager(configuration: configuration)
 }()
    let cellIdentifier = "cell"
    var Movcategory = ""
    var MovSubcategory = ""
     
    @IBOutlet var CollectionViewheight: NSLayoutConstraint!
    //Bannervideos
          
            var banerdata = [Dictionary<String,String>]()
          var filterPlayers : [AVPlayer?] = []
          var currentPage: Int = 0
          var filterScrollView : UIScrollView?
          var player: AVPlayer?
          var playerController : AVPlayerViewController?
          var avPlayerLayer : AVPlayerLayer!
    
    var newperma = ""
    var selftitle = ""
    
    
    
      var contenttypeid = "1"
    @IBOutlet var myScrollingView: UIScrollView!
   
    var collectionarray = [UICollectionView]()
    override func viewDidLoad()
    {
        super.viewDidLoad()
        
        //Register collectionviewcell
              collectionarray = [ComedyCollectionV,ThrillerCollectionV,ActionCollectioV,adventureCollectioV,fantasyCollectioV,romanceCollectioV,animationCollectioV,crimeCollectioV,mysteryCollectioV,dramaCollectioV,horrorCollectioV,scifiCollectioV,tollywoodCollectioV]
        
        
        for i in collectionarray
        {
              let flowLayout = UICollectionViewFlowLayout()
              flowLayout.scrollDirection = .horizontal
            let width = (i.frame.size.height * 280)/156
            
           
              flowLayout.itemSize = CGSize(width: width, height: i.frame.size.height)
              flowLayout.minimumLineSpacing = 10
              flowLayout.minimumInteritemSpacing = 10.0
              i.collectionViewLayout = flowLayout
              i.showsHorizontalScrollIndicator = false
            i.delegate = self
            i.dataSource = self
           i.register(UINib(nibName:"MyCell", bundle:nil), forCellWithReuseIdentifier: cellIdentifier)
        }
          if Connectivity.isConnectedToInternet()
        {
            self.Getimagelist()
            self.LoadallData()
         }else
        {
            Utility.Internetconnection(vc: self)
        }
          //Refresh the page
         Utility.configurscollview(scrollV: myScrollingView)
         myScrollingView.refreshControl?.addTarget(self, action: #selector(handleRefreshControl),for: .valueChanged)
    }
    

    
    func setupview()
    {
        Timer.scheduledTimer(withTimeInterval: 0.1, repeats: false) { (t) in
                    if Connectivity.isConnectedToInternet()
                    {
                        
                        self.LoadallData()
                     }else
                    {
                        Utility.Internetconnection(vc: self)
                    }
                }
    }
    @objc func handleRefreshControl()
    {
        myScrollingView.refreshControl?.beginRefreshing()
        setupview()
            DispatchQueue.main.async {
          self.myScrollingView.refreshControl?.endRefreshing()
       }
    }
      
     func Getimagelist()
          {
           //https://bigfantv.funasia.net/service/getBannerList.html
           
            
                     do
                     {
                         
                     /*
                       let feature12 = [  "titleimage":"newlogo","isimage":"1","videourl":"https://d73o4i22vgk5h.cloudfront.net/45921/RawVideo/uploads/videobanner/21/breaking_news_intro_maker_featuring_an_animated_logo_729.mp4"]
                       self.banerdata.append(feature12)
                     */

                        guard let parameters =
                            [
                              "userId":UserDefaults.standard.string(forKey: "id") ?? "",
                               "AccessToken":UserDefaults.standard.string(forKey:"AccessToken") ?? ""
                               
                                ] as? [String:Any] else { return  }
                           
                       
                       let url:URL = URL(string: "https://bigfantv.funasia.net/service/getBannerList.html")!
                            
                            
                            
                            
                           
                       self.manager.request(url, method: .post, parameters:parameters, encoding: JSONEncoding.default, headers: nil).responseJSON { (response) in
                         print("data from common function")
                                switch response.result
                                {

                           
                                case .success(_):
                               
                                    if response.value != nil
                                    {
                                        do
                                        {
                                           let decoder = JSONDecoder()
                                           self.Bannerdata = try decoder.decode(NewBannerList.self, from: response.data  ?? Data())
                                               
                                               for i in self.Bannerdata?.subComedymovList ?? [NewBannerListdeatails]()
                                               {
                                                print(i.bannerURL)
                                                   
                                                   let feature12 = [  "titleimage":"\(i.bannerImage ?? "")","isimage":"1","videourl":"\(i.action ?? "")","actionurl":"\(i.bannerURL ?? "")"]
                                                     self.banerdata.append(feature12)
                                                
                                               
                                            }
                                             self.setupFilterWith(size: self.Vinew!.bounds.size)
                                             }
                                             catch let error
                                             {
                                                 print("error.localizedDescription  \(error.localizedDescription)")
                                             }
                                }
                                break
                            case .failure(let error):
                                print("failure\(error)")
                                break
                            }
                        }
                        
                       
                    
                       
                        
                     }
                     catch let error
                     {
                       //  Utility.showAlert(vc: self, message:"\(error)", titelstring: Appcommon.Appname)
                     }
                 
       
           }
 /*
    func LoadallData()
       {
           Utility.ShowLoader(vc: self)
             
           
                   self.allcommon(collectionv: self.ActionCollectioV, category: "movies", subcategory: "action") { (data) in
                    
                       self.ActionMoviedata = data
                    self.ActionCollectioV.delegate = self
                    self.ActionCollectioV.dataSource = self
                    DispatchQueue.main.async {
                        self.ActionCollectioV.reloadData()
                    }
                       self.allcommon(collectionv: self.adventureCollectioV, category: "movies", subcategory: "adventure")
                       { (data) in
                           self.adventureMoviedata = data
                        self.adventureCollectioV.delegate = self
                        self.adventureCollectioV.dataSource = self
                        DispatchQueue.main.async {
                            self.adventureCollectioV.reloadData()
                        }
                        self.allcommon(collectionv: self.fantasyCollectioV, category: "movies", subcategory: "fantasy")
                        { (data) in
                            self.fantasyMoviedata = data
                            self.fantasyCollectioV.delegate = self
                            self.fantasyCollectioV.dataSource = self
                            DispatchQueue.main.async {
                                self.fantasyCollectioV.reloadData()
                            }
                             
                            self.allcommon(collectionv: self.romanceCollectioV, category: "movies", subcategory: "romance")
                            { (data) in
                                Utility.hideLoader(vc: self)
                                self.romanceMoviedata = data
                                
                                self.allcommon(collectionv: self.horrorCollectioV, category: "movies", subcategory: "horror") { (data) in
                                    self.horrorMoviedata = data
                                    self.allcommon(collectionv: self.mysteryCollectioV, category: "movies", subcategory: "mystery") { (data) in
                                        self.mysteryMoviedata = data
                                        self.allcommon(collectionv: self.scifiCollectioV, category: "movies", subcategory: "sci-fi") { (data) in
                                            self.scifiMoviedata = data
                                            self.allcommon(collectionv: self.ComedyCollectionV, category: "movies", subcategory: "comedy1") { (data) in
                                                self.ComedyMoviedata = data
                                                
                                                self.allcommon(collectionv: self.ThrillerCollectionV, category: "movies", subcategory: "thriller") { (data) in
                                                    self.ThrillerMoviedata = data
                                                    
                                                    
                                                    self.allcommon(collectionv: self.crimeCollectioV, category: "movies", subcategory: "crime") { (data) in
                                                        self.crimeMoviedata = data
                                                        
                                                        
                                                        self.allcommon(collectionv: self.dramaCollectioV, category: "movies", subcategory: "drama") { (data) in
                                                            self.dramaMoviedata = data
                                                        self.allcommon(collectionv: self.animationCollectioV, category: "movies", subcategory: "animation") { (data) in
                                                            self.animationMoviedata = data
                                                            self.allcommon(collectionv: self.tollywoodCollectioV, category: "movies", subcategory: "tollywood") { (data) in
                                                                self.tollywoodMoviedata = data
                                                            }
                                                            
                                                            }
                                                        }
                                                    }
                                                }
                                            }
                                        }
                                    }
                                    
                                }
                            }
                            
                        }
                        
                    }
                       
                       
                   }
               
 
 
           
          
    
       }
    */
    
    
    
      func LoadallData()
             {
                Utility.ShowLoader(vc: self)
                
                
                
              //  let downloadGroup = DispatchGroup()

//                downloadGroup.enter()
//                downloadGroup.enter()
//                downloadGroup.enter()
//                downloadGroup.enter()
//                downloadGroup.enter()
//                downloadGroup.enter()
//                downloadGroup.enter()
//                downloadGroup.enter()
//                downloadGroup.enter()
//                downloadGroup.enter()
//                downloadGroup.enter()
//                downloadGroup.enter()
//                downloadGroup.enter()
               
                                 
               Common.shared.getfeiltereddata(category: "movies", subcategory: "action") { (data, err) -> (Void) in
   
                 
                  self.ActionMoviedata = data
                 
                  DispatchQueue.main.async {
                    
                    print("1")
                      self.ActionCollectioV.reloadData()
                       
                  }
              }
               
                 
                   Common.shared.getfeiltereddata(category: "movies", subcategory: "adventure") { (data, err) -> (Void) in
   
                     
                     self.adventureMoviedata = data
                      
                     DispatchQueue.main.async {
                         print("2")
                         self.adventureCollectioV.reloadData()
                         
                     }
                 }
              
              
               Common.shared.getfeiltereddata(category: "movies", subcategory: "fantasy")
               { (data, err) -> (Void) in
    
                Utility.hideLoader(vc: self )
                 
                  self.fantasyMoviedata = data
                  
                  DispatchQueue.main.async
                  {
                      print("3")
                      self.fantasyCollectioV.reloadData()
                         
                  }
              }
                
                
               
                
                                    
                   Common.shared.getfeiltereddata(category: "movies", subcategory: "romance") { (data, err) -> (Void) in
    
                     
                  self.romanceMoviedata = data
                   Utility.hideLoader(vc: self)
                  DispatchQueue.main.async {
                    
                    
                     print("4")
                      self.romanceCollectioV.reloadData()
                         
                  }
              }
              
                  
                   Common.shared.getfeiltereddata(category: "movies", subcategory: "horror") { (data, err) -> (Void) in
    
                     
                  self.horrorMoviedata = data
                   Utility.hideLoader(vc: self)
                  DispatchQueue.main.async {
                    
                     
                     print("5")
                      self.horrorCollectioV.reloadData()
                         
                  }
              }
              
                 
                   Common.shared.getfeiltereddata(category: "movies", subcategory: "mystery") { (data, err) -> (Void) in
                     
                     self.mysteryMoviedata = data
                      
                     DispatchQueue.main.async {
                       
                         self.mysteryCollectioV.reloadData()
                         
                     }
                 }
             
              
               Common.shared.getfeiltereddata(category: "movies", subcategory: "sci-fi") { (data, err) -> (Void) in
     
                  self.scifiMoviedata = data
                   Utility.hideLoader(vc: self)
                  DispatchQueue.main.async {
                   
                     
                      self.scifiCollectioV.reloadData()
                         
                  }
              }
             
             
               Common.shared.getfeiltereddata(category: "movies", subcategory: "comedy1") { (data, err) -> (Void) in
     
                  self.ComedyMoviedata = data
                  
                  DispatchQueue.main.async {
                   
                      self.ComedyCollectionV.reloadData()
                         
                  }
              }
             
              
                Common.shared.getfeiltereddata(category: "movies", subcategory: "thriller") { (data, err) -> (Void) in
     
                  self.ThrillerMoviedata = data
                  
                    DispatchQueue.main.async {
                        
                      self.ThrillerCollectionV.reloadData()
                         
                  }
              }
               
              
             
               Common.shared.getfeiltereddata(category: "movies", subcategory: "crime") { (data, err) -> (Void) in
                   
                     self.crimeMoviedata = data
                      
                     DispatchQueue.main.async {
                        
                         self.crimeCollectioV.reloadData()
                         
                     }
                 }
              
              
               Common.shared.getfeiltereddata(category: "movies", subcategory: "drama") { (data, err) -> (Void) in
    
                 
                  self.dramaMoviedata = data
                  
                  DispatchQueue.main.async {
                    
                      self.dramaCollectioV.reloadData()
                         
                  }
              }
              
              
              
                Common.shared.getfeiltereddata(category: "movies", subcategory: "animation") { (data, err) -> (Void) in
                   
                  self.animationMoviedata = data
                   
                  DispatchQueue.main.async {
                    
                      self.animationCollectioV.reloadData()
                         
                  }
              }
            
               
                     Common.shared.getfeiltereddata(category: "movies", subcategory: "tollywood") { (data, err) -> (Void) in
                
                        self.tollywoodMoviedata = data
                        
                        DispatchQueue.main.async {
                            
                            self.tollywoodCollectioV.reloadData()
                               
                        }
                    }
                /*
                downloadGroup.notify(queue: .main, execute: {
                  // Step3: Update the UI
                  print("completed")
                })
                  
              */
               
          
             }
    /*
    func LoadallData()
          {
            Utility.ShowLoader(vc: self)
           serialDispatchQueue.async {[weak self] in
                              
            Common.shared.getfeiltereddata(category: "movies", subcategory: "action") { (data, err) -> (Void) in
 
               self.ActionMoviedata = data
               self.ActionCollectioV.delegate = self
               self.ActionCollectioV.dataSource = self
               DispatchQueue.main.async {
                   self.ActionCollectioV.reloadData()
                    
               }
           }
           }
              serialDispatchQueue.async {[weak self] in
                          
                Common.shared.getfeiltereddata(category: "movies", subcategory: "adventure") { (data, err) -> (Void) in
 
                  self.adventureMoviedata = data
                  self.adventureCollectioV.delegate = self
                  self.adventureCollectioV.dataSource = self
                  DispatchQueue.main.async {
                      self.adventureCollectioV.reloadData()
                      
                  }
              }
           }
           serialDispatchQueue.async {[weak self] in
                          
            Common.shared.getfeiltereddata(category: "movies", subcategory: "fantasy") { (data, err) -> (Void) in
 
               self.fantasyMoviedata = data
               self.fantasyCollectioV.delegate = self
               self.fantasyCollectioV.dataSource = self
               DispatchQueue.main.async {
                Utility.hideLoader(vc: self!)
                   self.fantasyCollectioV.reloadData()
                      
               }
           }
           }
              serialDispatchQueue.async {[weak self] in
              
                                 
                Common.shared.getfeiltereddata(category: "movies", subcategory: "romance") { (data, err) -> (Void) in
 
               self.romanceMoviedata = data
               self.romanceCollectioV.delegate = self
               self.romanceCollectioV.dataSource = self
               DispatchQueue.main.async {
                Utility.hideLoader(vc: self!)
                   self.romanceCollectioV.reloadData()
                      
               }
           }
           }
              serialDispatchQueue.async {[weak self] in
                              
                Common.shared.getfeiltereddata(category: "movies", subcategory: "horror") { (data, err) -> (Void) in
 
               self.horrorMoviedata = data
               self.horrorCollectioV.delegate = self
               self.horrorCollectioV.dataSource = self
               DispatchQueue.main.async {
                Utility.hideLoader(vc: self!)
                   self.horrorCollectioV.reloadData()
                      
               }
           }
           }
              serialDispatchQueue.async {[weak self] in
               
                Common.shared.getfeiltereddata(category: "movies", subcategory: "mystery") { (data, err) -> (Void) in
                  self.mysteryMoviedata = data
                  self.mysteryCollectioV.delegate = self
                  self.mysteryCollectioV.dataSource = self
                  DispatchQueue.main.async {
                      self.mysteryCollectioV.reloadData()
                      
                  }
              }
           }
           serialDispatchQueue.async {[weak self] in
                      
            Common.shared.getfeiltereddata(category: "movies", subcategory: "sci-fi") { (data, err) -> (Void) in
 
               self.scifiMoviedata = data
               self.scifiCollectioV.delegate = self
               self.scifiCollectioV.dataSource = self
               DispatchQueue.main.async {
                Utility.hideLoader(vc: self!)
                   self.scifiCollectioV.reloadData()
                      
               }
           }
           }
           serialDispatchQueue.async {[weak self] in
           
            Common.shared.getfeiltereddata(category: "movies", subcategory: "comedy1") { (data, err) -> (Void) in
 
               self.ComedyMoviedata = data
               self.ComedyCollectionV.delegate = self
               self.ComedyCollectionV.dataSource = self
               DispatchQueue.main.async {
                   self.ComedyCollectionV.reloadData()
                      
               }
           }
           }
           
           serialDispatchQueue.async {[weak self] in
            Common.shared.getfeiltereddata(category: "movies", subcategory: "thriller") { (data, err) -> (Void) in
 
               self.ThrillerMoviedata = data
               self.ThrillerCollectionV.delegate = self
               self.ThrillerCollectionV.dataSource = self
               DispatchQueue.main.async {
                   self.ThrillerCollectionV.reloadData()
                      
               }
           }
           }
           
           serialDispatchQueue.async {[weak self] in
            
            Common.shared.getfeiltereddata(category: "movies", subcategory: "crime") { (data, err) -> (Void) in
               
                  self.crimeMoviedata = data
                  self.crimeCollectioV.delegate = self
                  self.crimeCollectioV.dataSource = self
                  DispatchQueue.main.async {
                      self.crimeCollectioV.reloadData()
                      
                  }
              }
           }
           
           serialDispatchQueue.async {[weak self] in
           Common.shared.getfeiltereddata(category: "movies", subcategory: "drama") { (data, err) -> (Void) in
 
               self.dramaMoviedata = data
               self.dramaCollectioV.delegate = self
               self.dramaCollectioV.dataSource = self
               DispatchQueue.main.async {
                   self.dramaCollectioV.reloadData()
                      
               }
           }
           }
           
           
           serialDispatchQueue.async {[weak self] in
           Common.shared.getfeiltereddata(category: "movies", subcategory: "animation") { (data, err) -> (Void) in
      
               self.animationMoviedata = data
               self.animationCollectioV.delegate = self
               self.animationCollectioV.dataSource = self
               DispatchQueue.main.async {
                   self.animationCollectioV.reloadData()
                      
               }
           }
           }
            
                 serialDispatchQueue.async {[weak self] in
                 Common.shared.getfeiltereddata(category: "movies", subcategory: "tollywood") { (data, err) -> (Void) in
            
                     self.tollywoodMoviedata = data
                     self.tollywoodCollectioV.delegate = self
                     self.tollywoodCollectioV.dataSource = self
                     DispatchQueue.main.async {
                         self.tollywoodCollectioV.reloadData()
                            
                     }
                 }
                 }
           
            
       
          }
     */
    
    func allcommon(collectionv:UICollectionView, category:String,subcategory:String,completionBlock: @escaping (newFilteredComedyMovieList) -> Void) -> Void
    {
  
        
 
    }
    override func prepare(for segue: UIStoryboardSegue, sender: Any?)
    {
        if segue.identifier == "viewallmovie"
        {
            guard let navController = segue.destination as? UINavigationController,
                let displayVC = navController.topViewController as? ComedyViewAllVC else { return }
                  
            displayVC.Movcategory = Movcategory
            displayVC.MovSubcategory = MovSubcategory
            displayVC.selftitle = selftitle
            
        }
        }
    @IBAction func ViewAllcomedyBtTapped(_ sender: UIButton) {
        if sender.tag == 1
        {
            Movcategory = "movies"
            MovSubcategory = "comedy1"
            selftitle = "Comedy Movies"
        }else if sender.tag == 2
        {
            Movcategory = "movies"
            MovSubcategory = "Thriller"
             selftitle = "Thriller Movies"
        }else if sender.tag == 3
        {
            Movcategory = "movies"
            MovSubcategory = "Action"
             selftitle = "Action Movies"
        }else if sender.tag == 4
        {
            Movcategory = "movies"
            MovSubcategory = "fantasy"
             selftitle = "Fantasy Movies"
        }else if sender.tag == 5
        {
            Movcategory = "movies"
            MovSubcategory = "adventure"
             selftitle = "Adventure Movies"
        }else if sender.tag == 6
        {
            Movcategory = "movies"
            MovSubcategory = "animation"
             selftitle = "Animation Movies"
        }else if sender.tag == 7
        {
            Movcategory = "movies"
            MovSubcategory = "crime"
             selftitle = "Crime Movies"
        }else if sender.tag == 8
        {
            Movcategory = "movies"
            MovSubcategory = "mystery"
             selftitle = "Mystery Movies"
        }else if sender.tag == 9
        {
            Movcategory = "movies"
            MovSubcategory = "drama"
             selftitle = "Drama Movies"
        }else if sender.tag == 10
        {
            Movcategory = "movies"
            MovSubcategory = "romance"
             selftitle = "Romance Movies"
        }else if sender.tag == 11
        {
            Movcategory = "movies"
            MovSubcategory = "horror"
             selftitle = "Horror Movies"
        }else if sender.tag == 12
        {
            Movcategory = "movies"
            MovSubcategory = "sci-fi"
             selftitle = "Sci-Fi Movies"
        }else if sender.tag == 13
        {
            Movcategory = "movies"
            MovSubcategory = "tollywood"
             selftitle = "Tollywood Movies"
        }else if sender.tag == 14
        {
            Movcategory = "movies"
            MovSubcategory = "clips"
             selftitle = "Clips Movies"
        }
       
       performSegue(withIdentifier: "viewallmovie", sender: self)
    }
    
     
    
}

extension MovieVC:UICollectionViewDelegate,UICollectionViewDataSource
{
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        
        if collectionView == ActionCollectioV
        {
            return ActionMoviedata?.subComedymovList.count ?? 0
        }
        else if collectionView == adventureCollectioV
        {
            return adventureMoviedata?.subComedymovList.count ?? 0
        }
        else if collectionView == fantasyCollectioV
        {
            return fantasyMoviedata?.subComedymovList.count ?? 0
        }
        else if collectionView == romanceCollectioV
        {
           
            return romanceMoviedata?.subComedymovList.count ?? 0
        }
         else if collectionView == ComedyCollectionV
        {
 
            return ComedyMoviedata?.subComedymovList.count ?? 0
        }else if collectionView == ThrillerCollectionV
        {
             
            return ThrillerMoviedata?.subComedymovList.count ?? 0
        }else if collectionView == animationCollectioV
        {
 
            return animationMoviedata?.subComedymovList.count ?? 0
        }else if collectionView == crimeCollectioV
        {
 
            return crimeMoviedata?.subComedymovList.count ?? 0
        }else if collectionView == mysteryCollectioV
        {
 
            return mysteryMoviedata?.subComedymovList.count ?? 0
        }else if collectionView == dramaCollectioV
        {
 
            return dramaMoviedata?.subComedymovList.count ?? 0
        }else if collectionView == horrorCollectioV
        {
 
            return horrorMoviedata?.subComedymovList.count ?? 0
        }else if collectionView == scifiCollectioV
        {
 
            return scifiMoviedata?.subComedymovList.count ?? 0
        }else if collectionView == tollywoodCollectioV
        {
 
            return tollywoodMoviedata?.subComedymovList.count ?? 0
        }
        return 0
    }
    
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell
    {
         
        let Cell   = collectionView.dequeueReusableCell(withReuseIdentifier: cellIdentifier, for: indexPath) as! MyCell

        
        
        switch collectionView
        {
        case self.ActionCollectioV:
       
            Loaddataincell(maincell: Cell, data: ActionMoviedata!, ind: indexPath.row )
             
            
              
           
        case self.adventureCollectioV:
 
                  Loaddataincell(maincell: Cell, data: adventureMoviedata!, ind: indexPath.row )
 
        case self.fantasyCollectioV:
 
                  Loaddataincell(maincell: Cell, data: fantasyMoviedata!, ind: indexPath.row )
 
        case self.romanceCollectioV:
                  Loaddataincell(maincell: Cell, data: romanceMoviedata!, ind: indexPath.row )
 
        case self.horrorCollectioV:
 
                  Loaddataincell(maincell: Cell, data: horrorMoviedata!, ind: indexPath.row )
 
        case self.mysteryCollectioV:
 
                  Loaddataincell(maincell: Cell, data: mysteryMoviedata!, ind: indexPath.row )
 
        case self.scifiCollectioV:
 
                  Loaddataincell(maincell: Cell, data: scifiMoviedata!, ind: indexPath.row )
 
       
        case self.ComedyCollectionV:
             
                  Loaddataincell(maincell: Cell, data: ComedyMoviedata!, ind: indexPath.row )
       
        case self.ThrillerCollectionV:
 
                  Loaddataincell(maincell: Cell, data: ThrillerMoviedata!, ind: indexPath.row )
 
        case self.crimeCollectioV:
 
 
                  Loaddataincell(maincell: Cell, data: crimeMoviedata!, ind: indexPath.row )
 
        case self.dramaCollectioV:
     
             
                  Loaddataincell(maincell: Cell, data: dramaMoviedata!, ind: indexPath.row )
 
           
        case self.animationCollectioV:
      
            Loaddataincell(maincell: Cell, data: animationMoviedata!, ind: indexPath.row )
 
        case self.tollywoodCollectioV:
      
                  Loaddataincell(maincell: Cell, data: tollywoodMoviedata!, ind: indexPath.row )
           
       
        default:
           print("")
        }
        return Cell

    }
     
    func Loaddataincell(maincell:MyCell,data:newFilteredComedyMovieList,ind:Int )
    {
        let item = data.subComedymovList[ind]
 
  
         maincell.ImgSample.sd_setImage(with: URL(string:item.poster ?? ""), completed: nil)
 
        
       
          maincell.LbName.text = item.title ?? ""
         let image = item.is_fav_status == 1 ? UIImage(named: "liked") : UIImage(named: "like")
         maincell.btnCounter.setBackgroundImage(image, for: .normal)
        
        maincell.actionBlock = {
            () in
            if item.is_fav_status == 0
            {
                maincell.btnCounter.setBackgroundImage(UIImage(named: "liked"), for: .normal)
                self.AddtoFav(movieuniqidx: item.movie_uniq_id ?? "", endpoint: ApiEndPoints.AddToFavlist) { (true) in
                maincell.btnCounter.setBackgroundImage(UIImage(named: "liked"), for: .normal)
                    
                    data.subComedymovList[ind].is_fav_status = 1
                   
            }
            }else if item.is_fav_status == 1
            {
                maincell.btnCounter.setBackgroundImage(UIImage(named: "like"), for: .normal)
                self.AddtoFav(movieuniqidx: item.movie_uniq_id ?? "", endpoint: ApiEndPoints.DeleteFavLIst) { (true) in
                maincell.btnCounter.setBackgroundImage(UIImage(named: "like"), for: .normal)
                    data.subComedymovList[ind].is_fav_status = 0
                 
            }
            }
           
        }
         
    }
    
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath)
    {
        switch collectionView {
             
        case self.ActionCollectioV:
            
             if let data = ActionMoviedata?.subComedymovList[indexPath.row]
             {
                Movcategory = "movies"
                MovSubcategory = "action"
                passComedyMoviedata = data
                getcontentauthorised(movieid: data.movie_uniq_id ?? "")
            }
        case self.adventureCollectioV:
            if let data = adventureMoviedata?.subComedymovList[indexPath.row]
            {
                Movcategory = "movies"
                MovSubcategory = "adventure"
                passComedyMoviedata = data
                getcontentauthorised(movieid: data.movie_uniq_id ?? "")
            }
         case self.fantasyCollectioV:
             
            if let data = fantasyMoviedata?.subComedymovList[indexPath.row]
               {
                Movcategory = "movies"
                MovSubcategory = "fantasy"
                passComedyMoviedata = data
                getcontentauthorised(movieid: data.movie_uniq_id ?? "")
               }
        case self.romanceCollectioV:
            if let data = romanceMoviedata?.subComedymovList[indexPath.row]
               {
                Movcategory = "movies"
                MovSubcategory = "romance"
                passComedyMoviedata = data
                getcontentauthorised(movieid: data.movie_uniq_id ?? "")
               }
        case self.horrorCollectioV:
            if let data = horrorMoviedata?.subComedymovList[indexPath.row]
               {
                Movcategory = "movies"
                MovSubcategory = "horror"
                passComedyMoviedata = data
                getcontentauthorised(movieid: data.movie_uniq_id ?? "")
               }
        case self.mysteryCollectioV:
            if let data = mysteryMoviedata?.subComedymovList[indexPath.row]
               {
                Movcategory = "movies"
                MovSubcategory = "mystery"
                passComedyMoviedata = data
                getcontentauthorised(movieid: data.movie_uniq_id ?? "")
               }
        case self.scifiCollectioV:
            if let data = scifiMoviedata?.subComedymovList[indexPath.row]
               {
                Movcategory = "movies"
                MovSubcategory = "sci-fi"
                passComedyMoviedata = data
                getcontentauthorised(movieid: data.movie_uniq_id ?? "")
               }
        case self.ComedyCollectionV:
            if let data = ComedyMoviedata?.subComedymovList[indexPath.row]
               {
                Movcategory = "movies"
                MovSubcategory = "comedy1"
                passComedyMoviedata = data
                getcontentauthorised(movieid: data.movie_uniq_id ?? "")
               }
        case self.ThrillerCollectionV:
            if let data = ThrillerMoviedata?.subComedymovList[indexPath.row]
               {
                Movcategory = "movies"
                MovSubcategory = "thriller"
                passComedyMoviedata = data
                getcontentauthorised(movieid: data.movie_uniq_id ?? "")
               }
        case self.crimeCollectioV:
            if let data = crimeMoviedata?.subComedymovList[indexPath.row]
               {
                Movcategory = "movies"
                MovSubcategory = "crime"
                passComedyMoviedata = data
                getcontentauthorised(movieid: data.movie_uniq_id ?? "")
               }
        case self.dramaCollectioV:
            if let data = dramaMoviedata?.subComedymovList[indexPath.row]
               {
                Movcategory = "movies"
                MovSubcategory = "drama"
                passComedyMoviedata = data
                getcontentauthorised(movieid: data.movie_uniq_id ?? "")
               }
        case self.animationCollectioV:
            if let data = animationMoviedata?.subComedymovList[indexPath.row]
            {
                Movcategory = "movies"
                MovSubcategory = "animation"
                passComedyMoviedata = data
                getcontentauthorised(movieid: data.movie_uniq_id ?? "")
             }
        case self.tollywoodCollectioV:
            if let data = tollywoodMoviedata?.subComedymovList[indexPath.row]
            {
                Movcategory = "movies"
                MovSubcategory = "tollywood"
                passComedyMoviedata = data
                getcontentauthorised(movieid: data.movie_uniq_id ?? "")
            }
        
        default:
        print("default")
    }
    }
    
    func getcontentauthorised(movieid:String)
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
        
//        Api.IsContentAuthorised(movieid, endpoint: ApiEndPoints.isContentAuthorized, vc: self) { (res, err) -> (Void) in
//
//            do
//            {
//                let decoder = JSONDecoder()
//                self.authorizeddata = try decoder.decode(Authorizescontent.self, from: res  ?? Data())
//
//                if self.authorizeddata?.status == "OK"
//                {
//
//                let storyBoard: UIStoryboard = UIStoryboard(name: "Main", bundle: nil)
//                let displayVC = storyBoard.instantiateViewController(withIdentifier: "MoviesDetailsVC") as! MoviesDetailsVC
//                   displayVC.modalPresentationStyle = .fullScreen
//                    if let item = self.passComedyMoviedata
//                    {
//                        displayVC.imagename = item.poster ?? ""
//                        displayVC.moviename = item.title ?? ""
//                        displayVC.imdbID = item.custom?.customimdb?.field_value ?? ""
//                        displayVC.perma = item.c_permalink ?? ""
//                        displayVC.Movcategory = self.Movcategory
//                        displayVC.MovSubcategory = self.MovSubcategory
//                        displayVC.movieuniqid = item.movie_uniq_id ?? ""
//                        displayVC.Isfavourite = item.is_fav_status ?? 0
//                        displayVC.WatchDuration = item.watch_duration_in_seconds ?? 0
//                        displayVC.contenttypeid = item.content_types_id ?? ""
//                        displayVC.playerurlstr = item.permalink ?? ""
//                    }
//                    self.present(displayVC, animated: true, completion: nil)
//
//                }
//                else
//                {
//                    let alertController = MDCAlertController(title: "BigFan TV", message:  "Subscribe to a plan to view this content")
//                    let action = MDCAlertAction(title:"OK")
//                    { (action) in
//                        let storyBoard: UIStoryboard = UIStoryboard(name: "Main", bundle: nil)
//                        let VC1 = storyBoard.instantiateViewController(withIdentifier: "MyplansVC") as! MyplansVC
//                        let navController = UINavigationController(rootViewController: VC1) // Creating a navigation controller with VC1 at the root of the navigation stack.
//                          navController.navigationBar.barTintColor = Appcolor.backgorund3
//                          navController.navigationBar.isTranslucent = false
//                          navController.modalPresentationStyle = .fullScreen
//                        self.present(navController, animated:true, completion: nil)
//
//                    }
//                    let cancelaction = MDCAlertAction(title:"Cancel")
//                    { (cancelaction) in  }
//                    alertController.addAction(action)
//                    alertController.addAction(cancelaction)
//                    self.present(alertController, animated: true, completion: nil)
//
//                }
//
//            }
//            catch let error
//            {
//              //  Utility.showAlert(vc: self, message:"\(error)", titelstring: Appcommon.Appname)
//             }
//
//        }
    }
    
    func AddtoFav(movieuniqidx:String,endpoint:String, completionBlock: @escaping (Bool) -> Void) -> Void
    {
        Api.Addtofav(movie_uniq_id: movieuniqidx, endpoint: endpoint, vc: self) { (res, err) -> (Void) in
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
 
