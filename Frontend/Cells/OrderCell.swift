//
//  OrderCell.swift
//  Frontend
//
//  Created by Rebecca Krieger on 2/7/19.
//  Copyright © 2019 Artizian. All rights reserved.
//

import UIKit
import ExpandableCell

class OrderCell: ExpandableCell {
    override func awakeFromNib() {
        super.awakeFromNib()
    }
    
    @IBOutlet weak var OrderDate: UILabel!
    
    @IBOutlet weak var OrderDetails: UILabel!
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        
        // Configure the view for the selected state
    }
}
