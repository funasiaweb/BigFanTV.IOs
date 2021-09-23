//
//  PodcastListdetails.swift
//  bigfantv
//
//  Created by Ganesh on 23/12/20.
//  Copyright © 2020 Ganesh. All rights reserved.
//

import UIKit
import SDWebImage
import SwiftAudio
import AVFoundation
import MediaPlayer
import Alamofire
import MuviAudioPlayer
//AIzaSyDJdHauH0v3CF5bqxEkY5k1lDbsqGHTw4s
class podcasttablecell:UITableViewCell
{
    @IBOutlet var LbTitle: UILabel!
   
    @IBOutlet var nowPlayingAnimationImageView: UIImageView!
    @IBOutlet var LbDate: UILabel!
    
     var actionBlock: (() -> Void)? = nil
    @IBOutlet var Btshare: UIButton!
    
    
    @IBAction func BtSharetapped(_ sender: UIButton) {
     actionBlock?()
        
    }
}
class PodcastListdetails: UIViewController  {

    var currentTrack: Track!

    var muviPlayer = MuviAudioMiniView()
   var manager = MuviAudioPlayerManager()
    @IBOutlet var BtFav: UIButton!
    @IBOutlet var ImgPodcast: UIImageView!
    @IBOutlet var LbTitle: UILabel!
    @IBOutlet var TableV: UITableView!
    
    @IBOutlet var BtPlay: UIButton!
    @IBOutlet var ViPlayer: UIView!
    @IBOutlet var MuviPLayerView: UIView!

    @IBOutlet var LbPLayertitle: UILabel!
    @IBOutlet var ImgPodcastplayer: UIImageView!
    
    let timeFormatter = NumberFormatter()
    
    var audioPlayer : AVAudioPlayer?   // holds an audio player instance. This is an optional!
    var audioTimer: Timer?            // holds a timer instance
    var isDraggingTimeSlider = false    // Keep track of when the time slide is being dragged
    
   
    
    var selectedIndex = -1
    
    private var youtubepodcastedata:Youtubepodcast?

         private var Finalpodcastedata:PodcastData?
        private var Newpodcastedata:NewPodcastData?
        private var Newpodcastelist = [NewPodcastDataListDetails]()
       private var Newpodcastelistnew = [NewPodcastDataList]()
    
    // MARK: IBOutlets
     
    
    
     var player:AVPlayer?
    var playerItem:AVPlayerItem?
 
    var podcastdata = [NewPodcastDataListDetails]()
    var podcasttitle =  ""
    var podcastimage = ""
    var permalink = ""
    var isfromaudiopodcast = "0"
    var selectedindex = 0
    var isplaying = true
    var bombSoundEffect =  AVAudioPlayer()
    var episodedt:EdpisodeData?
       var Episodesdata = [Edpisodedetails]()
     var totalconents = 0
      var index = 1
     
     var isloading:Bool?
    var isfrom = "0"
    //Audio player
     @IBOutlet weak var playButton: UIButton!
     @IBOutlet weak var slider: UISlider!
     
 
    @IBOutlet weak var remainingTimeLabel: UILabel!
     @IBOutlet weak var elapsedTimeLabel: UILabel!
     @IBOutlet weak var titleLabel: UILabel!
    
     @IBOutlet weak var loadIndicator: UIActivityIndicatorView!
     //@IBOutlet weak var errorLabel: UILabel!
     
     private var isScrubbing: Bool = false
     private let controller = AudioController.shared
     private var lastLoadFailed: Bool = false
    
