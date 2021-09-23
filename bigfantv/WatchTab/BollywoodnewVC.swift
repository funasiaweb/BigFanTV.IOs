//
//  BollywoodnewVC.swift
//  bigfantv
//
//  Created by iOS on 09/07/2021.
//  Copyright © 2021 Ganesh. All rights reserved.
//

import UIKit

class BollywoodnewVC: UIViewController {

    @IBOutlet var factsCustomV: CustomView!
    @IBOutlet var behindthescenesCustomV: CustomView!

    @IBOutlet var photoshootsCustomV: CustomView!

    @IBOutlet var rarefootageCustomV: CustomView!
    @IBOutlet var interviewsCustomV: CustomView!
    @IBOutlet var launchesCustomV: CustomView!
    @IBOutlet var flashbackCustomV: CustomView!
    @IBOutlet var movietrailersCustomV: CustomView!
    @IBOutlet var moviereviewsCustomV: CustomView!
    @IBOutlet var celebrityinterviewsCustomV: CustomView!
    @IBOutlet var bollywoodgossipsCustomV: CustomView!
    @IBOutlet var makingofbollywoodCustomV: CustomView!

    
    override func viewDidLoad()
    {
        super.viewDidLoad()
        
        self.factsCustomV.LbTitle.text = "FACTS"
        self.behindthescenesCustomV.LbTitle.text = "BEHIND THE SCENES"
        self.photoshootsCustomV.LbTitle.text = "PHOTOSHOOT"
        self.rarefootageCustomV.LbTitle.text = "RARE FOOTAGE"
        self.interviewsCustomV.LbTitle.text = "INTERVIEW"
        self.launchesCustomV.LbTitle.text = "LAUNCHES"
        self.flashbackCustomV.LbTitle.text = "FLASHBACKS"
        self.movietrailersCustomV.LbTitle.text = "MOVIE TRAILERS"
        self.moviereviewsCustomV.LbTitle.text = "MOVIE REVEIWS"
        self.celebrityinterviewsCustomV.LbTitle.text = "CELEBRITY INTERVIEWS"
        self.bollywoodgossipsCustomV.LbTitle.text = "BOLLYWOOD GOSSIPS"
        self.makingofbollywoodCustomV.LbTitle.text = "MAKING OF MOVIES"
        
        if Connectivity.isConnectedToInternet()
        {
            self.Loaddata()
        }else
        {
            Utility.Internetconnection(vc: self)
        }

     }
    func Loaddata()
    {
        self.factsCustomV.loadallcontents(muvcategory: "bollywood-videos", muvsubcategory:  "facts", title: "FACTS")
        self.behindthescenesCustomV.loadallcontents(muvcategory: "bollywood-videos", muvsubcategory:  "behind-the-scenes", title: "BEHIND THE SCENES")
        self.photoshootsCustomV.loadallcontents(muvcategory:"bollywood-videos", muvsubcategory:  "photoshoots", title: "PHOTOSHOOT")
        self.rarefootageCustomV.loadallcontents(muvcategory:"bollywood-videos", muvsubcategory:  "rare-footage", title: "RARE FOOTAGE")
         self.interviewsCustomV.loadallcontents(muvcategory: "bollywood-videos", muvsubcategory:  "interviews", title: "INTERVIEW")
        self.launchesCustomV.loadallcontents(muvcategory: "bollywood-videos", muvsubcategory:  "launches", title: "LAUNCHES")
        self.flashbackCustomV.loadallcontents(muvcategory:  "bollywood-videos", muvsubcategory:  "flashback", title: "FLASHBACKS")
        self.movietrailersCustomV.loadallcontents(muvcategory: "movie-trailers", muvsubcategory:  "", title: "MOVIE TRAILERS")
        self.moviereviewsCustomV.loadallcontents(muvcategory:"movie-reviews", muvsubcategory:  "", title: "MOVIE REVEIWS")
        self.celebrityinterviewsCustomV.loadallcontents(muvcategory: "celebrity-interviews", muvsubcategory:  "", title: "CELEBRITY INTERVIEWS")
        self.bollywoodgossipsCustomV.loadallcontents(muvcategory: "bollywood-gossips", muvsubcategory:  "", title: "BOLLYWOOD GOSSIPS")
        self.makingofbollywoodCustomV.loadallcontents(muvcategory: "bollywood-videos", muvsubcategory:  "making-of-movies", title: "MAKING OF MOVIES")
       
    }
 
}
