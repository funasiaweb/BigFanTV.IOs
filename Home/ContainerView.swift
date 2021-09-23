//  ScrollingStackController
//  Efficient Scrolling Container for UIViewControllers
//
//  Created by Daniele Margutti.
//  Copyright © 2017 Daniele Margutti. All rights reserved.
//
//	Web: http://www.danielemargutti.com
//	Email: hello@danielemargutti.com
//	Twitter: @danielemargutti
//
//
//	Permission is hereby granted, free of charge, to any person obtaining a copy
//	of this software and associated documentation files (the "Software"), to deal
//	in the Software without restriction, including without limitation the rights
//	to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
//	copies of the Software, and to permit persons to whom the Software is
//	furnished to do so, subject to the following conditions:
//
//	The above copyright notice and this permission notice shall be included in
//	all copies or substantial portions of the Software.
//
//	THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
//	IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
//	FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
//	AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
//	LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
//	OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN
//	THE SOFTWARE.

import Foundation
import UIKit
import AVKit
import Alamofire
public class ContainerView: UIViewController, StackContainable {
    let manager: Alamofire.SessionManager = {
        let configuration = URLSessionConfiguration.default
         configuration.timeoutIntervalForRequest = TimeInterval(60)
        configuration.timeoutIntervalForResource = TimeInterval(60)
        return  Alamofire.SessionManager(configuration: configuration)
    }()
    @IBOutlet var Vinew: UIView!
    
    @IBOutlet var BTWathcnow: UIButton!
    private var Bannerdata:NewBannerList?
       private var banerdata = [Dictionary<String,String>]()
       var filterPlayers : [AVPlayer?] = []
       var currentPage: Int = 0
       var filterScrollView : UIScrollView?
       var player: AVPlayer?
       var playerController : AVPlayerViewController?
       var avPlayerLayer : AVPlayerLayer!
    
    public static func create() -> ContainerView {
		return UIStoryboard(name: "Containers", bundle: Bundle.main).instantiateViewController(withIdentifier: "ContainerView") as! ContainerView
	}
	
	public override func viewDidLoad() {
		super.viewDidLoad()
        
      //  BTWathcnow.roundCorners([.topLeft, .bottomRight], radius: 5, borderColor: nil, borderWidth: nil)
       
               if Connectivity.isConnectedToInternet()
             {
                 Getimagelist()
             }else
             {
               Utility.Internetconnection(vc: self)
             }
        
	}
    
         func Getimagelist()
       {
        do
        {
            let url:URL = URL(string: "https://bigfantv.funasia.net/service/getBannerList.html")!
            self.manager.request(url, method: .post, parameters: [:], encoding: JSONEncoding.default, headers: nil).responseJSON { (response) in
                      print(response)
                switch response.result
                {
                case .success(_):
                    if response.value != nil
                    {
                        do
                        {
                            let decoder = JSONDecoder()
                            self.Bannerdata = try decoder.decode(NewBannerList.self, from: response.data  ?? Data())
                            for i in self.Bannerdata?.subComedymovList ?? [NewBannerListdeatails]()
                            {
                                let feature12 = [  "titleimage":"\(i.bannerImage ?? "")","isimage":"1","videourl":"\(i.action ?? "")","actionurl":"\(i.bannerURL ?? "")"]
                                                  self.banerdata.append(feature12)
                            }
                            self.setupFilterWith(size: self.Vinew!.bounds.size)
                        }
                        catch let error
                        {
                            print("error.localizedDescription  \(error.localizedDescription)")
                        }
                    }
                    break
                case .failure(let error):
                    print("failure\(error)")
                    break
                }
            }
        }
        catch let error
        {
            //  Utility.showAlert(vc: self, message:"\(error)", titelstring: Appcommon.Appname)
        }
    }
	
    @IBAction func BtsubscribeTapped(_ sender: UIButton) {
   let storyBoard: UIStoryboard = UIStoryboard(name: "Main", bundle: nil)
   let VC1 = storyBoard.instantiateViewController(withIdentifier: "MyplansVC") as! MyplansVC
           
     let navController = UINavigationController(rootViewController: VC1) // Creating a navigation controller with VC1 at the root of the navigation stack.
    navController.navigationBar.barTintColor = Appcolor.backgorund3
        navController.navigationBar.isTranslucent = false
    navController.modalPresentationStyle = .fullScreen
    self.present(navController, animated:true, completion: nil)
    
    
    }
    public func preferredAppearanceInStack() -> ScrollingStackController.ItemAppearance
    {
        return .view(height: 190)
	}
		
    
    
    
}

