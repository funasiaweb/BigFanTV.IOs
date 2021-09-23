//
//  MuviAudioplayerVC.swift
//  bigfantv
//
//  Created by iOS on 24/05/2021.
//  Copyright © 2021 Ganesh. All rights reserved.
//

import UIKit
import MuviAudioPlayer
class MuviAudioplayerVC: UIViewController,MuviAudioPlayerDelegate
{
     var muviPlayer = MuviAudioMiniView()
   var manager = MuviAudioPlayerManager()
    override func viewDidLoad()
    {
        super.viewDidLoad()
        
        
        var MuviPlayer =    MuviAudioPlayerManager.shared.muviAudioMiniView!
       
        MuviPlayer.frame = CGRect(x: 20, y: 100, width: 300, height: 50)
        view.addSubview(MuviPlayer)
        guard let songurl = URL(string: "https://funasia.streamguys1.com/live-1") else {return}
        guard let songImageurl = URL(string: "https://d73o4i22vgk5h.cloudfront.net/45921/public/public/system/posters/517657/thumb/c3_1595496288.jpg") else {return}

        let song = MuviAudioPlayerItemInfo(id: "",
                                                    url: songurl,
                                                    title: "title audio",
                                                    albumTitle: "<AUdio Subtitle>",
                                                    coverImageURL: songImageurl)
        MuviAudioPlayerManager.shared.setup(with:[song])
    }
    override func viewWillAppear(_ animated: Bool)
    {
         MuviAudioPlayerManager.shared.playbackDelegate = self
    }
    override func viewDidAppear(_ animated: Bool) {
      
        
        // view.addSubview(muviPlayer)
    }
    func muviAudioPlayerManager(_ playerManager: MuviAudioPlayerManager,
    progressDidUpdate percentage: Double) {
       print("percentage: \(percentage * 100)")
    }
    func muviAudioPlayerManager(_ playerManager: MuviAudioPlayerManager,
    itemDidChange itemIndex: Int) {
        print("itemIndex: \(itemIndex)")
    }
    func muviAudioPlayerManager(_ playerManager: MuviAudioPlayerManager,
    statusDidChange status: MuviAudioPlayerStatus) {
       print("status: \(status)")
    }
    func getCoverImage(_ player: MuviAudioPlayerManager, _ callBack: @escaping
    (UIImage?) -> Void) {
    }
    func muviAudioPlayerAuthentication(code: Int, message: String) {
        print("Code: \(code) ::: \(message)")
    }
}
