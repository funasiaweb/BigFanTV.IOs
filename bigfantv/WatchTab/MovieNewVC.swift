//
//  MovieNewVC.swift
//  bigfantv
//
//  Created by Ganesh on 23/01/21.
//  Copyright © 2021 Ganesh. All rights reserved.
//

import UIKit
 import AVKit
import Alamofire
import SDWebImage
class MovieNewVC: UIViewController  {
    @IBOutlet weak var sliderCollectionView: UICollectionView!
    @IBOutlet weak var pageView: UIPageControl!
     
    
    var timernew = Timer()
    var counter = 0
    //Banners
     @IBOutlet var Vinew: UIView!
    private var Bannerdata:NewBannerList?
    private var banerdata = [Dictionary<String,String>]()
    var filterPlayers : [AVPlayer?] = []
    var currentPage: Int = 0
    var filterScrollView : UIScrollView?
    var player: AVPlayer?
    var playerController : AVPlayerViewController?
    var avPlayerLayer : AVPlayerLayer!
    let manager: Alamofire.SessionManager = {
        let configuration = URLSessionConfiguration.default
        return  Alamofire.SessionManager(configuration: configuration)
    }()
    @IBOutlet weak var ActionCustomV: CustomView!
    @IBOutlet weak var adventureCustomV: CustomView!
     @IBOutlet weak var fantasyCustomV: CustomView!
     @IBOutlet weak var romanceCustomV: CustomView!
     @IBOutlet weak var horrorCustomV: CustomView!
     @IBOutlet weak var mysteryCustomV: CustomView!
     @IBOutlet weak var scifiCustomV: CustomView!
     @IBOutlet weak var comedy1CustomV: CustomView!
     @IBOutlet weak var thrillerCustomV: CustomView!
     @IBOutlet weak var crimeCustomV: CustomView!
     @IBOutlet weak var dramaCustomV: CustomView!
     @IBOutlet weak var animationCustomV: CustomView!
     @IBOutlet weak var tollywoodCustomV: CustomView!
    
    @IBOutlet weak var EnglishLangCustomV: CustomView!
    @IBOutlet weak var HindiLangCustomV: CustomView!
    @IBOutlet weak var PunjabiLangCustomV: CustomView!
    @IBOutlet weak var TamilLangCustomV: CustomView!
    @IBOutlet weak var TeluguLangCustomV: CustomView!
    @IBOutlet weak var MarathiLangCustomV: CustomView!
    @IBOutlet weak var MalayalamLangCustomV: CustomView!
    @IBOutlet weak var BhojpuriLangCustomV: CustomView!
    @IBOutlet weak var GujaratiLangCustomV: CustomView!
    @IBOutlet weak var BengaliLangCustomV: CustomView!
    @IBOutlet weak var KannadaLangCustomV: CustomView!
    @IBOutlet weak var OdiyaLangCustomV: CustomView!
    @IBOutlet weak var HaryanviLangCustomV: CustomView!
    @IBOutlet weak var UrduLangCustomV: CustomView!
    @IBOutlet weak var NepaliLangCustomV: CustomView!
    var count = 15
     var loadtimer = Timer()
    var IsactionDatashown = false
    var IsadventureDatashown = false
    var IsfantasyDatashown = false
    var timer:Timer!
    var CategoryArray = [String]()

    let muviUrl:URL = URL(string: "https://bigfantv.com/en/rest/getFilteredContent")!

