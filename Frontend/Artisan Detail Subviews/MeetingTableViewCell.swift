//
//  MEetingTableViewCell.swift
//  
//
//  Created by Vernon Chan on 3/7/19.
//

import UIKit

class MeetingTableViewCell: UITableViewCell {

    @IBOutlet weak var title: UILabel!
    @IBOutlet weak var price: UILabel!
    @IBOutlet weak var stock: UILabel!
    @IBOutlet weak var meetingQuantity: UILabel!
    @IBOutlet weak var listingImage: UIImageView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
