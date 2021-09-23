//
//  Apimodel.swift
//  bigfantv
//
//  Created by Ganesh on 07/07/20.
//  Copyright © 2020 Ganesh. All rights reserved.
//

import Foundation
import Alamofire

class Configurator
{
   static let baseURL = "https://bigfantv.com/en/rest/"
   static let IMDBbaseURL = "https://www.omdbapi.com/?i=tt3896198&apikey=3d5555e0"
   static let requsetTimeOut: TimeInterval = 120
}
class ApiEndPoints
{
 static let Register = "registeruser"
 static let CheckEmailExistance = "CheckEmailExistance"
 static let login = "login"
 static let forgotpassword = "forgotpassword"
 static let GetLanguageList = "GetLanguageList"
 static let getcontentlist = "getcontentlist"
 static let getFilteredContent = "getFilteredContent"
 static let AddToFavlist = "AddToFavlist"
 static let DeleteFavLIst = "DeleteFavLIst"
 static let ViewFavourite = "ViewFavourite"
 static let searchData = "searchData"
 static let getcontentdetails = "getcontentdetails"
 static let UpdateUserProfileV1 = "UpdateUserProfileV1"
 static let GetProfileDetails = "GetProfileDetails"
 static let GetStudioPlanLists = "GetStudioPlanLists"
 static let isContentAuthorized = "isContentAuthorized"
 static let MyPlans = "MyPlans"
 static let episodeDetails = "episodeDetails"
 static let SocialAuth = "SocialAuth"
 static let VideoLogNew = "VideoLogNew"
 static let watchhistory = "watchhistory"
 static let getVideoDetails = "getVideoDetails"
 static let GetBannerSectionList = "GetBannerSectionList"
 static let PurchaseHistory = "PurchaseHistory"
 static let GetCardsListForPPV = "GetCardsListForPPV"
 static let loadFeaturedSections = "loadFeaturedSections"
 static let updateStripePayment = "updateStripePayment"
 static let getSubcategoryList = "getSubcategoryList"
}
class Keycenter
{
    static let authToken:String = "57b8617205fa3446ba004d583284f475"
    static var limit = 10
}
class Appcommon
{
    static let Appname = "BigFan TV"
}

typealias ApiResponse = ((_ response: Data?, _ message: String?) -> (Void))
typealias jsonArrayResponse = ((_ response: [[String:Any]]?, _ message: String?) -> (Void))

