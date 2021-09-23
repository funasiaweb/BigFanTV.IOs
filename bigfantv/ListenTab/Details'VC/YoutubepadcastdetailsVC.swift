//
//  YoutubrVideoDetailsVC.swift
//  PageView
//
//  Created by Ganesh on 17/02/21.
//  Copyright © 2021 Edbrix. All rights reserved.
//

import UIKit
import youtube_ios_player_helper_swift


class YoutubepadcastdetailsVC: UIViewController ,YTPlayerViewDelegate{

    var videourl = ""
    var videotitle = ""
    @IBOutlet var ViAdd: UIView!
    @IBOutlet var Lbtitle: UILabel!
    @IBOutlet var Lbdescription: UILabel!
    @IBOutlet var player:YTPlayerView!
  //  var player = YTPlayerView()
    var youTubeID = ""
    override func viewDidLoad()
    {
        super.viewDidLoad()
        self.Lbtitle.text = videotitle
        self.Lbdescription.text = videourl

        //bqwU6xopMmk
             
      //  youTubeID  = "bqwU6xopMmk"
      //   player.frame = self.ViAdd.frame
       //  ViAdd.addSubview(player)
        player.delegate = self

            //player.load(videoUrl: "https://www.youtube.com/watch?v=7rnaZT_q4fQ", startSeconds: 0, suggestedQuality: .auto)
         let url = videourl
        let playerVars = ["playsinline": 1, "autohide": 1, "showinfo": 0, "controls":1, "origin" : "http://youtube.com"] as [String : Any] // 0: will play video in fullscreen

        do{
            self.player.load(videoId: youTubeID, playerVars: playerVars)
            //load(withVideoId: youTubeID, playerVars: playerVars)
        }catch
        {
            print(error.localizedDescription)
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
        

        /*
         do {
             let regex = try NSRegularExpression(pattern: "(?<=v(=|/))([-a-zA-Z0-9_]+)|(?<=youtu.be/)([-a-zA-Z0-9_]+)", options: NSRegularExpression.Options.caseInsensitive)
             let match = regex.firstMatch(in: url, options: NSRegularExpression.MatchingOptions.reportProgress, range: NSMakeRange(0, url.lengthOfBytes(using: String.Encoding.utf8)))
             let range = match?.range(at: 0)
             let youTubeID = (url as NSString).substring(with: range!)
             print(youTubeID)
              player.load(videoId: youTubeID)
         } catch {
             print("error")
         }
        */
    }
      override func viewWillAppear(_ animated: Bool)
      {
       
               
    }
    @objc func BackBtTaped()
    {
        self.dismiss(animated: true, completion: nil)    }
    @objc func AddBtTaped()
    {
        self.navigationController?.popViewController(animated: true)
    }
    func playerViewDidBecomeReady(_ playerView: YTPlayerView) {
        player.playVideo()

    }
    func playerView(_ playerView: YTPlayerView, receivedError error: YTPlayerError) {
        print(error.rawValue)
    }
    func playerView(_ playerView: YTPlayerView, didChangeTo state: YTPlayerState) {
              print(state)
        }
        func playerView(_ playerView: YTPlayerView, didPlayTime playTime: Float) {
              print(playTime)
        }
}
