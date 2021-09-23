//
//  LivesViewController.swift
//  Outquiz
//
//  Created by Vasily Evreinov on 02.04.2018.
//  Copyright © 2018 UniProgy s.r.o. All rights reserved.
//

import UIKit

class LivesViewController: BaseViewController {
    
    @IBOutlet weak var infoLabel: UILabel!
    @IBOutlet weak var codeTitleLabel: UILabel!
    @IBOutlet weak var codeButton: UIButton!
    
    // MARK: - Buttons
    
    @IBAction func codeButtonTap(_ sender: Any) {
       // let shareText = String(format:NSLocalizedString("share_text", comment: ""),
                              // Bundle.main.infoDictionary![kCFBundleNameKey as String] as! String,
                             //  Misc.currentPlayer!.referral!,
                             //  Config.shared.data["app.host"]!)
        let refereal  = Misc.currentPlayer!.referral!
        let shareText = "Please download BigFAn Tv app to signup and enter the referrel code '\(refereal)' for playing the game."
        
        let activityController = UIActivityViewController(activityItems: [shareText], applicationActivities: nil)
        self.present(activityController, animated: true, completion: nil)
    }
    
    // MARK: - View
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureView()
    }

    func configureView() {
        // look
        self.view.backgroundColor = UIColor(cfgName: "colors.system.background")
        infoLabel.textColor = UIColor(cfgName: "colors.system.text")
        codeTitleLabel.textColor = UIColor(cfgName: "colors.system.text").withAlphaComponent(0.5)
        codeButton.backgroundColor = UIColor(cfgName: "colors.system.button.background")
        codeButton.setTitleColor(UIColor(cfgName: "colors.system.button.text"), for: .normal)
        view.viewWithTag(1)?.tintColor = UIColor(cfgName: "colors.lives.icon")
        
        // translations
        infoLabel.text = NSLocalizedString("Please share this code to your friends and every friend who downloads app and plays this game wins daily cash prizes.  He gets extra life and you get extra life.", comment: "")
        codeTitleLabel.text = NSLocalizedString("your referral code", comment: "").uppercased()
        codeButton.setTitle(Misc.currentPlayer?.referral, for: .normal)
        
        // navigation close button
        navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .done, target: self, action: #selector(closePopup))
    }
    
    @objc func closePopup()
    {
        self.dismiss(animated: true, completion: nil)
    }

}