//MARK: -- Login Module --
class Api {
    static func Login( email:String ,password:String, endpoint:String,vc:UIViewController, apiResponse:@escaping(ApiResponse)) {
       
           guard let parameters =
               [
                   "authToken" : Keycenter.authToken,
                   "email" : email,
                   "password" : password
                  
                   ] as? [String:Any] else { return  }
           print(parameters)
          // ManageHudder.sharedInstance.startActivityIndicator()
           Utility.ShowLoader(vc: vc)
           
           APIMaster.sharedInstance.apiRequestWith(vc: vc, urlString: endpoint, httpMethod: .post, info: parameters , requestHeaders: nil, parmEncodingType: JSONEncoding.default) { (response, error) -> (Void) in
               
             Utility.hideLoader(vc: vc)
              // ManageHudder.sharedInstance.stopActivityIndicator()
               if nil != error
               {
                   Utility.showAlert(vc: vc, message:error!.localizedDescription, titelstring:Appcommon.Appname )
               }
               else
               {
                   if response != nil
                   {
                        apiResponse(response, nil)
                   }
                   
                }
           }
       }
    static func Getconent(_ category:String ,subCat:String, endpoint:String,vc:UIViewController,offset:Int, apiResponse:@escaping(ApiResponse)) {
    
        guard let parameters =
            [
                "authToken" : Keycenter.authToken,
                "category" : category,
                "subcategory" : subCat,
                "limit" : Keycenter.limit,
                "offset" : offset,
                "order" : "asc",
                "country_code" : "USA",
              "user_id": UserDefaults.standard.string(forKey: "id") ?? "",
              "is_episode":0 
                ] as? [String:Any] else { return  }
        
       // ManageHudder.sharedInstance.startActivityIndicator()
         
        APIMaster.sharedInstance.apiRequestWith(vc: vc, urlString: endpoint, httpMethod: .post, info: parameters , requestHeaders: nil, parmEncodingType: JSONEncoding.default) { (response, error) -> (Void) in
              if nil != error
            {
                Utility.showAlert(vc: vc, message:error!.localizedDescription, titelstring:Appcommon.Appname )
            }
            else
            {
                if response != nil
                {
                     apiResponse(response, nil)
                }
                
             }
        }
    }
    static func Getsubcategory(  endpoint:String,vc:UIViewController,  apiResponse:@escaping(ApiResponse)) {
       
           guard let parameters =
               [
                   "authToken" : Keycenter.authToken,
                    "category_id": "757433"
                   
                   ] as? [String:Any] else { return  }
           
          // ManageHudder.sharedInstance.startActivityIndicator()
        Utility.ShowLoader(vc: vc)
           APIMaster.sharedInstance.apiRequestWith(vc: vc, urlString: endpoint, httpMethod: .post, info: parameters , requestHeaders: nil, parmEncodingType: JSONEncoding.default) { (response, error) -> (Void) in
            Utility.hideLoader(vc: vc)
                 if nil != error
               {
                   Utility.showAlert(vc: vc, message:error!.localizedDescription, titelstring:Appcommon.Appname )
               }
               else
               {
                   if response != nil
                   {
                        apiResponse(response, nil)
                   }
                   
                }
           }
       }
    static func Getconent8(_ category:String ,subCat:String, endpoint:String,vc:UIViewController,offset:Int, apiResponse:@escaping(ApiResponse)) {
    
        guard let parameters =
            [
                "authToken" : Keycenter.authToken,
                "category" : category,
                "subcategory" : subCat,
                "limit" : Keycenter.limit,
                "offset" : offset,
                "order" : "asc",
                "country_code" : "USA",
              "user_id": UserDefaults.standard.string(forKey: "id") ?? "",
              "is_episode":0
                ] as? [String:Any] else { return  }
        print(parameters)
       // ManageHudder.sharedInstance.startActivityIndicator()
         
        APIMaster.sharedInstance.apiRequestWith(vc: vc, urlString: endpoint, httpMethod: .post, info: parameters , requestHeaders: nil, parmEncodingType: JSONEncoding.default) { (response, error) -> (Void) in
              if nil != error
            {
                Utility.showAlert(vc: vc, message:error!.localizedDescription, titelstring:Appcommon.Appname )
            }
            else
            {
                if response != nil
                {
                     apiResponse(response, nil)
                }
                
             }
        }
    }
    static func Getstaticconent(_ category:String ,subCat:String, endpoint:String,vc:UIViewController,offset:Int, apiResponse:@escaping(ApiResponse)) {
      
          guard let parameters =
              [
                  "authToken" : Keycenter.authToken,
                  "category" : category,
                  "subcategory" : subCat,
                  "limit" : Keycenter.limit,
                  "offset" : offset,
                  "order" : "asc",
                  "country_code" : "USA",
                "user_id": UserDefaults.standard.string(forKey: "id") ?? ""
                  ] as? [String:Any] else { return  }
          
         // ManageHudder.sharedInstance.startActivityIndicator()
          
          APIMaster.sharedInstance.apiRequestWith(vc: vc, urlString: endpoint, httpMethod: .post, info: parameters , requestHeaders: nil, parmEncodingType: JSONEncoding.default) { (response, error) -> (Void) in
              
            
             // ManageHudder.sharedInstance.stopActivityIndicator()
              if nil != error
              {
                  Utility.showAlert(vc: vc, message:error!.localizedDescription, titelstring:Appcommon.Appname )
              }
              else
              {
                  if response != nil
                  {
                       apiResponse(response, nil)
                  }
                  
               }
          }
      }
    static func Getconentmain(_ category:String ,subCat:String, endpoint:String,vc:UIViewController,offset:Int, apiResponse:@escaping(ApiResponse)) {
       
           guard let parameters =
               [
                   "authToken" : Keycenter.authToken,
                   "category" : category,
                   "subcategory" : subCat,
                   "limit" : Keycenter.limit,
                   "offset" : offset,
                   "order" : "asc",
                   "country_code" : "USA",
                 "user_id": UserDefaults.standard.string(forKey: "id") ?? ""
                   ] as? [String:Any] else { return  }
           
          // ManageHudder.sharedInstance.startActivityIndicator()
           Utility.ShowLoader(vc: vc)
           
           APIMaster.sharedInstance.apiRequestWith(vc: vc, urlString: endpoint, httpMethod: .post, info: parameters , requestHeaders: nil, parmEncodingType: JSONEncoding.default) { (response, error) -> (Void) in
               
             Utility.hideLoader(vc: vc)
              // ManageHudder.sharedInstance.stopActivityIndicator()
               if nil != error
               {
                   Utility.showAlert(vc: vc, message:error!.localizedDescription, titelstring:Appcommon.Appname )
               }
               else
               {
                   if response != nil
                   {
                        apiResponse(response, nil)
                   }
                   
                }
           }
       }
    static func Getconent1(_ category:String ,subCat:String, endpoint:String,vc:UIViewController,offset:Int, apiResponse:@escaping(ApiResponse)) {
    
        guard let parameters =
            [
                "authToken" : Keycenter.authToken,
                "category" : category,
                "subcategory" : subCat,
                "limit" : Keycenter.limit,
                "offset" : offset,
                "order" : "asc",
                "country_code" : "USA",
                 "is_episode":0,
                "user_id": UserDefaults.standard.string(forKey: "id") ?? ""
                ] as? [String:Any] else { return  }
        
       // ManageHudder.sharedInstance.startActivityIndicator()
        //Utility.ShowLoader(vc: vc)
        
        APIMaster.sharedInstance.apiRequestWith(vc: vc, urlString: endpoint, httpMethod: .post, info: parameters , requestHeaders: nil, parmEncodingType: JSONEncoding.default) { (response, error) -> (Void) in
            
       //  Utility.hideLoader(vc: vc)
           // ManageHudder.sharedInstance.stopActivityIndicator()
            if nil != error
            {
                Utility.showAlert(vc: vc, message:error!.localizedDescription, titelstring:Appcommon.Appname )
            }
            else
            {
                if response != nil
                {
                     apiResponse(response, nil)
                }
                
             }
        }
    }
    static func Getconent11(_ category:String ,subCat:String, endpoint:String,vc:UIViewController,offset:Int, apiResponse:@escaping(ApiResponse)) {
    
        guard let parameters =
            [
                "authToken" : Keycenter.authToken,
                "category" : category,
                "subcategory" : subCat,
                "limit" : Keycenter.limit,
                "offset" : offset,
                "order" : "asc",
                "country_code" : "USA",
                "user_id": UserDefaults.standard.string(forKey: "id") ?? ""
                ] as? [String:Any] else { return  }
        
       // ManageHudder.sharedInstance.startActivityIndicator()
        Utility.ShowLoader(vc: vc)
        
        APIMaster.sharedInstance.apiRequestWith(vc: vc, urlString: endpoint, httpMethod: .post, info: parameters , requestHeaders: nil, parmEncodingType: JSONEncoding.default) { (response, error) -> (Void) in
            
         Utility.hideLoader(vc: vc)
           // ManageHudder.sharedInstance.stopActivityIndicator()
            if nil != error
            {
                Utility.showAlert(vc: vc, message:error!.localizedDescription, titelstring:Appcommon.Appname )
            }
            else
            {
                if response != nil
                {
                     apiResponse(response, nil)
                }
                
             }
        }
    }
    static func Getfeatureddata(_ endpoint:String,vc:UIViewController,offset:Int, apiResponse:@escaping(ApiResponse)) {
    
        guard let parameters =
            [
                "authToken" : Keycenter.authToken,
                "offset" : offset,
                "user_id": UserDefaults.standard.string(forKey: "id") ?? ""
                ] as? [String:Any] else { return  }
        
       // ManageHudder.sharedInstance.startActivityIndicator()
        print(parameters)
       // Utility.ShowLoader(vc: vc)
        
        APIMaster.sharedInstance.apiRequestWith(vc: vc, urlString: endpoint, httpMethod: .post, info: parameters , requestHeaders: nil, parmEncodingType: JSONEncoding.default) { (response, error) -> (Void) in
            
       //  Utility.hideLoader(vc: vc)
           // ManageHudder.sharedInstance.stopActivityIndicator()
            if nil != error
            {
                Utility.showAlert(vc: vc, message:error!.localizedDescription, titelstring:Appcommon.Appname )
            }
            else
            {
                if response != nil
                {
                     apiResponse(response, nil)
                }
                
             }
        }
    }
    static func GetBanners(_   endpoint:String,vc:UIViewController, apiResponse:@escaping(ApiResponse)) {
       
           guard let parameters =
               [
                   "authToken" : Keycenter.authToken,
                    
                   ] as? [String:Any] else { return  }
           
          // ManageHudder.sharedInstance.startActivityIndicator()
            
           APIMaster.sharedInstance.apiRequestWith(vc: vc, urlString: endpoint, httpMethod: .post, info: parameters , requestHeaders: nil, parmEncodingType: JSONEncoding.default) { (response, error) -> (Void) in
               
                 // ManageHudder.sharedInstance.stopActivityIndicator()
               if nil != error
               {
                   Utility.showAlert(vc: vc, message:error!.localizedDescription, titelstring:Appcommon.Appname )
               }
               else
               {
                   if response != nil
                   {
                        apiResponse(response, nil)
                   }
                   
                }
           }
       }
    static func Getfetauredc(_ category:String ,subCat:String, endpoint:String,vc:UIViewController,offset:Int, apiResponse:@escaping(ApiResponse)) {
       
           guard let parameters =
               [
                   "authToken" : Keycenter.authToken,
                   "category" : category,
                   "subcategory" : subCat,
                   "limit" : Keycenter.limit,
                   "offset" : offset,
                   "order" : "asc",
                   "country_code" : "USA",
                 "user_id": UserDefaults.standard.string(forKey: "id") ?? ""
                   ] as? [String:Any] else { return  }
           
          // ManageHudder.sharedInstance.startActivityIndicator()
           
           APIMaster.sharedInstance.apiRequestWith(vc: vc, urlString: endpoint, httpMethod: .post, info: parameters , requestHeaders: nil, parmEncodingType: JSONEncoding.default) { (response, error) -> (Void) in
               
             Utility.hideLoader(vc: vc)
              // ManageHudder.sharedInstance.stopActivityIndicator()
               if nil != error
               {
                   Utility.showAlert(vc: vc, message:error!.localizedDescription, titelstring:Appcommon.Appname )
               }
               else
               {
                   if response != nil
                   {
                        apiResponse(response, nil)
                   }
                   
                }
           }
       }
    static func Getconent2(_ category:String ,subCat:String, endpoint:String,vc:UIViewController,offset:Int, apiResponse:@escaping(ApiResponse)) {
    
        guard let parameters =
            [
                "authToken" : Keycenter.authToken,
                "category" : category,
                "subcategory" : subCat,
                "limit" : Keycenter.limit,
                "offset" : offset,
                "order" : "asc",
                "country_code" : "USA",
              "user_id": UserDefaults.standard.string(forKey: "id") ?? ""
                ] as? [String:Any] else { return  }
        
       // ManageHudder.sharedInstance.startActivityIndicator()
       // Utility.ShowLoader(vc: vc)
        
        APIMaster.sharedInstance.apiRequestWith(vc: vc, urlString: endpoint, httpMethod: .post, info: parameters , requestHeaders: nil, parmEncodingType: JSONEncoding.default) { (response, error) -> (Void) in
            
         // Utility.hideLoader(vc: vc)
           // ManageHudder.sharedInstance.stopActivityIndicator()
            if nil != error
            {
                Utility.showAlert(vc: vc, message:error!.localizedDescription, titelstring:Appcommon.Appname )
            }
            else
            {
                if response != nil
                {
                     apiResponse(response, nil)
                }
                
             }
        }
    }
    static func Getconent6(_ category:String ,subCat:String, endpoint:String,vc:UIViewController,offset:Int, apiResponse:@escaping(ApiResponse)) {
       
           guard let parameters =
               [
                   "authToken" : Keycenter.authToken,
                   "category" : category,
                   "subcategory" : subCat,
                   "limit" : Keycenter.limit,
                   "offset" : offset,
                   "order" : "asc",
                   "country_code" : "USA",
                   "is_episode":0,
                 "user_id": UserDefaults.standard.string(forKey: "id") ?? ""
                   ] as? [String:Any] else { return  }
           
          // ManageHudder.sharedInstance.startActivityIndicator()
          // Utility.ShowLoader(vc: vc)
           
           APIMaster.sharedInstance.apiRequestWith(vc: vc, urlString: endpoint, httpMethod: .post, info: parameters , requestHeaders: nil, parmEncodingType: JSONEncoding.default) { (response, error) -> (Void) in
               
            // Utility.hideLoader(vc: vc)
              // ManageHudder.sharedInstance.stopActivityIndicator()
               if nil != error
               {
                   Utility.showAlert(vc: vc, message:error!.localizedDescription, titelstring:Appcommon.Appname )
               }
               else
               {
                   if response != nil
                   {
                        apiResponse(response, nil)
                   }
                   
                }
           }
       }
    static func Getconent3(_ category:String ,subCat:String, endpoint:String,vc:UIViewController,offset:Int, apiResponse:@escaping(ApiResponse)) {
       
           guard let parameters =
               [
                   "authToken" : Keycenter.authToken,
                   "category" : category,
                   "subcategory" : subCat,
                   "limit" : Keycenter.limit,
                   "offset" : offset,
                   "order" : "asc",
                   "country_code" : "USA",
                 "user_id": UserDefaults.standard.string(forKey: "id") ?? ""
                   ] as? [String:Any] else { return  }
           
          // ManageHudder.sharedInstance.startActivityIndicator()
          // Utility.ShowLoader(vc: vc)
           
           APIMaster.sharedInstance.apiRequestWith(vc: vc, urlString: endpoint, httpMethod: .post, info: parameters , requestHeaders: nil, parmEncodingType: JSONEncoding.default) { (response, error) -> (Void) in
               
           //  Utility.hideLoader(vc: vc)
              // ManageHudder.sharedInstance.stopActivityIndicator()
               if nil != error
               {
                   Utility.showAlert(vc: vc, message:error!.localizedDescription, titelstring:Appcommon.Appname )
               }
               else
               {
                   if response != nil
                   {
                        apiResponse(response, nil)
                   }
                   
                }
           }
       }
    static func GetEpisodedetails(_ perma:String ,offset:Int, endpoint:String,vc:UIViewController,apiResponse:@escaping(ApiResponse)) {
 
        guard let parameters =
            [
                "authToken" : Keycenter.authToken,
                "permalink":perma,
                 "user_id": UserDefaults.standard.string(forKey: "id") ?? "",
                 "is_episode":1,
                 "limit":10,
                 "offset":offset,
                ] as? [String:Any] else { return  }
        
       // ManageHudder.sharedInstance.startActivityIndicator()
        Utility.ShowLoader(vc: vc)
        
        APIMaster.sharedInstance.apiRequestWith(vc: vc, urlString: endpoint, httpMethod: .post, info: parameters , requestHeaders: nil, parmEncodingType: JSONEncoding.default) { (response, error) -> (Void) in
            
          Utility.hideLoader(vc: vc)
           // ManageHudder.sharedInstance.stopActivityIndicator()
            if nil != error
            {
                Utility.showAlert(vc: vc, message:error!.localizedDescription, titelstring:Appcommon.Appname )
            }
            else
            {
                if response != nil
                {
                     apiResponse(response, nil)
                }
                
             }
        }
    }
    static func GetVideodetails(_ stream_uniq_id:String ,content_uniq_id:String, endpoint:String,vc:UIViewController,apiResponse:@escaping(ApiResponse)) {
    
           guard let parameters =
               [
                   "authToken" : Keycenter.authToken,
                   "content_uniq_id":content_uniq_id,
                    "stream_uniq_id": stream_uniq_id,
                   ] as? [String:Any] else { return  }
           
          // ManageHudder.sharedInstance.startActivityIndicator()
           Utility.ShowLoader(vc: vc)
           
           APIMaster.sharedInstance.apiRequestWith(vc: vc, urlString: endpoint, httpMethod: .post, info: parameters , requestHeaders: nil, parmEncodingType: JSONEncoding.default) { (response, error) -> (Void) in
               
             Utility.hideLoader(vc: vc)
              // ManageHudder.sharedInstance.stopActivityIndicator()
               if nil != error
               {
                   Utility.showAlert(vc: vc, message:error!.localizedDescription, titelstring:Appcommon.Appname )
               }
               else
               {
                   if response != nil
                   {
                        apiResponse(response, nil)
                   }
                   
                }
           }
       }
    static func GetMovieDeatilsconent(_ id:String,vc:UIViewController, apiResponse:@escaping(ApiResponse)) {
    
        guard let parameters =
            [
                
                    "l" : id,
                    "plot" : "full",
                    "r" : "json"
                 ] as? [String:Any] else { return  }
       // ManageHudder.sharedInstance.startActivityIndicator()
      //  Utility.ShowLoader(vc: vc)
        
        APIMaster.sharedInstance.apiRequestWithdetails(vc: vc, urlstr:  "https://www.omdbapi.com/?i=\(id)&apikey=3d5555e0",   httpMethod: .post, info: parameters , requestHeaders: nil, parmEncodingType: JSONEncoding.default) { (response, error) -> (Void) in
            
           //  Utility.hideLoader(vc: vc)
           // ManageHudder.sharedInstance.stopActivityIndicator()
            if nil != error
            {
                Utility.showAlert(vc: vc, message:error!.localizedDescription, titelstring:Appcommon.Appname )
            }
            else
            {
                if response != nil
                {
                     apiResponse(response, nil)
                }
                
             }
        }
    }
    
