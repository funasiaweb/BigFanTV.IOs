//
//  Radiocontainer.swift
//  bigfantv
//
//  Created by Ganesh on 12/11/20.
//  Copyright © 2020 Ganesh. All rights reserved.
//

import UIKit
import FirebaseFirestore
import Alamofire
class Radiocontainer: UIViewController, StackContainable {
    
         var Radioid = [String]()
    let RadioListdata:[RadioData] = [
        
           RadioData(Icon:"Funasia 104.9", Url: "https://ott.streann.com/loadbalancer/services/public/radios-secure/5b6e1d3a2cdc525067391d78/playlist.m3u8", Title: "Funasia 104.9"),
           RadioData(Icon: "Big FM 106.2", Url: "https://eu1.fastcast4u.com/proxy/dzcwbfih_eu?mp=/1", Title: "Big FM 106.2"),
           RadioData(Icon:"CHILLED LUV", Url: "http://funasia.streamguys1.com:80/live7", Title: "CHILLED LUV"),
           
           RadioData(Icon: "BEAT FM 97.8", Url: "https://funasia.streamguys1.com/live3", Title: "BEAT FM 97.8"),
           RadioData(Icon: "BEAT ANTHEMS", Url: "http://funasia.streamguys1.com:80/live5", Title: "BEAT ANTHEMS"),
          
           
           RadioData(Icon: "BIG MELODIES", Url: "https://funasia.streamguys1.com/live9", Title: "BIG MELODIES"),
            RadioData(Icon: "Radio Azad", Url: "https://usa2.fastcast4u.com/proxy/jgivvimk?mp=/1", Title: "Radio Azad"),
             RadioData(Icon:  "LUV LEGENDS", Url: "http://funasia.streamguys1.com:80/live8", Title: "LUV LEGENDS"),
          
           RadioData(Icon: "LUV FM 107.1", Url: "https://funasia.streamguys1.com/live3", Title: "LUV FM 107.1"),
           RadioData(Icon: "URBAN BEAT", Url: "http://funasia.streamguys1.com:80/live6", Title: "URBAN BEAT"),
           RadioData(Icon:"Radio Mirchi", Url: "https://streams.radio.co/s8d06d0298/listen", Title: "Radio Mirchi")
         
                     ]
    var filteredArray = [RadioData]()
    
    struct Favorite {
      let name: String
    }
     var finalradio = [Favorite]()
    
    let cellIdentifier = "cell"
    var category = ""
    var subcategory = ""
    var Radiotitle = ""
    var Radiourl = ""
    var isradioavailable = 0
    @IBOutlet var CollectionV: UICollectionView!
   
