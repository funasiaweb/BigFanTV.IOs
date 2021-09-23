//
//  APIMaster.swift
//  DemoSwift
//
//  Created by A1_Coder... on 6/2/18.
//  Copyright © 2017 Coder.... All rights reserved.
//

import UIKit
import Alamofire

typealias handler = ((_ response: Data?, _ error: Error?) -> (Void))


/// This is a api common class for generating request.


class APIMaster: NSObject {
    
    static let sharedInstance = APIMaster()
    
    let reachabilityManager = Alamofire.NetworkReachabilityManager(host: "www.apple.com")
    
    let manager = Alamofire.SessionManager.default
    /**
     This function is made for checking internet connectivity.
     */
    
    //MARK:- Network Rechability
    
    func isConnectedToInternet() -> Bool {
        return reachabilityManager!.isReachable
    }
    
    
    /**
     This function is made for generating an api request using get method.
     
     - Parameters:  api, httpmethod, httpheaders, parameters encoding type and a completion block
     
     ### Usage Example: ###
     ````
     APIMaster.sharedInstance.apiRequestWith(urlString: loginURLRequest, httpMethod: .get, requestHeaders: APIHeaders.headers(contentTypeKey: JSONFormKey), parmEncodingType: URLEncoding(JSONEncoding.default)) { (response, error) -> (Void) in
     }
     
     ````
     
     */
    
    //MARK:- API Call
    
//    func apiRequestWith(urlString: String,httpMethod: HTTPMethod, parmEncodingType: ParameterEncoding, completion: @escaping handler) {
//        
//        apiRequestWith(urlString: urlString, httpMethod: httpMethod, info: nil, requestHeaders: nil, parmEncodingType: parmEncodingType, completion: completion)
//    }
    
    /**
     This function is made for generating an api request for post method
     
     - Parameters:  api, httpmethod, httpheaders, parameters encoding type and a completion block
     
     ### Usage Example: ###
     ````
     APIMaster.sharedInstance.apiRequestWith(urlString: loginURLRequest, httpMethod: .post, info: loginParam , requestHeaders: APIHeaders.headers(contentTypeKey: JSONFormKey), parmEncodingType: URLEncoding(destination: .queryString)) { (response, error) -> (Void) in
     
     }
     ````
     */
    
    func apiRequestWith(vc:UIViewController, urlString: String,httpMethod: HTTPMethod ,info: [String:Any], requestHeaders: HTTPHeaders?, parmEncodingType: ParameterEncoding, completion: @escaping handler) {
        
        if isConnectedToInternet()
        {
            let urlStr = Configurator.baseURL + urlString
            
            _ = urlStr.addingPercentEncoding(withAllowedCharacters: CharacterSet.urlQueryAllowed)

            
             manager.session.configuration.timeoutIntervalForResource = 120
          //  manager.session.configuration.httpMaximumConnectionsPerHost =  30
             manager.session.configuration.timeoutIntervalForRequest = Configurator.requsetTimeOut
       // AppCommon.PrintLogs(printStatement:"Url: ---- \(apiName ?? "")")
       //     AppCommon.PrintLogs(printStatement:"Param: ---- \(info )")

           do
           {
            
            var request = try URLRequest(url: urlStr, method: httpMethod, headers: requestHeaders)
            
           do
           {
            
            
            
            request.httpBody = try JSONSerialization.data(withJSONObject: info, options: .prettyPrinted)
            
            manager.request(request).responseJSON
                { (response) in
                                      if nil != response.value
                                    {
                                       
                                        DispatchQueue.main.async { completion(response.data, nil)}
                                    }
                                    else
                                    {
                                       Utility.hideLoader(vc: vc)
                                        completion(nil,response.result.error)
                                     //   Utility.showAlert(vc: vc, message: "Server Error", titelstring:Appcommon.Appname )
                                       // AlertFunctions.showAlert(message: "Server Error")
                                    }
            }
            }
         
           catch
            {
                print(error.localizedDescription)
            }
            
           }
           catch
           {
            print(error.localizedDescription)
            }
            }
        else
        {
             Utility.hideLoader(vc: vc)
            Utility.Internetconnection(vc: vc)
          //  AlertFunctions.showAlert(message: "No Internet Connection")
        }
    }

    func apiRequestWithdetails(vc:UIViewController,urlstr:String,  httpMethod: HTTPMethod ,info: [String:Any], requestHeaders: HTTPHeaders?, parmEncodingType: ParameterEncoding, completion: @escaping handler) {
         
         if isConnectedToInternet()
         {
            let urlStr = urlstr
             print(urlstr)
            _ = urlStr.addingPercentEncoding(withAllowedCharacters: CharacterSet.urlQueryAllowed)

         manager.session.configuration.timeoutIntervalForRequest = Configurator.requsetTimeOut
        // AppCommon.PrintLogs(printStatement:"Url: ---- \(apiName ?? "")")
        //     AppCommon.PrintLogs(printStatement:"Param: ---- \(info )")

            do
            {
             var request = try URLRequest(url: urlStr, method: httpMethod, headers: requestHeaders)
             
            do
            {
             request.httpBody = try JSONSerialization.data(withJSONObject: info, options: .prettyPrinted)
             
             manager.request(request).responseJSON
                 { (response) in
                 print(response)
                                     if nil != response.value
                                     {
                                         DispatchQueue.main.async { completion(response.data, nil)}
                                     }
                                     else
                                     {
                                        
                                        Utility.hideLoader(vc: vc)
                                         Utility.showAlert(vc: vc, message: "Server Error", titelstring:Appcommon.Appname )
                                        // AlertFunctions.showAlert(message: "Server Error")
                                     }
             }
             }
          
            catch
             {
                 print(error.localizedDescription)
             }
             
            }
            catch
            {
             print(error.localizedDescription)
             }
             }
         else
         {
            Utility.hideLoader(vc: vc)
             Utility.Internetconnection(vc: vc)
           //  AlertFunctions.showAlert(message: "No Internet Connection")
         }
     }

    
    
    
   
}