    static func Addtofav(  movie_uniq_id:String, endpoint:String,vc:UIViewController,  apiResponse:@escaping(ApiResponse)) {
         
             guard let parameters =
                 [
                     "authToken" : Keycenter.authToken,
                     "user_id":UserDefaults.standard.string(forKey: "id"),
                     "movie_uniq_id" : movie_uniq_id,
                     "lang_code" : "en",
                     "content_type" : "0"
                     ] as? [String:Any] else { return  }
            
            // ManageHudder.sharedInstance.startActivityIndicator()
             print(parameters)
             APIMaster.sharedInstance.apiRequestWith(vc: vc, urlString: endpoint, httpMethod: .post, info: parameters , requestHeaders: nil, parmEncodingType: JSONEncoding.default) { (response, error) -> (Void) in
                 
                 // ManageHudder.sharedInstance.stopActivityIndicator()
                 if nil != error
                 {
                     Utility.showAlert(vc: vc, message:error!.localizedDescription, titelstring:Appcommon.Appname )
                 }
                 else
                 {
                     if response != nil
                     {
                       
                          apiResponse(response, nil)
                     }
                     
                  }
             }
         }
       
    static func Addtofavourite(_ user_id:String,movie_uniq_id:String,lang_code:String,content_type:Int, endpoint:String,vc:UIViewController,  apiResponse:@escaping(ApiResponse)) {
      
          guard let parameters =
              [
                  "authToken" : Keycenter.authToken,
                  "user_id":user_id,
                  "movie_uniq_id" : movie_uniq_id,
                  "lang_code" : "en",
                  "content_type" : "0"
                  ] as? [String:Any] else { return  }
         
         // ManageHudder.sharedInstance.startActivityIndicator()
          print(parameters)
          APIMaster.sharedInstance.apiRequestWith(vc: vc, urlString: endpoint, httpMethod: .post, info: parameters , requestHeaders: nil, parmEncodingType: JSONEncoding.default) { (response, error) -> (Void) in
              
              // ManageHudder.sharedInstance.stopActivityIndicator()
              if nil != error
              {
                  Utility.showAlert(vc: vc, message:error!.localizedDescription, titelstring:Appcommon.Appname )
              }
              else
              {
                  if response != nil
                  {
                    
                       apiResponse(response, nil)
                  }
                  
               }
          }
      }
    