    public static func create() -> Radiocontainer {
        return UIStoryboard(name: "Containers", bundle: Bundle.main).instantiateViewController(withIdentifier: "Radiocontainer") as! Radiocontainer
    }
    let manager: Alamofire.SessionManager = {
        let configuration = URLSessionConfiguration.default
         configuration.timeoutIntervalForRequest = TimeInterval(60)
        configuration.timeoutIntervalForResource = TimeInterval(60)
        return  Alamofire.SessionManager(configuration: configuration)
    }()
      var Radiodynamicdata:FavouriteRadioData?
    public override func viewDidLoad() {
        super.viewDidLoad()
        self.CollectionV.register(UINib(nibName:"LnagCellFeatured", bundle:nil), forCellWithReuseIdentifier: cellIdentifier)
       //     customClassGetDocument()
        Getimagelist { (true) in
            print("done")
        }
    }
    func Getimagelist( completionBlock: @escaping (Bool) -> Void) -> Void
    {
        do
        {
            let url:URL = URL(string: "https://funasia.net/bigfantv.funasia.net/service/getRadioFavourite.html")!
            guard let parameters =
                [
                    "userId":UserDefaults.standard.string(forKey: "id") ?? "",
                    "AccessToken":UserDefaults.standard.string(forKey:"AccessToken") ?? ""
                ] as? [String:Any] else { return  }
  
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
                            self.Radiodynamicdata = try decoder.decode(FavouriteRadioData.self, from: response.data  ?? Data())
             
                            if self.Radiodynamicdata?.favouriteRadioList.count ?? 0 > 0
                            {
                                completionBlock(true)
                                self.isradioavailable = 1
                            }else
                            {
                                completionBlock(false)
                                self.isradioavailable = 0
                            }
                            self.CollectionV.delegate = self
                            self.CollectionV.dataSource = self
              
                            DispatchQueue.main.async
                                {
                                    self.CollectionV.reloadData()
                                }
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
    private func customClassGetDocument() {
                            
                   guard let userid = UserDefaults.standard.string(forKey: "id")    else {return}
           let docRef = Firestore.firestore().collection("UserPreference").document(userid)

              docRef.getDocument { (document, error) in
               if let err = error
               {
                     print("Error fetch document: \(err)")
               }
               else
               {
                   guard let data = document?.data() else {return}
                self.Radioid =  data["Radio"] as? [String] ?? [String]()
                    
                   for i in self.Radioid
                   {
                       let f = Favorite(name: i)
                       self.finalradio.append(f)
                   }
                   
      let favoriteNames = self.finalradio.map { $0.name }
         self.filteredArray = self.RadioListdata.filter {  favoriteNames.contains($0.Title) }

                                    
                                    
                                    
                                  self.CollectionV.delegate = self
                                  self.CollectionV.dataSource = self
                                   self.CollectionV.reloadData()
                               
                                  Utility.hideLoader(vc: self)
                                  
                                 }

                      }
    }
              
    public func preferredAppearanceInStack() -> ScrollingStackController.ItemAppearance {
        return .view(height: 170)
    }
    
}
extension Radiocontainer:UICollectionViewDelegate,UICollectionViewDataSource
{
    public func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return Radiodynamicdata?.favouriteRadioList.count ?? 0
    }
    public func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
       
             let Comedycell = collectionView.dequeueReusableCell(withReuseIdentifier: cellIdentifier, for: indexPath) as! LnagCellFeatured
        
        Comedycell.ImgLang.sd_setImage(with: URL(string: Radiodynamicdata?.favouriteRadioList[indexPath.row].radioImage ?? ""), completed: nil)
        Comedycell.LbLang.text = Radiodynamicdata?.favouriteRadioList[indexPath.row].title
         
             return Comedycell
    
          
    }
    
    
    public func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
       let storyBoard: UIStoryboard = UIStoryboard(name: "Main", bundle: nil)
                               
        let displayVC = storyBoard.instantiateViewController(withIdentifier: "RadioDetailsVC") as! RadioDetailsVC
           displayVC.modalPresentationStyle = .fullScreen
                         
              displayVC.Videourl = Radiodynamicdata?.favouriteRadioList[indexPath.row].radioURL ?? ""
              displayVC.Videotitle = Radiodynamicdata?.favouriteRadioList[indexPath.row].title ?? ""
              displayVC.isfavourite  = Radiodynamicdata?.favouriteRadioList[indexPath.row].isFavourite ?? ""
              displayVC.radioid =  Radiodynamicdata?.favouriteRadioList[indexPath.row].radioID ?? ""
            
          self.present(displayVC, animated: true, completion: nil)
                                
        
    }
    
}
extension Radiocontainer: UICollectionViewDelegateFlowLayout
{
    public func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
           /*
            if UIDevice.current.userInterfaceIdiom == .pad
            {
                return CGSize(width: collectionView.frame.size.height + 40, height:collectionView.frame.size.height)
            }
            else if UIDevice.current.userInterfaceIdiom == .phone
            {
              
                
                return CGSize(width: collectionView.frame.size.height, height: collectionView.frame.size.height)
             }
            */
            return CGSize(width: collectionView.frame.size.height, height: collectionView.frame.size.height)
        }
     
   
    }
 
