//
//  Firebase.swift
//  bigfantv
//
//  Created by Ganesh on 14/07/20.
//  Copyright © 2020 Ganesh. All rights reserved.
//

import UIKit
import Firebase
import SDWebImage
import FirebaseFirestore
class Firebase: UIViewController {
 
    @IBOutlet var ImgSample: UIImageView!
    override func viewDidLoad() {
        super.viewDidLoad()
        ImgSample.sd_setImage(with: URL(string: "https://d73o4i22vgk5h.cloudfront.net/45921/public/public/system/studio_banner/45921/original/Big_FAN_Promo_web.jpg"), completed: nil)
       // AddData()
       // update()
       // customClassGetDocument()
    }
    
 
    
    
     func AddData()
     {
        let badRestaurantData: [String : Any] =
            [
                "country": "Indiawddd"
            ]
        guard let userid = UserDefaults.standard.value(forKey: "id")as? String  else {return}
        Firestore.firestore().collection("Country").document(userid).setData(badRestaurantData) { (error) in
            if let error = error {
                 print("Could not Add Data: \(error)")
            
            } else {
                 print("Data added succesfully")
            }
          }
    }
    
    func update()
    {
        guard let userid = UserDefaults.standard.value(forKey: "id")as? String  else {return}
         
        Firestore.firestore().collection("Country").document(userid).updateData([
                   "country": "India"
               ]) { err in
                   if let err = err {
                       print("Error updating document: \(err)")
                   } else {
                       print("Data successfully updated")
                   }
               }
    }
    private func customClassGetDocument() {
           // [START custom_type]
        guard let userid = UserDefaults.standard.value(forKey: "id")as? String  else {return}
        let docRef = Firestore.firestore().collection("Country").document(userid)

           docRef.getDocument { (document, error) in
            if let err = error
            {
                  print("Error fetch document: \(err)")
            }
            else {
                guard let data = document?.data() else {return}
                 print(data["country"])
               }
            
       
            //print(document?.data())
            //print(error)
           }

}
 
}