    static func SavevideoLog(_  movie_id:String,ip_address:String,duration:Float,  endpoint:String,vc:UIViewController,  apiResponse:@escaping(ApiResponse)) {
    
        guard let parameters =
            [
                "authToken" : Keycenter.authToken,
                "user_id" : UserDefaults.standard.string(forKey: "id") ?? "",
                "movie_id" : movie_id ,
                "ip_address":ip_address ,
                "played_length":duration,
                "resume_time":duration
               
                
                ] as? [String:Any] else { return  }
       
       // ManageHudder.sharedInstance.startActivityIndicator()
        print(parameters)
        APIMaster.sharedInstance.apiRequestWith(vc: vc, urlString: endpoint, httpMethod: .post, info: parameters , requestHeaders: nil, parmEncodingType: JSONEncoding.default) { (response, error) -> (Void) in
            
            // ManageHudder.sharedInstance.stopActivityIndicator()
            if nil != error
            {
                Utility.showAlert(vc: vc, message:error!.localizedDescription, titelstring:Appcommon.Appname )
            }
            else
            {
                if response != nil
                {
                  
                     apiResponse(response, nil)
                }
                
             }
        }
    }
    static func Viewfavouriteinmylibrary(_ user_id:String,limit:Int,offset:Int, endpoint:String,vc:UIViewController,  apiResponse:@escaping(ApiResponse)) {
        
            guard let parameters =
                [
                    "authToken" : Keycenter.authToken,
                    "user_id":user_id,
                    "limit":limit,
                    "offset":offset,
                    "lang_code":"en",
                    "country":"USA"
                    ] as? [String:Any] else { return  }
           
           // ManageHudder.sharedInstance.startActivityIndicator()
            
            
            APIMaster.sharedInstance.apiRequestWith(vc: vc, urlString: endpoint, httpMethod: .post, info: parameters , requestHeaders: nil, parmEncodingType: JSONEncoding.default) { (response, error) -> (Void) in
                
                
               // ManageHudder.sharedInstance.stopActivityIndicator()
                if nil != error
                {
                    Utility.showAlert(vc: vc, message:error!.localizedDescription, titelstring:Appcommon.Appname )
                }
                else
                {
                    if response != nil
                    {
                      print(response)
                         apiResponse(response, nil)
                    }
                    
                 }
            }
        }

