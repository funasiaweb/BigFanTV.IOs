//
//  ViewController.swift
//  bigfantv
//
//  Created by Ganesh on 25/06/20.
//  Copyright © 2020 Ganesh. All rights reserved.
//

import UIKit
import MuviSDK
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

class ViewController: UIViewController ,FSPagerViewDataSource,FSPagerViewDelegate {

 fileprivate let imageNames = ["01","02","03","04","05" ]
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
 }
 
 // MARK:- FSPagerViewDelegate
 
 func pagerViewWillEndDragging(_ pagerView: FSPagerView, targetIndex: Int) {
     self.pageControl.currentPage = targetIndex
 }
 
    
   
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
    @IBOutlet var ViScroll: UIView!
    var timr=Timer()
    var w:CGFloat=0.0
    override func viewDidLoad()
    {
        super.viewDidLoad()
        
        /*
     //   button.frame = CGRect(x: 200, y: 100, width: 300, height: 50)
        button.setTitle( "View All >", for: .normal)
        button.setTitleFont(UIFont(name: "Muli-Bold", size: 16)!, for: .normal)
        button.inkColor = .white
        button.isUppercaseTitle = false
        button.backgroundColor = .clear
        view.addSubview(button)
       button.translatesAutoresizingMaskIntoConstraints = false

         NSLayoutConstraint.activate([
                      button.bottomAnchor.constraint(equalTo: CollectionV.topAnchor,constant: 10),
                      button.trailingAnchor.constraint(equalTo: view.trailingAnchor,constant: -10),
                      button.widthAnchor.constraint(equalToConstant: 120),
                      button.heightAnchor.constraint(equalToConstant: 50)
                   
         ])
        */
     }
    
 
     
     override func viewDidAppear(_ animated: Bool) {
             super.viewDidAppear(true)
        
               
       
         }

         override func viewDidDisappear(_ animated: Bool) {
             super.viewDidAppear(true)

           //  deconfigAutoscrollTimer()
         }
  
    
    
    

     func configAutoscrollTimer()
         {

            var bgTask = UIBackgroundTaskIdentifier(rawValue: 0)
            bgTask = UIApplication.shared.beginBackgroundTask(expirationHandler: {
                UIApplication.shared.endBackgroundTask(bgTask)
            })
            
          
            timr = Timer.scheduledTimer(timeInterval: 0.03, target: self, selector: #selector(autoScrollView), userInfo: nil, repeats: true)
            RunLoop.current.add(timr, forMode: .default)
         }
         func deconfigAutoscrollTimer()
         {
             timr.invalidate()

         }
         func onTimer()
         {
             autoScrollView()
         }

    @objc func autoScrollView()
         {

             let initailPoint = CGPoint(x: w,y :0)

             if __CGPointEqualToPoint(initailPoint,self.CollectionV.contentOffset)
             {
                 if w<CollectionV.contentSize.width
                 {
                    w += 0.5
                 }
                 else
                 {
                     w = -self.view.frame.size.width
                 }

                 let offsetPoint = CGPoint(x: w,y :0)

                 CollectionV.contentOffset=offsetPoint

             }
             else
             {
                 w = CollectionV.contentOffset.x
             }
         }
     
 
     
/*
    func GetStaticdetails()
    {
        let inputObj =   StaticPageDetailsInput(permalink: "about-us")
        inputObj.langCode = "en"
        
        MuviAPISDK.controller.getStaticPageDetailsDataTask(inputObj) { (result) in
            switch result {
                
            case .success(let output,let response):print("success::\(output.content)")
            case .failure(let error): print("error::\(error.localizedDescription)")
            }
            print(result)
        }
    }
*/




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
}
   
extension ViewController: UICollectionViewDelegateFlowLayout {
        func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
            
            if UIDevice.current.userInterfaceIdiom == .pad {
                     return CGSize(width: 180, height: 280)
                   } else if UIDevice.current.userInterfaceIdiom == .phone  {
                return CGSize(width: 130, height: 190)
                     
                   }
            
            return CGSize(width: 180, height: 280)
        }
     
   
    }
 
