//
//  CollectionViewCellnew.swift
//  bigfantv
//
//  Created by Ganesh on 11/12/20.
//  Copyright © 2020 Ganesh. All rights reserved.
//

import UIKit

class CollectionViewCellnew: UICollectionViewCell {
    weak var delegate:LiveTVvc?

    @IBOutlet var Imageview: UIImageView!
    
    @IBOutlet var BtFav: UIButton!
    @IBOutlet var LbTime: UILabel!
    
    @IBOutlet var LbDate: UILabel!
     var actionBlock: (() -> Void)? = nil
    
     @IBAction func Favouritetapped(_ sender: UIButton) {
         actionBlock?()
     }
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

}