extension ContainerView: UIScrollViewDelegate {
     
    func setupFilterWith(size: CGSize)  {
        currentPage = 0
        filterPlayers.removeAll()
        filterScrollView = UIScrollView(frame: Vinew.bounds)
        
        let count = banerdata.count
        if count > 0
        {
        for i in 0...count-1 {
            //Adding image to scroll view
            let imgView : UIView = UIView.init(frame: CGRect(x: CGFloat(i) * size.width, y: 0, width: size.width, height: size.height))
            let imgViewThumbnail: UIImageView = UIImageView.init(frame: imgView.bounds)
            
            //imgView.image =
            imgView.backgroundColor = .clear
            imgViewThumbnail.contentMode = .scaleAspectFit
            imgView.addSubview(imgViewThumbnail)
            
           
           // imgView.bringSubviewToFront(imgView)
            if let url:URL = URL(string: banerdata[i]["titleimage"] ?? "")
            {
               imgViewThumbnail.sd_setImage(with: url, completed: nil)
               // imgViewThumbnail.image = UIImage(named: "newlogo")
            }
            let tap = UITapGestureRecognizer(target: self, action: #selector(cellTappedMethod(_:)))
            imgViewThumbnail.isUserInteractionEnabled = true
             imgViewThumbnail.tag = i
             imgViewThumbnail.addGestureRecognizer(tap)
            
            
            filterScrollView?.addSubview(imgView)
           
            
            //For Multiple player
            
            let player = AVPlayer(url: URL(string: banerdata[i]["videourl"] ?? "")!)
             let avPlayerLayer = AVPlayerLayer(player: player)
             avPlayerLayer.videoGravity = .resizeAspect
             avPlayerLayer.masksToBounds = true
             avPlayerLayer.cornerRadius = 5
             avPlayerLayer.frame = imgView.layer.bounds
             player.isMuted = true
             imgView.layer.addSublayer(avPlayerLayer)
           
            let button = UIButton(frame: CGRect(x: 30, y: self.Vinew.frame.size.height - 30, width: 20, height: 20))
                      // button.setTitle("mute", for: .normal)
                       button.setBackgroundImage(UIImage(named: "unmute"), for: .normal)
                       button.setTitleColor(.red, for: .normal)
                       button.tag = i
                       button.addTarget(self, action: #selector(mutevideo(_:)), for: .touchUpInside)
                       
                        imgView.addSubview(button)
            
            if banerdata[i]["isimage"] == "1"
            {
                button.isHidden = true
                avPlayerLayer.isHidden = true
                imgView.superview?.bringSubviewToFront(imgViewThumbnail)
            }else if banerdata[i]["isimage"] == "0"
            {
                 button.isHidden = false
                avPlayerLayer.isHidden = false
                imgView.superview?.sendSubviewToBack(imgViewThumbnail)
            }
            
                       imgView.superview?.bringSubviewToFront(button)
             filterPlayers.append(player)
            
        }
      
        filterScrollView?.isPagingEnabled = true
        filterScrollView?.contentSize = CGSize.init(width: CGFloat(banerdata.count) * size.width, height: size.height)
        filterScrollView?.backgroundColor = Appcolor.backgorund4
        filterScrollView?.delegate = self
        Vinew.addSubview(filterScrollView!)
         
        playVideos()
        }
    }
    @objc func cellTappedMethod(_ sender:AnyObject){
         print("you tap image number: \(sender.view.tag)")
      if  banerdata[sender.view.tag]["videourl"] == "1"
      {        guard let url = URL(string: banerdata[sender.view.tag]["actionurl"] ?? "") else { return }
          UIApplication.shared.open(url)
         
        
      }else if banerdata[sender.view.tag]["videourl"] == "2"
      {
        let storyBoard: UIStoryboard = UIStoryboard(name: "Main", bundle: nil)
                  let VC1 = storyBoard.instantiateViewController(withIdentifier: "FeedbackVC") as! FeedbackVC
                //https://funasia.net/bigfantvfeedback.funasia.net/addfeedback.html?
                
                //https://bigfantv.funasia.net/
                //https://funasia.net/bigfantv.funasia.net/
               VC1.planurl = banerdata[sender.view.tag]["actionurl"] ?? ""
                   
                let navController = UINavigationController(rootViewController: VC1) // Creating a navigation controller with VC1 at the root of the navigation stack.
                navController.navigationBar.barTintColor = Appcolor.backgorund4
                navController.modalPresentationStyle = .fullScreen
                 let textAttributes = [NSAttributedString.Key.foregroundColor:UIColor.white,NSAttributedString.Key.font: UIFont(name: "Muli-ExtraBold", size: 19)!]
                 navController.navigationBar.titleTextAttributes = textAttributes
                self.present(navController, animated:true, completion: nil)
        }
    }
    @objc func mutevideo( _ sender:UIButton)
    {
        for i in 0...filterPlayers.count - 1 {
                           if i == currentPage
                           {
                            if (filterPlayers[i])!.isMuted == true
                            {
                                sender.setBackgroundImage(UIImage(named: "unmute"), for: .normal)
                                (filterPlayers[i])!.isMuted = false
                            }else
                            {
                                sender.setBackgroundImage(UIImage(named: "mute"), for: .normal)
                                (filterPlayers[i])!.isMuted = true
                            }
                               
                                
                           }
                       }
    }
    func getThumbnailImage(forUrl url: URL) -> UIImage? {
        let asset: AVAsset = AVAsset(url: url)
        let imageGenerator = AVAssetImageGenerator(asset: asset)
        imageGenerator.appliesPreferredTrackTransform = true
        
        do {
            let thumbnailImage = try imageGenerator.copyCGImage(at: CMTimeMake(value: 1, timescale: 60) , actualTime: nil)
            return UIImage(cgImage: thumbnailImage)
        } catch let error {
            print(error)
        }
        
        return nil
    }
    
    func playVideos() {
        for i in 0...filterPlayers.count - 1 {
            playVideoWithPlayer((filterPlayers[i])!)
        }

        for i in 0...filterPlayers.count - 1 {
            if i != currentPage {
                (filterPlayers[i])!.pause()
            }
        }
    }
    
    func playVideoWithPlayer(_ player: AVPlayer) {
        player.playImmediately(atRate: 1.0)
       // player.play()
    }
   
   
   
    
    public func scrollViewDidScroll(_ scrollView: UIScrollView) {
        
        if scrollView == filterScrollView
        {
        let pageWidth : CGFloat = (filterScrollView?.frame.size.width)!
        let fractionalPage : Float = Float((filterScrollView?.contentOffset.x)! / pageWidth)
        let targetPage : NSInteger = lroundf(fractionalPage)
        
        if targetPage != currentPage {
            currentPage = targetPage
      
            for i in 0...filterPlayers.count - 1
            {
                if i == currentPage {
                    (filterPlayers[i])!.playImmediately(atRate: 1.0)
                } else {
                    (filterPlayers[i])!.pause()
                }
            }
        }
         
        
    }
    }
    
    func playVideoWithPlayer(_ player: AVPlayer, video:AVURLAsset, filterName:String) {
        
        let  avPlayerItem = AVPlayerItem(asset: video)
        
        if (filterName != "NoFilter") {
            let avVideoComposition = AVVideoComposition(asset: video, applyingCIFiltersWithHandler: { request in
                let source = request.sourceImage.clampedToExtent()
                let filter = CIFilter(name:filterName)!
                filter.setDefaults()
                filter.setValue(source, forKey: kCIInputImageKey)
                let output = filter.outputImage!
                request.finish(with:output, context: nil)
            })
            avPlayerItem.videoComposition = avVideoComposition
        }
        
        player.replaceCurrentItem(with: avPlayerItem)
        player.playImmediately(atRate: 1.0)
    }
    
    @objc func playerItemDidReachEnd(_ notification: Notification)
    {
 
                for i in 0...filterPlayers.count - 1 {
                    if i == currentPage {
                         
                        (filterPlayers[i])!.seek(to: CMTime.zero)
                        (filterPlayers[i])!.playImmediately(atRate: 1.0)
                    }
                }
    }
    
}

