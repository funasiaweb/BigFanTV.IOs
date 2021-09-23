//
//  ViewController.swift
//  bigfantv
//
//  Created by Ganesh on 25/06/20.
//  Copyright © 2020 Ganesh. All rights reserved.
//

import UIKit
 
import MaterialComponents.MaterialButtons
import MaterialComponents.MDCBaseCell
import FSPagerView
class newcell:MDCBaseCell
{
  
    
}
class collectionCell: MDCBaseCell
{
     
    @IBOutlet var ImgSample: UIImageView!
    @IBOutlet var LbSample: UILabel!
}
struct sample {
    let img,labletext:String
}

class ViewController: UIViewController,FSPagerViewDataSource,FSPagerViewDelegate  {

  
   fileprivate let imageNames = ["e1","e2","e3","e4","e5" ]
   fileprivate let pageControlStyles = ["Default", "Ring", "UIImage", "UIBezierPath - Star", "UIBezierPath - Heart"]
   fileprivate let pageControlAlignments = ["Right", "Center", "Left"]
   fileprivate let sectionTitles = ["Style", "Item Spacing", "Interitem Spacing", "Horizontal Alignment"]
   
   fileprivate var styleIndex = 0 {
       didSet {
           // Clean up
           self.pageControl.setStrokeColor(nil, for: .normal)
           self.pageControl.setStrokeColor(nil, for: .selected)
           self.pageControl.setFillColor(nil, for: .normal)
           self.pageControl.setFillColor(nil, for: .selected)
           self.pageControl.setImage(nil, for: .normal)
           self.pageControl.setImage(nil, for: .selected)
           self.pageControl.setPath(nil, for: .normal)
           self.pageControl.setPath(nil, for: .selected)
           switch self.styleIndex {
           case 0:
               // Default
               break
           case 1:
               // Ring
               self.pageControl.setStrokeColor(.green, for: .normal)
               self.pageControl.setStrokeColor(.green, for: .selected)
               self.pageControl.setFillColor(.green, for: .selected)
           case 2:
               // Image
               self.pageControl.setImage(UIImage(named:"icon_footprint"), for: .normal)
               self.pageControl.setImage(UIImage(named:"icon_cat"), for: .selected)
           
           default:
               break
           }
       }
   }
   fileprivate var alignmentIndex = 1 {
       didSet {
           self.pageControl.contentHorizontalAlignment = [.right,.center,.left][self.alignmentIndex]
       }
   }
   
   // ⭐️
   
   @IBOutlet weak var pagerView: FSPagerView! {
       didSet {
           self.pagerView.register(FSPagerViewCell.self, forCellWithReuseIdentifier: "cell")
          self.pagerView.automaticSlidingInterval = 2.0
          self.pagerView.delegate = self
          self.pagerView.dataSource = self
              self.typeIndex = 1
           
       }
   }
   fileprivate let transformerTypes: [FSPagerViewTransformerType] = [.crossFading,
                                                                     .zoomOut,
                                                                     .depth,
                                                                     .linear,
                                                                     .overlap,
                                                                     .ferrisWheel,
                                                                     .invertedFerrisWheel,
                                                                     .coverFlow,
                                                                     .cubic]
   fileprivate var typeIndex = 0 {
       didSet {
           let type = self.transformerTypes[typeIndex]
           self.pagerView.transformer = FSPagerViewTransformer(type:type)
           switch type {
           case .crossFading, .zoomOut, .depth:
               self.pagerView.itemSize = FSPagerView.automaticSize
               self.pagerView.decelerationDistance = 1
           case .linear, .overlap:
               let transform = CGAffineTransform(scaleX: 0.6, y: 0.75)
               self.pagerView.itemSize = self.pagerView.frame.size.applying(transform)
               self.pagerView.decelerationDistance = FSPagerView.automaticDistance
           case .ferrisWheel, .invertedFerrisWheel:
               self.pagerView.itemSize = CGSize(width: 180, height: 140)
               self.pagerView.decelerationDistance = FSPagerView.automaticDistance
           case .coverFlow:
               self.pagerView.itemSize = CGSize(width: 220, height: 170)
               self.pagerView.decelerationDistance = FSPagerView.automaticDistance
           case .cubic:
               let transform = CGAffineTransform(scaleX: 0.9, y: 0.9)
               self.pagerView.itemSize = self.pagerView.frame.size.applying(transform)
               self.pagerView.decelerationDistance = 1
           }
       }
   }
   
