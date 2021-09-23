//
//  demovc.swift
//  bigfantv
//
//  Created by Ganesh on 21/01/21.
//  Copyright © 2021 Ganesh. All rights reserved.
//

import UIKit
import Alamofire
class demovc: UIViewController {
       var firstServiceCallComplete = false
       var secondServiceCallComplete = false
     @IBOutlet var ComedyCollectionV: UICollectionView!
     @IBOutlet var ThrillerCollectionV: UICollectionView!
     @IBOutlet var ActionCollectioV: UICollectionView!
    @IBOutlet var  fantasyCollectioV: UICollectionView!
    @IBOutlet var  adventureCollectioV: UICollectionView!
    private var  ComedyMoviedata:newFilteredComedyMovieList?
       private var  Successdata:SuccessResponse?
       private var  passComedyMoviedata:newFilteredSubComedymovieList?
       private var  ThrillerMoviedata:newFilteredComedyMovieList?
       private var  ActionMoviedata:newFilteredComedyMovieList?
       private var  fantasyMoviedata:newFilteredComedyMovieList?
       private var  adventureMoviedata:newFilteredComedyMovieList?
    var cellIdentifier = "cell"
    let url:URL = URL(string: "https://bigfantv.com/en/rest/getFilteredContent")!
     var collectionarray = [UICollectionView]()
       override func viewDidLoad()
       {
           super.viewDidLoad()
           
           //Register collectionviewcell
                 collectionarray = [ComedyCollectionV,ThrillerCollectionV,ActionCollectioV,adventureCollectioV,fantasyCollectioV]
        for i in collectionarray
        {
              let flowLayout = UICollectionViewFlowLayout()
              flowLayout.scrollDirection = .horizontal
            let width = (i.frame.size.height * 280)/156
            
           
              flowLayout.itemSize = CGSize(width: width, height: i.frame.size.height)
              flowLayout.minimumLineSpacing = 10
              flowLayout.minimumInteritemSpacing = 10.0
              i.collectionViewLayout = flowLayout
              i.showsHorizontalScrollIndicator = false
            i.delegate = self
            i.dataSource = self
           i.register(UINib(nibName:"MyCell", bundle:nil), forCellWithReuseIdentifier: cellIdentifier)
        }
        let dispatchQueue = DispatchQueue(label: "myQueue", qos: .background)

        if Connectivity.isConnectedToInternet(){
            dispatchQueue.async {
                
            self.another1()
            }
             dispatchQueue.async {
            self.another2()
            }
                 dispatchQueue.async {
            self.another3()
                }
                     dispatchQueue.async {
            self.another4()
                    }
                         dispatchQueue.async {
            self.another5()
                        }
        }
         
    }
    
func another1() {
 
 
    }
   func another2()
   {
    let second =  Alamofire.request(url, method: .post, parameters:         [
        "authToken" : "57b8617205fa3446ba004d583284f475",
        "category" : "movies",
        "subcategory" : "adventure",
        "limit" :10,
        "offset" : 1,
        "user_id":UserDefaults.standard.string(forKey: "id") ?? "",
       "is_episode":0
        ], encoding: JSONEncoding.default, headers: nil)
      second.responseJSON { (dataw) in
         do
         {
        let decoder = JSONDecoder()
         let data = try decoder.decode(newFilteredComedyMovieList.self, from:  dataw.data ?? Data())
             self.adventureMoviedata = data
            print("found...2")
              
            DispatchQueue.main.async {
                self.adventureCollectioV.reloadData()
            }
         }catch
         {
             print(error)
         }
       self.secondServiceCallComplete = true
         
        
    }
    }
    func another3()
    {
    let third =  Alamofire.request(url, method: .post, parameters:         [
        "authToken" : "57b8617205fa3446ba004d583284f475",
        "category" : "movies",
        "subcategory" : "fantasy",
        "limit" :10,
        "offset" : 1,
        "user_id":UserDefaults.standard.string(forKey: "id") ?? "",
       "is_episode":0
        ], encoding: JSONEncoding.default, headers: nil)
      third.responseJSON { (dataw) in
         do
         {
        let decoder = JSONDecoder()
         let data = try decoder.decode(newFilteredComedyMovieList.self, from:  dataw.data ?? Data())
             self.fantasyMoviedata = data
             print("found...3")
              
            DispatchQueue.main.async {
                self.fantasyCollectioV.reloadData()
            }
         }catch
         {
             print(error)
         }
       self.firstServiceCallComplete = true
        
        
    }
   
     
 
 }
func another4()
{
    
    let fourth =  Alamofire.request(url, method: .post, parameters:         [
           "authToken" : "57b8617205fa3446ba004d583284f475",
           "category" : "movies",
           "subcategory" : "thriller",
           "limit" :10,
           "offset" : 1,
           "user_id":UserDefaults.standard.string(forKey: "id") ?? "",
          "is_episode":0
           ], encoding: JSONEncoding.default, headers: nil)
         fourth.responseJSON { (dataw) in
                       do
            {
           let decoder = JSONDecoder()
            let data = try decoder.decode(newFilteredComedyMovieList.self, from:  dataw.data ?? Data())
                self.ThrillerMoviedata = data
               print("found...4")
                 
               DispatchQueue.main.async {
                   self.ThrillerCollectionV.reloadData()
               }
            }catch
            {
                print(error)
            }
          self.firstServiceCallComplete = true
            
           
       }
 
    }
    func another5()
    {
       let fifth =  Alamofire.request(url, method: .post, parameters:         [
           "authToken" : "57b8617205fa3446ba004d583284f475",
           "category" : "movies",
           "subcategory" : "comedy1",
           "limit" :10,
           "offset" : 1,
           "user_id":UserDefaults.standard.string(forKey: "id") ?? "",
          "is_episode":0
           ], encoding: JSONEncoding.default, headers: nil)
         fifth.responseJSON { (dataw) in
            do
            {
           let decoder = JSONDecoder()
            let data = try decoder.decode(newFilteredComedyMovieList.self, from:  dataw.data ?? Data())
                self.ComedyMoviedata = data
               print("found...5")
                 
               DispatchQueue.main.async {
                   self.ComedyCollectionV.reloadData()
               }
            }catch
            {
                print(error)
            }
          self.firstServiceCallComplete = true
            
           
       }
    }
    
    
 private func handleServiceCallCompletion() {
     if self.firstServiceCallComplete && self.secondServiceCallComplete {
         // Handle the fact that you're finished
        
        print("completed...")
     }
 }
}
extension demovc:UICollectionViewDelegate,UICollectionViewDataSource
{
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        
        if collectionView == ActionCollectioV
        {
            return ActionMoviedata?.subComedymovList.count ?? 0
        }
        else if collectionView == adventureCollectioV
        {
            return adventureMoviedata?.subComedymovList.count ?? 0
        }
        else if collectionView == fantasyCollectioV
        {
            return fantasyMoviedata?.subComedymovList.count ?? 0
        }
        