     override func viewDidLoad()
    {   super.viewDidLoad()

      
        
        self.ActionCustomV.LbTitle.text = "ACTION"
        self.adventureCustomV.LbTitle.text = "ADVENTURE"
        self.fantasyCustomV.LbTitle.text = "FANTASY"
        self.romanceCustomV.LbTitle.text = "ROMANCE"
        self.horrorCustomV.LbTitle.text = "HORROR"
        self.mysteryCustomV.LbTitle.text = "MYSTERY"
        self.scifiCustomV.LbTitle.text = "SCI-FI"
        self.comedy1CustomV.LbTitle.text = "COMEDY"
        self.thrillerCustomV.LbTitle.text = "THRILLER"
        self.crimeCustomV.LbTitle.text = "CRIME"
        self.dramaCustomV.LbTitle.text = "DRAMA"
        self.animationCustomV.LbTitle.text = "ANIMATION"
        self.tollywoodCustomV.LbTitle.text = "TOLLYWOOD"
        self.EnglishLangCustomV.LbTitle.text = "ENGLISH MOVIES"
        self.HindiLangCustomV.LbTitle.text = "HINDI MOVIES"
        self.PunjabiLangCustomV.LbTitle.text = "PUNJABI MOVIES"
        self.TamilLangCustomV.LbTitle.text = "TAMIL MOVIES"
        self.TeluguLangCustomV.LbTitle.text = "TELUGU MOVIES"
        self.MarathiLangCustomV.LbTitle.text = "MARATHI MOVIES"
        self.MalayalamLangCustomV.LbTitle.text = "MALYALAM MOVIES"
        self.BhojpuriLangCustomV.LbTitle.text = "BHOJPURI MOVIES"
        self.GujaratiLangCustomV.LbTitle.text = "GUJARATI MOVIES"
        self.BengaliLangCustomV.LbTitle.text = "BENGALI MOVIES"
        self.KannadaLangCustomV.LbTitle.text = "KANNADA MOVIES"
        self.OdiyaLangCustomV.LbTitle.text = "ODIYA MOVIES"
        self.HaryanviLangCustomV.LbTitle.text = "HARYANVI MOVIES"
        self.UrduLangCustomV.LbTitle.text = "URDU MOVIES"
        self.NepaliLangCustomV.LbTitle.text = "NEPALI MOVIES"
            
        if Connectivity.isConnectedToInternet()
        {
        
           // Utility.ShowLoader(vc: self)
            self.Loaddata()
            self.Getimagelist()
           loadtimer = Timer.scheduledTimer(withTimeInterval: 3, repeats: true) { (t) in
            self.count -= 1
            if self.count == 1
                {
                    self.loadtimer.invalidate()
                }else
                {
                   // self.Loaddata()
                  //  self.Getimagelist()
                }
            }
            
             
        }else
        {
            Utility.Internetconnection(vc: self)
        }
    }
    func Loaddata()
    {
        /*
        self.ActionCustomV.loadallcontents(muvcategory: "movies", muvsubcategory:  "action", title: "Action Movies")
        self.adventureCustomV.loadallcontents(muvcategory: "movies", muvsubcategory:  "adventure", title: "Adventure Movies")
        self.fantasyCustomV.loadallcontents(muvcategory: "movies", muvsubcategory:  "fantasy", title: "Fantasy Movies")
        self.romanceCustomV.loadallcontents(muvcategory: "movies", muvsubcategory:  "romance", title: "Romance Movies")
        self.horrorCustomV.loadallcontents(muvcategory: "movies", muvsubcategory:  "horror", title: "Horror Movies")
        self.mysteryCustomV.loadallcontents(muvcategory: "movies", muvsubcategory:  "mystery", title: "Mystery Movies")
        */


        commonFunction(category: "movies", subCategory: "action", detailTitle: "Action Movies", collectionV: ActionCustomV)
        commonFunction(category: "movies", subCategory: "adventure", detailTitle: "Adventure Movies", collectionV: adventureCustomV)
        commonFunction(category: "movies", subCategory: "fantasy", detailTitle: "Fantasy Movies", collectionV: fantasyCustomV)
        commonFunction(category: "movies", subCategory: "romance", detailTitle: "Romance Movies", collectionV: romanceCustomV)
        /*
        Common.shared.getfeiltereddata(category: "movies", subcategory: "action") { (data, err) -> (Void) in
             
            if err != nil
            {
                self.ActionCustomV.isHidden = true
            }
            if data?.subComedymovList.count ?? 0 <= 0
            {
                self.ActionCustomV.isHidden = true
            }else
            {
                self.ActionCustomV.isHidden = false

            }
             
            self.ActionCustomV.Muvidata = data
            self.ActionCustomV.reloadata()
             self.ActionCustomV.Movcategory = "movies"
             self.ActionCustomV.selftitle = "Action Movies"
             self.ActionCustomV.MovSubcategory = "action"
             self.IsactionDatashown = true
             self.hideloader()
         }
         Common.shared.getfeiltereddata(category: "movies", subcategory: "adventure") { (data, err) -> (Void) in
             

            if err != nil
            {
                self.adventureCustomV.isHidden = true
            }
            if data?.subComedymovList.count ?? 0 <= 0
            {
                self.adventureCustomV.isHidden = true
            }else
            {
                self.adventureCustomV.isHidden = false

            }
            self.IsadventureDatashown = true
            self.hideloader()
            self.adventureCustomV.Movcategory = "movies"
             self.adventureCustomV.MovSubcategory = "adventure"
             self.adventureCustomV.selftitle = "Adventure Movies"
              
             self.adventureCustomV.Muvidata = data
             self.adventureCustomV.reloadata()
         }
         Common.shared.getfeiltereddata(category: "movies", subcategory: "fantasy") { (data, err) -> (Void) in
             

            if err != nil
            {
                self.fantasyCustomV.isHidden = true
            }
            if data?.subComedymovList.count ?? 0 <= 0
            {
                self.fantasyCustomV.isHidden = true
            }else
            {
                self.fantasyCustomV.isHidden = false

            }
             self.IsfantasyDatashown = true
             self.hideloader()
             self.fantasyCustomV.Movcategory = "movies"
             self.fantasyCustomV.MovSubcategory = "fantasy"
             self.fantasyCustomV.selftitle = "Fantasy Movies"
              
             self.fantasyCustomV.Muvidata = data
             self.fantasyCustomV.reloadata()
        }
 
         Common.shared.getfeiltereddata(category: "movies", subcategory: "romance") { (data, err) -> (Void) in
             

            if err != nil
            {
                self.romanceCustomV.isHidden = true
            }
            if data?.subComedymovList.count ?? 0 <= 0
            {
                self.romanceCustomV.isHidden = true
            }else
            {
                self.romanceCustomV.isHidden = false

            }
             self.romanceCustomV.Movcategory = "movies"
             self.romanceCustomV.MovSubcategory = "romance"
             self.romanceCustomV.selftitle = "Romance Movies"
              
             self.romanceCustomV.Muvidata = data
             self.romanceCustomV.reloadata()
         }
         Common.shared.getfeiltereddata(category: "movies", subcategory: "horror") { (data, err) -> (Void) in
             

            if err != nil
            {
                self.horrorCustomV.isHidden = true
            }
            if data?.subComedymovList.count ?? 0 <= 0
            {
                self.horrorCustomV.isHidden = true
            }else
            {
                self.horrorCustomV.isHidden = false

            }
             self.horrorCustomV.Movcategory = "movies"
             self.horrorCustomV.MovSubcategory = "horror"
             self.horrorCustomV.selftitle = "Horror Movies"
              
             self.horrorCustomV.Muvidata = data
             self.horrorCustomV.reloadata()
         }
         Common.shared.getfeiltereddata(category: "movies", subcategory: "mystery") { (data, err) -> (Void) in
             

            if err != nil
            {
                self.mysteryCustomV.isHidden = true
            }
            if data?.subComedymovList.count ?? 0 <= 0
            {
                self.mysteryCustomV.isHidden = true
            }else
            {
                self.mysteryCustomV.isHidden = false

            }
             self.mysteryCustomV.Movcategory = "movies"
             self.mysteryCustomV.MovSubcategory = "mystery"
             self.mysteryCustomV.selftitle = "Mystery Movies"
              
             self.mysteryCustomV.Muvidata = data
             self.mysteryCustomV.reloadata()
         }
         Common.shared.getfeiltereddata(category: "movies", subcategory: "sci-fi") { (data, err) -> (Void) in
             

            if err != nil
            {
                self.scifiCustomV.isHidden = true
            }
            if data?.subComedymovList.count ?? 0 <= 0
            {
                self.scifiCustomV.isHidden = true
            }else
            {
                self.scifiCustomV.isHidden = false

            }
              self.scifiCustomV.Movcategory = "movies"
              self.scifiCustomV.MovSubcategory = "sci-fi"
             self.scifiCustomV.selftitle = "Sci-Fi Movies"
               
              self.scifiCustomV.Muvidata = data
              self.scifiCustomV.reloadata()
         }
         Common.shared.getfeiltereddata(category: "movies", subcategory: "comedy1") { (data, err) -> (Void) in
             

            if err != nil
            {
                self.comedy1CustomV.isHidden = true
            }
            if data?.subComedymovList.count ?? 0 <= 0
            {
                self.comedy1CustomV.isHidden = true
            }else
            {
                self.comedy1CustomV.isHidden = false

            }
             self.comedy1CustomV.Movcategory = "movies"
             self.comedy1CustomV.MovSubcategory = "comedy1"
             self.comedy1CustomV.selftitle = "Comedy Movies"
              
             self.comedy1CustomV.Muvidata = data
             self.comedy1CustomV.reloadata()
         }
         Common.shared.getfeiltereddata(category: "movies", subcategory: "thriller") { (data, err) -> (Void) in
             

            if err != nil
            {
                self.thrillerCustomV.isHidden = true
            }
            if data?.subComedymovList.count ?? 0 <= 0
            {
                self.thrillerCustomV.isHidden = true
            }else
            {
                self.thrillerCustomV.isHidden = false

            }
             self.thrillerCustomV.Movcategory = "movies"
             self.thrillerCustomV.MovSubcategory = "thriller"
             self.thrillerCustomV.selftitle = "Thriller Movies"
              
             self.thrillerCustomV.Muvidata = data
             self.thrillerCustomV.reloadata()
         }
         Common.shared.getfeiltereddata(category: "movies", subcategory: "crime") { (data, err) -> (Void) in
             

            if err != nil
            {
                self.crimeCustomV.isHidden = true
            }
            if data?.subComedymovList.count ?? 0 <= 0
            {
                self.crimeCustomV.isHidden = true
            }else
            {
                self.crimeCustomV.isHidden = false

            }
             self.crimeCustomV.Movcategory = "movies"
             self.crimeCustomV.MovSubcategory = "crime"
             self.crimeCustomV.selftitle = "Crime Movies"
              
             self.crimeCustomV.Muvidata = data
             self.crimeCustomV.reloadata()
        }
         Common.shared.getfeiltereddata(category: "movies", subcategory: "drama") { (data, err) -> (Void) in
             

            if err != nil
            {
                self.dramaCustomV.isHidden = true
            }
            if data?.subComedymovList.count ?? 0 <= 0
            {
                self.dramaCustomV.isHidden = true
            }else
            {
                self.dramaCustomV.isHidden = false

            }
             self.dramaCustomV.Movcategory = "movies"
             self.dramaCustomV.MovSubcategory = "drama"
             self.dramaCustomV.selftitle = "Drama Movies"
              
             self.dramaCustomV.Muvidata = data
             self.dramaCustomV.reloadata()
         }
         Common.shared.getfeiltereddata(category: "movies", subcategory: "animation") { (data, err) -> (Void) in
             

            if err != nil
            {
                self.animationCustomV.isHidden = true
            }
            if data?.subComedymovList.count ?? 0 <= 0
            {
                self.animationCustomV.isHidden = true
            }else
            {
                self.animationCustomV.isHidden = false

            }
             self.animationCustomV.Movcategory = "movies"
             self.animationCustomV.MovSubcategory = "animation"
             self.animationCustomV.selftitle = "Animation Movies"
              self.animationCustomV.Muvidata = data
             self.animationCustomV.reloadata()
         }
         Common.shared.getfeiltereddata(category: "movies", subcategory: "tollywood") { (data, err) -> (Void) in
             

            
            if err != nil
            {
                self.tollywoodCustomV.isHidden = true
            }
            if data?.subComedymovList.count ?? 0 <= 0
            {
                self.tollywoodCustomV.isHidden = true
            }else
            {
                self.tollywoodCustomV.isHidden = false

            }
            self.tollywoodCustomV.Movcategory = "movies"
            self.tollywoodCustomV.MovSubcategory = "tollywood"
            self.tollywoodCustomV.selftitle = "Tollywood Movies"
             self.tollywoodCustomV.Muvidata = data
            self.tollywoodCustomV.reloadata()

         }
        Common.shared.getfeiltereddata(category:  "language-1" , subcategory: "english") { (data, err) -> (Void) in
             

            if err != nil
            {
                self.EnglishLangCustomV.isHidden = true
            }
            if data?.subComedymovList.count ?? 0 <= 0
            {
                self.EnglishLangCustomV.isHidden = true
            }else
            {
                self.EnglishLangCustomV.isHidden = false

            }
           self.EnglishLangCustomV.Movcategory = "language-1"
           self.EnglishLangCustomV.MovSubcategory = "english"
           self.EnglishLangCustomV.selftitle = "English Movies"
            self.EnglishLangCustomV.Muvidata = data
           self.EnglishLangCustomV.reloadata()
            
        }
        Common.shared.getfeiltereddata(category:  "language-1" , subcategory: "hindi") { (data, err) -> (Void) in
             

            if err != nil
            {
                self.HindiLangCustomV.isHidden = true
            }
            if data?.subComedymovList.count ?? 0 <= 0
            {
                self.HindiLangCustomV.isHidden = true
            }else
            {
                self.HindiLangCustomV.isHidden = false

            }
           self.HindiLangCustomV.Movcategory = "language-1"
           self.HindiLangCustomV.MovSubcategory = "hindi"
           self.HindiLangCustomV.selftitle = "Hindi Movies"
            self.HindiLangCustomV.Muvidata = data
           self.HindiLangCustomV.reloadata()
            
        }
        Common.shared.getfeiltereddata(category:  "language-1" , subcategory: "punjabi4") { (data, err) -> (Void) in
             

            if err != nil
            {
                self.PunjabiLangCustomV.isHidden = true
            }
            if data?.subComedymovList.count ?? 0 <= 0
            {
                self.PunjabiLangCustomV.isHidden = true
            }else
            {
                self.PunjabiLangCustomV.isHidden = false

            }
           self.PunjabiLangCustomV.Movcategory = "language-1"
           self.PunjabiLangCustomV.MovSubcategory = "punjabi4"
           self.PunjabiLangCustomV.selftitle = "Punjabi Movies"
            self.PunjabiLangCustomV.Muvidata = data
           self.PunjabiLangCustomV.reloadata()
            
        }
        Common.shared.getfeiltereddata(category:  "language-1" , subcategory: "tamil") { (data, err) -> (Void) in
             

            if err != nil
            {
                self.TamilLangCustomV.isHidden = true
            }
            if data?.subComedymovList.count ?? 0 <= 0
            {
                self.TamilLangCustomV.isHidden = true
            }else
            {
                self.TamilLangCustomV.isHidden = false

            }
           self.TamilLangCustomV.Movcategory = "language-1"
           self.TamilLangCustomV.MovSubcategory = "tamil"
           self.TamilLangCustomV.selftitle = "Tamil Movies"
            self.TamilLangCustomV.Muvidata = data
           self.TamilLangCustomV.reloadata()
            
        }
        Common.shared.getfeiltereddata(category:  "language-1" , subcategory: "telugu") { (data, err) -> (Void) in
             
            if err != nil
            {
                self.TeluguLangCustomV.isHidden = true
            }
            if data?.subComedymovList.count ?? 0 <= 0
            {
                self.TeluguLangCustomV.isHidden = true
            }else
            {
                self.TeluguLangCustomV.isHidden = false

            }
           self.TeluguLangCustomV.Movcategory = "language-1"
           self.TeluguLangCustomV.MovSubcategory = "telugu"
           self.TeluguLangCustomV.selftitle = "Telugu Movies"
            self.TeluguLangCustomV.Muvidata = data
           self.TeluguLangCustomV.reloadata()
            
        }
        Common.shared.getfeiltereddata(category:  "language-1" , subcategory: "marathi") { (data, err) -> (Void) in
             
            if err != nil
            {
                self.MarathiLangCustomV.isHidden = true
            }
            if data?.subComedymovList.count ?? 0 <= 0
            {
                self.MarathiLangCustomV.isHidden = true
            }else
            {
                self.MarathiLangCustomV.isHidden = false

            }
           self.MarathiLangCustomV.Movcategory = "language-1"
           self.MarathiLangCustomV.MovSubcategory = "marathi"
           self.MarathiLangCustomV.selftitle = "Marathi Movies"
            self.MarathiLangCustomV.Muvidata = data
           self.MarathiLangCustomV.reloadata()
            
        }
        Common.shared.getfeiltereddata(category:  "language-1" , subcategory: "malyalam") { (data, err) -> (Void) in
             
            if err != nil
            {
                self.MalayalamLangCustomV.isHidden = true
            }
            if data?.subComedymovList.count ?? 0 <= 0
            {
                self.MalayalamLangCustomV.isHidden = true
            }else
            {
                self.MalayalamLangCustomV.isHidden = false

            }
           self.MalayalamLangCustomV.Movcategory = "language-1"
           self.MalayalamLangCustomV.MovSubcategory = "malyalam"
           self.MalayalamLangCustomV.selftitle = "Malyalam Movies"
            self.MalayalamLangCustomV.Muvidata = data
           self.MalayalamLangCustomV.reloadata()
            
        }
        Common.shared.getfeiltereddata(category:  "language-1" , subcategory: "bhojpuri") { (data, err) -> (Void) in
             
            if err != nil
            {
                self.BhojpuriLangCustomV.isHidden = true
            }
            if data?.subComedymovList.count ?? 0 <= 0
            {
                self.BhojpuriLangCustomV.isHidden = true
            }else
            {
                self.BhojpuriLangCustomV.isHidden = false

            }
           self.BhojpuriLangCustomV.Movcategory = "language-1"
           self.BhojpuriLangCustomV.MovSubcategory = "bhojpuri"
           self.BhojpuriLangCustomV.selftitle = "Bhojpuri Movies"
            self.BhojpuriLangCustomV.Muvidata = data
           self.BhojpuriLangCustomV.reloadata()
            
        }
        Common.shared.getfeiltereddata(category:  "language-1" , subcategory: "gujarati") { (data, err) -> (Void) in
             
            if err != nil
            {
                self.GujaratiLangCustomV.isHidden = true
            }
            if data?.subComedymovList.count ?? 0 <= 0
            {
                self.GujaratiLangCustomV.isHidden = true
            }else
            {
                self.GujaratiLangCustomV.isHidden = false

            }
           self.GujaratiLangCustomV.Movcategory = "language-1"
           self.GujaratiLangCustomV.MovSubcategory = "gujarati"
           self.GujaratiLangCustomV.selftitle = "Gujarati Movies"
            self.GujaratiLangCustomV.Muvidata = data
           self.GujaratiLangCustomV.reloadata()
            
        }
        Common.shared.getfeiltereddata(category:  "language-1" , subcategory: "bengali") { (data, err) -> (Void) in
             
            if err != nil
            {
                self.BengaliLangCustomV.isHidden = true
            }
            if data?.subComedymovList.count ?? 0 <= 0
            {
                self.BengaliLangCustomV.isHidden = true
            }else
            {
                self.BengaliLangCustomV.isHidden = false

            }
           self.BengaliLangCustomV.Movcategory = "language-1"
           self.BengaliLangCustomV.MovSubcategory = "bengali"
           self.BengaliLangCustomV.selftitle = "Bengali Movies"
            self.BengaliLangCustomV.Muvidata = data
           self.BengaliLangCustomV.reloadata()
            
        }
        Common.shared.getfeiltereddata(category:  "language-1" , subcategory: "kannada") { (data, err) -> (Void) in
             
            if err != nil
            {
                self.KannadaLangCustomV.isHidden = true
            }
            if data?.subComedymovList.count ?? 0 <= 0
            {
                self.KannadaLangCustomV.isHidden = true
            }else
            {
                self.KannadaLangCustomV.isHidden = false

            }
           self.KannadaLangCustomV.Movcategory = "language-1"
           self.KannadaLangCustomV.MovSubcategory = "kannada"
           self.KannadaLangCustomV.selftitle = "Kannada Movies"
            self.KannadaLangCustomV.Muvidata = data
           self.KannadaLangCustomV.reloadata()
            
        }
        Common.shared.getfeiltereddata(category:  "language-1" , subcategory: "odiya") { (data, err) -> (Void) in
             
            if err != nil
            {
                self.OdiyaLangCustomV.isHidden = true
            }
            if data?.subComedymovList.count ?? 0 <= 0
            {
                self.OdiyaLangCustomV.isHidden = true
            }else
            {
                self.OdiyaLangCustomV.isHidden = false

            }
           self.OdiyaLangCustomV.Movcategory = "language-1"
           self.OdiyaLangCustomV.MovSubcategory = "odiya"
           self.OdiyaLangCustomV.selftitle = "Odiya Movies"
            self.OdiyaLangCustomV.Muvidata = data
           self.OdiyaLangCustomV.reloadata()
            
        }
        Common.shared.getfeiltereddata(category:  "language-1" , subcategory: "haryanvi") { (data, err) -> (Void) in
             
            if err != nil
            {
                self.HaryanviLangCustomV.isHidden = true
            }
            if data?.subComedymovList.count ?? 0 <= 0
            {
                self.HaryanviLangCustomV.isHidden = true
            }else
            {
                self.HaryanviLangCustomV.isHidden = false

            }
           self.HaryanviLangCustomV.Movcategory = "language-1"
           self.HaryanviLangCustomV.MovSubcategory = "haryanvi"
           self.HaryanviLangCustomV.selftitle = "Haryanvi Movies"
            self.HaryanviLangCustomV.Muvidata = data
           self.HaryanviLangCustomV.reloadata()
            
        }
        Common.shared.getfeiltereddata(category:  "language-1" , subcategory: "urdu") { (data, err) -> (Void) in
             
            if err != nil
            {
                self.UrduLangCustomV.isHidden = true
            }
            if data?.subComedymovList.count ?? 0 <= 0
            {
                self.UrduLangCustomV.isHidden = true
            }else
            {
                self.UrduLangCustomV.isHidden = false

            }
           self.UrduLangCustomV.Movcategory = "language-1"
           self.UrduLangCustomV.MovSubcategory = "urdu"
           self.UrduLangCustomV.selftitle = "Urdu Movies"
            self.UrduLangCustomV.Muvidata = data
           self.UrduLangCustomV.reloadata()
            
        }
        Common.shared.getfeiltereddata(category:  "language-1" , subcategory: "nepali") { (data, err) -> (Void) in
             
            if err != nil
            {
                self.NepaliLangCustomV.isHidden = true
            }
            if data?.subComedymovList.count ?? 0 <= 0
            {
                self.NepaliLangCustomV.isHidden = true
            }else
            {
                self.NepaliLangCustomV.isHidden = false

            }
           self.NepaliLangCustomV.Movcategory = "language-1"
           self.NepaliLangCustomV.MovSubcategory = "nepali"
           self.NepaliLangCustomV.selftitle = "Nepali Movies"
            self.NepaliLangCustomV.Muvidata = data
           self.NepaliLangCustomV.reloadata()
            
        }
         
      */
        
    }
    override func viewDidAppear(_ animated: Bool) {
        let sliderflowLayout = UICollectionViewFlowLayout()
        sliderflowLayout.scrollDirection = .horizontal
        let size = sliderCollectionView.frame.size
        sliderflowLayout.itemSize = CGSize(width: size.width, height: size.height)
        sliderflowLayout.minimumLineSpacing = 0
        sliderflowLayout.minimumInteritemSpacing = 0
         sliderCollectionView.collectionViewLayout = sliderflowLayout
        sliderCollectionView.showsHorizontalScrollIndicator = false
    }
    func hideloader()
    {
        if IsactionDatashown == true || IsadventureDatashown == true || IsfantasyDatashown == true
        {
            Utility.hideLoader(vc: self)
        }
    }
   
