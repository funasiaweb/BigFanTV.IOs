//
//  PullLanguageVC.swift
//  bigfantv
//
//  Created by Ganesh on 15/07/20.
//  Copyright © 2020 Ganesh. All rights reserved.
//

import UIKit
import FirebaseFirestore
import MaterialComponents.MDCButton

class PullLanguageVC: UIViewController
{

        var languagearraay = ["A" ,"अ","ਅ", "அ", "ఆ", "अ", "ക", "अ","ક","অ","ಕ"]
       // let imagearray = ["lang1","lang8", "lang11", "lang10", "lang9", "lang5", "lang7", "lang8","lang4","lang2","lang6"]
      //  let selectimagearray = ["langa1","langa8", "langa11", "langa10", "langa9", "langa5", "langa7", "langa8","langa4","langa2","langa6"]
      //  let newarray = ["English","Hindi", "Punjabi", "Tamil", "Telugu", "Marathi", "Malayalam", "Bhojpuri","Gujarati","Bengali","Kannada"]
      let imagearray =
         ["lang1","lang8", "lang11", "lang10", "lang9", "lang5", "lang7", "lang8","lang4","lang2","lang6","lang12","lang8","lang13","lang8"]
     let selectimagearray = ["langa1","langa8", "langa11", "langa10", "langa9", "langa5", "langa7", "langa8","langa4","langa2","langa6","langa12","langa8","langa13","langa8"]
    let newarray =
        ["English","Hindi", "Punjabi", "Tamil", "Telugu", "Marathi", "Malayalam", "Bhojpuri","Gujarati","Bengali","Kannada","Odiya","Haryanvi","Urdu","Nepali"]
     let subcatearray = ["english","hindi", "punjabi4", "tamil", "telugu", "marathi", "malyalam", "bhojpuri","gujarati","bengali","kannada","odiya","haryanvi","urdu","nepali"]
        var selectedCells:[Int] = []
        var arrSelectedIndex = [IndexPath]()
        var arrSelectedData = [String]()
        var isshown = false
        var _selectedCells : NSMutableArray = []
        var arraydata = [String]()
    let cellIdentifier = "cell"
        @IBOutlet var CollectionV: UICollectionView!
        override func viewDidLoad() {
              
            super.viewDidLoad()
            
            CollectionV.allowsMultipleSelection = true
           self.CollectionV.register(UINib(nibName:"LnagCellFeatured", bundle:nil), forCellWithReuseIdentifier: cellIdentifier)
           
            
        }
        
    override func viewDidAppear(_ animated: Bool) {
        customClassGetDocument()
      
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
        
        @IBAction func NextbtTapped(_ sender: MDCButton) {
       
            if arrSelectedIndex.count == 0
            {
                Utility.showAlert(vc: self, message: "Please select atleast one preferred Language.", titelstring: "BigFan TV")
            }else
            {
                AddData()
            }
        
        }
        private func customClassGetDocument() {
                   // [START custom_type]
            
            Utility.ShowLoader(vc: self)
                guard let userid = UserDefaults.standard.string(forKey: "id")  else {return}
                let docRef = Firestore.firestore().collection("UserLanguagepreference").document(userid)

                   docRef.getDocument { (document, error) in
                     Utility.hideLoader(vc: self)
                    
                    if let err = error
                    {
                        
                          print("Error fetch document: \(err)")
                    } else
                    {
                       if let data = document?.data()
                       {
                        self.arraydata = data["Language"]as? [String] ?? [String]()
                       }
                    }
                    
                  
                    
                    DispatchQueue.main.async {
                        self.CollectionV.delegate = self
                        self.CollectionV.dataSource = self
                         self.CollectionV.reloadData()
                    }
                    
                    
                   }

        }
        
        
         func AddData()
         {
            
            guard let userid = UserDefaults.standard.string(forKey: "id")   else {return}
                   
            Utility.ShowLoader(vc: self)

                   Firestore.firestore().collection("UserLanguagepreference").document(userid).updateData([
                               "Language": arrSelectedData
                          ]) { err in
                    Utility.hideLoader(vc: self)
                              if let err = err {
                                
                                  print("Error updating document: \(err)")
                              } else {
                                LoginVC.isfromLogin = false
                                //self.performSegue(withIdentifier: "pullcountry", sender: self)
                                let storyBoard: UIStoryboard = UIStoryboard(name: "Main", bundle: nil)
                                let displayVC = storyBoard.instantiateViewController(withIdentifier: "PullCountryVC") as! PullCountryVC
                                self.navigationController?.pushViewController(displayVC, animated: true)
                                  print("Data successfully updated")
                              }
                          }
       
        }
         

    }
    extension PullLanguageVC:UICollectionViewDelegate,UICollectionViewDataSource
    {
        func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
            return 15
        }
        
        func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell
        {
            let Comedycell = collectionView.dequeueReusableCell(withReuseIdentifier: cellIdentifier, for: indexPath) as! LnagCellFeatured
                       
               Comedycell.ImgLang.image = UIImage(named: imagearray[indexPath.row])
               Comedycell.LbLang.text = newarray[indexPath.row]
                     
              if isshown == false
              {
                for i in arraydata
                {
                     
                    if i  == newarray[indexPath.row]
                    {
                        arrSelectedData.append(i)
                        arrSelectedIndex.append(indexPath)
                        
                    }
                    
                }
              }
                 
            if arrSelectedIndex.contains(indexPath)
           {
              Comedycell.ImgLang.image = UIImage(named: selectimagearray[indexPath.row])
           } else
           {
              Comedycell.ImgLang.image = UIImage(named: imagearray[indexPath.row])
               
           }
                
                   return Comedycell
             
        }
        
      func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath){
            isshown = true
        let strData = newarray[indexPath.row]
        if arrSelectedIndex.contains(indexPath)
        {
                 arrSelectedIndex = arrSelectedIndex.filter { $0 != indexPath}
                 arrSelectedData = arrSelectedData.filter { $0 != strData}
        }
        else
        {
            arrSelectedIndex.append(indexPath)
             arrSelectedData.append(strData)
        }

               collectionView.reloadData()
        }

         
        
        
    }

     extension PullLanguageVC: UICollectionViewDelegateFlowLayout {
             func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
                /*
                 if UIDevice.current.userInterfaceIdiom == .pad {
                          return CGSize(width: 418, height: 87)
                        } else if UIDevice.current.userInterfaceIdiom == .phone  {
                   let height = collectionView.frame.size.width/2 - 5
                                  return CGSize(width:height , height:height)
                          
                        }
                 */
                 let height = collectionView.frame.size.width/2 - 5
                 return CGSize(width:height , height:height)
             }
        
         }
