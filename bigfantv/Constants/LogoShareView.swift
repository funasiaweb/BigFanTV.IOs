//
//  LogoShareView.swift
//  SwiftRadio
//
//  Created by Cameron Mcleod on 2019-07-12.
//  Copyright © 2019 matthewfecher.com. All rights reserved.
//

import UIKit

class LogoShareView: UIView {
    
    @IBOutlet weak var albumArtImageView: UIImageView!
    @IBOutlet weak var radioShoutoutLabel: UILabel!
    @IBOutlet weak var trackTitleLabel: UILabel!
    @IBOutlet weak var trackArtistLabel: UILabel!
    @IBOutlet weak var logoImageView: UIImageView!
    
    class func instanceFromNib() -> LogoShareView {
        return UINib(nibName: "LogoShareView", bundle: nil).instantiate(withOwner: nil, options: nil)[0] as! LogoShareView
    }
    
    func shareSetup(albumArt : UIImage , trackTitle: String )
    {
        
          self.albumArtImageView.image = albumArt
          self.trackTitleLabel.text = trackTitle
        self.logoImageView.image = UIImage(named: "newlogo")
       
    }
}
