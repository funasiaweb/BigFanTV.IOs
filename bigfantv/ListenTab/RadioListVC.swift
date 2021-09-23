//
//  RadioListVC.swift
//  bigfantv
//
//  Created by Ganesh on 30/07/20.
//  Copyright © 2020 Ganesh. All rights reserved.
//

import UIKit
import Alamofire
import SDWebImage
import MuviAudioPlayer
class RadioListVC: UIViewController {

   private var ComedyMoviedata:newFilteredComedyMovieList?
        private var passComedyMoviedata:newFilteredComedyMovieList?
        private var ThrillerMoviedata:newFilteredComedyMovieList?
        private var ActionMoviedata:newFilteredComedyMovieList?
    var muviPlayer = MuviAudioMiniView()
   var managers = MuviAudioPlayerManager()
    @IBOutlet var MuviPLayerView: UIView!
    var audioname  = ""

        @IBOutlet var ComedyCollectionV: UICollectionView!
         var radioid = ""
        @IBOutlet var ThrillerCollectionV: UICollectionView!
        
        @IBOutlet var ActionCollectioV: UICollectionView!
        
    let manager: Alamofire.SessionManager = {
            let configuration = URLSessionConfiguration.default
             configuration.timeoutIntervalForRequest = TimeInterval(60)
            configuration.timeoutIntervalForResource = TimeInterval(60)
            return  Alamofire.SessionManager(configuration: configuration)
        }()
         var Radiodynamicdata:FavRadiodata?
        /*
     1) Radio Mirchi- https://streams.radio.co/s8d06d0298/listen
     2) Funasia 104.9 FM - https://ott.streann.com/loadbalancer/services/public/radios-secure/5b6e1d3a2cdc525067391d78/playlist.m3u8
     3) Radio Azad - https://usa2.fastcast4u.com/proxy/jgivvimk?mp=/1
     4) Big FM 106.2 - https://eu1.fastcast4u.com/proxy/dzcwbfih_eu?mp=/1
     5) LUV FM 107.1 - https://funasia.streamguys1.com/live2
     6) BEAT FM 97.8 - https://funasia.streamguys1.com/live3
     */
    /*
    let RadioListdata:[RadioData] =
        
        [
            RadioData(Icon:"Funasia 104.9", Url: "https://ott.streann.com/loadbalancer/services/public/radios-secure/5b6e1d3a2cdc525067391d78/playlist.m3u8", Title: "Funasia 104.9"),
            RadioData(Icon: "Big FM 106.2", Url: "https://funasia.streamguys1.com/live4", Title: "Big FM 106.2"),
            RadioData(Icon: "BEAT FM 97.8", Url: "https://funasia.streamguys1.com/live3", Title: "BEAT FM 97.8"),
            RadioData(Icon: "LUV FM 107.1", Url: "https://funasia.streamguys1.com/live3", Title: "LUV FM 107.1"),
            RadioData(Icon: "Radio Azad", Url: "https://usa2.fastcast4u.com/proxy/jgivvimk?mp=/1", Title: "Radio Azad"),
            RadioData(Icon: "BIG MELODIES", Url: "https://funasia.streamguys1.com/live9", Title: "BIG MELODIES"),
            RadioData(Icon:  "LUV LEGENDS", Url: "http://funasia.streamguys1.com:80/live8", Title: "LUV LEGENDS"),
            RadioData(Icon:"CHILLED LUV", Url: "http://funasia.streamguys1.com:80/live7", Title: "CHILLED LUV"),
            RadioData(Icon: "URBAN BEAT", Url: "http://funasia.streamguys1.com:80/live6", Title: "URBAN BEAT"),
            RadioData(Icon: "BEAT ANTHEMS", Url: "http://funasia.streamguys1.com:80/live5", Title: "BEAT ANTHEMS"),
            RadioData(Icon:"Radio Mirchi", Url: "https://streams.radio.co/s8d06d0298/listen", Title: "Radio Mirchi")
        ]
    */
           static var isfrom = 0
        
           static var toviewall = 0
           var imagename = ""
           var moviename = ""
           var movietype = ""
           var timereleasedate  = ""
           var language = ""
           var movdescription: String = ""
           var isfavourite = ""
           var totalcount = 0
           let cellIdentifier  = "cell"
           var Videourl = ""
           var Videotitle = ""
  
  
    override func viewDidLoad()
    {
        super.viewDidLoad()

        self.ComedyCollectionV.register(UINib(nibName:"Radiocell", bundle:nil), forCellWithReuseIdentifier: cellIdentifier)
    }
    
    override func viewWillAppear(_ animated: Bool)
    {
       self.MuviPLayerView.isHidden = true
    
        MuviAudioPlayerManager.shared.playbackDelegate = self
    }
    
