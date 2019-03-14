//
//  PaymentItemsTable.swift
//  Frontend
//
//  Created by Rebecca Krieger on 3/10/19.
//  Copyright © 2019 Artizian. All rights reserved.
//

import UIKit

class PaymentItemsTable: UITableView {

    /*
    // Only override draw() if you perform custom drawing.
    // An empty implementation adversely affects performance during animation.
    override func draw(_ rect: CGRect) {
        // Drawing code
    }
    */
    var tableViewHeight: CGFloat {
        layoutIfNeeded()
        
        return contentSize.height
    }

}