    func Getimagelist()
  {
   do
   {
       guard let parameters =
           [
               "userId":UserDefaults.standard.string(forKey: "id") ?? "",
               "AccessToken":UserDefaults.standard.string(forKey:"AccessToken") ?? "",
               "offset":"1"

           ] as? [String:Any] else { return  }
       print(parameters)
       // https://funasia.net/bigfantv.funasia.net/service/getBannerList.html
       let url:URL = URL(string: "https://funasia.net/bigfantv.funasia.net/service/getBannerList.html")!
       self.manager.request(url, method: .post, parameters:parameters, encoding: JSONEncoding.default, headers: nil).responseJSON { (response) in
            print("response =\(response)")
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
                           let feature12 = [  "titleimage":"\(i.bannerImage ?? "")","isimage":"1","videourl":"\(i.action ?? "")","actionurl":"\(i.bannerURL ?? "")","permalink":"\(i.permalink ?? "")"]
                           self.banerdata.append(feature12)
                       }
                       print("count = \(self.banerdata.count)")
                       self.sliderCollectionView.delegate = self
                       self.sliderCollectionView.dataSource = self
                       self.pageView.numberOfPages = self.banerdata.count
                       self.pageView.currentPage = 0
                       DispatchQueue.main.async {
                           self.sliderCollectionView.reloadData()
                       }
                       DispatchQueue.main.async {
                           self.timernew = Timer.scheduledTimer(timeInterval: 2.0, target: self, selector: #selector(self.changeImage), userInfo: nil, repeats: true)
                       }
                       
                       //self.setupFilterWith(size: self.Vinew!.bounds.size)
                   }
                   catch let error
                   {
                       print("error.localizedDescription  \(error.localizedDescription)")
                   }
               }
               break
           case .failure(let error) :
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
@objc func changeImage() {

   if counter < self.banerdata.count {
    let index = IndexPath.init(item: counter, section: 0)
    self.sliderCollectionView.scrollToItem(at: index, at: .centeredHorizontally, animated: true)
    pageView.currentPage = counter
    counter += 1
} else {
    counter = 0
    let index = IndexPath.init(item: counter, section: 0)
    self.sliderCollectionView.scrollToItem(at: index, at: .left, animated: true)
    pageView.currentPage = counter
    counter = 1
}
    
}
    @objc func animateScrollView() {
        let scrollWidth = filterScrollView?.bounds.width ?? 0
        let currentXOffset = filterScrollView?.contentOffset.x ?? 0

            let lastXPos = currentXOffset + scrollWidth
        if lastXPos != filterScrollView?.contentSize.width {
                print("Scroll")
                filterScrollView?.setContentOffset(CGPoint(x: lastXPos, y: 0), animated: true)
            }
            else {
                print("Scroll to start")
                filterScrollView?.setContentOffset(CGPoint(x: 0, y: 0), animated: true)
            }
        }

    func scheduledTimerWithTimeInterval(){
            // Scheduling timer to Call the function "updateCounting" with the interval of 1 seconds
            timer = Timer.scheduledTimer(timeInterval: 2, target: self, selector: #selector(self.animateScrollView), userInfo: nil, repeats: true)
        }
   
    
    func commonFunction(category:String,subCategory:String,detailTitle:String,collectionV:CustomView)
    {
        guard  let  parameters =
            [
                "authToken" : "57b8617205fa3446ba004d583284f475",
                "category" : category,
                "subcategory" : subCategory,
                "limit" :4,
                "offset" : 1,
                "user_id": "",
                 "is_episode":0
                ] as? [String:Any] else { return  }
           
        print(parameters)
            //let url:URL = URL(string: "https://bigfantv.com/en/rest/getFilteredContent")!
              
        Alamofire.request(muviUrl, method: .post, parameters: parameters, encoding: JSONEncoding.default, headers: nil).validate().response {[weak self] (data) in
            do
            {
                let decoder = JSONDecoder()
         //   weak var muvidatas : newFilteredComedyMovieList?
           let muvidatas = try decoder.decode(newFilteredComedyMovieList.self, from: data.data ?? Data())
                if muvidatas.status == "OK" && muvidatas.code == 200
                {
                    collectionV.isHidden = false
                    collectionV.Movcategory = category
                    collectionV.MovSubcategory = subCategory
                    collectionV.selftitle = detailTitle
                    collectionV.Muvidata = muvidatas
                    DispatchQueue.main.async {
                    collectionV.reloadata()
                    }
                    
                }else
                {
                    collectionV.isHidden = true

                    Utility.showAlert(vc: self ?? UIViewController(), message: "\(muvidatas.status ?? "")", titelstring: Appcommon.Appname)
                }
                
                
            }catch
            {
                collectionV.isHidden = true
                print(error.localizedDescription)
            }
            
            
                    
                    
        }
    }
}
extension MovieNewVC: UIScrollViewDelegate {
     
    func setupFilterWith(size: CGSize)  {
        currentPage = 0
        filterPlayers.removeAll()
        filterScrollView = UIScrollView(frame: Vinew.bounds)
        
        let count = banerdata.count
        if count > 0
        {
        for i in 0...count-1 {
            //Adding image to scroll view
            let imgView : UIView = UIView.init(frame: CGRect(x: CGFloat(i) * size.width, y: 0, width: size.width, height: size.height))
            let imgViewThumbnail: UIImageView = UIImageView.init(frame: imgView.bounds)
            
            //imgView.image =
            imgView.backgroundColor = .clear
            imgViewThumbnail.contentMode = .scaleAspectFit
            imgView.addSubview(imgViewThumbnail)
            
           
           // imgView.bringSubviewToFront(imgView)
            if let url:URL = URL(string: banerdata[i]["titleimage"] ?? "")
            {
               imgViewThumbnail.sd_setImage(with: url, completed: nil)
               // imgViewThumbnail.image = UIImage(named: "newlogo")
            }
            let tap = UITapGestureRecognizer(target: self, action: #selector(cellTappedMethod(_:)))
            imgViewThumbnail.isUserInteractionEnabled = true
             imgViewThumbnail.tag = i
             imgViewThumbnail.addGestureRecognizer(tap)
            
            
            filterScrollView?.addSubview(imgView)
           
            
            //For Multiple player
            
            let player = AVPlayer(url: URL(string: banerdata[i]["videourl"] ?? "")!)
             let avPlayerLayer = AVPlayerLayer(player: player)
             avPlayerLayer.videoGravity = .resizeAspect
             avPlayerLayer.masksToBounds = true
             avPlayerLayer.cornerRadius = 5
             avPlayerLayer.frame = imgView.layer.bounds
             player.isMuted = true
             imgView.layer.addSublayer(avPlayerLayer)
           
            let button = UIButton(frame: CGRect(x: 30, y: self.Vinew.frame.size.height - 30, width: 20, height: 20))
                      // button.setTitle("mute", for: .normal)
                       button.setBackgroundImage(UIImage(named: "unmute"), for: .normal)
                       button.setTitleColor(.red, for: .normal)
                       button.tag = i
                       button.addTarget(self, action: #selector(mutevideo(_:)), for: .touchUpInside)
                       
                        imgView.addSubview(button)
            
            if banerdata[i]["isimage"] == "1"
            {
                button.isHidden = true
                avPlayerLayer.isHidden = true
                imgView.superview?.bringSubviewToFront(imgViewThumbnail)
            }else if banerdata[i]["isimage"] == "0"
            {
                 button.isHidden = false
                avPlayerLayer.isHidden = false
                imgView.superview?.sendSubviewToBack(imgViewThumbnail)
            }
            
                       imgView.superview?.bringSubviewToFront(button)
             filterPlayers.append(player)
            
        }
      
        filterScrollView?.isPagingEnabled = true
        filterScrollView?.contentSize = CGSize.init(width: CGFloat(banerdata.count) * size.width, height: size.height)
        filterScrollView?.backgroundColor = Appcolor.backgorund4
        filterScrollView?.delegate = self
        Vinew.addSubview(filterScrollView!)
            self.scheduledTimerWithTimeInterval()
        playVideos()
        }
    }
    @objc func cellTappedMethod(_ sender:AnyObject){
         print("you tap image number: \(sender.view.tag)")
      if  banerdata[sender.view.tag]["videourl"] == "1"
      {        guard let url = URL(string: banerdata[sender.view.tag]["actionurl"] ?? "") else { return }
          UIApplication.shared.open(url)
         
        
      }else if banerdata[sender.view.tag]["videourl"] == "2"
      {
        let storyBoard: UIStoryboard = UIStoryboard(name: "Main", bundle: nil)
                  let VC1 = storyBoard.instantiateViewController(withIdentifier: "FeedbackVC") as! FeedbackVC
                //https://funasia.net/bigfantvfeedback.funasia.net/addfeedback.html?
                
                //https://bigfantv.funasia.net/
                //https://funasia.net/bigfantv.funasia.net/
               VC1.planurl = banerdata[sender.view.tag]["actionurl"] ?? ""
                   
                let navController = UINavigationController(rootViewController: VC1) // Creating a navigation controller with VC1 at the root of the navigation stack.
                navController.navigationBar.barTintColor = Appcolor.backgorund4
                navController.modalPresentationStyle = .fullScreen
                 let textAttributes = [NSAttributedString.Key.foregroundColor:UIColor.white,NSAttributedString.Key.font: UIFont(name: "Muli-ExtraBold", size: 19)!]
                 navController.navigationBar.titleTextAttributes = textAttributes
                self.present(navController, animated:true, completion: nil)
        }
    }
    @objc func mutevideo( _ sender:UIButton)
    {
        for i in 0...filterPlayers.count - 1 {
                           if i == currentPage
                           {
                            if (filterPlayers[i])!.isMuted == true
                            {
                                sender.setBackgroundImage(UIImage(named: "unmute"), for: .normal)
                                (filterPlayers[i])!.isMuted = false
                            }else
                            {
                                sender.setBackgroundImage(UIImage(named: "mute"), for: .normal)
                                (filterPlayers[i])!.isMuted = true
                            }
                               
                                
                           }
                       }
    }
    func getThumbnailImage(forUrl url: URL) -> UIImage? {
        let asset: AVAsset = AVAsset(url: url)
        let imageGenerator = AVAssetImageGenerator(asset: asset)
        imageGenerator.appliesPreferredTrackTransform = true
        
        do {
            let thumbnailImage = try imageGenerator.copyCGImage(at: CMTimeMake(value: 1, timescale: 60) , actualTime: nil)
            return UIImage(cgImage: thumbnailImage)
        } catch let error {
            print(error)
        }
        
        return nil
    }
    
    func playVideos() {
        for i in 0...filterPlayers.count - 1 {
            playVideoWithPlayer((filterPlayers[i])!)
        }

        for i in 0...filterPlayers.count - 1 {
            if i != currentPage {
                (filterPlayers[i])!.pause()
            }
        }
    }
    
    func playVideoWithPlayer(_ player: AVPlayer) {
        player.playImmediately(atRate: 1.0)
       // player.play()
    }
   
   
   
    
    public func scrollViewDidScroll(_ scrollView: UIScrollView) {
        
        if scrollView == filterScrollView
        {
        let pageWidth : CGFloat = (filterScrollView?.frame.size.width)!
        let fractionalPage : Float = Float((filterScrollView?.contentOffset.x)! / pageWidth)
        let targetPage : NSInteger = lroundf(fractionalPage)
        
        if targetPage != currentPage {
            currentPage = targetPage
      
            for i in 0...filterPlayers.count - 1
            {
                if i == currentPage {
                    (filterPlayers[i])!.playImmediately(atRate: 1.0)
                } else {
                    (filterPlayers[i])!.pause()
                }
            }
        }
         
        
    }
    }
    
    func playVideoWithPlayer(_ player: AVPlayer, video:AVURLAsset, filterName:String) {
        
        let  avPlayerItem = AVPlayerItem(asset: video)
        
        if (filterName != "NoFilter") {
            let avVideoComposition = AVVideoComposition(asset: video, applyingCIFiltersWithHandler: { request in
                let source = request.sourceImage.clampedToExtent()
                let filter = CIFilter(name:filterName)!
                filter.setDefaults()
                filter.setValue(source, forKey: kCIInputImageKey)
                let output = filter.outputImage!
                request.finish(with:output, context: nil)
            })
            avPlayerItem.videoComposition = avVideoComposition
        }
        
        player.replaceCurrentItem(with: avPlayerItem)
        player.playImmediately(atRate: 1.0)
    }
    
    @objc func playerItemDidReachEnd(_ notification: Notification)
    {
 
                for i in 0...filterPlayers.count - 1 {
                    if i == currentPage {
                         
                        (filterPlayers[i])!.seek(to: CMTime.zero)
                        (filterPlayers[i])!.playImmediately(atRate: 1.0)
                    }
                }
    }
    
}

extension MovieNewVC:UICollectionViewDataSource,UICollectionViewDelegate
{
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
         if collectionView == sliderCollectionView
        {
            return self.banerdata.count
        }
        return 0

    }
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
          if collectionView == sliderCollectionView{
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cell", for: indexPath)
            if let vc = cell.viewWithTag(111) as? UIImageView {
                vc.sd_setImage(with: URL(string: banerdata[indexPath.row]["titleimage"] ?? ""), completed: nil)
            }
            return cell
        }
        return UICollectionViewCell()
    }
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath)
    {
          if collectionView == sliderCollectionView
        {
            if  banerdata[indexPath.row]["videourl"] == "1"
            {        guard let url = URL(string: banerdata[indexPath.row]["actionurl"] ?? "") else { return }
                UIApplication.shared.open(url)
               
              
            }
            else if  banerdata[indexPath.row]["videourl"] == "3"
            {
            //  self.getcontendeatilsbannerfor(permaas: banerdata[sender.view.tag]["permalink"] ?? "")
            }
            else if banerdata[indexPath.row]["videourl"] == "2"
            {
              let storyBoard: UIStoryboard = UIStoryboard(name: "Main", bundle: nil)
                        let VC1 = storyBoard.instantiateViewController(withIdentifier: "FeedbackVC") as! FeedbackVC
                      //https://funasia.net/bigfantvfeedback.funasia.net/addfeedback.html?
                      
                      //https://bigfantv.funasia.net/
                      //https://funasia.net/bigfantv.funasia.net/
                     VC1.planurl = banerdata[indexPath.row]["actionurl"] ?? ""
                         
                      let navController = UINavigationController(rootViewController: VC1) // Creating a navigation controller with VC1 at the root of the navigation stack.
                      navController.navigationBar.barTintColor = Appcolor.backgorund3
                      navController.modalPresentationStyle = .fullScreen
                       let textAttributes = [NSAttributedString.Key.foregroundColor:UIColor.white,NSAttributedString.Key.font: UIFont(name: "Muli-ExtraBold", size: 19)!]
                       navController.navigationBar.titleTextAttributes = textAttributes
                      self.present(navController, animated:true, completion: nil)
              }
        }
         
    }
    
}