    static func Viewfavourite(_ user_id:String,  endpoint:String,vc:UIViewController,  apiResponse:@escaping(ApiResponse)) {
        
            guard let parameters =
                [
                    "authToken" : Keycenter.authToken,
                    "user_id":user_id,
                    "limit":10,
                    "offset":1,
                    "lang_code":"en",
                    "country":"USA"
                    ] as? [String:Any] else { return  }
           
           // ManageHudder.sharedInstance.startActivityIndicator()
            
            
            APIMaster.sharedInstance.apiRequestWith(vc: vc, urlString: endpoint, httpMethod: .post, info: parameters , requestHeaders: nil, parmEncodingType: JSONEncoding.default) { (response, error) -> (Void) in
                
                
               // ManageHudder.sharedInstance.stopActivityIndicator()
                if nil != error
                {
                    Utility.showAlert(vc: vc, message:error!.localizedDescription, titelstring:Appcommon.Appname )
                }
                else
                {
                    if response != nil
                    {
                      print(response)
                         apiResponse(response, nil)
                    }
                    
                 }
            }
        }
    static func GetWatchhistory(_   endpoint:String,vc:UIViewController,  apiResponse:@escaping(ApiResponse)) {
        
            guard let parameters =
                [
                    "authToken" : Keycenter.authToken,
                    "user_id":UserDefaults.standard.string(forKey: "id") ?? "",
                    "lang_code":"en",
                    "country":"USA"
                    ] as? [String:Any] else { return  }
           
           // ManageHudder.sharedInstance.startActivityIndicator()
        //    Utility.ShowLoader(vc: vc)
            
            APIMaster.sharedInstance.apiRequestWith(vc: vc, urlString: endpoint, httpMethod: .post, info: parameters , requestHeaders: nil, parmEncodingType: JSONEncoding.default) { (response, error) -> (Void) in
                
              // Utility.hideLoader(vc: vc)
               // ManageHudder.sharedInstance.stopActivityIndicator()
                if nil != error
                {
                    Utility.showAlert(vc: vc, message:error!.localizedDescription, titelstring:Appcommon.Appname )
                }
                else
                {
                    if response != nil
                    {
                      
                         apiResponse(response, nil)
                    }
                    
                 }
            }
        }
    static func GetWatchhistoryinmylibraries(_   endpoint:String,offset:Int,limit:Int,vc:UIViewController,  apiResponse:@escaping(ApiResponse)) {
        
            guard let parameters =
                [
                    "authToken" : Keycenter.authToken,
                    "user_id":UserDefaults.standard.string(forKey: "id") ?? "",
                    "lang_code":"en",
                    "country":"USA",
                    "limit":limit,
                    "offset":offset
                    ] as? [String:Any] else { return  }
           
           // ManageHudder.sharedInstance.startActivityIndicator()
        //    Utility.ShowLoader(vc: vc)
            
            APIMaster.sharedInstance.apiRequestWith(vc: vc, urlString: endpoint, httpMethod: .post, info: parameters , requestHeaders: nil, parmEncodingType: JSONEncoding.default) { (response, error) -> (Void) in
                
              // Utility.hideLoader(vc: vc)
               // ManageHudder.sharedInstance.stopActivityIndicator()
                if nil != error
                {
                    Utility.showAlert(vc: vc, message:error!.localizedDescription, titelstring:Appcommon.Appname )
                }
                else
                {
                    if response != nil
                    {
                      
                         apiResponse(response, nil)
                    }
                    
                 }
            }
        }
    

