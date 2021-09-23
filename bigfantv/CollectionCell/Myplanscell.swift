//
//  Myplanscell.swift
//  bigfantv
//
//  Created by Ganesh on 12/11/20.
//  Copyright © 2020 Ganesh. All rights reserved.
//

import UIKit

class Myplanscell: UITableViewCell {

    @IBOutlet var Title: UILabel!
    
    @IBOutlet var LbDetails: UILabel!
    
    
    @IBOutlet var BtUpgrade: UIButton!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