     var podcasturl = ""
    var AudioName = ""
    
    
    var youtubeId = ""
    override func viewDidLoad() {
        super.viewDidLoad()
     
 
         player = AVPlayer()
       timeFormatter.minimumIntegerDigits = 2
       timeFormatter.minimumFractionDigits = 0
       timeFormatter.roundingMode = .down
       
        
       // ImgPodcast.load(url:  URL(string: podcastimage)!)
        
          ImgPodcast.sd_setImage(with: URL(string: podcastimage), completed: nil)
        
        if isfromaudiopodcast == "1"
        {
            if Connectivity.isConnectedToInternet()
            {
                self.getEpisodedeatils(permaa: permalink, offset: 1)
            }else
            {
                Utility.Internetconnection(vc: self)
            }
        }else if isfromaudiopodcast == "2"
        {
            self.loadepisodes()
        }else if isfromaudiopodcast == "4"
        {
            self.loadyoutubeepisodes()
            
        }
        LbTitle.text = podcasttitle
        TableV.separatorColor = UIColor.gray
        TableV.tableFooterView = UIView()
       // TableV.delegate  = self
       // TableV.dataSource = self
        controller.player.event.stateChange.addListener(self, handleAudioPlayerStateChange)
        controller.player.event.secondElapse.addListener(self, handleAudioPlayerSecondElapsed)
        controller.player.event.seek.addListener(self, handleAudioPlayerDidSeek)
        controller.player.event.updateDuration.addListener(self, handleAudioPlayerUpdateDuration)
        controller.player.event.didRecreateAVPlayer.addListener(self, handleAVPlayerRecreated)
        controller.player.event.fail.addListener(self, handlePlayerFailure)
        updateMetaData()
        handleAudioPlayerStateChange(data: controller.player.playerState)
        
    }
    override func viewWillAppear(_ animated: Bool) {
        self.ViPlayer.isHidden = true
        self.MuviPLayerView.isHidden = true

        
         MuviAudioPlayerManager.shared.playbackDelegate = self
   }
    
    @IBAction func BtShareTapped(_ sender: UIButton) {
         
        let url = URL(string:podcastimage)
        
          if let data = try? Data(contentsOf: url!)
          {
              let image: UIImage = UIImage(data:data)!
              guard  let videoLink =  URL(string: podcasttitle) else {return}
              let radioShoutout =  "Please download the BigFan TV application to view the content : \(videoLink)"
              //currentTrack.artworkImage = image
              
               currentTrack = Track(title: podcasttitle, artworkImage: image)
               
            
              let shareImage = ShareImageGenerator(radioShoutout: radioShoutout, track: currentTrack).generate()
              
              let activityViewController = UIActivityViewController(activityItems: [radioShoutout, shareImage], applicationActivities: nil)
              activityViewController.popoverPresentationController?.sourceRect = CGRect(x: view.center.x, y: view.center.y, width: 0, height: 0)
              activityViewController.popoverPresentationController?.sourceView = view
              activityViewController.popoverPresentationController?.permittedArrowDirections = UIPopoverArrowDirection(rawValue: 0)
              
              activityViewController.completionWithItemsHandler = {(activityType: UIActivity.ActivityType?, completed:Bool, returnedItems:[Any]?, error: Error?) in
                  if completed
                  {
                      // do something on completion if you want
                  }
              }
              present(activityViewController, animated: true, completion: nil)
              
          }
    }
    
    @IBAction func BtFavTapped(_ sender: UIButton) {
    }
    func loadyoutubeepisodes()
    {
        Utility.ShowLoader(vc: self)
        let url = "https://youtube.googleapis.com/youtube/v3/playlistItems?part=snippet&maxResults=50&playlistId=\(youtubeId)&key=AIzaSyDJdHauH0v3CF5bqxEkY5k1lDbsqGHTw4s"
            print(url)
        Alamofire.request(url, parameters: [:]).responseData { response in
                  
                     
            print("podcast response ==\(response.data)")
                       
            do

           {
            guard let podcastttdata = response.data else { return }
                           
            let decoder = JSONDecoder()
            self.youtubepodcastedata = try decoder.decode(Youtubepodcast.self, from:podcastttdata )
 
            self.TableV.delegate = self
            self.TableV.dataSource = self
        
            Utility.hideLoader(vc: self)
            DispatchQueue.main.async
            {
                self.TableV.reloadData()
            }
            
           }
            catch let error
            {
                  Utility.showAlert(vc: self, message:"\(error)", titelstring: Appcommon.Appname)
            }
            Utility.hideLoader(vc: self)
            
        }
        
        
    }
    
