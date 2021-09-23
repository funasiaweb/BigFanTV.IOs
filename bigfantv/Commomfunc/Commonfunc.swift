//
//  Commonfunc.swift
//  bigfantv
//
//  Created by Ganesh on 15/12/20.
//  Copyright © 2020 Ganesh. All rights reserved.
//

import Foundation
import AVKit
import Alamofire
 class CommonApiEndPoints
 {
  static let getRadioFavourite  = "getRadioFavourite.html"
  static let getlivetvList  = "getlivetvList.html"
  static let getSpecificCategoryLiveTv  = "getSpecificCategoryLiveTv.html"
  static let saveFavouriteLiveTv  = "saveFavouriteLiveTv.html"
  static let getFavouriteLiveTv  = "getFavouriteLiveTv.html"
  static  let getAllPodcastList = "getAllPodcastList.html"
    static let GetPpvPlan = "GetPpvPlan"
    static let getAllAudioVideoPodcastList = "getAllAudioVideoPodcastList.html"
    static let getSpecificCategoryWisePodcast = "getSpecificCategoryWisePodcast.html"
   
 }
class Common
{
     static let shared = Common()
      private init(){}
     typealias handlers = ((_ response: newFilteredComedyMovieList?, _ error: Error?) -> (Void))
    typealias handledata = ((_ response: Data?, _ error: Error?) -> (Void))
      static let manager: Alamofire.SessionManager = {
        let configuration = URLSessionConfiguration.default
       // configuration.httpMaximumConnectionsPerHost = 70
        configuration.timeoutIntervalForRequest = 20
       configuration.timeoutIntervalForResource = 20
       return  Alamofire.SessionManager(configuration: configuration)
   }()
       static let manager1: Alamofire.SessionManager = {
        let configuration = URLSessionConfiguration.default
        
       //  configuration.httpMaximumConnectionsPerHost = 70
         configuration.timeoutIntervalForRequest = TimeInterval(60)
        configuration.timeoutIntervalForResource = TimeInterval(60)
        return  Alamofire.SessionManager(configuration: configuration)
    }()
       static let manager2: Alamofire.SessionManager = {
        let configuration = URLSessionConfiguration.default
     //    configuration.httpMaximumConnectionsPerHost = 70
         configuration.timeoutIntervalForRequest =  60
        configuration.timeoutIntervalForResource =  60
        return  Alamofire.SessionManager(configuration: configuration)
    }()
    
    
  func getfeiltereddata(  category:String,subcategory: String, completion: @escaping handlers) -> Void
      
      {
    guard let parameters =
        [
            "authToken" : "57b8617205fa3446ba004d583284f475",
            "category" : category,
            "subcategory" : subcategory,
            "limit" :4,
            "offset" : 1,
             
            "user_id":UserDefaults.standard.string(forKey: "id") ?? "",
           "is_episode":0
            ] as? [String:Any] else { return  }
       
        let url:URL = URL(string: "https://bigfantv.com/en/rest/getFilteredContent")!
        
        Alamofire.request(url, method: .post, parameters: parameters, encoding: JSONEncoding.default, headers: nil).validate().response  { (response) in

             
            if let data = response.data {
                do
                {
                    let decoder = JSONDecoder()
                    let data = try decoder.decode(newFilteredComedyMovieList.self, from:  data )
                    if data.status == "OK"
                    {
                     completion(data,nil)
                    }
                     }
                     catch let error
                     {
                         print(error.localizedDescription)
                     }

            }
        }
         
       // manager.session.configuration.httpMaximumConnectionsPerHost = 50
        /*
        manager.request(url, method: .post, parameters: parameters, encoding: JSONEncoding.default, headers: nil).responseJSON { (response) in
    
            switch response.result
            {

       
            case .success(_):
           
                if response.value != nil
                {
                    do
                    {
                        let decoder = JSONDecoder()
                        let data = try decoder.decode(newFilteredComedyMovieList.self, from: response.data ?? Data())
                        if data.status == "OK"
                        {
                         completion(data,nil)
                        }
                         }
                         catch let error
                         {
                             print(error.localizedDescription)
                         }
            }
            break
        case .failure(let error):
            print(error)
            break
        }
    }
        */
    }
      func getfeiltereddataother(  category:String,subcategory:String, completion: @escaping handlers) -> Void
      
