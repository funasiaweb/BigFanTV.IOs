//
//  CustomCell.swift
//  UICollectionViewInUIView
//
//  Created by michal on 31/05/2019.
//  Copyright © 2019 borama. All rights reserved.
//

import UIKit

class CustomCell: UICollectionViewCell {

    @IBOutlet weak var label: UILabel!
    
    @IBOutlet var ImgSample: UIImageView!
     var actionBlock: (() -> Void)? = nil
    
    @IBOutlet var BtFavourite: UIButton!
    @IBAction func Favouritetapped(_ sender: UIButton) {
         actionBlock?()
     }
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

}
