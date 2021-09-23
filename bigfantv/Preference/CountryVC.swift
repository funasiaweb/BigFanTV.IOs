//
//  CountryVC.swift
//  bigfantv
//
//  Created by Ganesh on 10/07/20.
//  Copyright © 2020 Ganesh. All rights reserved.
//

import UIKit
import FirebaseFirestore
class CountryCell:UITableViewCell
{
    @IBOutlet var ImgCountry: UIImageView!
    
    @IBOutlet var ImgCheckmark: UIImageView!
    @IBOutlet var LbCountry: UILabel!
}
class CountryVC: UIViewController {
    let sampledata:[sample] = [
          sample(img: "1011", labletext: "South Africa"),
                            sample(img: "1012", labletext: "Germany"),
                            sample(img: "1013", labletext: "France"),
                            sample(img: "1014", labletext: "India"),
                            sample(img: "1015", labletext: "Canada"),
                            sample(img: "1016", labletext: "USA"),
                           sample(img: "1017", labletext: "UAE")
              
              
             ]
    
    
    var selectedCells:[Int] = []
    var arrSelectedData = ""
     var resultSearchController = UISearchController()
     var filteredUserMeetingsDate = [sample]()
    var countrystring = ""
    var isshown = false
    @IBOutlet var TableV: UITableView!
    override func viewDidLoad() {
        super.viewDidLoad()
      
             self.TableV.delegate = self
             self.TableV.dataSource = self
              self.TableV.reloadData()
        resultSearchController = ({
                 let controller = UISearchController(searchResultsController: nil)
                 controller.searchResultsUpdater = self
                 controller.dimsBackgroundDuringPresentation = false
                 controller.searchBar.sizeToFit()
                 controller.searchBar.barTintColor = Appcolor.backgorund2
                 controller.searchBar.tintColor  =  UIColor.white
                 TableV.tableHeaderView = controller.searchBar
                 
                 return controller
             })()
       //  TableV.tableFooterView = UIView()
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
                   }
                   @objc func close()
                   {
                       self.dismiss(animated: true, completion: nil)
                   }
    
    
    @IBAction func NextbtTapped(_ sender: UIButton) {
    
        if selectedCells.count > 0
        {
           // AddData()
            self.performSegue(withIdentifier: "toradio", sender: self)
        }else
        {
             Utility.showAlert(vc: self, message: "Please select atleast one country.", titelstring: "BigFan TV")
        }
    
    }
    private func customClassGetDocument() {
                   // [START custom_type]
            
            Utility.ShowLoader(vc: self)
                guard let userid = UserDefaults.standard.string(forKey: "id")     else {return}
                let docRef = Firestore.firestore().collection("UserLanguagepreference").document(userid)

                   docRef.getDocument { (document, error) in
                    if let err = error
                    {
                          print("Error fetch document: \(err)")
                    }
                    else {
                        guard let data = document?.data() else {return}
                        self.countrystring = data["Countrycode"] as? String ?? ""
                       
                       }
                    
                  
                 
                    Utility.hideLoader(vc: self)
                    
                   }

        }
        
        
        
    
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        
                   if segue.identifier == "toradio"
                   {
                    guard let navController = segue.destination as? UINavigationController,
                        let displayVC = navController.topViewController as? RadioStationVC else {
                            return
                    }
                                
                          displayVC.countrycode = arrSelectedData
                                      
                                      
                  }
        
      
        }
    
    func AddData()
      {
         let badRestaurantData: [String : Any] =
             [
                 "Country": arrSelectedData
             ]
         
         guard let userid = UserDefaults.standard.value(forKey: "id")as? String  else {return}
         Firestore.firestore().collection("Userpreference").document(userid).setData(badRestaurantData) { (error) in
             if let error = error {
                  print("Could not Add Data: \(error)")
             
             } else {
                  
                 self.performSegue(withIdentifier: "toradio", sender: self)
             }
           }
     }
    

}

 extension CountryVC:UITableViewDelegate,UITableViewDataSource
 {
     func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if  (resultSearchController.isActive && resultSearchController.searchBar.text != "" && resultSearchController.searchBar.text!.count > 1)
                {
                 return    filteredUserMeetingsDate.count
        }else
        {
             return sampledata.count
        }
       
     }
     
     func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        
        
         if let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)as? CountryCell
         {
            if  (resultSearchController.isActive && resultSearchController.searchBar.text != "" && resultSearchController.searchBar.text!.count > 1)
          {
            let item = filteredUserMeetingsDate[indexPath.row]
            cell.ImgCountry.image = UIImage(named: "\(item.img)")
            cell.LbCountry.text = item.labletext
            }
           else
            {
            
            cell.ImgCountry.image = UIImage(named: "\(sampledata[indexPath.row].img)")
            cell.LbCountry.text = sampledata[indexPath.row].labletext
            }
            
            
            cell.ImgCheckmark.image =  self.selectedCells.contains(indexPath.row) ? UIImage(named: "check-marknew") : nil
            
            
             return cell
         }
         return UITableViewCell()
     }
     func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
            
                if !self.selectedCells.contains(indexPath.row)
                {
                               self.selectedCells.removeAll()
                    
                    self.selectedCells.append(indexPath.row)
                    arrSelectedData = sampledata[indexPath.row].labletext
                      
                    tableView.reloadData()
                }
       
     }
   
     func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        /*
           if UIDevice.current.userInterfaceIdiom == .pad {
                             return 90
                           } else if UIDevice.current.userInterfaceIdiom == .phone  {
                       return 70
                             
                           }
        */
       return 70
     }
 }

extension CountryVC:UISearchResultsUpdating
{
    func updateSearchResults(for searchController: UISearchController) {
         
          filteredUserMeetingsDate.removeAll()
        for item in  sampledata
          {
              let str  = searchController.searchBar.text!
            let str2  = item.labletext.lowercased()
          
            if str2.contains(str.lowercased())
              {
                  filteredUserMeetingsDate.append(item)
                  TableV.reloadData()
              }
              
             TableV.reloadData()
          }
          
          
      }
    
}
