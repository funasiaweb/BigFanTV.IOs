//
//  SettingVC.swift
//  bigfantv
//
//  Created by Ganesh on 03/07/20.
//  Copyright © 2020 Ganesh. All rights reserved.
//

import UIKit

class SettingVC: UIViewController {

    @IBOutlet var ImgProfile: UIImageView!
    override func viewDidLoad() {
        super.viewDidLoad()

       
    }
    override func viewDidAppear(_ animated: Bool) {
               ImgProfile.layer.cornerRadius = ImgProfile.frame.size.height / 2
               ImgProfile.layer.borderColor = UIColor.white.cgColor
               ImgProfile.layer.borderWidth = 2
    }
 
   

}
