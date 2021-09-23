//
//  LanguageVC.swift
//  bigfantv
//
//  Created by Ganesh on 10/07/20.
//  Copyright © 2020 Ganesh. All rights reserved.
//

import UIKit
import MaterialComponents.MDCButton
import Alamofire
import SwiftyJSON
class  languagecell: UITableViewCell {
    
    @IBOutlet var ViButton: UIView!
    @IBOutlet var ImgLanguage: UIImageView!
    @IBOutlet var LbLanguage: UILabel!
}
class LanguageVC: UIViewController {

    var LangData:LanguageData?
    var isshown  = true
    @IBOutlet var TableV: UITableView!
    
    var selectedCells:[Int] = []
    override func viewDidLoad() {
        super.viewDidLoad()
      
        TableV.allowsMultipleSelection = true
        
      
    }
    override func viewWillAppear(_ animated: Bool) {
        if Connectivity.isConnectedToInternet()
        {
            getlanguagelist()
        }else
        {
            Utility.Internetconnection(vc: self)
        }
    }
    
    
    func getlanguagelist()
    {
       Utility.ShowLoader(vc: self)
        let url = Configurator.baseURL + ApiEndPoints.GetLanguageList
        
        let parameters = [
            "authToken":Keycenter.authToken
             
             ] as? [String:Any]
        
                 let manager = Alamofire.SessionManager.default
                 manager.session.configuration.timeoutIntervalForRequest = 2000


              manager.request(url, method: .post, parameters: parameters)
                      .responseJSON {
                          response in
                        print(response)
                          switch (response.result)
                          {
                          case .success:
                              if let json = response.value
                                                 {
                             
                              guard let swiftyJsonVar = JSON(response.value!) as? JSON else {return}
                                                   
                                              if swiftyJsonVar["status"].description == "OK"
                                                  {
                                                    do
                                                    {
                                                        let decoder = JSONDecoder()
                                                        self.LangData = try decoder.decode(LanguageData.self, from: response.data ?? Data())
                                                        self.TableV.delegate = self
                                                        self.TableV.dataSource = self
                                                        DispatchQueue.main.async {
                                                            self.TableV.reloadData()
                                                        }
                                                    } catch let error as NSError {
                                                        //do something with error
                                                    }
                                                   
                                                       Utility.hideLoader(vc: self)
                                                      
                                                  }
                                                 
                                                 }
                                                 
                                                 break // succes path
                          case .failure(let error):
                              Utility.hideLoader(vc: self)
                              if error._code == NSURLErrorTimedOut {
                                  print("Request timeout!")
                              }
                          }
        }
        
        
        
        
    }
}
extension LanguageVC:UITableViewDelegate,UITableViewDataSource
{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return LangData?.Languagelist.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)as? languagecell
        {
            cell.ViButton.layer.cornerRadius =  cell.ViButton.frame.size.height/2
            cell.ViButton.layer.borderColor = UIColor.gray.cgColor
            cell.ViButton.layer.borderWidth = 0.8
            cell.LbLanguage.text = LangData?.Languagelist[indexPath.row].language
            cell.ImgLanguage.image =  self.selectedCells.contains(indexPath.row) ? UIImage(named: "right") : nil
            cell.ViButton.backgroundColor = self.selectedCells.contains(indexPath.row) ? Appcolor.backgorund2 : UIColor.white
            cell.LbLanguage.textColor = self.selectedCells.contains(indexPath.row) ? UIColor.darkGray : UIColor.darkGray
            
            if isshown == true
            {
            if LangData?.Languagelist[indexPath.row].code == LangData?.default_lang
            {
                
                 cell.ImgLanguage.image =   UIImage(named: "right")
                 cell.ViButton.backgroundColor =   Appcolor.backgorund2
                 cell.LbLanguage.textColor =   UIColor.white
                isshown = false
            }
            }
            return cell
        }
        return UITableViewCell()
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
               if self.selectedCells.contains(indexPath.row) {
                 self.selectedCells.remove(at: self.selectedCells[indexPath.row] )
              } else {
                  self.selectedCells.append(indexPath.row)
              }
              
              tableView.reloadData()
    }
  
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 90
    }
}
