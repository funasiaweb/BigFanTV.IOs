//
//  WatchhistCell.swift
//  bigfantv
//
//  Created by Ganesh on 14/10/20.
//  Copyright © 2020 Ganesh. All rights reserved.
//

import UIKit
 
class WatchhistCell: UICollectionViewCell {

    @IBOutlet var ImgSample: UIImageView!
     
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
         
    }

}

public enum AppColor {
    
    case blue
    case gray
    case graySeparator
    
    var rgba: [CGFloat] {
        switch self {
        case .blue: return [118.0 / 255.0, 214.0 / 255.0, 255.0 / 255.0, 1.0]
        case .gray: return [235.0 / 255.0, 235.0 / 255.0, 235.0 / 255.0, 1.0]
        case .graySeparator: return [169.0 / 255.0, 169.0 / 255.0, 169.0 / 255.0, 1.0]
        }
    }
    
    var r: CGFloat { return self.rgba[0] }
    var g: CGFloat { return self.rgba[1] }
    var b: CGFloat { return self.rgba[2] }
    var a: CGFloat { return self.rgba[3] }
    
}

// MARK: - UIColor extension
extension UIColor {
    
    convenience init(appColor: AppColor) {
        self.init(red: appColor.r, green: appColor.g, blue: appColor.b, alpha: appColor.a)
    }
}



