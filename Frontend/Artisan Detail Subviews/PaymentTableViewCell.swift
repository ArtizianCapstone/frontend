//
//  PaymentTableViewCell.swift
//  Frontend
//
//  Created by Vernon Chan on 3/11/19.
//  Copyright © 2019 Artizian. All rights reserved.
//

import UIKit

class PaymentTableViewCell: UITableViewCell {
    
    @IBOutlet weak var paymentLabel: UILabel!
    @IBOutlet weak var roundedBoxBackground: UIButton!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
