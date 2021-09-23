//
//  Newlang.swift
//  bigfantv
//
//  Created by Ganesh on 10/07/20.
//  Copyright © 2020 Ganesh. All rights reserved.
//

import UIKit
import FirebaseFirestore
import MaterialComponents.MDCButton
class Newlangcell:UICollectionViewCell{
    
    @IBOutlet var LbCell: UILabel!
    @IBOutlet var Vicell: UIView!
    
    @IBOutlet var ImgSelected: UIImageView!
    @IBOutlet var LbChannel: UILabel!
    @IBOutlet var LbLang: UILabel!
    @IBOutlet var ImgCell: UIImageView!
    @IBOutlet var ViLn: UIView!
}
class Newlang: UIViewController {
    
    
   
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
    
    var _selectedCells : NSMutableArray = []
    @IBOutlet var CollectionV: UICollectionView!
    let cellIdentifier = "cell"
    override func viewDidLoad()
    {
        super.viewDidLoad()
       
        self.CollectionV.register(UINib(nibName:"LnagCellFeatured", bundle:nil), forCellWithReuseIdentifier: cellIdentifier)
          
        CollectionV.delegate = self
        CollectionV.dataSource = self
        CollectionV.allowsMultipleSelection = true
        arrSelectedIndex.append(IndexPath(item: 0, section: 0))
        arrSelectedData.append("English")
       
    }
    
   
    @IBAction func NextbtTapped(_ sender: MDCButton)
    {
   
        if arrSelectedIndex.count == 0
        {
            Utility.showAlert(vc: self, message: "Please select atleast one preferred Language.", titelstring: "BigFan TV")
        }
        else
        {
            AddData()
        }
    
    }
    
    
    
     func AddData()
     {
        let badRestaurantData: [String : Any] =
            [
                "Language": arrSelectedData
            ]
        
        guard let userid = UserDefaults.standard.string(forKey: "id")  else {return}
        
        Firestore.firestore().collection("UserLanguagepreference").document(userid).setData(badRestaurantData)
        { (error) in
            if let error = error
            {
                 print("Could not Add Data: \(error)")
             }
            else
            {
                 print("data added")
                self.performSegue(withIdentifier: "tocountry", sender: self)
            }
          }
    }
     

}
extension Newlang:UICollectionViewDelegate,UICollectionViewDataSource
{
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 15
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
            
        let Comedycell = collectionView.dequeueReusableCell(withReuseIdentifier: cellIdentifier, for: indexPath) as! LnagCellFeatured
            Comedycell.ImgLang.image = UIImage(named: imagearray[indexPath.row])
            Comedycell.LbLang.text = newarray[indexPath.row]
          
                  
                  // cell.LbCell.text = languagearraay[indexPath.row]
                  //  cell.LbLang.text = newarray[indexPath.row]
                  //  cell.Vicell.layer.cornerRadius = cell.Vicell.frame.size.height/2
                 //   cell.Vicell.layer.borderColor = UIColor.gray.cgColor
                 //   cell.Vicell.layer.borderWidth = 0.8
                  
                    if arrSelectedIndex.contains(indexPath)
                    {
                       Comedycell.ImgLang.image = UIImage(named: selectimagearray[indexPath.row])
                        
                    }
                    else
                    {
                       Comedycell.ImgLang.image = UIImage(named: imagearray[indexPath.row])
                        
                    }

        //    Comedycell.layoutSubviews()
                  
        return Comedycell
                
        
                 
    }
    
  func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath){
   
    let strData = newarray[indexPath.row]
    if arrSelectedIndex.contains(indexPath)
    {
            arrSelectedIndex = arrSelectedIndex.filter { $0 != indexPath}
             arrSelectedData = arrSelectedData.filter { $0 != strData}
           }
           else {
               arrSelectedIndex.append(indexPath)
                arrSelectedData.append(strData)
           }

           collectionView.reloadData()
    }

     
    
    
}

 extension Newlang: UICollectionViewDelegateFlowLayout {
         func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
             /*
            if UIDevice.current.userInterfaceIdiom == .pad
             {
                return CGSize(width: 418, height: 87)
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
