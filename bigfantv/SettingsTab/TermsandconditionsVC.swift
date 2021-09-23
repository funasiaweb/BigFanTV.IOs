//
//  TermsandconditionsVC.swift
//  bigfantv
//
//  Created by iOS on 27/07/2021.
//  Copyright © 2021 Ganesh. All rights reserved.
//

import UIKit

class TermsandconditionsVC: UIViewController {

    @IBOutlet var Lbtitle:UILabel!
    var isfrom = 0
    
    override func viewDidLoad()
    {
        super.viewDidLoad()

        if isfrom == 0
        {
            self.title = "Terms And Conditions"
            self.Lbtitle.text = "This Agreement is entered into by and between BIG FAN TV, and the above listed client (hereinafter referred to as the ‘Client’)/Whereas, the CLIENT has obtained all required and appropriate consents from an individual or individuals to enable the Client to obtain consumer and investigative reports regarding such person or persons to be used to evaluate certain transactions between the Client and the consenting individual; AND WHEREAS, the Client wishes to use BIG FAN TV service provider obtain, purchase such reports and BIG FAN TV wishes to see such reports to the Client, on and subject to the terms of this agreement.NOW, THEREFORE, in consideration of of the mutual covenants set forth in this Agreement, and other good valuable consideration (receipt and sufficiency of which is hereby acknowledged by BIG FAN TV APP and the Client), BIG FAN TV App and the Client hereby covenant and agree as follows -"
        }else
        {
            self.title = "About Us"
            self.Lbtitle.text = "It’s so BIG, you can’t go anywhere else! Indian Entertainment at your doorstep. Enjoy Bollywood and beyond with the Big FAN App.\n Big FAN TV is one of North America’s leading OTTs with the biggest catalogue of South Asian movies and music. Our library boasts of a variety of Hindi, Punjabi, Gujarati, Marathi, Tamil, Telugu and Malayalam movies only a click away. Stream this unique collection anytime, anywhere and on devices like Apple TV, Roku, Android, Google Chromecast, iOS and Android Mobile devices. Share and heart these movies to build your personal collection for repeated viewing. If you thought this is it, you’re wrong. You can watch your favorite movies, listen to chartbusters and play the most exciting games here. This is your one stop for entertainment."
        }
     }
    override func viewDidAppear(_ animated: Bool) {
        let viewright = UIView(frame: CGRect(x:  0, y: 0, width: 50,height: 30))
        viewright.backgroundColor = UIColor.clear
                 
        var button: UIButton = UIButton(type: .custom)
        button = UIButton(frame: CGRect(x: 0,y: 0, width: 30, height: 30))
        button.setImage(UIImage(named: "backarrow"), for: UIControl.State.normal)
        button.addTarget(self, action: #selector(BackBtTaped), for: UIControl.Event.touchUpInside)
                     
        viewright.addSubview(button)
               
        let leftbuttton = UIBarButtonItem(customView: viewright)
        self.navigationItem.leftBarButtonItem = leftbuttton
        

    }
     
    @objc func BackBtTaped()
    {
        self.dismiss(animated: true, completion: nil)
        
    }

    

}