   @IBOutlet weak var pageControl: FSPageControl! {
       didSet {
           self.pageControl.numberOfPages = self.imageNames.count
          self.pageControl.backgroundColor = .clear
           self.pageControl.contentHorizontalAlignment = .center
           self.pageControl.contentInsets = UIEdgeInsets(top: 0, left: 20, bottom: 0, right: 20)
           self.pageControl.hidesForSinglePage = true
       }
   }
   
   // MARK:- UITableViewDataSource
   
   func numberOfSections(in tableView: UITableView) -> Int {
       return self.sectionTitles.count
   }
   

   // MARK:- FSPagerViewDataSource
   
   func numberOfItems(in pagerView: FSPagerView) -> Int {
       return self.imageNames.count
   }
   
   public func pagerView(_ pagerView: FSPagerView, cellForItemAt index: Int) -> FSPagerViewCell {
       let cell = pagerView.dequeueReusableCell(withReuseIdentifier: "cell", at: index)
       cell.imageView?.image = UIImage(named: self.imageNames[index])
       cell.imageView?.contentMode = .scaleAspectFill
      
       return cell
       
   }
   func pagerView(_ pagerView: FSPagerView, didSelectItemAt index: Int) {
          pagerView.deselectItem(at: index, animated: true)
          pagerView.scrollToItem(at: index, animated: true)
      }
      
      func pagerViewWillEndDragging(_ pagerView: FSPagerView, targetIndex: Int) {
          self.pageControl.currentPage = targetIndex
      }
      
      func pagerViewDidEndScrollAnimation(_ pagerView: FSPagerView) {
          self.pageControl.currentPage = pagerView.currentIndex
      }
   
   
   
 
 // MARK:- FSPagerViewDelegate
  
 
    
   
    let button = MDCButton()
    
    let sampledata:[sample] = [
     sample(img: "The_Lunchbox_poster", labletext: "kolhapur"),
     sample(img: "The_Lunchbox_poster", labletext: "kolhapur"),
     sample(img: "The_Lunchbox_poster", labletext: "kolhapur"),
     sample(img: "The_Lunchbox_poster", labletext: "kolhapur"),
     sample(img: "The_Lunchbox_poster", labletext: "kolhapur"),
     sample(img: "The_Lunchbox_poster", labletext: "kolhapur"),
     sample(img: "The_Lunchbox_poster", labletext: "kolhapur"),
     sample(img: "The_Lunchbox_poster", labletext: "kolhapur"),
     sample(img: "The_Lunchbox_poster", labletext: "kolhapur"),
     sample(img: "The_Lunchbox_poster", labletext: "kolhapur"),
     sample(img: "The_Lunchbox_poster", labletext: "kolhapur"),
     sample(img: "The_Lunchbox_poster", labletext: "kolhapur"),
     
           
     
     
     
     
 
    ]
    @IBOutlet var CollectionV: UICollectionView!
   
    @IBOutlet var Collectionv2: UICollectionView!
    @IBOutlet var ViSegment: UIView!
   
    var timr=Timer()
    var w:CGFloat=0.0
    override func viewDidLoad()
    {
        super.viewDidLoad()
        
     
     }
    
 
     
     override func viewDidAppear(_ animated: Bool) {
             super.viewDidAppear(true)
        
               
       
         }

         override func viewDidDisappear(_ animated: Bool) {
             super.viewDidAppear(true)

          
         }
  
    
    
  



}
extension ViewController:UICollectionViewDelegate,UICollectionViewDataSource
{
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return sampledata.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
       if let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cell", for: indexPath)as? collectionCell
       {
        
      //  cell.LbSample.text = sampledata[indexPath.row].labletext
        cell.ImgSample.image = UIImage(named: "\(sampledata[indexPath.row].img)")
        return cell
        }
        
        
        
        return UICollectionViewCell()
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        performSegue(withIdentifier: "tofeature", sender: self)
    }
}
   
extension ViewController: UICollectionViewDelegateFlowLayout {
        func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
            
            if UIDevice.current.userInterfaceIdiom == .pad {
                return CGSize(width: 180, height:self.CollectionV.frame.size.height)
                   } else if UIDevice.current.userInterfaceIdiom == .phone  {
                return CGSize(width: 150, height: collectionView.frame.size.height)
                     
                   }
            
            return CGSize(width: 180, height: 280)
        }
     
   
    }
 