      {
    guard let parameters =
        [
            "authToken" : "57b8617205fa3446ba004d583284f475",
            "category" : category,
            "subcategory" : subcategory,
            "limit" :4,
            "offset" : 1,
             
            "user_id":UserDefaults.standard.string(forKey: "id") ?? "",
           "is_episode":0
            ] as? [String:Any] else { return  }
       
        let url:URL = URL(string: "https://bigfantv.com/en/rest/getFilteredContent")!
        
        
        
         
       // manager.session.configuration.httpMaximumConnectionsPerHost = 50
        Common.manager2.request(url, method: .post, parameters: parameters, encoding: JSONEncoding.default, headers: nil).responseJSON { (response) in
     
            switch response.result
            {

       
            case .success(_):
           
                if response.value != nil
                {
                    do
                    {
                        let decoder = JSONDecoder()
                        let data = try decoder.decode(newFilteredComedyMovieList.self, from: response.data ?? Data())
                        if data.status == "OK"
                        {
                         completion(data,nil)
                        }
                         }
                         catch let error
                         {
                             print(error.localizedDescription)
                         }
            }
            break
        case .failure(let error):
            print(error)
            break
        }
    }
    }
      func getfeiltereddataw(  category:String,subcategory:String, completion: @escaping handlers) -> Void
         
         {
       guard let parameters =
           [
               "authToken" : "57b8617205fa3446ba004d583284f475",
               "category" : category,
               "subcategory" : subcategory,
               "limit" :4,
               "offset" : 1,
                
               "user_id":UserDefaults.standard.string(forKey: "id") ?? "",
              "is_episode":0
               ] as? [String:Any] else { return  }
          
           let url:URL = URL(string: "https://bigfantv.com/en/rest/getFilteredContent")!
           
           
           
            
          // manager.session.configuration.httpMaximumConnectionsPerHost = 50
            Common.manager1.request(url, method: .post, parameters: parameters, encoding: JSONEncoding.default, headers: nil).responseJSON { (response) in
        
               switch response.result
               {

          
               case .success(_):
              
                   if response.value != nil
                   {
                       do
                       {
                           let decoder = JSONDecoder()
                           let data = try decoder.decode(newFilteredComedyMovieList.self, from: response.data ?? Data())
                           if data.status == "OK"
                           {
                            completion(data,nil)
                           }
                            }
                            catch let error
                            {
                                print(error.localizedDescription)
                            }
               }
               break
           case .failure(let error):
               print(error)
               break
           }
       }
       }
      func getfeiltereddata1(  category:String,subcategory:String, completion: @escaping handlers) -> Void
       
       {
     guard let parameters =
         [
             "authToken" : "57b8617205fa3446ba004d583284f475",
             "category" : category,
             "subcategory" : subcategory,
             "limit" :4,
             "offset" : 1,
             
             "user_id":UserDefaults.standard.string(forKey: "id") ?? "",
            
             ] as? [String:Any] else { return  }
        
         let url:URL = URL(string: "https://bigfantv.com/en/rest/getFilteredContent")!
         
         
         
         
        
        Common.manager.request(url, method: .post, parameters: parameters, encoding: JSONEncoding.default, headers: nil).responseJSON { (response) in
      print("data from common function")
             switch response.result
             {

        
             case .success(_):
            
                 if response.value != nil
                 {
                     do
                     {
                         let decoder = JSONDecoder()
                         let data = try decoder.decode(newFilteredComedyMovieList.self, from: response.data ?? Data())
                         if data.status == "OK"
                         {
                          completion(data,nil)
                         }
                          }
                          catch let error
                          {
                              print(error.localizedDescription)
                          }
             }
             break
         case .failure(let error):
             print(error)
             break
         }
     }
     }
       func getfeiltereddata2(  category:String,subcategory:String, completion: @escaping handlers) -> Void
        