    func loadepisodes()
    {
        Utility.ShowLoader(vc: self)
        guard let url = URL(string: podcasturl) else {
            return
        }
        print(url)
        Alamofire.request(url, parameters: [:]).responseData { response in
                  
                     
            print(response)
                       do
                       {
                           guard let podcastttdata = response.data else { return }
                           let decoder = JSONDecoder()
                          self.Finalpodcastedata = try decoder.decode(PodcastData.self, from:podcastttdata )
 
                     
                           self.TableV.delegate = self
                           self.TableV.dataSource = self
                           Utility.hideLoader(vc: self)
                           DispatchQueue.main.async
                               {
                              self.TableV.reloadData()
                               
                                 
                               }
                          
                       }
                       catch let error
                       {
                            
                         //  Utility.showAlert(vc: self, message:"\(error)", titelstring: Appcommon.Appname)
                       }
                        
                      Utility.hideLoader(vc: self)
                   }
    }
    func getEpisodedeatils(permaa:String,offset:Int)
      {
          Api.GetEpisodedetails(permaa,offset:offset, endpoint: ApiEndPoints.episodeDetails, vc: self) { (res, err) -> (Void) in
              do
              {
             
                  let decoder = JSONDecoder()
                  self.episodedt = try decoder.decode(EdpisodeData.self, from: res  ?? Data())
                  
                 if self.episodedt?.list?.count ?? 0 > 0
                 {
           
                  self.totalconents = Int(self.episodedt?.string_code ?? "") ?? 0
                   
                  for i in self.episodedt?.list ?? [Edpisodedetails]()
                  {
                      self.Episodesdata.append(i)
                  }
                 }
                 
                 self.TableV.delegate = self
                 self.TableV.dataSource  = self
                 DispatchQueue.main.async
                     {
                         self.TableV.reloadData()
                      self.isloading = false
                     }
              
              }
              catch let error
              {
                  Utility.showAlert(vc: self, message:"\(error)", titelstring: Appcommon.Appname)
              }
          }
      }
 
    
    @IBAction func BackBttapped(_ sender: UIButton)
    {
        self.dismiss(animated: true, completion: nil)
    }
     
    
    
    
    //Audio player
    @IBAction func togglePlay(_ sender: Any)
       {
           if !controller.audioSessionController.audioSessionIsActive {
               try? controller.audioSessionController.activateSession()
           }
           if lastLoadFailed, let item = controller.player.currentItem {
               lastLoadFailed = false
               
               try? controller.player.load(item: item, playWhenReady: true)
           }
           else {
               controller.player.togglePlaying()
           }
       }
       
       @IBAction func startScrubbing(_ sender: UISlider) {
            isScrubbing = true
        }
        
        @IBAction func scrubbing(_ sender: UISlider) {
            controller.player.seek(to: Double(slider.value))
        }
       @IBAction func scrubbingValueChanged(_ sender: UISlider) {
           let value = Double(slider.value)
           elapsedTimeLabel.text = value.secondsToString()
           remainingTimeLabel.text = (controller.player.duration - value).secondsToString()
       }
       
       func updateTimeValues() {
           self.slider.maximumValue = Float(self.controller.player.duration)
           self.slider.setValue(Float(self.controller.player.currentTime), animated: true)
           self.elapsedTimeLabel.text = self.controller.player.currentTime.secondsToString()
           self.remainingTimeLabel.text = (self.controller.player.duration - self.controller.player.currentTime).secondsToString()
       }
       func setPlayButtonState(forAudioPlayerState state: AudioPlayerState) {
           playButton.setImage(state == .playing ? UIImage(named: "pausenew") : UIImage(named: "play-buttonnew"), for: .normal)
          // playButton.setTitle(state == .playing ? "Pause" : "Play", for: .normal)
       }
       
       func setErrorMessage(_ message: String) {
           self.loadIndicator.stopAnimating()
           
          
       }
       func updateMetaData() {
           if let item = controller.player.currentItem {
               
               
               item.getArtwork({ (image) in
                   
               })
           }
       }
       func handleAudioPlayerStateChange(data: AudioPlayer.StateChangeEventData) {
           print(data)
           DispatchQueue.main.async {
               self.setPlayButtonState(forAudioPlayerState: data)
               switch data {
               case .loading:
                   self.loadIndicator.startAnimating()
                   self.updateMetaData()
                   self.updateTimeValues()
               case .buffering:
                   self.loadIndicator.startAnimating()
               case .ready:
                
                   self.loadIndicator.stopAnimating()
                   self.updateMetaData()
                   self.updateTimeValues()
               case .playing, .paused, .idle:
                   self.loadIndicator.stopAnimating()
                   self.updateTimeValues()
               }
           }
       }
       
       func handleAudioPlayerSecondElapsed(data: AudioPlayer.SecondElapseEventData) {
           if !isScrubbing {
               DispatchQueue.main.async {
                   self.updateTimeValues()
               }
           }
       }
       
