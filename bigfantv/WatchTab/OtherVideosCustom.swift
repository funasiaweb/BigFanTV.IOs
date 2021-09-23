//
//  OtherVideosCustom.swift
//  bigfantv
//
//  Created by Ganesh on 01/02/21.
//  Copyright © 2021 Ganesh. All rights reserved.
//

import UIKit
import Alamofire
class OtherVideosCustom: UIViewController
{
     @IBOutlet var  comedyCustomV: CustomView!
    @IBOutlet var  standupcomedyCustomV: CustomView!
    @IBOutlet var  poetryCustomV: CustomView!
    @IBOutlet var  newsCustomV: CustomView!
    @IBOutlet var  lifestyleandtrendsCustomV: CustomView!
    @IBOutlet var  spiritualandmotivationCustomV: CustomView!
    @IBOutlet var  fashionCustomV: CustomView!
    @IBOutlet var   foodrecipesCustomV: CustomView!
    @IBOutlet var  diycraftsCustomV: CustomView!
    @IBOutlet var  kidsCustomV: CustomView!
    @IBOutlet var  sportsCustomV: CustomView!
    @IBOutlet var  technologyCustomV: CustomView!
    @IBOutlet var  healthcareremediesCustomV: CustomView!
   
    @IBOutlet var  religiousCustomV: CustomView!
    @IBOutlet var  gameplayCustomV: CustomView!
    @IBOutlet var  gametrailersCustomV: CustomView!
    
     var IsComedycustomloaded = false
     var IsstandupComedycustomloaded = false
     var Ispoetrycustomloaded = false
    

    override func viewDidLoad()
    {
        super.viewDidLoad()

        if Connectivity.isConnectedToInternet()
        {
             Utility.ShowLoader(vc: self)
           // self.Loaddata()
             
        }else
        {
            Utility.Internetconnection(vc: self)
        }
        self.comedyCustomV.LbTitle.text = "COMEDY"
        self.standupcomedyCustomV.LbTitle.text = "STANDUP COMEDY"
        self.poetryCustomV.LbTitle.text = "POETRY"
        self.newsCustomV.LbTitle.text = "NEWS"
        self.lifestyleandtrendsCustomV.LbTitle.text = "LIFESTYLE & TRENDS"
        self.spiritualandmotivationCustomV.LbTitle.text = "SPIRTUAL & MOTIVATION"
        self.fashionCustomV.LbTitle.text = "FASHION"
        self.foodrecipesCustomV.LbTitle.text = "FOOD & RECIPES"
        self.diycraftsCustomV.LbTitle.text = "DIY & CRAFTS"
        self.kidsCustomV.LbTitle.text = "KIDS"
        self.sportsCustomV.LbTitle.text = "SPORTS"
        self.technologyCustomV.LbTitle.text = "TECHNOLOGY"
        self.healthcareremediesCustomV.LbTitle.text = "HEALTHCARE & REMEDIES"
        self.religiousCustomV.LbTitle.text = "RELIGIOUS"
        self.gametrailersCustomV.LbTitle.text = "GAME TRAILERS"
        self.gameplayCustomV.LbTitle.text = "GAMEPLAYS"
        

    }
    override func viewDidAppear(_ animated: Bool) {
  
        if Connectivity.isConnectedToInternet()
        {
            Timer.scheduledTimer(withTimeInterval: 0.02, repeats: false) { (t) in
                
            self.Loaddata()
            }
             
        }else
        {
            Utility.Internetconnection(vc: self)
        }
    }
 
