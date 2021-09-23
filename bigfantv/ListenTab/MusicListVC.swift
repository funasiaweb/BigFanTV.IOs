//
//  MusicListVC.swift
//  bigfantv
//
//  Created by Ganesh on 30/07/20.
//  Copyright © 2020 Ganesh. All rights reserved.
//

import UIKit
import MaterialComponents.MaterialDialogs
import MuviAudioPlayer
class MusicListVC: UIViewController
{

        private var ComedyMoviedata:newFilteredComedyMovieList?
        private var passComedyMoviedata:newFilteredComedyMovieList?
        private var ThrillerMoviedata:newFilteredComedyMovieList?
        private var ActionMoviedata:newFilteredComedyMovieList?
          
        @IBOutlet var ComedyCollectionV: UICollectionView!
        
        @IBOutlet var ThrillerCollectionV: UICollectionView!
        
        @IBOutlet var ActionCollectioV: UICollectionView!
          @IBOutlet var   BollywoodJukeboxCollectionV: UICollectionView!
          @IBOutlet var   HollywoodJukeboxCollectionV: UICollectionView!
          @IBOutlet var   InstrumentalSongsCollectionV: UICollectionView!
          @IBOutlet var   SpiritualSongsCollectionV: UICollectionView!
          @IBOutlet var   PatrioticSongsCollectionV: UICollectionView!
    @IBOutlet var   GazalCollectionV: UICollectionView!
    @IBOutlet var   GoldenmemoriesCollectionV: UICollectionView!
    @IBOutlet var   NinitieshitsCollectionV: UICollectionView!
    @IBOutlet var   TraditionalfolksCollectionV: UICollectionView!
    @IBOutlet var   MtvunpluggedCollectionV: UICollectionView!
    
    var playerurlstr = ""
    @IBOutlet var myScrollingView: UIScrollView!
        private var BollywoodJukeboxdata:newFilteredComedyMovieList?
        private var HollywoodJukeboxdata:newFilteredComedyMovieList?
        private var InstrumentalSongsdata:newFilteredComedyMovieList?
        private var SpiritualSongsdata:newFilteredComedyMovieList?
        private var PatrioticSongsdata:newFilteredComedyMovieList?
    private var Gazaldata:newFilteredComedyMovieList?
    private var Goldenmemoriesdata:newFilteredComedyMovieList?
    private var Ninitieshitsdata:newFilteredComedyMovieList?
    private var Traditionalfolksdata:newFilteredComedyMovieList?
    private var Mtvunpluggeddata:newFilteredComedyMovieList?
    
    
    private var authorizeddata:Authorizescontent?
    var contentdata:contentdetails?
    var PPVdata:PPVplans?
        private var Successdata:SuccessResponse?
       private let serialDispatchQueue = DispatchQueue(label: "serial-dispatch-queue")
    static var isfrom = 0
        
        static var toviewall = 0
           var imagename = ""
           var moviename = ""
           var movietype = ""
           var timereleasedate  = ""
           var language = ""
           var permalink = ""
           var movdescription: String = ""
           var totalcount = 0
           let cellIdentifier = "cell"
           var Movcategory = ""
           var MovSubcategory = ""
    var selftitle  = ""
    var songtitle = ""
    // private var authorizeddata:Authorizescontent?
        var collectionarray =  [UICollectionView]()
    
    var muviPlayer = MuviAudioMiniView()
   var manager = MuviAudioPlayerManager()
        override func viewDidLoad() {
               super.viewDidLoad()

            
            
            collectionarray = [ComedyCollectionV,ActionCollectioV, ThrillerCollectionV,BollywoodJukeboxCollectionV,HollywoodJukeboxCollectionV,PatrioticSongsCollectionV,InstrumentalSongsCollectionV,SpiritualSongsCollectionV,GazalCollectionV,GoldenmemoriesCollectionV,NinitieshitsCollectionV,MtvunpluggedCollectionV,TraditionalfolksCollectionV ]
            
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
               i.register(UINib(nibName:"MusicCell", bundle:nil), forCellWithReuseIdentifier: cellIdentifier)
            }
           
                    Timer.scheduledTimer(withTimeInterval: 0.01, repeats: false) { (t) in
                        if Connectivity.isConnectedToInternet()
                        {
                           self.LoadallData()
                        }else
                        {
                            Utility.Internetconnection(vc: self)
                        }
                    }
                     
