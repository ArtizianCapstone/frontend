//
//  CustomMeetingCell.swift
//  Frontend
//
//  Created by Jackson Kurtz on 2/10/19.
//  Copyright © 2019 Artizian. All rights reserved.
//

import UIKit

class CustomMeetingCell: UITableViewCell {
    @IBOutlet weak var artisanNameLabel: UILabel!
    @IBOutlet weak var meetingTimeLabel: UILabel!
    @IBOutlet weak var numItemsLabel: UILabel!
    
    @IBOutlet weak var checkButton: UIButton!
    var checked = false
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    @IBAction func checkMeeting(_ sender: Any) {
        if checked {
            checkButton.setTitle("\u{f0c8}", for: .normal)
            checked = false
        }
        else {
            checkButton.setTitle("\u{f14a}", for: .normal)
            checked = true
        }
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
