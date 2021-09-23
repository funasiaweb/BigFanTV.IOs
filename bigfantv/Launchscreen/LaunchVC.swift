//
//  LaunchVC.swift
//  bigfantv
//
//  Created by Ganesh on 09/07/20.
//  Copyright © 2020 Ganesh. All rights reserved.
//

import UIKit
import MaterialComponents.MDCButton
class LaunchVC: UIViewController {

    @IBOutlet var BtCreate: MDCButton!
    @IBOutlet var BtLogin: MDCButton!
    override func viewDidLoad() {
        super.viewDidLoad()

        
        
    }
    override func viewDidAppear(_ animated: Bool) {
        
             BtLogin.layer.cornerRadius = BtLogin.frame.size.height / 2
             BtLogin.layer.borderColor = UIColor.clear.cgColor
             BtLogin.layer.borderWidth = 0.2
        
             BtCreate.layer.cornerRadius = BtCreate.frame.size.height / 2
             BtCreate.layer.borderColor = UIColor.clear.cgColor
             BtCreate.layer.borderWidth = 0.2
        
    }
    
 

}