    static func Searchdata(_ query:String,  endpoint:String,vc:UIViewController,  apiResponse:@escaping(ApiResponse)) {
    
        guard let parameters =
            [
                "authToken" : Keycenter.authToken,
                "q":query,
                "limit":20,
                "offset":1,
                "lang_code":"en",
                "country":"USA"
                ] as? [String:Any] else { return  }
        print(parameters)
       // ManageHudder.sharedInstance.startActivityIndicator()
        Utility.ShowLoader(vc: vc)
        
        APIMaster.sharedInstance.apiRequestWith(vc: vc, urlString: endpoint, httpMethod: .post, info: parameters , requestHeaders: nil, parmEncodingType: JSONEncoding.default) { (response, error) -> (Void) in
            
           Utility.hideLoader(vc: vc)
           // ManageHudder.sharedInstance.stopActivityIndicator()
            if nil != error
            {
                Utility.showAlert(vc: vc, message:error!.localizedDescription, titelstring:Appcommon.Appname )
            }
            else
            {
                if response != nil
                {
                   
                     apiResponse(response, nil)
                }
                
             }
        }
    }
    
       static func getcontentdetails(_ permalink:String,  endpoint:String,vc:UIViewController,  apiResponse:@escaping(ApiResponse)) {
       
           guard let parameters =
               [
                "authToken" : Keycenter.authToken ,
                "permalink" : permalink ,
                "id": UserDefaults.standard.string(forKey: "id") ?? "",
                "lang_code":"en",
                     ] as? [String:Any] else { return  }
           
        print(parameters)
          // ManageHudder.sharedInstance.startActivityIndicator()
           Utility.ShowLoader(vc: vc)
           
           APIMaster.sharedInstance.apiRequestWith(vc: vc, urlString: endpoint, httpMethod: .post, info: parameters , requestHeaders: nil, parmEncodingType: JSONEncoding.default) { (response, error) -> (Void) in
               
              Utility.hideLoader(vc: vc)
              // ManageHudder.sharedInstance.stopActivityIndicator()
               if nil != error
               {
                   Utility.showAlert(vc: vc, message:error!.localizedDescription, titelstring:Appcommon.Appname )
               }
               else
               {
                   if response != nil
                   {
                      
                        apiResponse(response, nil)
                   }
                   
                }
           }
       }
    static func getcontentdetailsafterppv(_ permalink:String,  endpoint:String,vc:UIViewController,  apiResponse:@escaping(ApiResponse)) {
    
        guard let parameters =
            [
             "authToken" : Keycenter.authToken ,
             "permalink" : permalink ,
             "id": UserDefaults.standard.string(forKey: "id") ?? "",
             "lang_code":"en",
                  ] as? [String:Any] else { return  }
        
     print(parameters)
       // ManageHudder.sharedInstance.startActivityIndicator()
       // Utility.ShowLoader(vc: vc)
        
        APIMaster.sharedInstance.apiRequestWith(vc: vc, urlString: endpoint, httpMethod: .post, info: parameters , requestHeaders: nil, parmEncodingType: JSONEncoding.default) { (response, error) -> (Void) in
            
          // Utility.hideLoader(vc: vc)
           // ManageHudder.sharedInstance.stopActivityIndicator()
            if nil != error
            {
               // Utility.showAlert(vc: vc, message:error!.localizedDescription, titelstring:Appcommon.Appname )
            }
            else
            {
                if response != nil
                {
                   
                     apiResponse(response, nil)
                }
                
             }
        }
    }
    static func Updateprofile( file:String,  endpoint:String,vc:UIViewController,  apiResponse:@escaping(ApiResponse)) {
        
            guard let parameters =
                [
                    "authToken" : Keycenter.authToken,
                    "user_id":UserDefaults.standard.string(forKey: "id") ?? "",
                    "file":file,
                   
                    ] as? [String:Any] else { return  }
            
           // ManageHudder.sharedInstance.startActivityIndicator()
            Utility.ShowLoader(vc: vc)
            
            APIMaster.sharedInstance.apiRequestWith(vc: vc, urlString: endpoint, httpMethod: .post, info: parameters , requestHeaders: nil, parmEncodingType: JSONEncoding.default) { (response, error) -> (Void) in
                
               Utility.hideLoader(vc: vc)
               // ManageHudder.sharedInstance.stopActivityIndicator()
                if nil != error
                {
                    Utility.showAlert(vc: vc, message:error!.localizedDescription, titelstring:Appcommon.Appname )
                }
                else
                {
                    if response != nil
                    {
                      
                         apiResponse(response, nil)
                    }
                    
                 }
            }
        }
    
    
    static func getuserprofile( email:String,  endpoint:String,vc:UIViewController,  apiResponse:@escaping(ApiResponse)) {
          
              guard let parameters =
                  [
                      "authToken" : Keycenter.authToken,
                      "user_id":UserDefaults.standard.string(forKey: "id") ?? "",
                      "email":email,
                     
                      ] as? [String:Any] else { return  }
              
             // ManageHudder.sharedInstance.startActivityIndicator()
             
              APIMaster.sharedInstance.apiRequestWith(vc: vc, urlString: endpoint, httpMethod: .post, info: parameters , requestHeaders: nil, parmEncodingType: JSONEncoding.default) { (response, error) -> (Void) in
                  
                
                 // ManageHudder.sharedInstance.stopActivityIndicator()
                  if nil != error
                  {
                      Utility.showAlert(vc: vc, message:error!.localizedDescription, titelstring:Appcommon.Appname )
                  }
                  else
                  {
                      if response != nil
                      {
                        
                           apiResponse(response, nil)
                      }
                      
                   }
              }
          }
      
      

