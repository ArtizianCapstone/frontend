//
//  MeetingHistoryTableViewCell.swift
//  Frontend
//
//  Created by Vernon Chan on 5/16/19.
//  Copyright © 2019 Artizian. All rights reserved.
//

import UIKit

class MeetingHistoryTableViewCell: UITableViewCell {

    @IBOutlet weak var dateLabel: UILabel!
    @IBOutlet weak var itemCountLabel: UILabel!
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
