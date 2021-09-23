//
//  LiveTVTableViewCell.swift
//  bigfantv
//
//  Created by Ganesh on 11/12/20.
//  Copyright © 2020 Ganesh. All rights reserved.
//

import UIKit
import SDWebImage
protocol CollectionViewCellDelegate2: class {
    func collectionView(collectionviewcell: CollectionViewCellnew?, index: Int,rowindex:Int, didTappedInTableViewCell: LiveTVTableViewCell)
    // other delegate methods that you can define to perform action in viewcontroller
}

class LiveTVTableViewCell: UITableViewCell {
    
    weak var cellDelegate: CollectionViewCellDelegate2?
    
    var rowWithColors: [LiveTvListdetails]?
    var rowindext = 0
    @IBOutlet var subCategoryLabel: UILabel!
    @IBOutlet var collectionView: UICollectionView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        backgroundColor = Appcolor.backgorund3
       
        // TODO: need to setup collection view flow layout
        let flowLayout = UICollectionViewFlowLayout()
        flowLayout.scrollDirection = .horizontal
      let width = (collectionView.frame.size.height * 280)/156
          flowLayout.itemSize = CGSize(width: width, height: collectionView.frame.size.height)
       flowLayout.minimumLineSpacing = 10
       flowLayout.minimumInteritemSpacing = 10
       self.collectionView.collectionViewLayout = flowLayout
        self.collectionView.showsHorizontalScrollIndicator = false
        
        // Comment if you set Datasource and delegate in .xib
        self.collectionView.dataSource = self
        self.collectionView.delegate = self
        
        // Register the xib for collection view cell
        let cellNib = UINib(nibName: "CollectionViewCellnew", bundle: nil)
        self.collectionView.register(cellNib, forCellWithReuseIdentifier: "collectionviewcellid")
    }
}

extension LiveTVTableViewCell: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    
    // The data we passed from the TableView send them to the CollectionView Model
    func updateCellWith(row: [LiveTvListdetails],rowindex:Int) {
        rowindext = rowindex
        self.rowWithColors = row
        self.collectionView.reloadData()
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let cell = collectionView.cellForItem(at: indexPath) as? CollectionViewCellnew
        print("I'm tapping the \(indexPath.item)")
        print("I'm not tapping the \(rowindext)")
        self.cellDelegate?.collectionView(collectionviewcell: cell, index: indexPath.item, rowindex: rowindext, didTappedInTableViewCell: self)
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return self.rowWithColors?.count ?? 0
    }
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }

    // Set the data for each cell (color and color name)
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "collectionviewcellid", for: indexPath) as? CollectionViewCellnew {
            
            cell.backgroundView?.backgroundColor = Appcolor.backgorund4
            cell.contentView.backgroundColor = Appcolor.backgorund4
           
            cell.Imageview.sd_setImage(with: URL(string: "\(self.rowWithColors?[indexPath.item].tvImage ?? "")"), completed: nil)
          //  cell.LbTime.text = self.rowWithColors?[indexPath.item].description ?? ""
            cell.LbDate.text = self.rowWithColors?[indexPath.item].title ?? ""
            let image = self.rowWithColors?[indexPath.item].isFavourite == "1" ? UIImage(named: "liked") : UIImage(named: "like")
            cell.BtFav.isHidden = false
            cell.BtFav.setBackgroundImage(image, for: .normal)
            cell.actionBlock = {
                () in
                if self.rowWithColors?[indexPath.item].isFavourite == "0"
                {
                    cell.BtFav.setBackgroundImage(UIImage(named: "liked"), for: .normal)
                    guard let parameters = [
                        "userId":UserDefaults.standard.string(forKey: "id") ?? ""  ,
                        "AccessToken":UserDefaults.standard.string(forKey:"AccessToken") ?? "" ,
                        "liveTvId": self.rowWithColors?[indexPath.item].liveTvID ?? "",
                        "isFavourite":"1"
                        ] as? [String:Any] else {
                        return
                    }
                    Common.shared.Commonapi(parameters: parameters, urlString: CommonApiEndPoints.saveFavouriteLiveTv) { (data, err) -> (Void) in
                        if data != nil
                        {
                            self.rowWithColors?[indexPath.item].isFavourite = "1"
                            cell.BtFav.setBackgroundImage(UIImage(named: "liked"), for: .normal)
                            
                        }
                    }
                }else if self.rowWithColors?[indexPath.item].isFavourite == "1"
                {
                     cell.BtFav.setBackgroundImage(UIImage(named: "like"), for: .normal)
                     guard let parameters = [
                         "userId":UserDefaults.standard.string(forKey: "id") ?? ""  ,
                         "AccessToken":UserDefaults.standard.string(forKey:"AccessToken") ?? "" ,
                         "liveTvId": self.rowWithColors?[indexPath.item].liveTvID ?? "",
                         "isFavourite":"0"
                         ] as? [String:Any] else {
                         return
                     }
                     Common.shared.Commonapi(parameters: parameters, urlString: CommonApiEndPoints.saveFavouriteLiveTv) { (data, err) -> (Void) in
                         if data != nil
                         {
                             self.rowWithColors?[indexPath.item].isFavourite = "0"
                             cell.BtFav.setBackgroundImage(UIImage(named: "like"), for: .normal)
                             
                         }
                     }
                }
               
            }
            return cell
        }
        return UICollectionViewCell()
    }
     
    
    
     
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return UIEdgeInsets(top:0, left: 0, bottom: 0, right: 0)
    }
    
    // margin between items
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return 10
    }
    
    // minimum line margin
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 10
    }
}