      static func getStudioplanlist(_ movieid:String,  endpoint:String,vc:UIViewController,  apiResponse:@escaping(ApiResponse)) {
      
          guard let parameters =
              [
                  "authToken" : Keycenter.authToken,
                  "movie_unique_id" : movieid,
                  "id": UserDefaults.standard.string(forKey: "id") ?? ""
                   
                    ] as? [String:Any] else { return  }
          
         // ManageHudder.sharedInstance.startActivityIndicator()
          Utility.ShowLoader(vc: vc)
          
          APIMaster.sharedInstance.apiRequestWith(vc: vc, urlString: endpoint, httpMethod: .post, info: parameters , requestHeaders: nil, parmEncodingType: JSONEncoding.default) { (response, error) -> (Void) in
              
             Utility.hideLoader(vc: vc)
             // ManageHudder.sharedInstance.stopActivityIndicator()
              if nil != error
              {
                  Utility.showAlert(vc: vc, message:error!.localizedDescription, titelstring:Appcommon.Appname )
              }
              else
              {
                  if response != nil
                  {
                     
                       apiResponse(response, nil)
                  }
                  
               }
          }
      }
    static func getMyplanlist(endpoint:String,vc:UIViewController,  apiResponse:@escaping(ApiResponse))
    {
    
        guard let parameters =
            [
                "authToken" : Keycenter.authToken,
                 "user_id": UserDefaults.standard.string(forKey: "id") ?? ""
               
                  ] as? [String:Any] else { return  }
        
       // ManageHudder.sharedInstance.startActivityIndicator()
        Utility.ShowLoader(vc: vc)
        
        APIMaster.sharedInstance.apiRequestWith(vc: vc, urlString: endpoint, httpMethod: .post, info: parameters , requestHeaders: nil, parmEncodingType: JSONEncoding.default) { (response, error) -> (Void) in
            
           Utility.hideLoader(vc: vc)
           // ManageHudder.sharedInstance.stopActivityIndicator()
            if nil != error
            {
                Utility.showAlert(vc: vc, message:error!.localizedDescription, titelstring:Appcommon.Appname )
            }
            else
            {
                if response != nil
                {
                   
                     apiResponse(response, nil)
                }
                
             }
        }
    }

