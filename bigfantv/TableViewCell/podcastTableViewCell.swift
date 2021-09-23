//
//  podcastTableViewCell.swift
//  bigfantv
//
//  Created by Ganesh on 11/12/20.
//  Copyright © 2020 Ganesh. All rights reserved.
//

import UIKit
import SDWebImage
protocol CollectionViewCellDelegate1: class {
    func collectionView(collectionviewcell: CollectionViewCellnew?, index: Int,rowindex:Int, didTappedInTableViewCell: podcastTableViewCell)
    // other delegate methods that you can define to perform action in viewcontroller
}

class podcastTableViewCell: UITableViewCell {
    
    weak var cellDelegate: CollectionViewCellDelegate1?
    
    var rowWithColors: [AudioPodcastDataListDetails]?
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
       flowLayout.minimumLineSpacing = 2
       flowLayout.minimumInteritemSpacing = 2.0
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

extension podcastTableViewCell: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    
    // The data we passed from the TableView send them to the CollectionView Model
    func updateCellWith(row: [AudioPodcastDataListDetails],rowindex:Int) {
        rowindext = rowindex
        self.rowWithColors = row
        self.collectionView.reloadData()
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let cell = collectionView.cellForItem(at: indexPath) as? CollectionViewCellnew
        print("I'm tapping the \(indexPath.item)")
        self.cellDelegate?.collectionView(collectionviewcell: cell, index: indexPath.item, rowindex: rowindext, didTappedInTableViewCell: self)
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if rowWithColors?.count ?? 0 <= 0
        {
            collectionView.setEmptyViewnew1(title: "No Content Available")
        }else
        {
            collectionView.restore()
        }
        return self.rowWithColors?.count ?? 0
    }
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }

    // Set the data for each cell (color and color name)
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell
    {
        if let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "collectionviewcellid", for: indexPath) as? CollectionViewCellnew
        {
            
            cell.backgroundView?.backgroundColor = Appcolor.backgorund3
            cell.contentView.backgroundColor = Appcolor.backgorund3
           
            cell.Imageview.sd_setImage(with: URL(string: "\(self.rowWithColors?[indexPath.item].itunesimage ?? "")"), completed: nil)
          //  cell.LbTime.text = self.rowWithColors?[indexPath.item].description ?? ""
            cell.LbDate.text = self.rowWithColors?[indexPath.item].title ?? ""
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
