//
//  MusicCell.swift
//  bigfantv
//
//  Created by Ganesh on 09/10/20.
//  Copyright © 2020 Ganesh. All rights reserved.
//

import UIKit

class MusicCell: UICollectionViewCell {

    @IBOutlet var btnCounter: UIButton!
   
    @IBOutlet var LbName: UILabel!
    @IBOutlet var ImgSample: UIImageView!
    
    var actionBlock: (() -> Void)? = nil
    
     @IBAction func Favouritetapped(_ sender: UIButton) {
         actionBlock?()
     }
    override func awakeFromNib() {
        super.awakeFromNib()
       
    }

}