        {
      guard let parameters =
          [
              "authToken" : "57b8617205fa3446ba004d583284f475",
              "category" : category,
              "subcategory" : subcategory,
              "limit" :4,
              "offset" : 1,
               
              "user_id":UserDefaults.standard.string(forKey: "id") ?? "",
             
              ] as? [String:Any] else { return  }
         
          let url:URL = URL(string: "https://bigfantv.com/en/rest/getFilteredContent")!
          
          
          
          
         // manager.session.configuration.httpMaximumConnectionsPerHost = 50
            Common.manager.request(url, method: .post, parameters: parameters, encoding: JSONEncoding.default, headers: nil).responseJSON { (response) in
       
              switch response.result
              {

         
              case .success(_):
             
                  if response.value != nil
                  {
                      do
                      {
                          let decoder = JSONDecoder()
                          let data = try decoder.decode(newFilteredComedyMovieList.self, from: response.data ?? Data())
                          
                           completion(data,nil)
     
                           }
                           catch let error
                           {
                               print(error.localizedDescription)
                           }
              }
              break
          case .failure(let error):
              print(error)
              break
          }
      }
      }
      func Commonapi(  parameters:[String:Any] ,urlString:String, completion: @escaping handledata) -> Void
         {
            
            
            let urlStr = "https://funasia.net/bigfantv.funasia.net/service/" + urlString
                       
            _ = urlStr.addingPercentEncoding(withAllowedCharacters: CharacterSet.urlQueryAllowed)

            Common.manager.request(urlStr, method: .post, parameters: parameters, encoding: JSONEncoding.default, headers: nil).responseJSON { (response) in
        
            
               switch response.result
               {
               case .success(_):
              
                   if response.value != nil
                   {
                  //  print(response)
                        completion(response.data,nil)
                   }
               break
           case .failure(let error):
               print(error)
               break
           }
       }
       }
    static func getpodcastdata(  category:String,subcategory:String,vc:UIViewController ,completion: @escaping handledata) -> Void
         
         {
            
       guard let parameters =
           [
               "authToken" : "57b8617205fa3446ba004d583284f475",
               "category" : category,
               "subcategory" : subcategory,
               "limit" :4,
               "offset" : 1,
                
               "country_code" : "USA",
               "user_id":UserDefaults.standard.string(forKey: "id") ?? "",
              "is_episode":0
               ] as? [String:Any] else { return  }
          
           let url:URL = URL(string: "https://bigfantv.com/en/rest/getFilteredContent")!
           
             Utility.ShowLoader(vc: vc)
           
           let manager = Alamofire.SessionManager.default
          // manager.session.configuration.httpMaximumConnectionsPerHost = 50
           manager.request(url, method: .post, parameters: parameters, encoding: JSONEncoding.default, headers: nil).responseJSON { (response) in
             Utility.hideLoader(vc: vc)
               switch response.result {

          
               case .success(_):
              
                   if response.value != nil
                   {
                       do
                       {
                           let decoder = JSONDecoder()
                           
                        completion(response.data,nil)
      
                            }
                            catch let error
                            {
                                print(error.localizedDescription)
                            }
               }
               break
           case .failure(let error):
               print(error)
               break
           }
       }
       }
    static func getcontentdata(moviecategory:String,moviesubcategory:String,endpoint:String ,vc:UIViewController,offst:Int, completionBlock: @escaping (newFilteredComedyMovieList) -> Void) -> Void
    {
        Api.Getconent8(moviecategory, subCat: moviesubcategory , endpoint: endpoint, vc: vc, offset: offst) { (result, err) -> (Void) in
            do
            {
                 let decoder = JSONDecoder()
                 let data = try decoder.decode(newFilteredComedyMovieList.self, from: result  ?? Data())
                if data.subComedymovList != nil
                {
                    if data.subComedymovList.count > 0
                    {
                        if data.status == "OK" && data.code == 200
                        {
                            
                            completionBlock(data)
                            
                        }
                    }
                    
                }
 
            }
            catch let error
            {
                print(error.localizedDescription)
            }
            
             
        }
    }
    
    
}
class Common1
{
     typealias handlers = ((_ response: newFilteredComedyMovieList?, _ error: Error?) -> (Void))
    typealias handledata = ((_ response: Data?, _ error: Error?) -> (Void))
      static let manager: Alamofire.SessionManager = {
        let configuration = URLSessionConfiguration.default
       // configuration.httpMaximumConnectionsPerHost = 70
        configuration.timeoutIntervalForRequest = 20
       configuration.timeoutIntervalForResource = 20
       return  Alamofire.SessionManager(configuration: configuration)
   }()
       static let manager1: Alamofire.SessionManager = {
        let configuration = URLSessionConfiguration.default
         //configuration.httpMaximumConnectionsPerHost = 70
         configuration.timeoutIntervalForRequest = TimeInterval(60)
        configuration.timeoutIntervalForResource = TimeInterval(60)
        return  Alamofire.SessionManager(configuration: configuration)
    }()
       static let manager2: Alamofire.SessionManager = {
        let configuration = URLSessionConfiguration.default
       //  configuration.httpMaximumConnectionsPerHost = 70
         configuration.timeoutIntervalForRequest =  60
        configuration.timeoutIntervalForResource =  60
        return  Alamofire.SessionManager(configuration: configuration)
    }()
    
    
   static func getfeiltereddata(  category:String,subcategory:String, completion: @escaping handlers) -> Void
      