    static func IsContentAuthorised(_ movieid:String,  endpoint:String,vc:UIViewController,  apiResponse:@escaping(ApiResponse)) {
    
        guard let parameters =
            [
                "authToken" : Keycenter.authToken ,
                "movie_id" : movieid ,
                "user_id": UserDefaults.standard.string(forKey: "id") ?? ""
                 
                  ] as? [String:Any] else { return  }
        // ManageHudder.sharedInstance.startActivityIndicator()
        Utility.ShowLoader(vc: vc)
        
        APIMaster.sharedInstance.apiRequestWith(vc: vc, urlString: endpoint, httpMethod: .post, info: parameters , requestHeaders: nil, parmEncodingType: JSONEncoding.default) { (response, error) -> (Void) in
            
           Utility.hideLoader(vc: vc)
           // ManageHudder.sharedInstance.stopActivityIndicator()
            if nil != error
            {
                Utility.showAlert(vc: vc, message:error!.localizedDescription, titelstring:Appcommon.Appname )
            }
            else
            {
                if response != nil
                {
                    
                     apiResponse(response, nil)
                }
                
             }
        }
    }
    
    static func Getpurchasehistory(  endpoint:String,vc:UIViewController,  apiResponse:@escaping(ApiResponse)) {
    
        guard let parameters =
            [
                "authToken" : Keycenter.authToken ?? "",
                "user_id": UserDefaults.standard.string(forKey: "id") ?? "" ?? ""
                 
                  ] as? [String:Any] else { return  }
         
       // ManageHudder.sharedInstance.startActivityIndicator()
        Utility.ShowLoader(vc: vc)
        
        APIMaster.sharedInstance.apiRequestWith(vc: vc, urlString: endpoint, httpMethod: .post, info: parameters , requestHeaders: nil, parmEncodingType: JSONEncoding.default) { (response, error) -> (Void) in
            
           Utility.hideLoader(vc: vc)
           // ManageHudder.sharedInstance.stopActivityIndicator()
            if nil != error
            {
                Utility.showAlert(vc: vc, message:error!.localizedDescription, titelstring:Appcommon.Appname )
            }
            else
            {
                if response != nil
                {
                     apiResponse(response, nil)
                }
                
             }
        }
    }
    
    static func LoginWithGoogle(email:String,name:String, gplus_userid:String, endpoint:String,vc:UIViewController,  apiResponse:@escaping(ApiResponse)) {
        
            guard let parameters =
                [
                    "authToken":Keycenter.authToken,
                    "email":email,
                    "name":name,
                    "gplus_userid":gplus_userid
                     ] as? [String:Any] else { return  }
           
           // ManageHudder.sharedInstance.startActivityIndicator()
            
            APIMaster.sharedInstance.apiRequestWith(vc: vc, urlString: endpoint, httpMethod: .post, info: parameters , requestHeaders: nil, parmEncodingType: JSONEncoding.default) { (response, error) -> (Void) in
                
                // ManageHudder.sharedInstance.stopActivityIndicator()
                if nil != error
                {
                    Utility.showAlert(vc: vc, message:error!.localizedDescription, titelstring:Appcommon.Appname )
                }
                else
                {
                    if response != nil
                    {
                      
                         apiResponse(response, nil)
                    }
                    
                 }
            }
        }
    static func LoginWithFb(email:String,name:String, gplus_userid:String, endpoint:String,vc:UIViewController,  apiResponse:@escaping(ApiResponse)) {
    
        guard let parameters =
            [
                "authToken":Keycenter.authToken,
                "email":email,
                "name":name,
                "fb_userid":gplus_userid
                 ] as? [String:Any] else { return  }
       
       // ManageHudder.sharedInstance.startActivityIndicator()
        
        APIMaster.sharedInstance.apiRequestWith(vc: vc, urlString: endpoint, httpMethod: .post, info: parameters , requestHeaders: nil, parmEncodingType: JSONEncoding.default) { (response, error) -> (Void) in
            
            // ManageHudder.sharedInstance.stopActivityIndicator()
            if nil != error
            {
                Utility.showAlert(vc: vc, message:error!.localizedDescription, titelstring:Appcommon.Appname )
            }
            else
            {
                if response != nil
                {
                  
                     apiResponse(response, nil)
                }
                
             }
        }
    }
    static func Updatestripepayment(_ planid:String  , endpoint:String,vc:UIViewController,  apiResponse:@escaping(ApiResponse)) {
       
           guard let parameters =
               [
                   "authToken" : Keycenter.authToken,
                   "plan_id" : planid,
                   "user_id": UserDefaults.standard.string(forKey: "id") ?? ""
                   ] as? [String:Any] else { return  }
           
          // ManageHudder.sharedInstance.startActivityIndicator()
           Utility.ShowLoader(vc: vc)
           
           APIMaster.sharedInstance.apiRequestWith(vc: vc, urlString: endpoint, httpMethod: .post, info: parameters , requestHeaders: nil, parmEncodingType: JSONEncoding.default) { (response, error) -> (Void) in
               
            Utility.hideLoader(vc: vc)
              // ManageHudder.sharedInstance.stopActivityIndicator()
               if nil != error
               {
                   Utility.showAlert(vc: vc, message:error!.localizedDescription, titelstring:Appcommon.Appname )
               }
               else
               {
                   if response != nil
                   {
                        apiResponse(response, nil)
                   }
                   
                }
           }
       }
}

