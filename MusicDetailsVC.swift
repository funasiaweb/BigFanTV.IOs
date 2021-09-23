//
//  MusicDetailsVC.swift
//  bigfantv
//
//  Created by Ganesh on 01/08/20.
//  Copyright © 2020 Ganesh. All rights reserved.
//

import UIKit
import MaterialComponents.MDCTabBar
import SDWebImage
class MusicDetailsVC: UIViewController {

    @IBOutlet var ImgMovie: UIImageView!
       
       @IBOutlet var LbName: UILabel!
       @IBOutlet var LbCategory: UILabel!
       @IBOutlet var LbProduction: UILabel!
       @IBOutlet var LbWriter: UILabel!
       
       @IBOutlet var LbGener: UILabel!
       @IBOutlet var LbActors: UILabel!
       var ComedyMoviedata:newFilteredComedyMovieList?
       var ThrillerMoviedata:ThrillerMovieList?
       var ActionMoviedata:ActionMovieList?
       var comedydata = [newFilteredSubComedymovieList]()
       var thrillerdata = [subThrillermovieList]()
       var actiondata = [subActionmovieList]()
       
       @IBOutlet var LbTimenReleasedate: UILabel!
       @IBOutlet var LbLanguage: UILabel!
       
       @IBOutlet var LbDescription: UILabel!
       
           @IBOutlet var Viback: UIView!
           @IBOutlet var ViDetails: UIView!
           @IBOutlet var CollectionV: UICollectionView!
           @IBOutlet var ViTab: UIView!
        var contentdata:contentdetails?
        var perma = ""
        var playerUrl:URL?
        
           let sampledata:[sample] = [
             sample(img: "a11", labletext: "kolhapur"),
             sample(img: "a11", labletext: "kolhapur"),
            sample(img: "a11", labletext: "kolhapur"),
             sample(img: "a11", labletext: "kolhapur"),
             sample(img: "a11", labletext: "kolhapur"),
              sample(img: "a11", labletext: "kolhapur"),
             sample(img: "a11", labletext: "kolhapur"),
               ]
               
             
       
       var imagename = ""
       var moviename = ""
       var movietype = ""
       var timereleasedate  = ""
       var language = ""
       var movdescription: String = ""
       var imdbID = ""
       var IMDBdata:IMDBdataList?
           
               override func viewDidLoad() {
               super.viewDidLoad()
                   CollectionV.delegate = self
                   CollectionV.dataSource = self
                  
           }
          
           override func viewDidAppear(_ animated: Bool) {
              
               
               
               
               Timer.scheduledTimer(withTimeInterval: 0.1, repeats: false) { (t) in
                        if Connectivity.isConnectedToInternet()
                        {
                           
                           if self.imdbID != ""
                           {
                            self.GetrMoviedetails()
                           }else
                           {
                               self.LbName.text = self.moviename
                               self.ImgMovie.sd_setImage(with: URL(string: self.imagename), completed: nil)
                               self.LbDescription.text  = self.movdescription
                               self.LbTimenReleasedate.text = self.timereleasedate
                               self.LbLanguage.text  = self.language
                               
                           }
                        }else
                        {
                            Utility.Internetconnection(vc: self)
                        }
                    }
               
               let tabBar = MDCTabBar(frame: CGRect(x: 0, y:0, width: ViTab.bounds.width, height: 80))
                     tabBar.items = [
                     UITabBarItem(title: "Similar", image: UIImage(named: "phone"), tag: 0),
                     UITabBarItem(title: "More Details", image: UIImage(named: "heart"), tag: 1)
                     
                     ]
                     tabBar.itemAppearance = .titles
                     tabBar.displaysUppercaseTitles = false
                     tabBar.tintColor = .white
                     tabBar.bottomDividerColor = UIColor.gray
                     tabBar.selectedItemTintColor = .white
                     tabBar.barTintColor = .clear
                     tabBar.alignment = .justified
                     tabBar.selectedItemTitleFont = UIFont(name: "Muli-Bold", size: 18)!
                     tabBar.unselectedItemTitleFont = UIFont(name: "Muli-Bold", size: 16)!
                     tabBar.delegate = self
                     tabBar.autoresizingMask = [.flexibleWidth, .flexibleBottomMargin]
                     tabBar.sizeToFit()
               
                     ViTab.addSubview(tabBar)
           }
       
      
       
       
        
           @IBAction func BackBtTapped(_ sender: UIButton) {
               self.dismiss(animated: true, completion: nil)
           }
           
       }
       extension MusicDetailsVC:MDCTabBarDelegate
       {

           func tabBar(_ tabBar: MDCTabBar, didSelect item: UITabBarItem) {
               
               if item.tag == 0
               {
                   ViDetails.isHidden = true
                   CollectionV.isHidden = false
                  
                   
               }else if item.tag == 1
               {
                   ViDetails.isHidden = false
                   CollectionV.isHidden = true
               }
             
           }
           

           func GetrMoviedetails()
           {
                      
               Api.GetMovieDeatilsconent( imdbID, vc: self ) { (res, err) -> (Void) in
                               do
                               {
                                   let decoder = JSONDecoder()
                                  self.IMDBdata = try decoder.decode(IMDBdataList.self, from: res  ?? Data())
                                   self.LbName.text = self.IMDBdata?.Title
                                   self.LbCategory.text = self.IMDBdata?.Genre
                                   self.ImgMovie.sd_setImage(with: URL(string: self.IMDBdata?.Poster ?? ""), completed: nil)
                                   self.LbTimenReleasedate.text = "\(self.IMDBdata?.Runtime ?? "") | \(self.IMDBdata?.Released ?? "")"
                                   self.LbLanguage.text  = self.IMDBdata?.Language
                                   self.LbActors.text = self.IMDBdata?.Actors
                                   self.LbWriter.text = self.IMDBdata?.Director
                                   self.LbProduction.text = self.IMDBdata?.Production
                                   self.LbGener.text = self.IMDBdata?.Genre
                                  
                                  
                               }
                               catch let error
                               {
                                   Utility.showAlert(vc: self, message:"\(error)", titelstring: Appcommon.Appname)
                               }
                           }
                 }
           
       }

       extension MusicDetailsVC:UICollectionViewDelegate,UICollectionViewDataSource
       {
             func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
                
              return 0
                  
             }
             
             func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
                
                if let Comedycell = collectionView.dequeueReusableCell(withReuseIdentifier: "cell", for: indexPath)as? MovieCell
                {
                 //cell.ImgSample.contentMode = .scaleAspectFill
                             
                 
               
                
                 return Comedycell
               }
                    
                 
                 
                 return UICollectionViewCell()
             }
       }
          
       extension MusicDetailsVC: UICollectionViewDelegateFlowLayout {
               func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
                /*
                if UIDevice.current.userInterfaceIdiom == .pad {
                            return CGSize(width: 180, height: collectionView.frame.size.height)
                          } else if UIDevice.current.userInterfaceIdiom == .phone  {
                   return CGSize(width: 156, height: collectionView.frame.size.height)
                            
                          }
                   */
                   return CGSize(width: 156, height: collectionView.frame.size.height)
               }
           }
        
