//
//  EducationCustom.swift
//  bigfantv
//
//  Created by Ganesh on 02/02/21.
//  Copyright © 2021 Ganesh. All rights reserved.
//

import UIKit

class EducationCustom: UIViewController {

    @IBOutlet var  engineeringconceptsCustomV: CustomView!
    @IBOutlet var  schooleducationCustomV: CustomView!
    @IBOutlet var  computeritCustomV: CustomView!
    @IBOutlet var  musicCustomV: CustomView!
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
        self.engineeringconceptsCustomV.LbTitle.text = "ENGINEERING CONCEPTS"
        self.schooleducationCustomV.LbTitle.text = "SCHOOL EDUCATION"
        self.computeritCustomV.LbTitle.text = "COMPUTER & IT"
        self.musicCustomV.LbTitle.text = "MUSIC"

        
    }
    func Loaddata()
          {
           Utility.ShowLoader(vc: self)
    
            Common.shared.getfeiltereddataother(category: "education-learn-with-us", subcategory:  "engineering-concepts") { (data, err) -> (Void) in
    
                self.engineeringconceptsCustomV.MovSubcategory =  "engineering-concepts"
               self.engineeringconceptsCustomV.Movcategory = "education-learn-with-us"
               self.engineeringconceptsCustomV.selftitle = "education-learn-with-us"
               self.engineeringconceptsCustomV.Isfrom = "othervideos"
               self.engineeringconceptsCustomV.isHidden = false
               DispatchQueue.main.async
                   {
                       self.engineeringconceptsCustomV.Muvidata = data
                       self.engineeringconceptsCustomV.reloadata()
                   }
               
           }
           
           Common.shared.getfeiltereddataother(category: "education-learn-with-us", subcategory: "school-education") { (data, err) -> (Void) in
               
 
               self.schooleducationCustomV.MovSubcategory = "school-education"
               self.schooleducationCustomV.Movcategory = "education-learn-with-us"
               self.schooleducationCustomV.selftitle = "school-education"
               self.schooleducationCustomV.Isfrom = "othervideos"
               self.schooleducationCustomV.isHidden = false
               DispatchQueue.main.async
                   {
               self.schooleducationCustomV.Muvidata = data
               self.schooleducationCustomV.reloadata()
               }
            }
           Common.shared.getfeiltereddataother(category: "education-learn-with-us", subcategory: "computer-amp-it") { (data, err) -> (Void) in
               self.IscompDatashown = true
               self.hideloader()
                self.computeritCustomV.MovSubcategory = "computer-amp-it"
                self.computeritCustomV.Movcategory = "education-learn-with-us"
                self.computeritCustomV.selftitle = "Computer & IT"
                self.computeritCustomV.Isfrom = "othervideos"
                self.computeritCustomV.isHidden = false
               DispatchQueue.main.async
                   {
                self.computeritCustomV.Muvidata = data
                self.computeritCustomV.reloadata()
               }
            }
           
           Common.shared.getfeiltereddataother(category: "education-learn-with-us", subcategory: "music") { (data, err) -> (Void) in
             self.IsmusicDatashown = true
             self.hideloader()
                self.musicCustomV.Movcategory = "education-learn-with-us"
                self.musicCustomV.MovSubcategory = "music"
                self.musicCustomV.selftitle = "Music"
                self.musicCustomV.Isfrom = "othervideos"
                self.musicCustomV.isHidden = false
               DispatchQueue.main.async
                   {
                self.musicCustomV.Muvidata = data
                self.musicCustomV.reloadata()
               }
            }
    }
    func hideloader()
    {
        if IscompDatashown == true || IsmusicDatashown == true
        {
            Utility.hideLoader(vc: self)
        }
    }
    
 
 
}
