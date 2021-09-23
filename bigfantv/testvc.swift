//
//  testvc.swift
//  bigfantv
//
//  Created by Ganesh on 02/07/20.
//  Copyright © 2020 Ganesh. All rights reserved.
//

import UIKit
import AVKit
//import MaterialComponents
import MaterialComponents.MaterialBottomNavigation

class testvc: UIViewController,MDCBottomNavigationBarDelegate{
    let bottomNavBar = MDCBottomNavigationBar()
   
    lazy var MovieController: MovieNewVC = {
        let mainstoryboard = UIStoryboard(name: "Main", bundle: Bundle.main)
         var viewController = mainstoryboard.instantiateViewController(withIdentifier: "MovieNewVC") as! MovieNewVC
    //   self.addViewControllerAsChildViewController(childViewController: viewController)
       return viewController
       
     }()
   
    lazy var LivetvController: LiveTVvc = {
        let mainstoryboard = UIStoryboard(name: "Main", bundle: Bundle.main)
           var viewController = mainstoryboard.instantiateViewController(withIdentifier: "LiveTVvc") as! LiveTVvc
         // self.addViewControllerAsChildViewController(childViewController: viewController)
         return viewController
         
       }()
    lazy var SeriesController: SeriesVC =
        {
             let mainstoryboard = UIStoryboard(name: "Main", bundle: Bundle.main)
        var viewController = mainstoryboard.instantiateViewController(withIdentifier: "SeriesVC") as! SeriesVC
    // self.addViewControllerAsChildViewController(childViewController: viewController)
      return viewController
      
    }()
    lazy var OthervideosController: OtherVideosCustom = {
        let mainstoryboard = UIStoryboard(name: "Main", bundle: Bundle.main)
           var viewController = mainstoryboard.instantiateViewController(withIdentifier: "OtherVideosCustom") as! OtherVideosCustom
         // self.addViewControllerAsChildViewController(childViewController: viewController)
         return viewController
         
       }()
    lazy var HollywoodController: HollywoodCustom = {
        let mainstoryboard = UIStoryboard(name: "Main", bundle: Bundle.main)
              var viewController = mainstoryboard.instantiateViewController(withIdentifier: "HollywoodCustom") as! HollywoodCustom
          //  self.addViewControllerAsChildViewController(childViewController: viewController)
            return viewController
            
          }()
    lazy var EducationController: EducationCustom = {
                 let mainstoryboard = UIStoryboard(name: "Main", bundle: Bundle.main)
                 var viewController = mainstoryboard.instantiateViewController(withIdentifier: "EducationCustom") as! EducationCustom
              // self.addViewControllerAsChildViewController(childViewController: viewController)
               return viewController
               
             }()
    lazy var BollywwodController: BollywoodnewVC = {
         
        let mainstoryboard = UIStoryboard(name: "Main", bundle: Bundle.main)
                    
        var viewController = mainstoryboard.instantiateViewController(withIdentifier: "BollywoodnewVC") as! BollywoodnewVC
                 // self.addViewControllerAsChildViewController(childViewController: viewController)
                  return viewController
                  
                }()
    
    
    @IBOutlet var Containerview: UIView!
    @IBOutlet var Viadd: UIView!
    @IBOutlet var Vitest: UIView!
    @IBOutlet var visegment: UIView!
    
    @IBOutlet var Visearch: UIView!
    
