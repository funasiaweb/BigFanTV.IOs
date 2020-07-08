//
//  pagecontrol.swift
//  bigfantv
//
//  Created by Ganesh on 03/07/20.
//  Copyright © 2020 Ganesh. All rights reserved.
//

import UIKit
class pagecell:UICollectionViewCell{
    
    @IBOutlet var Imgsample: UIImageView!
}
class pagecontrol: UIViewController {

    @IBOutlet var CollectionV: UICollectionView!
    @IBOutlet var PageCtrl: UIPageControl!
  let sampledata  = [
    UIImage(named: "0"),
    UIImage(named: "bv"),
    UIImage(named: "2"),
    UIImage(named: "3"),
    UIImage(named: "bv"),
    UIImage(named: "5"),
    UIImage(named: "6"),
    UIImage(named: "bv")
     ]
          
        var timer = Timer()
        var counterr = 0
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

       
   //     timer  = Timer.scheduledTimer(timeInterval: 2, target: self, selector: #selector(changeimage), userInfo: nil, repeats: true)
        
        PageCtrl.numberOfPages = sampledata.count
        PageCtrl.currentPage = 0
        CollectionV.delegate = self
        CollectionV.dataSource = self
       
    }
   
    
    @objc func changeimage()
    {
        if counterr < sampledata.count
        {
            let index = IndexPath.init(item: counterr, section: 0)
            CollectionV.scrollToItem(at: index, at: .centeredHorizontally, animated: true)
            PageCtrl.currentPage = counterr
            counterr += 1
        }else
        {
            counterr = 0
            let index = IndexPath.init(item: counterr, section: 0)
            CollectionV.scrollToItem(at: index, at: .centeredHorizontally, animated: false)
            PageCtrl.currentPage = counterr
            counterr = 1
            
        }
    }
    
}
extension pagecontrol:UICollectionViewDelegate,UICollectionViewDataSource
{
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return sampledata.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cell", for: indexPath)
         
          
        //  cell.LbSample.text = sampledata[indexPath.row].labletext
       
       
        if let vc = cell.viewWithTag(111)as? UIImageView
        {
            vc.image =  sampledata[indexPath.row]
             
        } else if let ab = cell.viewWithTag(222)as? UIPageControl
        {
             ab.currentPage = indexPath.row
        }
      
          
        
          return cell
    }
    
    
}

extension pagecontrol:UICollectionViewDelegateFlowLayout
{
   
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let size = CollectionV.frame.size
        return CGSize(width: size.width, height: size.height)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 0.0
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return 0.0
    }
     
}