         else if collectionView == ComedyCollectionV
        {
 
            return ComedyMoviedata?.subComedymovList.count ?? 0
        }else if collectionView == ThrillerCollectionV
        {
             
            return ThrillerMoviedata?.subComedymovList.count ?? 0
        }
        return 0
    }
    
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell
    {
         
        let Cell   = collectionView.dequeueReusableCell(withReuseIdentifier: cellIdentifier, for: indexPath) as! MyCell
 
            if collectionView == ActionCollectioV
            {
       
            Loaddataincell(maincell: Cell, data: ActionMoviedata!, ind: indexPath.row )
            }else if collectionView == adventureCollectioV
            {
                Loaddataincell(maincell: Cell, data: adventureMoviedata!, ind: indexPath.row )
            }else if collectionView == fantasyCollectioV
            {
                Loaddataincell(maincell: Cell, data: fantasyMoviedata!, ind: indexPath.row )
             }
            else if collectionView == ComedyCollectionV
            {
                Loaddataincell(maincell: Cell, data: ComedyMoviedata!, ind: indexPath.row )
             }
            else if collectionView == ThrillerCollectionV
            {
                Loaddataincell(maincell: Cell, data: ThrillerMoviedata!, ind: indexPath.row )
             }
 
        return Cell

    }
     
    func Loaddataincell(maincell:MyCell,data:newFilteredComedyMovieList,ind:Int )
    {
        let item = data.subComedymovList[ind]
   
        maincell.ImgSample.sd_setImage(with: URL(string:item.poster ?? ""), completed: nil)
  
        maincell.LbName.text = item.title ?? ""
         let image = item.is_fav_status == 1 ? UIImage(named: "liked") : UIImage(named: "like")
         maincell.btnCounter.setBackgroundImage(image, for: .normal)
        
    }
    
    
}