    @IBOutlet var ViCast: UIView!
    @IBOutlet var CollectionV: UICollectionView!
    @IBOutlet var tfSearch: UITextField!
    var searchdata:searchList?
    
    
    @IBOutlet var MovieV: UIView!
    @IBOutlet var LivtTvV: UIView!
    @IBOutlet var OtherVideosV: UIView!
    @IBOutlet var EducationV: UIView!
    @IBOutlet var HollywoodVV: UIView!
    @IBOutlet var BollywoodV: UIView!
    @IBOutlet var SeriesV:UIView!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        /*
        remove(asChildViewController:SeriesController)
        remove(asChildViewController:OthervideosController)
        remove(asChildViewController:HollywoodController)
        remove(asChildViewController:SixthController)
        remove(asChildViewController:BollywwodController)
        remove(asChildViewController:LivetvController)
        addViewControllerAsChildViewController(childViewController: MovieController)
        */
     //   MovieController.view.isHidden = false
        /*
         LivetvController.view.isHidden = true
         SeriesController.view.isHidden = true
        OthervideosController.view.isHidden = true
        HollywoodController.view.isHidden = true
        SixthController.view.isHidden = true
        BollywwodController.view.isHidden = true
        
      */
         MovieV.isHidden = true
         LivtTvV.isHidden = false
         OtherVideosV.isHidden = true
         EducationV.isHidden = true
         HollywoodVV.isHidden = true
         BollywoodV.isHidden = true
         SeriesV.isHidden = true
         addViewControllerAsChildViewController(views: MovieV, childViewController: MovieController)
        addViewControllerAsChildViewController(views: LivtTvV, childViewController: LivetvController)
        addViewControllerAsChildViewController(views: OtherVideosV, childViewController: OthervideosController)
        addViewControllerAsChildViewController(views: EducationV, childViewController: EducationController)
        addViewControllerAsChildViewController(views: HollywoodVV, childViewController: HollywoodController)
        addViewControllerAsChildViewController(views: BollywoodV, childViewController: BollywwodController)
        addViewControllerAsChildViewController(views: SeriesV, childViewController: SeriesController)
        
        
        let tabBar = MDCTabBar(frame: CGRect(x: 0, y:0, width: visegment.bounds.width , height: visegment.bounds.height))
               /*
         Live-tv
         Movies
         Bollywood
         Hollywood
         series
         other videos
         */
        tabBar.items = [
             UITabBarItem(title: "Live TV", image: UIImage(named: "heart"), tag: 1),
            UITabBarItem(title: "Movies", image: UIImage(named: "phone"), tag: 0),
           UITabBarItem(title: "Bollywood", image: UIImage(named: "phone"), tag: 4),
                      UITabBarItem(title: "Hollywood", image: UIImage(named: "heart"), tag: 5),
                      UITabBarItem(title: "Series", image: UIImage(named: "phone"), tag: 6),
            UITabBarItem(title: "Other Videos", image: UIImage(named: "heart"), tag: 2),
            UITabBarItem(title: "Education", image: UIImage(named: "heart"), tag: 3)
            
           
            
                           ]
        tabBar.itemAppearance = .titles
        tabBar.displaysUppercaseTitles = false
        tabBar.tintColor = UIColor(red: 0/255.0, green: 175/255.0, blue: 240/255.0, alpha: 1.0)
        tabBar.bottomDividerColor = UIColor.clear
        tabBar.selectedItemTintColor = UIColor(red: 0/255.0, green: 175/255.0, blue: 240/255.0, alpha: 1.0)
        tabBar.barTintColor = Appcolor.backgorund2
        tabBar.alignment = .leading
        tabBar.selectedItemTitleFont = UIFont(name: "Muli-Bold", size: 16)!
        tabBar.unselectedItemTitleFont = UIFont(name: "Muli-Bold", size: 16)!
        tabBar.delegate = self
        tabBar.autoresizingMask = [.flexibleWidth, .flexibleBottomMargin]
        tabBar.sizeToFit()
                      
        visegment.addSubview(tabBar)
        
