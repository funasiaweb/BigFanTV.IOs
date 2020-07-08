//
//  test3.swift
//  bigfantv
//
//  Created by Ganesh on 02/07/20.
//  Copyright © 2020 Ganesh. All rights reserved.
//

import UIKit
import FSPagerView
class test3: UIViewController  {
 
// MARK:- FSPagerViewDelegate
 
    
          let sampledata:[sample] = [
           sample(img: "livetv", labletext: "kolhapur"),
           sample(img: "livetv", labletext: "kolhapur"),
          sample(img: "livetv", labletext: "kolhapur"),
           sample(img: "livetv", labletext: "kolhapur"),
           sample(img: "livetv", labletext: "kolhapur"),
            sample(img: "livetv", labletext: "kolhapur"),
           sample(img: "livetv", labletext: "kolhapur"),
            sample(img: "livetv", labletext: "kolhapur"),
              sample(img: "livetv", labletext: "kolhapur"),
             sample(img: "livetv", labletext: "kolhapur"),
            sample(img: "livetv", labletext: "kolhapur"),
             sample(img: "livetv", labletext: "kolhapur"),
             
           
                 
           
           
           
           
       
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
      extension test3:UICollectionViewDelegate,UICollectionViewDataSource
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
         
      extension test3: UICollectionViewDelegateFlowLayout {
              func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
                 if UIDevice.current.userInterfaceIdiom == .pad {
                           return CGSize(width: 180, height: 200)
                         } else if UIDevice.current.userInterfaceIdiom == .phone  {
                    return CGSize(width: (UIScreen.main.bounds.width/2 - 20), height: 112) 
                           
                         }
                  
                  return CGSize(width: 180, height: 280)
              }
          }
       
