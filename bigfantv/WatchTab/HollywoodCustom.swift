//
//  EducationCustom.swift
//  bigfantv
//
//  Created by Ganesh on 02/02/21.
//  Copyright © 2021 Ganesh. All rights reserved.
//

import UIKit
class HollywoodCustom: UIViewController {

    @IBOutlet var  GossipCustomV: CustomView!
    @IBOutlet var  schooleducationCustomV: CustomView!
    @IBOutlet var  CelebrityinterCustomV: CustomView!
    @IBOutlet var  movietrailers: CustomView!
    var IsmusicDatashown = false
    var IscompDatashown = false
     
    override func viewDidLoad() {
        super.viewDidLoad()
        if Connectivity.isConnectedToInternet()
        {
            self.Loaddata()
        }else
        {
            Utility.Internetconnection(vc: self)
        }
        
        self.GossipCustomV.LbTitle.text = "GOSSIP"
        self.movietrailers.LbTitle.text = "MOVIE TRAILERS"
        self.CelebrityinterCustomV.LbTitle.text = "CELEBRITY INTERVIEWS"
     }
    func Loaddata()
          {
           Utility.ShowLoader(vc: self)
        let requestGroup =  DispatchGroup()
     //Need as many of these statements as you have Alamofire.requests
            requestGroup.enter()
            requestGroup.enter()
            requestGroup.enter()
            Common.shared.getfeiltereddata(category: "hollywood", subcategory:  "gossip") { (data, err) -> (Void) in
    
                requestGroup.leave()
                self.GossipCustomV.MovSubcategory =  "gossip"
               self.GossipCustomV.Movcategory = "hollywood"
               self.GossipCustomV.selftitle = "hollywood"
               self.GossipCustomV.Isfrom = "othervideos"
               self.GossipCustomV.isHidden = false
               DispatchQueue.main.async
                   {
                       self.GossipCustomV.Muvidata = data
                       self.GossipCustomV.reloadata()
                   }
           }
           Common.shared.getfeiltereddata(category: "hollywood", subcategory: "celebrity-interviews1") { (data, err) -> (Void) in
            requestGroup.leave()
               self.IscompDatashown = true
               self.hideloader()
                self.CelebrityinterCustomV.MovSubcategory = "celebrity-interviews1"
                self.CelebrityinterCustomV.Movcategory = "hollywood"
                self.CelebrityinterCustomV.selftitle = "celebrity-interviews"
                self.CelebrityinterCustomV.Isfrom = "othervideos"
                self.CelebrityinterCustomV.isHidden = false
               DispatchQueue.main.async
                   {
                self.CelebrityinterCustomV.Muvidata = data
                self.CelebrityinterCustomV.reloadata()
               }
            }
           Common.shared.getfeiltereddata(category: "hollywood", subcategory: "movie-trailers1") { (data, err) -> (Void) in
            requestGroup.leave()
             self.IsmusicDatashown = true
             self.hideloader()
                self.movietrailers.Movcategory = "hollywood"
                self.movietrailers.MovSubcategory = "movie-trailers1"
                self.movietrailers.selftitle = "movie-trailers"
                self.movietrailers.Isfrom = "othervideos"
                self.movietrailers.isHidden = false
               DispatchQueue.main.async
                   {
                self.movietrailers.Muvidata = data
                self.movietrailers.reloadata()
               }
            }
            requestGroup.notify(queue: DispatchQueue.main, execute: {
                 // Hide HUD, refresh data, etc.
                  print("DEBUG: all Done")
             })
    }
    func hideloader()
    {
        if IscompDatashown == true || IsmusicDatashown == true
        {
            Utility.hideLoader(vc: self)
        }
    }
}