      {
    guard let parameters =
        [
            "authToken" : "57b8617205fa3446ba004d583284f475",
            "category" : category,
            "subcategory" : subcategory,
            "limit" :4,
            "offset" : 1,
             
            "user_id":UserDefaults.standard.string(forKey: "id") ?? "",
           "is_episode":0
            ] as? [String:Any] else { return  }
       
        let url:URL = URL(string: "https://bigfantv.com/en/rest/getFilteredContent")!
        
        
        
         
       // manager.session.configuration.httpMaximumConnectionsPerHost = 50
         
        manager.request(url, method: .post, parameters: parameters, encoding: JSONEncoding.default, headers: nil).responseJSON { (response) in
    
            switch response.result
            {

       
            case .success(_):
           
                if response.value != nil
                {
                    do
                    {
                        let decoder = JSONDecoder()
                        let data = try decoder.decode(newFilteredComedyMovieList.self, from: response.data ?? Data())
                        if data.status == "OK"
                        {
                         completion(data,nil)
                        }
                         }
                         catch let error
                         {
                             print(error.localizedDescription)
                         }
            }
            break
        case .failure(let error):
            print(error)
            break
        }
    }
    }
    static func getfeiltereddataother(  category:String,subcategory:String, completion: @escaping handlers) -> Void
      
      {
    guard let parameters =
        [
            "authToken" : "57b8617205fa3446ba004d583284f475",
            "category" : category,
            "subcategory" : subcategory,
            "limit" :4,
            "offset" : 1,
             
            "user_id":UserDefaults.standard.string(forKey: "id") ?? "",
           "is_episode":0
            ] as? [String:Any] else { return  }
       
        let url:URL = URL(string: "https://bigfantv.com/en/rest/getFilteredContent")!
        
        
        
         
       // manager.session.configuration.httpMaximumConnectionsPerHost = 50
        manager2.request(url, method: .post, parameters: parameters, encoding: JSONEncoding.default, headers: nil).responseJSON { (response) in
     
            switch response.result
            {

       
            case .success(_):
           
                if response.value != nil
                {
                    do
                    {
                        let decoder = JSONDecoder()
                        let data = try decoder.decode(newFilteredComedyMovieList.self, from: response.data ?? Data())
                        if data.status == "OK"
                        {
                         completion(data,nil)
                        }
                         }
                         catch let error
                         {
                             print(error.localizedDescription)
                         }
            }
            break
        case .failure(let error):
            print(error)
            break
        }
    }
    }
    static func getfeiltereddataw(  category:String,subcategory:String, completion: @escaping handlers) -> Void
         
