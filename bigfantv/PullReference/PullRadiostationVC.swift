//
//  PullRadiostationVC.swift
//  bigfantv
//
//  Created by Ganesh on 15/07/20.
//  Copyright © 2020 Ganesh. All rights reserved.
//

import UIKit
import FirebaseFirestore
import MaterialComponents.MDCButton
import Alamofire
class PullRadiostationVC: UIViewController {
   
    let manager: Alamofire.SessionManager = {
          let configuration = URLSessionConfiguration.default
           configuration.httpMaximumConnectionsPerHost = 70
           configuration.timeoutIntervalForRequest = TimeInterval(60)
          configuration.timeoutIntervalForResource = TimeInterval(60)
          return  Alamofire.SessionManager(configuration: configuration)
      }()

    var Radiodynamicdata:FavRadiodata?
    var faVdata:successFavouriteRadioList?
         var arrSelectedIndex = [IndexPath]()
        var arrSelectedData = [String]()
  
           
         let arr = ["funasia_radio2",
                    "big_radio2",
                    "bigm5",
                    "beat_radio2",
                    "bigm3",
                     "bigm7",
                    "azad2",
                    "bigm6",
                    "lov_radio2",
                    "bigm4",
                    "mirchi_radio2"]
        let namearr =
            [ "Funasia 104.9",
              "Big FM 106.2",
              "CHILLED LUV",
              "BEAT FM 97.8",
              "BEAT ANTHEMS",
              "BIG MELODIES",
              "Radio Azad",
              "LUV LEGENDS",
              "LUV FM 107.1",
              "URBAN BEAT",
              "Radio Mirchi"]
        var Radioid = [String]()
        var isshown = false
        @IBOutlet var CollectionV: UICollectionView!
        
        override func viewDidLoad() {
            super.viewDidLoad()
          
            
        }
        
