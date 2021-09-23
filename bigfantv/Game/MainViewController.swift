//
//  MainViewController.swift
//  Outquiz
//
//  Created by Vasily Evreinov on 16.03.2018.
//  Copyright © 2018 UniProgy s.r.o. All rights reserved.
//

import UIKit

class MainViewController: BaseViewController {
    
    // MARK: - View
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    @IBAction func PlayBtTapped(_ sender: UIButton) {
    if(Misc.currentPlayer == nil)
        {
            performSegue(withIdentifier: "MainToLogin", sender: self)
        } else {
            if(Misc.currentPlayer?.username == nil) {
                let storyboard = UIStoryboard(name: "Login", bundle: nil)
                let controller = storyboard.instantiateViewController(withIdentifier: "Profile") as! ProfileViewController
                let navigationController = UINavigationController(rootViewController: controller)
                navigationController.modalPresentationStyle = .fullScreen
                self.present(navigationController, animated: true, completion: nil)
            } else {
               
                performSegue(withIdentifier: "MainToHome", sender: self)
            }
        }
    
    }
    
}
