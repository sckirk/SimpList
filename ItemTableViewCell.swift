//
//  ItemTableViewCell.swift
//  SimpList
//
//  Created by Suzannah Kirk-Daligcon on 1/11/17.
//  Copyright © 2017 SK. All rights reserved.
//

import UIKit

class ItemTableViewCell: UITableViewCell {
    
    //MARK: Properties
    @IBOutlet var itemNameLabel: UILabel!
    @IBOutlet var qtyImageView: UIImageView!
    
    

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