            configureRefreshControl()
            
        }
    
    override func viewWillAppear(_ animated: Bool)
    {
         MuviAudioPlayerManager.shared.playbackDelegate = self
    }
 
    func configureRefreshControl ()
    {
        // Add the refresh control to your UIScrollView object.
                
        Utility.configurscollview(scrollV: myScrollingView)
        myScrollingView.refreshControl?.addTarget(self, action:
                                                        #selector(handleRefreshControl),
                                                        for: .valueChanged)
     }
               
    @objc func handleRefreshControl()
    {
        // Update your content…
        
        myScrollingView.refreshControl?.beginRefreshing()
                               
      if Connectivity.isConnectedToInternet()
      {
        LoadallData()
      }else
      {
          Utility.Internetconnection(vc: self)
      }
          DispatchQueue.main.async {
        self.myScrollingView.refreshControl?.endRefreshing()
     }
        
    }
                   
 
                 
    func LoadallData()
    {
        Utility.ShowLoader(vc: self)
        
           
                    
             Common.shared.getfeiltereddata(category: "cover-songs", subcategory: "") { (data, err) -> (Void) in
          
                   self.ThrillerMoviedata = data
 
                 DispatchQueue.main.async
                     {
                           self.ThrillerCollectionV.reloadData()
                     }
               }
         
                   
          
                      
            Common.shared.getfeiltereddata(category: "originals-songs", subcategory: "") { (data, err) -> (Void) in
                     
                  self.ComedyMoviedata = data
 
                          
                DispatchQueue.main.async
                    {
                          self.ComedyCollectionV.reloadData()
                    }
              }
            
        

           
                    
             Common.shared.getfeiltereddata(category:"cover-songs", subcategory: "mashup") { (data, err) -> (Void) in
          
                   self.ActionMoviedata = data
 
                 DispatchQueue.main.async
                     {
                        Utility.hideLoader(vc:   self)
                           self.ActionCollectioV.reloadData()
                     }
               }
         
          
             Common.shared.getfeiltereddata(category:"cover-songs", subcategory: "ghazal") { (data, err) -> (Void) in
          
                   self.Gazaldata = data
 
                 DispatchQueue.main.async
                     {
                        Utility.hideLoader(vc:   self)
                           self.GazalCollectionV.reloadData()
                     }
               }
         
          
                    
             Common.shared.getfeiltereddata(category:"cover-songs", subcategory: "golden-memories") { (data, err) -> (Void) in
          
                   self.Goldenmemoriesdata = data
 
                 DispatchQueue.main.async
                     {
                        Utility.hideLoader(vc:   self)
                           self.GoldenmemoriesCollectionV.reloadData()
                     }
               }
         
          
                    
             Common.shared.getfeiltereddata(category:"cover-songs", subcategory: "90s-hits") { (data, err) -> (Void) in
          
                   self.Ninitieshitsdata = data
 
                 DispatchQueue.main.async
                     {
                        Utility.hideLoader(vc:   self)
                           self.NinitieshitsCollectionV.reloadData()
                     }
               }
         
          
                    
             Common.shared.getfeiltereddata(category:"cover-songs", subcategory:  "traditional-folks") { (data, err) -> (Void) in
          
                   self.Traditionalfolksdata = data
 
                 DispatchQueue.main.async
                     {
                        Utility.hideLoader(vc:   self)
                           self.TraditionalfolksCollectionV.reloadData()
                     }
               }
         
          
                    
             Common.shared.getfeiltereddata(category:"cover-songs", subcategory: "mtv-unplugged") { (data, err) -> (Void) in
          
                   self.Mtvunpluggeddata = data
 
                 DispatchQueue.main.async
                     {
                        Utility.hideLoader(vc:   self)
                           self.MtvunpluggedCollectionV.reloadData()
                     }
               }
        
        
        
        
        
        
        
        
        
        
        
        
        
           
                    
             Common.shared.getfeiltereddata(category:"cover-songs", subcategory: "spiritual") { (data, err) -> (Void) in
          
                   self.SpiritualSongsdata = data
 
                 DispatchQueue.main.async
                     {
                         
                           self.SpiritualSongsCollectionV.reloadData()
                     }
               }
            
         
        

           
                    
             Common.shared.getfeiltereddata(category:"cover-songs", subcategory: "patriotic") { (data, err) -> (Void) in
          
                   self.PatrioticSongsdata = data
 
                 DispatchQueue.main.async
                     {
                         
                           self.PatrioticSongsCollectionV.reloadData()
                     }
               }
         
           
                    
             Common.shared.getfeiltereddata(category:"cover-songs", subcategory: "instrumental") { (data, err) -> (Void) in
          
                   self.InstrumentalSongsdata = data
 
                 DispatchQueue.main.async
                     {
                        Utility.hideLoader(vc:   self)
                           self.InstrumentalSongsCollectionV.reloadData()
                     }
               }
         

        
           /*
                    
             Common.shared.getfeiltereddata(category: "music-jukebox", subcategory: "bollywood") { (data, err) -> (Void) in
          
                   self.BollywoodJukeboxdata = data
 
                 DispatchQueue.main.async
                     {
                           self.BollywoodJukeboxCollectionV.reloadData()
                     }
               }
        
           
                    
             Common.shared.getfeiltereddata(category:"music-jukebox", subcategory: "hollywood1") { (data, err) -> (Void) in
          
                   self.HollywoodJukeboxdata = data
 
                 DispatchQueue.main.async
                     {
                        Utility.hideLoader(vc:   self)
                           self.HollywoodJukeboxCollectionV.reloadData()
                     }
               }
         
*/
         
 
                    
  
    }

      
        
        override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
            
            
                       if segue.identifier == "tomusic"
                       {
                        guard let navController = segue.destination as? UINavigationController,
                            let displayVC = navController.topViewController as? SongsDetailsVC else {
                                return
                        }
                         
                                displayVC.permalink = permalink
                                
                                //displayVC.ComedyMoviedata = ComedyMoviedata
                                //displayVC.ThrillerMoviedata = ThrillerMoviedata
                               // displayVC.ActionMoviedata = ActionMoviedata
                                     
                       }else if segue.identifier == "toviewall"
                       {
                      guard let navController = segue.destination as? UINavigationController,
                                           let displayVC = navController.topViewController as? MusicViewAllVC else {
                                               return
                                       }
                             
                              displayVC.Movcategory = Movcategory
                              displayVC.MovSubcategory = MovSubcategory
                             displayVC.selftitle = selftitle
                             //  displayVC.ActionMoviedata = ActionMoviedata
                        
                        
                        
                        
                        
                       }
            
          
            }
        
    
        @IBAction func ViewAllcomedyBtTapped(_ sender: UIButton) {
              if sender.tag == 1
              {
                  Movcategory = "originals-songs"
                  MovSubcategory = ""
                selftitle = "Originals-songs"
              }else if sender.tag == 2
              {
                  Movcategory = "cover-songs"
                  MovSubcategory = ""
                selftitle = "Cover-songs"
              }else if sender.tag == 3
              {
                  Movcategory =  "cover-songs"
                  MovSubcategory = "mashup"
                selftitle = "Mashup songs"
              }else if sender.tag == 4
              {
                  Movcategory = "music-jukebox"
                  MovSubcategory = "bollywood"
                selftitle =  "Bollywood songs"
              }else if sender.tag == 5
              {
                  Movcategory = "music-jukebox"
                  MovSubcategory = "hollywood1"
                selftitle = "Hollywood songs"
              }else if sender.tag == 6
              {
                  Movcategory = "cover-songs"
                  MovSubcategory = "instrumental"
                selftitle = "Instrumental songs"
              }else if sender.tag == 7
              {
                  Movcategory = "cover-songs"
                  MovSubcategory = "spiritual"
                selftitle = "Spiritual songs"
              }else if sender.tag == 8
              {
                  Movcategory = "cover-songs"
                  MovSubcategory = "patriotic"
                selftitle = "Patriotic songs"
              }else if sender.tag == 9
              {
                  Movcategory = "cover-songs"
                  MovSubcategory = "ghazal"
                selftitle = "Ghazals"
              }else if sender.tag == 10
              {
                  Movcategory = "cover-songs"
                  MovSubcategory = "golden-memories"
                selftitle = "Golden-memories"
              }else if sender.tag == 11
              {
                  Movcategory = "cover-songs"
                  MovSubcategory = "90s-hits"
                selftitle = "90s-hits"
              }else if sender.tag == 12
              {
                  Movcategory = "cover-songs"
                  MovSubcategory = "traditional-folks"
                selftitle = "Traditional-Folks"
              }else if sender.tag == 13
              {
                  Movcategory = "cover-songs"
                  MovSubcategory = "mtv-unplugged"
                selftitle = "Mtv-Unplugged"
              }
             performSegue(withIdentifier: "toviewall", sender: self)
          }
        
    }

    extension MusicListVC:UICollectionViewDelegate,UICollectionViewDataSource
    {
        func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
            
            if collectionView == ComedyCollectionV
            {
 
                return ComedyMoviedata?.subComedymovList.count ?? 0
            }else if collectionView == ThrillerCollectionV
            {
 
                return ThrillerMoviedata?.subComedymovList.count ?? 0
            }else if collectionView == ActionCollectioV
            {
 
                return ActionMoviedata?.subComedymovList.count ?? 0
            }else if collectionView == BollywoodJukeboxCollectionV
           {
 
               return BollywoodJukeboxdata?.subComedymovList.count ?? 0
           }else if collectionView == HollywoodJukeboxCollectionV
           {
 
               return HollywoodJukeboxdata?.subComedymovList.count ?? 0
           }else if collectionView == InstrumentalSongsCollectionV
           {
 
               return InstrumentalSongsdata?.subComedymovList.count ?? 0
           }else if collectionView == SpiritualSongsCollectionV
          {
 
              return SpiritualSongsdata?.subComedymovList.count ?? 0
          }else if collectionView == PatrioticSongsCollectionV
          {
 
              return PatrioticSongsdata?.subComedymovList.count ?? 0
          }else if collectionView == GazalCollectionV
           {
 
               return Gazaldata?.subComedymovList.count ?? 0
           }else if collectionView == GoldenmemoriesCollectionV
           {
 
               return Goldenmemoriesdata?.subComedymovList.count ?? 0
           }else if collectionView == NinitieshitsCollectionV
           {
 
               return Ninitieshitsdata?.subComedymovList.count ?? 0
           }else if collectionView == TraditionalfolksCollectionV
          {
   
              return Traditionalfolksdata?.subComedymovList.count ?? 0
          }else if collectionView == MtvunpluggedCollectionV
          {
 
              return Mtvunpluggeddata?.subComedymovList.count ?? 0
          }
            return 0
        }
        
        func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
            var Cell   = collectionView.dequeueReusableCell(withReuseIdentifier: cellIdentifier, for: indexPath) as! MusicCell
 
                   
            switch collectionView
            {
            case self.ComedyCollectionV:
                        let maincell = collectionView.dequeueReusableCell(withReuseIdentifier: cellIdentifier, for: indexPath) as! MusicCell
                     
                       if let data = ComedyMoviedata
                       {
                           Loaddataincell(maincell: maincell, data: data, ind: indexPath.row, tag: "ActionCollectioV")
                       }
                       
                       Cell = maincell
                        
                   case self.ThrillerCollectionV:
                           
                           let maincell = collectionView.dequeueReusableCell(withReuseIdentifier: cellIdentifier, for: indexPath) as! MusicCell
                         
                           if let data = ThrillerMoviedata
                           {
                               Loaddataincell(maincell: maincell, data: data, ind: indexPath.row, tag: "ActionCollectioV")
                           }
                           
                           Cell = maincell
                            
                   case self.ActionCollectioV:
                               
                       let maincell = collectionView.dequeueReusableCell(withReuseIdentifier: cellIdentifier, for: indexPath) as! MusicCell
                              
                       if let data = ActionMoviedata
                       {
                           Loaddataincell(maincell: maincell, data: data, ind: indexPath.row, tag: "ActionCollectioV")
                       }
                       Cell = maincell
                   
                   case self.BollywoodJukeboxCollectionV:
                                    
                       let maincell = collectionView.dequeueReusableCell(withReuseIdentifier: cellIdentifier, for: indexPath) as! MusicCell
                                  
                       if let data = BollywoodJukeboxdata
                       {
                           Loaddataincell(maincell: maincell, data: data, ind: indexPath.row, tag: "ActionCollectioV")
                       }
                       
                       Cell = maincell
                    case self.HollywoodJukeboxCollectionV:
                        
                        let maincell = collectionView.dequeueReusableCell(withReuseIdentifier: cellIdentifier, for: indexPath) as! MusicCell
                      
                        if let data = HollywoodJukeboxdata
                        {
                            Loaddataincell(maincell: maincell, data: data, ind: indexPath.row, tag: "ActionCollectioV")
                        }
                        
                        Cell = maincell
                         
                    case self.InstrumentalSongsCollectionV:
                            
                            let maincell = collectionView.dequeueReusableCell(withReuseIdentifier: cellIdentifier, for: indexPath) as! MusicCell
                          
                            if let data = InstrumentalSongsdata
                            {
                                Loaddataincell(maincell: maincell, data: data, ind: indexPath.row, tag: "ActionCollectioV")
                            }
                            
                            Cell = maincell
                             
                    case self.SpiritualSongsCollectionV:
                                
                        let maincell = collectionView.dequeueReusableCell(withReuseIdentifier: cellIdentifier, for: indexPath) as! MusicCell
                               
                        if let data = SpiritualSongsdata
                        {
                            Loaddataincell(maincell: maincell, data: data, ind: indexPath.row, tag: "ActionCollectioV")
                        }
                        Cell = maincell
                        case self.PatrioticSongsCollectionV:
                                    
                            let maincell = collectionView.dequeueReusableCell(withReuseIdentifier: cellIdentifier, for: indexPath) as! MusicCell
                                   
                            if let data = PatrioticSongsdata
                            {
                                Loaddataincell(maincell: maincell, data: data, ind: indexPath.row, tag: "ActionCollectioV")
                            }
                            Cell = maincell
                
                case self.GazalCollectionV:
                                 
                    let maincell = collectionView.dequeueReusableCell(withReuseIdentifier: cellIdentifier, for: indexPath) as! MusicCell
                               
                    if let data = Gazaldata
                    {
                        Loaddataincell(maincell: maincell, data: data, ind: indexPath.row, tag: "ActionCollectioV")
                    }
                    
                    Cell = maincell
                 case self.GoldenmemoriesCollectionV:
                     
                     let maincell = collectionView.dequeueReusableCell(withReuseIdentifier: cellIdentifier, for: indexPath) as! MusicCell
                   
                     if let data = Goldenmemoriesdata
                     {
                         Loaddataincell(maincell: maincell, data: data, ind: indexPath.row, tag: "ActionCollectioV")
                     }
                     
                     Cell = maincell
                      
                 case self.NinitieshitsCollectionV:
                         
                         let maincell = collectionView.dequeueReusableCell(withReuseIdentifier: cellIdentifier, for: indexPath) as! MusicCell
                       
                         if let data = Ninitieshitsdata
                         {
                             Loaddataincell(maincell: maincell, data: data, ind: indexPath.row, tag: "ActionCollectioV")
                         }
                         
                         Cell = maincell
                          
                 case self.TraditionalfolksCollectionV:
                             
                     let maincell = collectionView.dequeueReusableCell(withReuseIdentifier: cellIdentifier, for: indexPath) as! MusicCell
                            
                     if let data = Traditionalfolksdata
                     {
                         Loaddataincell(maincell: maincell, data: data, ind: indexPath.row, tag: "ActionCollectioV")
                     }
                     Cell = maincell
                     case self.MtvunpluggedCollectionV:
                                 
                         let maincell = collectionView.dequeueReusableCell(withReuseIdentifier: cellIdentifier, for: indexPath) as! MusicCell
                                
                         if let data = Mtvunpluggeddata
                         {
                             Loaddataincell(maincell: maincell, data: data, ind: indexPath.row, tag: "ActionCollectioV")
                         }
                         Cell = maincell
                    
                   default :
                    print("")
            }
             return Cell
          
        }
            
            
            func Loaddataincell(maincell:MusicCell,data:newFilteredComedyMovieList,ind:Int,tag:String)
            {
                let item = data.subComedymovList[ind]
                DispatchQueue.main.async {
                    
                maincell.ImgSample.sd_setImage(with: URL(string: item.poster ?? ""), completed: nil)
                }
                print("title === > \(item.title)")
                maincell.LbName.text = item.title ?? ""
                if UserDefaults.standard.bool(forKey: "isLoggedin") == true
                {
                    maincell.btnCounter.isHidden = false
                }else
                {
                    maincell.btnCounter.isHidden = true
                }
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
        
        func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
            
            if collectionView == ComedyCollectionV
            {
              
                imagename = ComedyMoviedata?.subComedymovList[indexPath.row].poster ?? ""
                moviename = ComedyMoviedata?.subComedymovList[indexPath.row].title ?? ""
                movietype = ComedyMoviedata?.subComedymovList[indexPath.row].poster ?? ""
                permalink =  ComedyMoviedata?.subComedymovList[indexPath.row].c_permalink ?? ""
             
                let item = ComedyMoviedata?.subComedymovList[indexPath.row]
              self.getcontentauthorized(movieid: item?.movie_uniq_id ?? "", planurls: item?.permalink ?? "", index: indexPath.row, permad: item?.c_permalink ?? "")
            }else if collectionView == ThrillerCollectionV
            {
                 imagename = ThrillerMoviedata?.subComedymovList[indexPath.row].poster ?? ""
                 moviename = ThrillerMoviedata?.subComedymovList[indexPath.row].title ?? ""
                 movietype = ThrillerMoviedata?.subComedymovList[indexPath.row].poster ?? ""
                 permalink =  ThrillerMoviedata?.subComedymovList[indexPath.row].c_permalink ?? ""
                let item = ThrillerMoviedata?.subComedymovList[indexPath.row]
              self.getcontentauthorized(movieid: item?.movie_uniq_id ?? "", planurls: item?.permalink ?? "", index: indexPath.row, permad: item?.c_permalink ?? "")
             }else if collectionView == ActionCollectioV
            {
               imagename = ActionMoviedata?.subComedymovList[indexPath.row].poster ?? ""
                moviename = ActionMoviedata?.subComedymovList[indexPath.row].title ?? ""
                movietype = ActionMoviedata?.subComedymovList[indexPath.row].poster ?? ""
                 permalink =  ActionMoviedata?.subComedymovList[indexPath.row].c_permalink ?? ""
                 
                let item = ActionMoviedata?.subComedymovList[indexPath.row]
              self.getcontentauthorized(movieid: item?.movie_uniq_id ?? "", planurls: item?.permalink ?? "", index: indexPath.row, permad: item?.c_permalink ?? "")
            }else if collectionView == BollywoodJukeboxCollectionV
             {
                 imagename = BollywoodJukeboxdata?.subComedymovList[indexPath.row].poster ?? ""
                moviename = BollywoodJukeboxdata?.subComedymovList[indexPath.row].title ?? ""
                movietype = BollywoodJukeboxdata?.subComedymovList[indexPath.row].poster ?? ""
                permalink =  BollywoodJukeboxdata?.subComedymovList[indexPath.row].c_permalink ?? ""
                let item = BollywoodJukeboxdata?.subComedymovList[indexPath.row]
              self.getcontentauthorized(movieid: item?.movie_uniq_id ?? "", planurls: item?.permalink ?? "", index: indexPath.row, permad: item?.c_permalink ?? "")
                
            }else if collectionView == HollywoodJukeboxCollectionV
             {
                imagename = HollywoodJukeboxdata?.subComedymovList[indexPath.row].poster ?? ""
                moviename = HollywoodJukeboxdata?.subComedymovList[indexPath.row].title ?? ""
                movietype = HollywoodJukeboxdata?.subComedymovList[indexPath.row].poster ?? ""
                permalink =  HollywoodJukeboxdata?.subComedymovList[indexPath.row].c_permalink ?? ""
                let item = HollywoodJukeboxdata?.subComedymovList[indexPath.row]
              self.getcontentauthorized(movieid: item?.movie_uniq_id ?? "", planurls: item?.permalink ?? "", index: indexPath.row, permad: item?.c_permalink ?? "")
                
              }else if collectionView == InstrumentalSongsCollectionV
             {
                imagename = InstrumentalSongsdata?.subComedymovList[indexPath.row].poster ?? ""
                moviename = InstrumentalSongsdata?.subComedymovList[indexPath.row].title ?? ""
                movietype = InstrumentalSongsdata?.subComedymovList[indexPath.row].poster ?? ""
                permalink =  InstrumentalSongsdata?.subComedymovList[indexPath.row].c_permalink ?? ""
                let item = InstrumentalSongsdata?.subComedymovList[indexPath.row]
              self.getcontentauthorized(movieid: item?.movie_uniq_id ?? "", planurls: item?.permalink ?? "", index: indexPath.row, permad: item?.c_permalink ?? "")
                
              }else if collectionView == SpiritualSongsCollectionV
            {
               imagename = SpiritualSongsdata?.subComedymovList[indexPath.row].poster ?? ""
               moviename = SpiritualSongsdata?.subComedymovList[indexPath.row].title ?? ""
               movietype = SpiritualSongsdata?.subComedymovList[indexPath.row].poster ?? ""
               permalink =  SpiritualSongsdata?.subComedymovList[indexPath.row].c_permalink ?? ""
                let item = SpiritualSongsdata?.subComedymovList[indexPath.row]
              self.getcontentauthorized(movieid: item?.movie_uniq_id ?? "", planurls: item?.permalink ?? "", index: indexPath.row, permad: item?.c_permalink ?? "")
                
              }else if collectionView == PatrioticSongsCollectionV
            {
               imagename = PatrioticSongsdata?.subComedymovList[indexPath.row].poster ?? ""
               moviename = PatrioticSongsdata?.subComedymovList[indexPath.row].title ?? ""
               movietype = PatrioticSongsdata?.subComedymovList[indexPath.row].poster ?? ""
               permalink =  PatrioticSongsdata?.subComedymovList[indexPath.row].c_permalink ?? ""
                let item = PatrioticSongsdata?.subComedymovList[indexPath.row]
              self.getcontentauthorized(movieid: item?.movie_uniq_id ?? "", planurls: item?.permalink ?? "", index: indexPath.row, permad: item?.c_permalink ?? "")
                
              }
            
            else if collectionView == GazalCollectionV
             {
                 imagename = Gazaldata?.subComedymovList[indexPath.row].poster ?? ""
                moviename = Gazaldata?.subComedymovList[indexPath.row].title ?? ""
                movietype = Gazaldata?.subComedymovList[indexPath.row].poster ?? ""
                permalink =  Gazaldata?.subComedymovList[indexPath.row].c_permalink ?? ""
                let item = Gazaldata?.subComedymovList[indexPath.row]
              self.getcontentauthorized(movieid: item?.movie_uniq_id ?? "", planurls: item?.permalink ?? "", index: indexPath.row, permad: item?.c_permalink ?? "")
                
            }else if collectionView == GoldenmemoriesCollectionV
             {
                imagename = Goldenmemoriesdata?.subComedymovList[indexPath.row].poster ?? ""
                moviename = Goldenmemoriesdata?.subComedymovList[indexPath.row].title ?? ""
                movietype = Goldenmemoriesdata?.subComedymovList[indexPath.row].poster ?? ""
                permalink =  Goldenmemoriesdata?.subComedymovList[indexPath.row].c_permalink ?? ""
                let item = Goldenmemoriesdata?.subComedymovList[indexPath.row]
              self.getcontentauthorized(movieid: item?.movie_uniq_id ?? "", planurls: item?.permalink ?? "", index: indexPath.row, permad: item?.c_permalink ?? "")
                
              }else if collectionView == NinitieshitsCollectionV
             {
                imagename = Ninitieshitsdata?.subComedymovList[indexPath.row].poster ?? ""
                moviename = Ninitieshitsdata?.subComedymovList[indexPath.row].title ?? ""
                movietype = Ninitieshitsdata?.subComedymovList[indexPath.row].poster ?? ""
                permalink =  Ninitieshitsdata?.subComedymovList[indexPath.row].c_permalink ?? ""
                let item = Ninitieshitsdata?.subComedymovList[indexPath.row]
              self.getcontentauthorized(movieid: item?.movie_uniq_id ?? "", planurls: item?.permalink ?? "", index: indexPath.row, permad: item?.c_permalink ?? "")
                
              }
              else if collectionView == TraditionalfolksCollectionV
            {
               imagename = Traditionalfolksdata?.subComedymovList[indexPath.row].poster ?? ""
               moviename = Traditionalfolksdata?.subComedymovList[indexPath.row].title ?? ""
               movietype = Traditionalfolksdata?.subComedymovList[indexPath.row].poster ?? ""
               permalink =  Traditionalfolksdata?.subComedymovList[indexPath.row].c_permalink ?? ""
                let item = Traditionalfolksdata?.subComedymovList[indexPath.row]
              self.getcontentauthorized(movieid: item?.movie_uniq_id ?? "", planurls: item?.permalink ?? "", index: indexPath.row, permad: item?.c_permalink ?? "")
             }else if collectionView == MtvunpluggedCollectionV
            {
               imagename = Mtvunpluggeddata?.subComedymovList[indexPath.row].poster ?? ""
               moviename = Mtvunpluggeddata?.subComedymovList[indexPath.row].title ?? ""
               movietype = Mtvunpluggeddata?.subComedymovList[indexPath.row].poster ?? ""
               permalink =  Mtvunpluggeddata?.subComedymovList[indexPath.row].c_permalink ?? ""
               let item = Mtvunpluggeddata?.subComedymovList[indexPath.row]
             self.getcontentauthorized(movieid: item?.movie_uniq_id ?? "", planurls: item?.permalink ?? "", index: indexPath.row, permad: item?.c_permalink ?? "")
            }
            
            
            
            
            
            
            
            
           // performSegue(withIdentifier: "tomusic", sender: self)
        }
       
       
        func getcontentauthorized(movieid:String,planurls:String,index:Int,permad:String)
        {
            Utility.ShowLoader(vc: self)
            
            Api.IsContentAuthorised(movieid, endpoint: ApiEndPoints.isContentAuthorized, vc: self) { (res, err) -> (Void) in
                                 
                do{
                                     
                    let decoder = JSONDecoder()
                    self.authorizeddata = try decoder.decode(Authorizescontent.self, from: res  ?? Data())
                    Utility.hideLoader(vc: self)
                    if self.authorizeddata?.status == "OK"
                    {
                        /*
                        let storyBoard: UIStoryboard = UIStoryboard(name: "Main", bundle: nil)
                        let displayVC = storyBoard.instantiateViewController(withIdentifier: "SongsDetailsVC") as! SongsDetailsVC
                           displayVC.modalPresentationStyle = .fullScreen
                            print(self.permalink)
                           displayVC.permalink = self.permalink
                       displayVC.songtitle = self.moviename
                        displayVC.IsAuthorizedContent = 1
                        displayVC.playerurlstr = planurls
                       //self.present(displayVC, animated: true, completion: nil)
                        */
                        self.getcontendeatils(permaa: permad)
                    }else
                    {
                        print("else..//")
                       /*
                        
                        let storyBoard: UIStoryboard = UIStoryboard(name: "Main", bundle: nil)
                        let displayVC = storyBoard.instantiateViewController(withIdentifier: "SongsDetailsVC") as! SongsDetailsVC
                           displayVC.modalPresentationStyle = .fullScreen
                            print(self.permalink)
                           displayVC.permalink = self.permalink
                       displayVC.songtitle = self.moviename
                        displayVC.IsAuthorizedContent = 0
                        displayVC.playerurlstr = planurls

                       //self.present(displayVC, animated: true, completion: nil)
                        */
                        self.getcontendeatils(permaa: permad)

                    }
                                 }
                                 catch let error
                                 {
                                    Utility.hideLoader(vc: self)

                                   Utility.showAlert(vc: self, message:"\(error)", titelstring: Appcommon.Appname)
                                 }
                             }
            
        }
        
           
        func getcontendeatils(permaa:String)
           {
            Utility.ShowLoader(vc: self)
               Api.getcontentdetails(permaa, endpoint: ApiEndPoints.getcontentdetails, vc: UIViewController()) { (res, err) -> (Void) in
                   do
                   {
                      let decoder = JSONDecoder()
                      self.contentdata = try decoder.decode(contentdetails.self, from: res  ?? Data())
                    Utility.hideLoader(vc: self)

                    if self.contentdata?.msg == "Ok"
                      {
                          //self.getPPVplans(movieuniqids: self.contentdata?.submovie?.muvi_uniq_id ?? "", planid: self.contentdata?.submovie?.ppv_plan_id  ?? "")
                        var MuviPlayerV =    MuviAudioPlayerManager.shared.muviAudioMiniView!

                       // let theHeight = view.frame.size.height //grabs the height of your view

                        self.muviPlayer.audioTitleLabel.adjustsFontSizeToFitWidth = true
                        self.muviPlayer.audioSubTitleLabel.adjustsFontSizeToFitWidth = true

                        MuviPlayerV.audioTitleLabel.textColor = UIColor.black
                        MuviPlayerV.audioSubTitleLabel.textColor = UIColor.black

                            //[NSAttributedString.Key.font: UIFont(name: "Muli-Bold", size: 16)!,NSAttributedString.Key.foregroundColor : UIColor.white], for: .normal
                        MuviPlayerV.layer.backgroundColor = UIColor.white.cgColor
                        MuviPlayerV.frame = CGRect(x: 0, y: UIScreen.main.bounds.height - 214, width: UIScreen.main.bounds.width, height: 60)
                        self.view.addSubview(MuviPlayerV)

                        self.myScrollingView.bringSubviewToFront(MuviPlayerV)

                        guard let songurl = URL(string: self.contentdata?.submovie?.movieUrl ?? "") else {return}
                        guard let songImageurl = URL(string:  self.contentdata?.submovie?.poster ?? "") else {return}

                      //  print("name === \(self.contentdata?.submovie?.name)")
                      //  print("titlename === \(self.contentdata?.submovie?.custom3)")

                        let song = MuviAudioPlayerItemInfo(id: "",
                                                                    url: songurl,
                                                                    title:self.contentdata?.submovie?.name ?? "",
                                                                    albumTitle: self.contentdata?.submovie?.custom3 ?? "",
                                                                    coverImageURL: songImageurl)
                        MuviAudioPlayerManager.shared.setup(with:[song])
                          
                      }
                      
                   }
                   catch let error
                   {
                    Utility.hideLoader(vc: self)

                       Utility.showAlert(vc: UIViewController(), message:"\(error)", titelstring: Appcommon.Appname)
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
    }
       
 
extension MusicListVC:MuviAudioPlayerDelegate
{
    func muviAudioPlayerManager(_ playerManager: MuviAudioPlayerManager,
    progressDidUpdate percentage: Double) {
       print("percentage: \(percentage * 100)")
    }
    func muviAudioPlayerManager(_ playerManager: MuviAudioPlayerManager,
    itemDidChange itemIndex: Int) {
        print("itemIndex: \(itemIndex)")
    }
    func muviAudioPlayerManager(_ playerManager: MuviAudioPlayerManager,
    statusDidChange status: MuviAudioPlayerStatus) {
       print("status: \(status)")
    }
    func getCoverImage(_ player: MuviAudioPlayerManager, _ callBack: @escaping
    (UIImage?) -> Void) {
    }
    func muviAudioPlayerAuthentication(code: Int, message: String) {
        print("Code: \(code) ::: \(message)")
    }
}

 
/*
 "cover-songs", "",
 ("originals-songs", ""
 ("cover-songs", "mashup"
  ("cover-songs", "ghazal"
  ("cover-songs", "golden-memories"
 ("cover-songs", "90s-hits"
 ("cover-songs", "traditional-folks"
 ("cover-songs", "mtv-unplugged"
 ("cover-songs", "spiritual"
 ("cover-songs", "patriotic"
  ("cover-songs", "instrumental"
   "music-jukebox", "bollywood"
  ("music-jukebox", "hollywood1"
 
  
  
   
  
  
  
 
  
 
  
 */
