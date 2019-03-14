//
//  ExpandableCells.swift
//  Frontend
//
//  Created by Rebecca Krieger on 3/11/19.
//  Copyright © 2019 Artizian. All rights reserved.
//

import Foundation
//
//  ExpandableCells.swift
//  ExpandableCell
//
//  Created by Seungyoun Yi on 2017. 8. 7..
//  Copyright © 2017년 SeungyounYi. All rights reserved.
//

import UIKit
import ExpandableCell


class NormalCell: UITableViewCell {
    static let ID = "NormalCell"
}

class ExpandableCell2: ExpandableCell {
    static let ID = "ExpandableCell"
    
    @IBOutlet weak var DateShown: UILabel!
    @IBOutlet weak var MoneyOwed: UILabel!
    @IBOutlet weak var ArtisanName: UILabel!
}
class ExpandableSelectableCell2: ExpandableCell {
    static let ID = "ExpandableSelectableCell2"
    
    override func isSelectable() -> Bool {
        return true
    }
}

class ExpandableInitiallyExpanded: ExpandableCell {
    static let ID = "InitiallyExpandedExpandableCell"
    
    override func isSelectable() -> Bool {
        return true
    }
    
    override func isInitiallyExpanded() -> Bool {
        return true
    }
}

class ExpandedCell: UITableViewCell {
    static let ID = "ExpandedCell"
    
    @IBOutlet weak var OrderID: UILabel!
    @IBOutlet weak var ItemName: UILabel!
    @IBOutlet weak var Quanity: UILabel!
    @IBOutlet weak var MoneyMade: UILabel!
}