         {
       guard let parameters =
           [
               "authToken" : "57b8617205fa3446ba004d583284f475",
               "category" : category,
               "subcategory" : subcategory,
               "limit" :4,
               "offset" : 1,
                
               "user_id":UserDefaults.standard.string(forKey: "id") ?? "",
              "is_episode":0
               ] as? [String:Any] else { return  }
          
           let url:URL = URL(string: "https://bigfantv.com/en/rest/getFilteredContent")!
           
           
           
            
          // manager.session.configuration.httpMaximumConnectionsPerHost = 50
           manager1.request(url, method: .post, parameters: parameters, encoding: JSONEncoding.default, headers: nil).responseJSON { (response) in
        
               switch response.result
               {

          
               case .success(_):
              
                   if response.value != nil
                   {
                       do
                       {
                           let decoder = JSONDecoder()
                           let data = try decoder.decode(newFilteredComedyMovieList.self, from: response.data ?? Data())
                           if data.status == "OK"
                           {
                            completion(data,nil)
                           }
                            }
                            catch let error
                            {
                                print(error.localizedDescription)
                            }
               }
               break
           case .failure(let error):
               print(error)
               break
           }
       }
       }
    static func getfeiltereddata1(  category:String,subcategory:String, completion: @escaping handlers) -> Void
       
       {
     guard let parameters =
         [
             "authToken" : "57b8617205fa3446ba004d583284f475",
             "category" : category,
             "subcategory" : subcategory,
             "limit" :4,
             "offset" : 1,
             
             "user_id":UserDefaults.standard.string(forKey: "id") ?? "",
            
             ] as? [String:Any] else { return  }
        
         let url:URL = URL(string: "https://bigfantv.com/en/rest/getFilteredContent")!
         
         
         
         
        
        manager.request(url, method: .post, parameters: parameters, encoding: JSONEncoding.default, headers: nil).responseJSON { (response) in
      print("data from common function")
             switch response.result
             {

        
             case .success(_):
            
                 if response.value != nil
                 {
                     do
                     {
                         let decoder = JSONDecoder()
                         let data = try decoder.decode(newFilteredComedyMovieList.self, from: response.data ?? Data())
                         if data.status == "OK"
                         {
                          completion(data,nil)
                         }
                          }
                          catch let error
                          {
                              print(error.localizedDescription)
                          }
             }
             break
         case .failure(let error):
             print(error)
             break
         }
     }
     }
     static func getfeiltereddata2(  category:String,subcategory:String, completion: @escaping handlers) -> Void
        