        //   Viadd.frame = CGRect(x: 0, y: tabBar.frame.maxY - 10, width: view.bounds.width, height: UIScreen.main.bounds.height)
      
    }
    override func viewWillAppear(_ animated: Bool) {
         
    }
    override func viewDidAppear(_ animated: Bool)
    {
        setupAirPlayButton()
    }
    func setupAirPlayButton()
    {
             var buttonView: UIView? = nil
             let buttonFrame = CGRect(x: 0, y: 0, width: 48, height: 48)

             // It's highly recommended to use the AVRoutePickerView in order to avoid AirPlay issues after iOS 11.
             if #available(iOS 11.0, *)
           {
                 let airplayButton = AVRoutePickerView(frame: buttonFrame)
        
            
                 airplayButton.activeTintColor = UIColor.blue
            
                 airplayButton.tintColor = UIColor.white
               
            if #available(iOS 13.0, *) {
                airplayButton.prioritizesVideoDevices = true
            } else {
                // Fallback on earlier versions
            }
                 buttonView = airplayButton
             } else {
                 // If you still support previous iOS versions you can use MPVolumeView
               // let airplayButton = MPVolumeView(frame: buttonFrame)
                 //airplayButton.showsVolumeSlider = false
                // buttonView = airplayButton
             }
           
            
            ViCast.addSubview(buttonView ?? UIView())
             // If there are no AirPlay devices available, the button will not be displayed.
             let buttonItem = UIBarButtonItem(customView: buttonView!)
            // self.navigationItem.setRightBarButton(buttonItem, animated: true)
         }
    @IBAction func SearchBttapped(_ sender: UIButton)
    {
       
         
    }
    
    
    @IBAction func BtSearchTapped(_ sender: UIButton) {
        
        if !(tfSearch.text?.isEmpty ?? false)
        {
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
                                      
                                
                                   
                                   DispatchQueue.main.async
                                       {
                                       self.CollectionV.reloadData()
                                        UIView.animate(withDuration: 0.3) {
                                            self.CollectionV.isHidden = false
                                        }
                                       }
                                  
                               }
                               catch let error
                               {
                                   Utility.showAlert(vc: self, message:"\(error)", titelstring: Appcommon.Appname)
                               }
                           }
    }
    
    private func addViewControllerAsChildViewController(views:UIView, childViewController: UIViewController) {
 
        addChild(childViewController)
      views.addSubview(childViewController.view)
      
      childViewController.view.frame = views.bounds
      childViewController.view.autoresizingMask = [.flexibleWidth, .flexibleHeight]
      
      // Notify the childViewController, that you are going to add it into the Container-View -Controller
        childViewController.didMove(toParent: self)
      
    }
  private func remove(asChildViewController viewController: UIViewController) {
      // Notify Child View Controller
    viewController.willMove(toParent: nil)

      // Remove Child View From Superview
      viewController.view.removeFromSuperview()

      // Notify Child View Controller
    viewController.removeFromParent()
  }
}
extension testvc:MDCTabBarDelegate
{

    func tabBar(_ tabBar: MDCTabBar, didSelect item: UITabBarItem) {
     
        if item.tag == 0
        {
             
            MovieV.isHidden = false
            LivtTvV.isHidden = true
            OtherVideosV.isHidden = true
            EducationV.isHidden = true
            HollywoodVV.isHidden = true
            BollywoodV.isHidden = true
            SeriesV.isHidden = true
         
            
        }else if item.tag == 1
        {
             
            MovieV.isHidden = true
            LivtTvV.isHidden = false
            OtherVideosV.isHidden = true
            EducationV.isHidden = true
            HollywoodVV.isHidden = true
            BollywoodV.isHidden = true
            SeriesV.isHidden = true
         
        }
        else if item.tag == 2
        {
            MovieV.isHidden = true
            LivtTvV.isHidden = true
            OtherVideosV.isHidden = false
            EducationV.isHidden = true
            HollywoodVV.isHidden = true
            BollywoodV.isHidden = true
            SeriesV.isHidden = true
                  }
        else if item.tag == 3
        {
            MovieV.isHidden = true
            LivtTvV.isHidden = true
            OtherVideosV.isHidden = true
            EducationV.isHidden = false
            HollywoodVV.isHidden = true
            BollywoodV.isHidden = true
            SeriesV.isHidden = true
            
        }else if item.tag == 4
        {
            MovieV.isHidden = true
            LivtTvV.isHidden = true
            OtherVideosV.isHidden = true
            EducationV.isHidden = true
            HollywoodVV.isHidden = true
            BollywoodV.isHidden = false
            SeriesV.isHidden = true
            
            
        }
        else if item.tag == 5
        {
            MovieV.isHidden = true
            LivtTvV.isHidden = true
            OtherVideosV.isHidden = true
            EducationV.isHidden = true
            HollywoodVV.isHidden = false
            BollywoodV.isHidden = true
            SeriesV.isHidden = true
           
        }else if item.tag == 6
        {
            MovieV.isHidden = true
            LivtTvV.isHidden = true
            OtherVideosV.isHidden = true
            EducationV.isHidden = true
            HollywoodVV.isHidden = true
            BollywoodV.isHidden = true
            SeriesV.isHidden = false
           
        }
       
    }
    
}