    override func viewDidAppear(_ animated: Bool)
    {
        if Connectivity.isConnectedToInternet()
        {
            self.GetRadioist()
        }
    }
       
    func GetRadioist()
    {
        Utility.ShowLoader(vc: self)
            
        do
           {
            guard let parameters =
                        [
                            "userId":UserDefaults.standard.string(forKey: "id") ?? "",
                            "AccessToken":UserDefaults.standard.string(forKey:"AccessToken") ?? ""
                         ] as? [String:Any] else { return  }
                    
            let url:URL = URL(string: "https://funasia.net/bigfantv.funasia.net/service/getAllRadioList.html")!
                    
            self.manager.request(url, method: .post, parameters: parameters, encoding: JSONEncoding.default, headers: nil).responseJSON { (response) in
            
                Utility.hideLoader(vc: self)
  
                switch response.result
                {
 
                case .success(_):
                                  
                    if response.value != nil
                    {
                        do
                          {
                            let decoder = JSONDecoder()
                            self.Radiodynamicdata = try decoder.decode(FavRadiodata.self, from: response.data  ?? Data())
        
                            if self.Radiodynamicdata?.favouriteRadioList.count ?? 0 > 0
                            {
                                self.ComedyCollectionV.delegate = self
                                self.ComedyCollectionV.dataSource = self
         
                                DispatchQueue.main.async
                               {
                                    self.ComedyCollectionV.reloadData()
                               }
                            }else
                            {
                                self.ComedyCollectionV.setEmptyViewnew1(title: "No Radio available.")
                            }

                          }
                        catch let error
                        {
                            Utility.showAlert(vc: self, message: error.localizedDescription, titelstring: "")
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
        {         //  Utility.showAlert(vc: self, message:"\(error)", titelstring: Appcommon.Appname)
        }
        
    }
    }

    
extension RadioListVC:UICollectionViewDelegate,UICollectionViewDataSource
{
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int
    {
        return self.Radiodynamicdata?.favouriteRadioList.count ?? 0
    }
        
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell
    {
        if let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cell", for: indexPath)as? Radiocell
        {
     
            cell.ImgSample.sd_setImage(with: URL(string: Radiodynamicdata?.favouriteRadioList[indexPath.row].radioImage ?? ""), completed: nil)
                     //  cell.LbChannel.text = Radiodynamicdata?.favouriteRadioList[indexPath.row].title
               
            return cell
        }
        return UICollectionViewCell()
       
    }
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath)
    {
        
        if collectionView == ComedyCollectionV
            {
 
                UIView.animate(withDuration: 0.1)
                {
                    self.MuviPLayerView.isHidden = false
                }
                
            Videourl = Radiodynamicdata?.favouriteRadioList[indexPath.row].radioURL ?? ""
            Videotitle = Radiodynamicdata?.favouriteRadioList[indexPath.row].title ?? ""
            isfavourite  = Radiodynamicdata?.favouriteRadioList[indexPath.row].isFavourite ?? ""
            radioid =  Radiodynamicdata?.favouriteRadioList[indexPath.row].radioID ?? ""
            
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

                guard let songurl = URL(string: Videourl) else {return}
                guard let songImageurl = URL(string:  Radiodynamicdata?.favouriteRadioList[indexPath.row].radioImage ?? "") else {return}

              //  print("name === \(self.contentdata?.submovie?.name)")
              //  print("titlename === \(self.contentdata?.submovie?.custom3)")

                let song = MuviAudioPlayerItemInfo(id: "",
                                                            url: songurl,
                                                            title:Videotitle,
                                                            albumTitle: "",
                                                            coverImageURL: songImageurl)
                //MuviAudioPlayerManager.shared.setup(with:[song])
                var playeritems: [MuviAudioPlayerItemInfo] = []
                playeritems.append(song)
                for i in Radiodynamicdata?.favouriteRadioList ?? [FavouriteRadioList]()
                {
                    if i.title != Videotitle
                    {
                        guard let songurl = URL(string: i.radioURL ) else {return}
                        guard let songImageurl = URL(string:  i.radioImage ) else {return}
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
        
extension RadioListVC: UICollectionViewDelegateFlowLayout
    {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize
    {
                /*
                if UIDevice.current.userInterfaceIdiom == .pad
                {
                    return CGSize(width:  collectionView.frame.size.height + 40, height:collectionView.frame.size.height)
                }
                else if UIDevice.current.userInterfaceIdiom == .phone
                {
                    let height = collectionView.frame.size.width/2 - 5
                   return CGSize(width:height , height:height)
                         
                       }
                */
               let height = collectionView.frame.size.width/2 - 5
                return CGSize(width:height , height:height)
    }
    
}
    
extension RadioListVC:MuviAudioPlayerDelegate
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

 
