//
//  MyCell2.swift
//  bigfantv
//
//  Created by Ganesh on 21/12/20.
//  Copyright © 2020 Ganesh. All rights reserved.
//

import UIKit

class MyCell2: UICollectionViewCell {
    @IBOutlet var ImgSample: UIImageView!
     
     @IBOutlet var LbName: UILabel!
     
     @IBOutlet var ViLike: UIView!
     @IBOutlet var ViLabel: UIView!
     @IBOutlet var btnCounter: UIButton!
     
     
     var btnTapAction : (()->())?
     var actionBlock: (() -> Void)? = nil
    
     @IBAction func Favouritetapped(_ sender: UIButton) {
         actionBlock?()
     }
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

}
