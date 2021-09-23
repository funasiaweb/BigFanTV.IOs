//
//  TableViewCell.swift
//  CollectionViewInsideTableViewExample
//
//  Created by John Codeos on 12/20/19.
//  Copyright © 2019 John Codeos. All rights reserved.
//

import UIKit
import SDWebImage
protocol CollectionViewCellDelegate: class {
    func collectionView(collectionviewcell: CollectionViewCell?, index: Int,rowindex:Int, didTappedInTableViewCell: TableViewCell)
    // other delegate methods that you can define to perform action in viewcontroller
}

class TableViewCell: UITableViewCell {
    
    weak var cellDelegate: CollectionViewCellDelegate?
    
    var rowWithColors: [FeaturedDatadetails]?
    var rowindext = 0
    @IBOutlet var subCategoryLabel: UILabel!
    @IBOutlet var collectionView: UICollectionView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        backgroundColor = Appcolor.backgorund4
       
        // TODO: need to setup collection view flow layout
        let flowLayout = UICollectionViewFlowLayout()
          flowLayout.scrollDirection = .horizontal
        let width = ((collectionView.frame.size.height - 18) * 280)/156
           flowLayout.itemSize = CGSize(width: width, height: collectionView.frame.size.height)
        flowLayout.minimumLineSpacing = 10
        flowLayout.minimumInteritemSpacing = 10
       self.collectionView.collectionViewLayout = flowLayout
        self.collectionView.showsHorizontalScrollIndicator = false
        
        // Comment if you set Datasource and delegate in .xib
        self.collectionView.dataSource = self
        self.collectionView.delegate = self
        
        // Register the xib for collection view cell
        let cellNib = UINib(nibName: "CollectionViewCell", bundle: nil)
        self.collectionView.register(cellNib, forCellWithReuseIdentifier: "collectionviewcellid")
    }
}

extension TableViewCell: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    
    // The data we passed from the TableView send them to the CollectionView Model
    func updateCellWith(row: [FeaturedDatadetails],rowindex:Int) {
        rowindext = rowindex
        self.rowWithColors = row
        self.collectionView.reloadData()
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let cell = collectionView.cellForItem(at: indexPath) as? CollectionViewCell
        print("I'm tapping the \(indexPath.item)")
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
        if let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "collectionviewcellid", for: indexPath) as? CollectionViewCell {
            
            cell.backgroundView?.backgroundColor = Appcolor.backgorund4
            cell.contentView.backgroundColor = Appcolor.backgorund4
            cell.Imageview.sd_setImage(with: URL(string: "\(self.rowWithColors?[indexPath.item].poster ?? "")"), completed: nil)
            cell.nameLabel.text = self.rowWithColors?[indexPath.item].title ?? ""
            return cell
        }
        return UICollectionViewCell()
    }
    
    
    
    
     
 
}
