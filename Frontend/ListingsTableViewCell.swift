//
//  ListingsTableViewCell.swift
//  Frontend
//
//  Created by Zane Ali on 2/6/19.
//  Copyright © 2019 Artizian. All rights reserved.
//

import UIKit

class ListingsTableViewCell: UITableViewCell {
    //MARK: Properties
    
    @IBOutlet weak var sellerName: UILabel!
    @IBOutlet weak var itemName: UILabel!
    @IBOutlet weak var priceValue: UILabel!
    @IBOutlet weak var stockValue: UILabel!
    @IBOutlet weak var sellerImage: UIImageView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
