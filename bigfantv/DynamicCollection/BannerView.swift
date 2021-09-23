//
//  CustomView.swift
//  UICollectionViewInUIView
//
//  Created by michal on 31/05/2019.
//  Copyright © 2019 borama. All rights reserved.
//

import UIKit
import SDWebImage
import FSPagerView
 
@IBDesignable
class BannerView: UIView   {

     var Muvidata:newFilteredComedyMovieList?
     let imageNames = ["BEAT ANTHEMS","BEAT ANTHEMS","BEAT ANTHEMS","BEAT ANTHEMS","BEAT ANTHEMS","BEAT ANTHEMS","BEAT ANTHEMS"]
    @IBOutlet var contentView: UIView!

    
    var array = [String]()
    var tapviewall = ""
    override init(frame: CGRect) {
        super.init(frame: frame)
        commonInit()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        commonInit()
    }
    
    private func commonInit() {
        let bundle = Bundle(for: type(of: self))
        bundle.loadNibNamed("BannerView", owner: self, options: nil)
        addSubview(contentView)
        contentView.frame = bounds
        contentView.autoresizingMask = [.flexibleWidth, .flexibleHeight]
    //    contentView.backgroundColor = .red
        
    }
    
    
   
}

 