    func Loaddata()
       {
       
 
         Common.shared.getfeiltereddataother(category: "standup-comedy", subcategory: "") { (data, err) -> (Void) in
    
            self.IsstandupComedycustomloaded = true
            self.Hideloader()
            self.standupcomedyCustomV.Movcategory = "standup-comedy"
            self.standupcomedyCustomV.selftitle = "Standup-Comedy"
            self.standupcomedyCustomV.Isfrom = "othervideos"
            self.standupcomedyCustomV.isHidden = false
            DispatchQueue.main.async
                {
                    self.standupcomedyCustomV.Muvidata = data
                    self.standupcomedyCustomV.reloadata()
                }
            
        }
        
        Common.shared.getfeiltereddataother(category: "poetry", subcategory: "") { (data, err) -> (Void) in
            
            self.Ispoetrycustomloaded = true
            self.Hideloader()
            self.poetryCustomV.Movcategory = "poetry"
            self.poetryCustomV.selftitle = "Poetry"
            self.poetryCustomV.Isfrom = "othervideos"
            self.poetryCustomV.isHidden = false
            DispatchQueue.main.async
                {
            self.poetryCustomV.Muvidata = data
            self.poetryCustomV.reloadata()
            }
         }
        Common.shared.getfeiltereddataother(category: "religious", subcategory: "") { (data, err) -> (Void) in
            self.IsComedycustomloaded = true
            self.Hideloader()
             self.religiousCustomV.Movcategory = "religious"
             self.religiousCustomV.selftitle = "Religious"
             self.religiousCustomV.Isfrom = "othervideos"
             self.religiousCustomV.isHidden = false
            DispatchQueue.main.async
                {
             self.religiousCustomV.Muvidata = data
             self.religiousCustomV.reloadata()
            }
         }
        
        Common.shared.getfeiltereddataother(category: "news", subcategory: "") { (data, err) -> (Void) in
             self.newsCustomV.Movcategory = "news"
             self.newsCustomV.selftitle = "News"
             self.newsCustomV.Isfrom = "othervideos"
             self.newsCustomV.isHidden = false
            DispatchQueue.main.async
                {
             self.newsCustomV.Muvidata = data
             self.newsCustomV.reloadata()
            }
         }
        Common.shared.getfeiltereddataother(category: "lifestyle-amp-trends", subcategory: "") { (data, err) -> (Void) in
             self.lifestyleandtrendsCustomV.Movcategory = "lifestyle-amp-trends"
             self.lifestyleandtrendsCustomV.selftitle = "Lifestyle & trends"
             self.lifestyleandtrendsCustomV.Isfrom = "othervideos"
             self.lifestyleandtrendsCustomV.isHidden = false
                        DispatchQueue.main.async
                {
             self.lifestyleandtrendsCustomV.Muvidata = data
             self.lifestyleandtrendsCustomV.reloadata()
            }
         }
        Common.shared.getfeiltereddataother(category: "spiritual-amp-motivation", subcategory: "") { (data, err) -> (Void) in
             self.spiritualandmotivationCustomV.Movcategory = "spiritual-amp-motivation"
             self.spiritualandmotivationCustomV.selftitle = "Spiritual & Motivation"
             self.spiritualandmotivationCustomV.Isfrom = "othervideos"
             self.spiritualandmotivationCustomV.isHidden = false
            DispatchQueue.main.async
                {
             self.spiritualandmotivationCustomV.Muvidata = data
             self.spiritualandmotivationCustomV.reloadata()
            }
         }
           Common.shared.getfeiltereddataother(category: "fashion", subcategory: "") { (data, err) -> (Void) in
                self.fashionCustomV.Movcategory = "fashion"
                self.fashionCustomV.selftitle = "Fashion"
                self.fashionCustomV.Isfrom = "othervideos"
                self.fashionCustomV.isHidden = false
            DispatchQueue.main.async
                {
                self.fashionCustomV.Muvidata = data
                self.fashionCustomV.reloadata()
            }
            }
        Common.shared.getfeiltereddataother(category: "food-amp-recipes", subcategory: "") { (data, err) -> (Void) in
             self.foodrecipesCustomV.Movcategory = "food-amp-recipes"
             self.foodrecipesCustomV.selftitle = "food & recipes"
             self.foodrecipesCustomV.Isfrom = "othervideos"
             self.foodrecipesCustomV.isHidden = false
            DispatchQueue.main.async
                {
             self.foodrecipesCustomV.Muvidata = data
             self.foodrecipesCustomV.reloadata()
            }
         }
        Common.shared.getfeiltereddataother(category: "diy-amp-crafts", subcategory: "") { (data, err) -> (Void) in
             self.diycraftsCustomV.Movcategory = "diy-amp-crafts"
             self.diycraftsCustomV.selftitle = "diy & crafts"
             self.diycraftsCustomV.Isfrom = "othervideos"
             self.diycraftsCustomV.isHidden = false
             self.diycraftsCustomV.Muvidata = data
             self.diycraftsCustomV.reloadata()
         }
        Common.shared.getfeiltereddataother(category: "kids", subcategory: "") { (data, err) -> (Void) in
             self.kidsCustomV.Movcategory = "kids"
             self.kidsCustomV.selftitle = "Kids"
             self.kidsCustomV.Isfrom = "othervideos"
             self.kidsCustomV.isHidden = false
            DispatchQueue.main.async
                {
             self.kidsCustomV.Muvidata = data
             self.kidsCustomV.reloadata()
            }
         }
        
        Common.shared.getfeiltereddataother(category: "sports", subcategory: "") { (data, err) -> (Void) in
             self.sportsCustomV.Movcategory = "sports"
             self.sportsCustomV.selftitle = "Sports"
             self.sportsCustomV.Isfrom = "othervideos"
             self.sportsCustomV.isHidden = false
            DispatchQueue.main.async
                {
             self.sportsCustomV.Muvidata = data
             self.sportsCustomV.reloadata()
            }
         }
        Common.shared.getfeiltereddataother(category: "comedy", subcategory: "") { (data, err) -> (Void) in
               
            DispatchQueue.main.async
                {
               self.comedyCustomV.Muvidata = data
               self.comedyCustomV.reloadata()
            }

               self.comedyCustomV.Movcategory = "comedy"
               self.comedyCustomV.selftitle = "Comedy"
               self.comedyCustomV.Isfrom = "othervideos"
               self.comedyCustomV.isHidden = false
               
             }
           Common.shared.getfeiltereddataother(category: "technology", subcategory: "") { (data, err) -> (Void) in
                self.technologyCustomV.Movcategory = "technology"
                self.technologyCustomV.selftitle = "Technology"
                self.technologyCustomV.Isfrom = "othervideos"
                self.technologyCustomV.isHidden = false
            DispatchQueue.main.async
                {
                self.technologyCustomV.Muvidata = data
                self.technologyCustomV.reloadata()
            }
            }
        Common.shared.getfeiltereddataother(category: "healthcare-amp-remedies", subcategory: "") { (data, err) -> (Void) in
             self.healthcareremediesCustomV.Movcategory = "healthcare-amp-remedies"
             self.healthcareremediesCustomV.selftitle = "healthcare & remedies"
             self.healthcareremediesCustomV.Isfrom = "othervideos"
             self.healthcareremediesCustomV.isHidden = false
            DispatchQueue.main.async
                {
             self.healthcareremediesCustomV.Muvidata = data
             self.healthcareremediesCustomV.reloadata()
            }
         }

        Common.shared.getfeiltereddataother(category: "gaming", subcategory: "gameplay") { (data, err) -> (Void) in
             self.gameplayCustomV.Movcategory = "gaming"
             self.gameplayCustomV.selftitle = "gameplay"
             self.gametrailersCustomV.MovSubcategory = "game-tragameplayilers"
             self.gameplayCustomV.isHidden = false
             self.gameplayCustomV.Isfrom = "othervideos"
            DispatchQueue.main.async
                {
             self.gameplayCustomV.Muvidata = data
             self.gameplayCustomV.reloadata()
            }
         }
        Common.shared.getfeiltereddataother(category: "gaming", subcategory: "game-trailers") { (data, err) -> (Void) in
             self.gametrailersCustomV.Movcategory = "gaming"
             self.gametrailersCustomV.selftitle = "Game-trailers"
             self.gametrailersCustomV.MovSubcategory = "game-trailers"
             self.gametrailersCustomV.isHidden = false
             self.gametrailersCustomV.Muvidata = data
            DispatchQueue.main.async
                {
             self.gametrailersCustomV.Isfrom = "othervideos"
             self.gametrailersCustomV.reloadata()
            }
         }

        
    }
    func Hideloader()
    {
        if IsComedycustomloaded == true || IsstandupComedycustomloaded == true || Ispoetrycustomloaded == true
        {
            Utility.hideLoader(vc: self)
        }
    }
}
