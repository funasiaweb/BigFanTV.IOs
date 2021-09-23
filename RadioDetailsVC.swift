//
//  RadioDetailsVC.swift
//  bigfantv
//
//  Created by Ganesh on 17/07/20.
//  Copyright © 2020 Ganesh. All rights reserved.
//

import UIKit
import MuviPlayer
import Alamofire
class RadioDetailsVC: UIViewController {

       
        @IBOutlet var CollectionV: UICollectionView!
        
    @IBOutlet var BtFavourite: UIButton!
    @IBOutlet var Viback: UIView!
    let sampledata:[sample] = [
          sample(img: "ra1", labletext: "kolhapur"),
          sample(img: "ra1", labletext: "kolhapur"),
         sample(img: "ra1", labletext: "kolhapur"),
          sample(img: "ra1", labletext: "kolhapur"),
          sample(img: "ra1", labletext: "kolhapur")
           
            ]
             let playerview = MuviPlayerView()
           var Videourl = ""
           var Videotitle = ""
    var radioid = ""
    var isfavourite = "0"
          
    @IBOutlet var LbTitle: UILabel!
    @IBOutlet var ViPlayer: UIView!
    
            override func viewDidLoad() {
            super.viewDidLoad()
                
                LbTitle.text = Videotitle
                print("Videourl===\(Videourl)")
                
               self.playerview.frame = CGRect(x: 0, y:0, width:self.ViPlayer.frame.size.width, height:self.ViPlayer.frame.size.height)
              self.playerview.backgroundColor = .black
              self.ViPlayer.addSubview(self.playerview)
                 
                self.playerview.playbackDelegate = self
                self.playerview.useMuviPlayerControls = true
                 self.playerview.controls?.showBuffering()
                 self.playerview.controls?.multipleAudioButton?.isHidden = true
                 self.playerview.controls?.subtitleButton?.isHidden = true
                 self.playerview.controls?.pollingCardButton.isHidden = true
                 self.playerview.controls?.pipButton?.isHidden = true
                 self.playerview.controls?.multipleAudioButton?.set(active: false)
                 self.playerview.controls?.subtitleButton?.set(active: false)
                                      
                                                  self.playerview.controls?.playPauseButton?.set(active: true)
                                                  self.playerview.controls?.pipButton?.isHidden = false
                                                  self.playerview.controls?.fullscreenButton?.isHidden = false
                                                  self.playerview.controls?.fullscreenButton?.set(active: true)
                                                  self.playerview.controls?.forwardButton?.isHidden = false
                                                  self.playerview.controls?.rewindButton?.isHidden = false
                                                  self.playerview.controls?.rewindButton?.set(active: true)
                                                  self.playerview.controls?.resolutionButton?.isHidden = false
                                                  self.playerview.enablePlaybackSpeed = true
                                           

                                                 if let url = URL(string:  Videourl)
                                                  {
                                                      let item = MuviPlayerItem(url: url)
                                                      self.playerview.set(item: item)
                                                    
                                                      self.playerview.player.play()
                                                   }
        }
         
    
    override func viewWillAppear(_ animated: Bool) {
        
       if isfavourite == "0"
       {
          self.BtFavourite.setBackgroundImage(UIImage(named: "like"), for: .normal)
        }else
       {
         self.BtFavourite.setBackgroundImage(UIImage(named: "liked"), for: .normal)
       }
    }
        @IBAction func BackBtTapped(_ sender: UIButton) {
            self.dismiss(animated: true, completion: nil)
        }
        
    @IBAction func BtFavouritetapped(_ sender: UIButton) {
        if Connectivity.isConnectedToInternet()
        {
            if self.isfavourite == "0"
            {
               favouriteradio(isfav: "1")
            }else if self.isfavourite == "1"
            {
                
                favouriteradio(isfav: "0")
            }
            
        }else
        {
            Utility.Internetconnection(vc: self)
        }
    }
    func favouriteradio(isfav:String)
    {
        
        guard let url:URL = URL(string: "https://funasia.net/bigfantv.funasia.net/service/getIsFavouriteRadio.html") else {return}
    guard let parameters =
        [
            "radioId": radioid,
            "isFavourite": isfav,
          "userId":UserDefaults.standard.string(forKey: "id") ?? "",
           "AccessToken":UserDefaults.standard.string(forKey:"AccessToken") ?? ""
           
            ] as? [String:Any] else { return  }
        
        print(parameters)
        let second =  Alamofire.request(url, method: .post, parameters:  parameters, encoding: JSONEncoding.default, headers: nil)
      second.responseJSON { (dataw) in
         do
         {
        let decoder = JSONDecoder()
         let data = try decoder.decode(IsfavRadio.self, from:  dataw.data ?? Data())
            if data.success == 1
            {
                if self.isfavourite == "0"
                {
                    self.BtFavourite.setBackgroundImage(UIImage(named: "liked"), for: .normal)
                    self.isfavourite = "1"
                }else if self.isfavourite == "1"
                {
                    self.BtFavourite.setBackgroundImage(UIImage(named: "like"), for: .normal)
                    self.isfavourite = "0"
                }
            }
         }catch
         {
             print(error)
         }
       
         
        
    }
    }
}
    
    
extension RadioDetailsVC:MuviPlayerPlaybackDelegate
{
    func backButtonAction(player: MuviVideoPlayer, item: MuviPlayerItem?) {
        if self.playerview.isPlaying
        {
            self.playerview.player.pause()
        }
        self.dismiss(animated: true, completion: nil)
    }
    
    
}
