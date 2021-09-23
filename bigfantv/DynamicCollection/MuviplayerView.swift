//
//  CustomView.swift
//  UICollectionViewInUIView
//
//  Created by michal on 31/05/2019.
//  Copyright © 2019 borama. All rights reserved.
//

import UIKit
import MuviPlayer
@IBDesignable
class MuviplayerView: UIView {

    @IBOutlet var contentView: UIView!
    
    @IBOutlet var PlayerV: UIView!
    
     let playerview = MuviPlayerView()
    var isFullscreen = false
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        commonInit()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        commonInit()
    }
    
    private func commonInit()
    {
        let bundle = Bundle(for: type(of: self))
        bundle.loadNibNamed("MuviplayerView", owner: self, options: nil)
        addSubview(contentView)
        contentView.frame = bounds
        contentView.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        contentView.backgroundColor = .red
        PlayerV.backgroundColor = UIColor.green
        initmuviPlayer()
     }
    
    func  initmuviPlayer()
    {
        playerview.backgroundColor = Appcolor.backgorund4
        playerview.playbackDelegate = self
        playerview.useMuviPlayerControls = true
        playerview.controls?.airplayButton?.isHidden = true
        playerview.controls?.forwardButton?.isHidden = true
        playerview.controls?.rewindButton?.isHidden = true
        playerview.controls?.resolutionButton?.isHidden = true
        playerview.controls?.multipleAudioButton?.isHidden = true
        playerview.controls?.subtitleButton?.isHidden = true
        self.playerview.enablePlaybackSpeed = true
        playerview.frame = PlayerV.bounds
        playerview.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        PlayerV.addSubview(playerview)
     
        if let url = URL(string:   "https://d3b0pu5pa31rn8.cloudfront.net/45921/EncodedVideo/uploads/movie_stream/full_movie/630670/SHANKAR_IPS_144.mp4?Expires=1612841686&Signature=HqZGlcYB6FVH0ZcHO7BVoYrGnwye1xGRrB07~A4N~BrfKz1C-xLTTFUL1hAzLgmvO8zPRdn0nwt23jTEgJiWeOgD2BUlPxRaqgBwM~xDziwrTHaxSOYL7dKw0XVnVP0jfs6o7jbycye9g7e2UO6YX316N5aECrCn7Iggl8qAFyRcPT7e-Csyyt6l8sRdOiz2tNmfSowmVaOign86TJJD~nHFQ74aIOPAlFqyorajd4lPE8LOMtUPAPDFXkR0cfUbD6ju4z~8Ig0njVoh8Mi~svKoTobLz7bp7w6Ce1EE-GFbiB7pfJ3yWEC40vkz0F7Bj9p8721sOL4bE3QNY~vx9A__&Key-Pair-Id=APKAI7LE5J4L2WM2V57A")
        {
            let item = MuviPlayerItem(url: url)
            self.playerview.set(item: item)
           
            self.playerview.player.play()
        }
        
    }
    
    
}

 
extension MuviplayerView:MuviPlayerPlaybackDelegate
{
    func backButtonAction(player: MuviVideoPlayer, item: MuviPlayerItem?) {
        print("tapped")
        
        
    }
    
    func playbackDidBegin(player: MuviVideoPlayer) {
        print("started")
    }
    func playbackDidFailed(with error: MuviPlayerPlaybackError) {
        print(error)
    }
    
    
}
