//
//  PaddingTextView.swift
//  Outquiz
//
//  Created by Vasily Evreinov on 15/03/2019.
//  Copyright © 2019 Vasily Evreinov. All rights reserved.
//

import UIKit

class PaddingTextView: UITextView {
    
    let padding = UIEdgeInsets(top: 8, left: 8, bottom: 8, right: 8);
    
    override func layoutSubviews() {
        super.layoutSubviews()
        setup()
    }
    func setup() {
        textContainerInset = padding
    }
    
}
