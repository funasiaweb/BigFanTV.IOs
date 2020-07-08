//
//  SAMPLE.swift
//  bigfantv
//
//  Created by Ganesh on 04/07/20.
//  Copyright © 2020 Ganesh. All rights reserved.
//

import UIKit
import MaterialComponents.MDCBaseCell

class samplecell:MDCBaseCell
{
    
    @IBOutlet var ImgProfile: UIImageView!
}
class SAMPLE: UIViewController {
    let sampledata:[sample] = [
           sample(img: "bv", labletext: "kolhapur"),
           sample(img: "bv", labletext: "kolhapur"),
           sample(img: "bv", labletext: "kolhapur"),
           sample(img: "bv", labletext: "kolhapur"),
           sample(img: "bv", labletext: "kolhapur"),
           sample(img: "bv", labletext: "kolhapur"),
           sample(img: "bv", labletext: "kolhapur"),
           sample(img: "bv", labletext: "kolhapur"),
           sample(img: "bv", labletext: "kolhapur"),
           sample(img: "bv", labletext: "kolhapur"),
           
           
          ]
    @IBOutlet var CollectionV: UICollectionView!
    override func viewDidLoad() {
        super.viewDidLoad()

        CollectionV.delegate = self
    
    }
     

}
extension SAMPLE:UICollectionViewDelegate,UICollectionViewDataSource
{
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return sampledata.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
       if let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cell", for: indexPath)as? samplecell
      {
        
    
        cell.ImgProfile.image = UIImage(named: "\(sampledata[indexPath.row].img)")
        return cell
        }
        
        return collectionCell()
    }
    
    
}
extension SAMPLE: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
           return UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)
       }
       func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
           return 0.0
       }
       func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
           return 0.0
       }
       
       func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
               if UIDevice.current.userInterfaceIdiom == .pad
               {
                 
                return CGSize(width: 228, height: 234)
                
               } else if UIDevice.current.userInterfaceIdiom == .phone
               {
                return CGSize(width: 130, height: 120)
                                     
              }
                                          
                                          
                                 return CGSize(width: 294, height: 270)
       }
       
       
            
       }
    
