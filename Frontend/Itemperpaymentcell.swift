//
//  Itemperpaymentcell.swift
//  Frontend
//
//  Created by Rebecca Krieger on 3/10/19.
//  Copyright © 2019 Artizian. All rights reserved.
//

import UIKit

class Itemperpaymentcell: UITableViewCell {
    @IBOutlet weak var OrderID: UILabel!
    @IBOutlet weak var ItemName: UILabel!
    @IBOutlet weak var Quantity: UILabel!
    @IBOutlet weak var TotalMoneyPerItem: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