        override func viewDidAppear(_ animated: Bool) {
                    let viewright = UIView(frame: CGRect(x:  0, y: 0, width: 50,height: 30))
                                       viewright.backgroundColor = UIColor.clear
                let  button4 = UIButton(frame: CGRect(x: 0,y: 0, width: 30, height: 30))
                     button4.setImage(UIImage(named: "backarrow"), for: UIControl.State.normal)
                     button4.setTitle("close", for: .normal)
                     button4.addTarget(self, action: #selector(close), for: UIControl.Event.touchUpInside)
               
                   viewright.addSubview(button4)
                               
                   let leftbuttton = UIBarButtonItem(customView: viewright)
                    self.navigationItem.leftBarButtonItem = leftbuttton
                  
            //customClassGetDocument()
            if Connectivity.isConnectedToInternet()
            {
                Getimagelist()
            }
    }
                          @objc func close()
                          {
                            self.navigationController?.popViewController(animated: true)
                          }
        
        
        @IBAction func FinishBttapped(_ sender: MDCButton) {
                self.performSegue(withIdentifier: "Backtotab", sender: self)
        }
    func Getimagelist()
                {
                 //https://bigfantv.funasia.net/service/getBannerList.html
                   Utility.ShowLoader(vc: self)
                  
                           do
                           {
                               
                           /*
                             let feature12 = [  "titleimage":"newlogo","isimage":"1","videourl":"https://d73o4i22vgk5h.cloudfront.net/45921/RawVideo/uploads/videobanner/21/breaking_news_intro_maker_featuring_an_animated_logo_729.mp4"]
                             self.banerdata.append(feature12)
                           */

                                 guard let parameters =
                                     [
                                       "userId":UserDefaults.standard.string(forKey: "id") ?? "",
                                        "AccessToken":UserDefaults.standard.string(forKey:"AccessToken") ?? ""
                                        
                                         ] as? [String:Any] else { return  }
                             
                             let url:URL = URL(string: "https://funasia.net/bigfantv.funasia.net/service/getAllRadioList.html")!
                                  
                                  
                                  
                                  
                                 
                             self.manager.request(url, method: .post, parameters: parameters, encoding: JSONEncoding.default, headers: nil).responseJSON { (response) in
                               print("data from common function")
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
           
                                               self.CollectionV.delegate = self
                                               self.CollectionV.dataSource = self
            
                                               DispatchQueue.main.async {
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
    
    @IBAction func PreviousBtTapped(_ sender: UIButton) {
        self.navigationController?.popViewController(animated: true)
    }
    
        private func customClassGetDocument() {
                              // [START custom_type]
                       
                       Utility.ShowLoader(vc: self)
                   
                           guard let userid = UserDefaults.standard.string(forKey: "id")    else {return}
                           let docRef = Firestore.firestore().collection("UserPreference").document(userid)

                              docRef.getDocument { (document, error) in
                               if let err = error
                               {
                                     print("Error fetch document: \(err)")
                               }
                               else {
                                   guard let data = document?.data() else {return}
                                self.Radioid =  data["Radio"] as? [String] ?? [String]()
                                    }
                               
                              
                               self.CollectionV.delegate = self
                               self.CollectionV.dataSource = self
                                self.CollectionV.reloadData()
                            
                               Utility.hideLoader(vc: self)
                               
                              }

                   }
           
                 func updatedata()
                 {
                    
                    guard let userid = UserDefaults.standard.string(forKey: "id") else   {return}
                             
                           Firestore.firestore().collection("UserPreference").document(userid).updateData([
                                       "Radio":arrSelectedData
                                  ]) { err in
                                      if let err = err {
                                          print("Error updating document: \(err)")
                                      } else {
                                        self.performSegue(withIdentifier: "Backtotab", sender: self)
                                          print("Data successfully updated")
                                      }
                                  }
               
                }
         
    //
    }

    extension PullRadiostationVC:UICollectionViewDelegate,UICollectionViewDataSource
    {
        func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
           return self.Radiodynamicdata?.favouriteRadioList.count ?? 0
        }
        
        func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
              if let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cell", for: indexPath)as? Newlangcell
            {
                  
                cell.ImgCell.sd_setImage(with: URL(string: Radiodynamicdata?.favouriteRadioList[indexPath.row].radioImage ?? ""), completed: nil)
                cell.LbChannel.text = Radiodynamicdata?.favouriteRadioList[indexPath.row].title
                
                   let image = Radiodynamicdata?.favouriteRadioList[indexPath.row].isFavourite ==  "1"  ? UIImage(named: "check-marknew") : nil
                        cell.ImgSelected.image = image
                     
                      return cell
                      }
 
                      return UICollectionViewCell()
        }
        
      func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath){
 
        let item = Radiodynamicdata?.favouriteRadioList[indexPath.row]
        if item?.isFavourite ==  "0"
        {
            
            self.AddtoFav(movieuniqidx: item?.radioID ?? "", endpoint: 1) { (true) in
            collectionView.reloadData()
                self.Radiodynamicdata?.favouriteRadioList[indexPath.row].isFavourite =  "1"
               
               
        }
        }else if item?.isFavourite ==  "1"
        {
            
            self.AddtoFav(movieuniqidx: item?.radioID ?? "", endpoint: 0) { (true) in
            collectionView.reloadData()
                self.Radiodynamicdata?.favouriteRadioList[indexPath.row].isFavourite =  "0"
             
        }
        }

               
        }
        func AddtoFav(movieuniqidx:String,endpoint:Int, completionBlock: @escaping (Bool) -> Void) -> Void
        {
            
 //https://funasia.net/bigfantv.funasia.net/service/saveFavouriteRadio.html
            guard let parameters =
                [
                   "userId":UserDefaults.standard.string(forKey: "id") ?? "",
                   "AccessToken":UserDefaults.standard.string(forKey:"AccessToken") ?? "",
                   "radioId":movieuniqidx,
                   "isFavourite":"\(endpoint)"
                   
                    ] as? [String:Any] else { return  }
          print(parameters)
 
            let url = "https://funasia.net/bigfantv.funasia.net/service/saveFavouriteRadio.html"
            Alamofire.request(url, method: .post, parameters: parameters, encoding: JSONEncoding.default, headers: nil).responseJSON { (data) in
                do
                {
                    
                    let decoder = JSONDecoder()
                    let fafcdata = try decoder.decode(successFavouriteRadioList.self, from: data.data ?? Data())
                    if fafcdata.Success == 1
                    {
                        completionBlock(true)
                    }
                    
                }catch
                {
                    print(error.localizedDescription)
                }
            }
            
        }

         
        
        
    }

    extension PullRadiostationVC: UICollectionViewDelegateFlowLayout
         {
                 func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
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