        {
      guard let parameters =
          [
              "authToken" : "57b8617205fa3446ba004d583284f475",
              "category" : category,
              "subcategory" : subcategory,
              "limit" :4,
              "offset" : 1,
               
              "user_id":UserDefaults.standard.string(forKey: "id") ?? "",
             
              ] as? [String:Any] else { return  }
         
          let url:URL = URL(string: "https://bigfantv.com/en/rest/getFilteredContent")!
          
          
          
          
         // manager.session.configuration.httpMaximumConnectionsPerHost = 50
          manager.request(url, method: .post, parameters: parameters, encoding: JSONEncoding.default, headers: nil).responseJSON { (response) in
       
              switch response.result
              {

         
              case .success(_):
             
                  if response.value != nil
                  {
                      do
                      {
                          let decoder = JSONDecoder()
                          let data = try decoder.decode(newFilteredComedyMovieList.self, from: response.data ?? Data())
                          
                           completion(data,nil)
     
                           }
                           catch let error
                           {
                               print(error.localizedDescription)
                           }
              }
              break
          case .failure(let error):
              print(error)
              break
          }
      }
      }
    static func Commonapi4(  parameters:[String:Any] ,urlString:String, completion: @escaping handledata) -> Void
         {
            //https://bigfantv.com/en/rest/GetPpvPlan
            
            let urlStr = "https://bigfantv.com/en/rest/" + urlString
                       
            _ = urlStr.addingPercentEncoding(withAllowedCharacters: CharacterSet.urlQueryAllowed)

           manager.request(urlStr, method: .post, parameters: parameters, encoding: JSONEncoding.default, headers: nil).responseJSON { (response) in
        
               switch response.result
               {
               case .success(_):
              
                   if response.value != nil
                   {
                        completion(response.data,nil)
                   }
               break
           case .failure(let error):
               print(error)
               break
           }
       }
       }
    static func Commonapi(  parameters:[String:Any] ,urlString:String, completion: @escaping handledata) -> Void
         {
            
            
            let urlStr = "https://funasia.net/bigfantv.funasia.net/service/" + urlString
                       
            _ = urlStr.addingPercentEncoding(withAllowedCharacters: CharacterSet.urlQueryAllowed)

           manager.request(urlStr, method: .post, parameters: parameters, encoding: JSONEncoding.default, headers: nil).responseJSON { (response) in
        
               switch response.result
               {
               case .success(_):
              
                   if response.value != nil
                   {
                        completion(response.data,nil)
                   }
               break
           case .failure(let error):
               print(error)
               break
           }
       }
       }
    static func getpodcastdata(  category:String,subcategory:String,vc:UIViewController ,completion: @escaping handledata) -> Void
         
         {
            
       guard let parameters =
           [
               "authToken" : "57b8617205fa3446ba004d583284f475",
               "category" : category,
               "subcategory" : subcategory,
               "limit" :4,
               "offset" : 1,
                
               "country_code" : "USA",
               "user_id":UserDefaults.standard.string(forKey: "id") ?? "",
              "is_episode":0
               ] as? [String:Any] else { return  }
          
           let url:URL = URL(string: "https://bigfantv.com/en/rest/getFilteredContent")!
           
             Utility.ShowLoader(vc: vc)
           
           let manager = Alamofire.SessionManager.default
          // manager.session.configuration.httpMaximumConnectionsPerHost = 50
           manager.request(url, method: .post, parameters: parameters, encoding: JSONEncoding.default, headers: nil).responseJSON { (response) in
             Utility.hideLoader(vc: vc)
               switch response.result {

          
               case .success(_):
              
                   if response.value != nil
                   {
                       do
                       {
                           let decoder = JSONDecoder()
                           
                        completion(response.data,nil)
      
                            }
                            catch let error
                            {
                                print(error.localizedDescription)
                            }
               }
               break
           case .failure(let error):
               print(error)
               break
           }
       }
       }
    static func getcontentdata(moviecategory:String,moviesubcategory:String,endpoint:String ,vc:UIViewController,offst:Int, completionBlock: @escaping (newFilteredComedyMovieList) -> Void) -> Void
    {
        Api.Getconent8(moviecategory, subCat: moviesubcategory , endpoint: endpoint, vc: vc, offset: offst) { (result, err) -> (Void) in
            do
            {
                 let decoder = JSONDecoder()
                 let data = try decoder.decode(newFilteredComedyMovieList.self, from: result  ?? Data())
                if data.subComedymovList != nil
                {
                    if data.subComedymovList.count > 0
                    {
                        if data.status == "OK" && data.code == 200
                        {
                            
                            completionBlock(data)
                            
                        }
                    }
                    
                }
 
            }
            catch let error
            {
                print(error.localizedDescription)
            }
            
             
        }
    }
    
    
}
extension MovieVC: UIScrollViewDelegate {
     
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
        filterScrollView?.backgroundColor = Appcolor.backgorund3
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
                navController.navigationBar.barTintColor = Appcolor.backgorund3
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
    
    @objc func playerItemDidReachEnd(_ notification: Notification) {
 
                for i in 0...filterPlayers.count - 1 {
                    if i == currentPage {
                         
                        (filterPlayers[i])!.seek(to: CMTime.zero)
                        (filterPlayers[i])!.playImmediately(atRate: 1.0)
                    }
                }
    }
    
}