       func handleAudioPlayerDidSeek(data: AudioPlayer.SeekEventData) {
           isScrubbing = false
       }
       
       func handleAudioPlayerUpdateDuration(data: AudioPlayer.UpdateDurationEventData) {
           DispatchQueue.main.async {
               self.updateTimeValues()
           }
       }
       
       func handleAVPlayerRecreated() {
           try? controller.audioSessionController.set(category: .playback)
       }
       
       func handlePlayerFailure(data: AudioPlayer.FailEventData) {
           if let error = data as NSError? {
               if error.code == -1009 {
                   lastLoadFailed = true
                   DispatchQueue.main.async {
                       self.setErrorMessage("Network disconnected. Please try again...")
                   }
               }
           }
       }

      
    
}
extension PodcastListdetails:UITableViewDelegate,UITableViewDataSource
{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        if isfromaudiopodcast == "1"
        {
            return Episodesdata.count
        }else if isfromaudiopodcast == "2"
        {
            return Finalpodcastedata?.channel?.list?.count ?? 0
        }else if isfromaudiopodcast == "4"
        {
            return self.youtubepodcastedata?.items.count ?? 0
        }
         return 0
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell
    {
         
        if isfromaudiopodcast == "1"
        {
             let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)as! podcasttablecell
             cell.LbTitle.text = self.Episodesdata[indexPath.row].episode_title ?? ""
            cell.LbDate.text = self.Episodesdata[indexPath.row].episode_date ?? ""
           // cell.nowPlayingAnimationImageView.isHidden = true
           // cell.nowPlayingAnimationImageView.animationImages = AnimationFrames.createFrames()
           // cell.nowPlayingAnimationImageView.animationDuration = 0.7
            cell.actionBlock =
                {
                    let url = URL(string:self.Episodesdata[indexPath.row].poster_url ?? "")
                    
                      if let data = try? Data(contentsOf: url!)
                      {
                          let image: UIImage = UIImage(data:data)!
                        guard  let videoLink =  URL(string: self.Episodesdata[indexPath.row].video_url ?? "") else {return}
                          let radioShoutout =  "Please download the BigFan TV application to view the content : \(videoLink)"
                          //currentTrack.artworkImage = image
                          
                        self.currentTrack = Track(title: self.Episodesdata[indexPath.row].episode_title ?? "", artworkImage: image)
                           
                        
                        let shareImage = ShareImageGenerator(radioShoutout: radioShoutout, track: self.currentTrack).generate()
                          
                          let activityViewController = UIActivityViewController(activityItems: [radioShoutout, shareImage], applicationActivities: nil)
                        activityViewController.popoverPresentationController?.sourceRect = CGRect(x: self.view.center.x, y: self.view.center.y, width: 0, height: 0)
                        activityViewController.popoverPresentationController?.sourceView = self.view
                          activityViewController.popoverPresentationController?.permittedArrowDirections = UIPopoverArrowDirection(rawValue: 0)
                          
                          activityViewController.completionWithItemsHandler = {(activityType: UIActivity.ActivityType?, completed:Bool, returnedItems:[Any]?, error: Error?) in
                              if completed
                              {
                                  // do something on completion if you want
                              }
                          }
                          self.present(activityViewController, animated: true, completion: nil)
                          
                      }
            }
           // cell.nowPlayingAnimationImageView.startAnimating()
            cell.contentView.backgroundColor = (indexPath.row == selectedIndex) ? Appcolor.backgorund3 : Appcolor.backgorund4
              return cell
        }else if self.isfromaudiopodcast == "4"
        {
            let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)as! podcasttablecell
            cell.LbTitle.text = self.youtubepodcastedata?.items[indexPath.row].snippet?.title ?? ""
            cell.LbDate.text =  self.youtubepodcastedata?.items[indexPath.row].snippet?.snippetDescription ?? ""
            // cell.nowPlayingAnimationImageView.isHidden = true
          // cell.nowPlayingAnimationImageView.animationImages = AnimationFrames.createFrames()
          // cell.nowPlayingAnimationImageView.animationDuration = 0.7
           cell.actionBlock =
               {
                let url = URL(string:self.youtubepodcastedata?.items[indexPath.row].snippet?.thumbnails?.high.url ?? "")
                   
                     if let data = try? Data(contentsOf: url!)
                     {
                         let image: UIImage = UIImage(data:data)!
                       guard  let videoLink =  URL(string: self.Episodesdata[indexPath.row].video_url ?? "") else {return}
                         let radioShoutout =  "Please download the BigFan TV application to view the content"
                         //currentTrack.artworkImage = image
                         
                        self.currentTrack = Track(title:self.youtubepodcastedata?.items[indexPath.row].snippet?.title ?? "", artworkImage: image)
                          
                       
                       let shareImage = ShareImageGenerator(radioShoutout: radioShoutout, track: self.currentTrack).generate()
                         
                         let activityViewController = UIActivityViewController(activityItems: [radioShoutout, shareImage], applicationActivities: nil)
                       activityViewController.popoverPresentationController?.sourceRect = CGRect(x: self.view.center.x, y: self.view.center.y, width: 0, height: 0)
                       activityViewController.popoverPresentationController?.sourceView = self.view
                         activityViewController.popoverPresentationController?.permittedArrowDirections = UIPopoverArrowDirection(rawValue: 0)
                         
                         activityViewController.completionWithItemsHandler = {(activityType: UIActivity.ActivityType?, completed:Bool, returnedItems:[Any]?, error: Error?) in
                             if completed
                             {
                                 // do something on completion if you want
                             }
                         }
                         self.present(activityViewController, animated: true, completion: nil)
                         
                     }
           }
          // cell.nowPlayingAnimationImageView.startAnimating()
           cell.contentView.backgroundColor = (indexPath.row == selectedIndex) ? Appcolor.backgorund3 : Appcolor.backgorund4
             return cell

            
        }else
        {
         
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)as! podcasttablecell
            
            cell.LbTitle.text = Finalpodcastedata?.channel?.list?[indexPath.row].title  ?? ""
            cell.LbDate.text = Finalpodcastedata?.channel?.list?[indexPath.row].pubDate  ?? ""
                  cell.actionBlock =
                      {
                        let url = URL(string:self.Finalpodcastedata?.channel?.list?[indexPath.row].itunesimage  ?? "")
                          
                            if let data = try? Data(contentsOf: url!)
                            {
                                let image: UIImage = UIImage(data:data)!
                                guard  let videoLink =  URL(string: self.Finalpodcastedata?.channel?.list?[indexPath.row].url  ?? "") else {return}
                                let radioShoutout =  "Please download the BigFan TV application to view the content : \(videoLink)"
                                //currentTrack.artworkImage = image
                                
                                self.currentTrack = Track(title: self.Finalpodcastedata?.channel?.list?[indexPath.row].title  ?? "", artworkImage: image)
                                 
                              
                              let shareImage = ShareImageGenerator(radioShoutout: radioShoutout, track: self.currentTrack).generate()
                                
                                let activityViewController = UIActivityViewController(activityItems: [radioShoutout, shareImage], applicationActivities: nil)
                              activityViewController.popoverPresentationController?.sourceRect = CGRect(x: self.view.center.x, y: self.view.center.y, width: 0, height: 0)
                              activityViewController.popoverPresentationController?.sourceView = self.view
                                activityViewController.popoverPresentationController?.permittedArrowDirections = UIPopoverArrowDirection(rawValue: 0)
                                
                                activityViewController.completionWithItemsHandler = {(activityType: UIActivity.ActivityType?, completed:Bool, returnedItems:[Any]?, error: Error?) in
                                    if completed
                                    {
                                        // do something on completion if you want
                                    }
                                }
                                self.present(activityViewController, animated: true, completion: nil)
                                
                            }
                  }
            //cell.nowPlayingAnimationImageView.isHidden = (indexPath.row == selectedIndex) ? false : true
           // cell.nowPlayingAnimationImageView.animationImages = AnimationFrames.createFrames()
           // cell.nowPlayingAnimationImageView.animationDuration = 0.7
            //  cell.nowPlayingAnimationImageView.startAnimating()
            //cell.contentView.backgroundColor = (indexPath.row == selectedIndex) ? Appcolor.backgorund3 : Appcolor.backgorund4
        
        return cell
        }
        
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        MuviAudioPlayerManager.shared.pause()

        if isfromaudiopodcast == "1"
        {
            UIView.animate(withDuration: 0.1) {
                
                self.MuviPLayerView.isHidden = false
            }
               selectedIndex = indexPath.row
            
            self.TableV.reloadData()
            /*
            titleLabel.text = self.Episodesdata[indexPath.row].episode_title ?? ""
            
            try? controller.player.load(item:   DefaultAudioItem(audioUrl: self.Episodesdata[indexPath.row].embeddedUrl ?? "", artist: "", title: "", albumTitle: "", sourceType: .stream,  artwork: nil), playWhenReady: true)
 */
            var MuviPlayerV =    MuviAudioPlayerManager.shared.muviAudioMiniView!

           // let theHeight = view.frame.size.height //grabs the height of your view

            self.muviPlayer.audioTitleLabel.adjustsFontSizeToFitWidth = true
            self.muviPlayer.audioSubTitleLabel.adjustsFontSizeToFitWidth = true

            MuviPlayerV.audioTitleLabel.textColor = UIColor.black
            MuviPlayerV.audioSubTitleLabel.textColor = UIColor.black

                //[NSAttributedString.Key.font: UIFont(name: "Muli-Bold", size: 16)!,NSAttributedString.Key.foregroundColor : UIColor.white], for: .normal
            MuviPlayerV.layer.backgroundColor = UIColor.white.cgColor
            MuviPlayerV.frame = CGRect(x: 0, y: 0, width: MuviPLayerView.frame.size.width, height: MuviPLayerView.frame.size.height)
            self.MuviPLayerView.addSubview(MuviPlayerV)

            //self.myScrollingView.bringSubviewToFront(MuviPlayerV)

            self.AudioName = self.Episodesdata[indexPath.row].episode_title ?? ""
            guard let songurl = URL(string: self.Episodesdata[indexPath.row].embeddedUrl ?? "") else {return}
            guard let songImageurl = URL(string:  self.Episodesdata[indexPath.row].poster_url ?? "") else {return}

          //  print("name === \(self.contentdata?.submovie?.name)")
          //  print("titlename === \(self.contentdata?.submovie?.custom3)")

            let song = MuviAudioPlayerItemInfo(id: "",
                                                        url: songurl,
                                                        title:self.Episodesdata[indexPath.row].episode_title ?? "",
                                                        albumTitle: "",
                                                        coverImageURL: songImageurl)
            var playeritems: [MuviAudioPlayerItemInfo] = []
            playeritems.append(song)
            print(AudioName)
            for i in Episodesdata
            {
                if i.episode_title != self.AudioName
                {
                    guard let newsongurl = URL(string: i.embeddedUrl ?? "") else {return}
                    guard let newsongImageurl = URL(string:  i.poster_url ?? "") else {return}
                    
                    playeritems.append(MuviAudioPlayerItemInfo(id: "",
                                                               url: newsongurl,
                                                               title:i.episode_title ?? "",
                                                               albumTitle: "",
                                                               coverImageURL: newsongImageurl))
                    
                }
            }
            print("count   === \(playeritems.count)")
            MuviAudioPlayerManager.shared.setup(with: playeritems)
           // MuviAudioPlayerManager.shared.setup(with:[song])
        }
        else if isfromaudiopodcast == "4"
        {
            let storyBoard: UIStoryboard = UIStoryboard(name: "Main", bundle: nil)
            let displayVC = storyBoard.instantiateViewController(withIdentifier: "YoutubepadcastdetailsVC") as! YoutubepadcastdetailsVC
                              
            displayVC.modalPresentationStyle = .fullScreen

            displayVC.youTubeID = youtubepodcastedata?.items[indexPath.row].snippet?.resourceID?.videoID ?? ""
            displayVC.videotitle = youtubepodcastedata?.items[indexPath.row].snippet?.title ?? ""
            displayVC.videourl = youtubepodcastedata?.items[indexPath.row].snippet?.snippetDescription ?? ""
              
            let navController = UINavigationController(rootViewController: displayVC) // Creating a navigation controller with VC1 at the root of the navigation stack.
            navController.navigationBar.barTintColor = Appcolor.backgorund3
           navController.modalPresentationStyle = .fullScreen
             let textAttributes = [NSAttributedString.Key.foregroundColor:UIColor.white,NSAttributedString.Key.font: UIFont(name: "Muli-ExtraBold", size: 19)!]
             navController.navigationBar.titleTextAttributes = textAttributes
            self.present(navController, animated:true, completion: nil)
        }else
        {
            if isfrom == "3"
            {
                let storyBoard: UIStoryboard = UIStoryboard(name: "Main", bundle: nil)
                let displayVC = storyBoard.instantiateViewController(withIdentifier: "RadioDetailsVC") as! RadioDetailsVC
                                  
                displayVC.modalPresentationStyle = .fullScreen

                 print(Finalpodcastedata?.channel?.list?[indexPath.row].url ?? "")
                displayVC.Videourl = Finalpodcastedata?.channel?.list?[indexPath.row].url ?? ""
                displayVC.Videotitle =  Finalpodcastedata?.channel?.list?[indexPath.row].title ?? ""
                  
                self.present(displayVC, animated: true, completion: nil)
                
            }else
            {
                UIView.animate(withDuration: 0.1)
                {
                    self.MuviPLayerView.isHidden = false
                }
                selectedIndex = indexPath.row
                self.TableV.reloadData()
                /*
                titleLabel.text = Finalpodcastedata?.channel?.list?[indexPath.row].title ?? ""
                try? controller.player.load(item:   DefaultAudioItem(audioUrl: Finalpodcastedata?.channel?.list?[indexPath.row].url ?? "", artist: "", title: "", albumTitle: "", sourceType: .stream,  artwork: nil), playWhenReady: true)
                */
                var MuviPlayerV =    MuviAudioPlayerManager.shared.muviAudioMiniView!

               // let theHeight = view.frame.size.height //grabs the height of your view

                self.muviPlayer.audioTitleLabel.adjustsFontSizeToFitWidth = true
                self.muviPlayer.audioSubTitleLabel.adjustsFontSizeToFitWidth = true

                MuviPlayerV.audioTitleLabel.textColor = UIColor.black
                MuviPlayerV.audioSubTitleLabel.textColor = UIColor.black

                    //[NSAttributedString.Key.font: UIFont(name: "Muli-Bold", size: 16)!,NSAttributedString.Key.foregroundColor : UIColor.white], for: .normal
                MuviPlayerV.layer.backgroundColor = UIColor.white.cgColor
                MuviPlayerV.frame = CGRect(x: 0, y: 0, width: MuviPLayerView.frame.size.width, height: MuviPLayerView.frame.size.height)
                self.MuviPLayerView.addSubview(MuviPlayerV)

                //self.myScrollingView.bringSubviewToFront(MuviPlayerV)

                guard let songurl = URL(string: Finalpodcastedata?.channel?.list?[indexPath.row].url ?? "") else {return}
                guard let songImageurl = URL(string:  Finalpodcastedata?.channel?.list?[indexPath.row].itunesimage ?? "") else {return}

              //  print("name === \(self.contentdata?.submovie?.name)")
              //  print("titlename === \(self.contentdata?.submovie?.custom3)")

                self.AudioName = Finalpodcastedata?.channel?.list?[indexPath.row].title ?? ""
                let song = MuviAudioPlayerItemInfo(id: "",
                                                            url: songurl,
                                                            title:Finalpodcastedata?.channel?.list?[indexPath.row].title ?? "",
                                                            albumTitle: "",
                                                            coverImageURL: songImageurl)
                //MuviAudioPlayerManager.shared.setup(with:[song])
                var playeritems: [MuviAudioPlayerItemInfo] = []
                playeritems.append(song)
                
                for i in Finalpodcastedata?.channel?.list ?? [PodcastDataListDetails]()
                {
                    if i.title != self.AudioName
                    {
                        guard let songurl = URL(string: i.url ?? "") else {return}
                        guard let songImageurl = URL(string:  i.itunesimage ?? "") else {return}
                        playeritems.append(MuviAudioPlayerItemInfo(id: "",
                                                                   url: songurl,
                                                                   title:i.title ?? "",
                                                                   albumTitle: "",
                                                                   coverImageURL: songImageurl))
                    }
                }
                 MuviAudioPlayerManager.shared.setup(with: playeritems)
            }
        }
    }
     
   
   
    
    
   
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 80
    }
    
    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
 
            if isfromaudiopodcast == "1"
            {
            if Episodesdata.count < totalconents
               {
          
                if indexPath.row == Episodesdata.count - 1 && !(isloading ?? false)
                   {  //numberofitem count
                       isloading = true
                      index = index + 1
                      self.getEpisodedeatils(permaa: permalink, offset: index)
                       
                   }
              }
            }
        }
    
}

extension PodcastListdetails:MuviAudioPlayerDelegate
{
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

 
