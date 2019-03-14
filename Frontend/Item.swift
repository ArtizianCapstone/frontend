//
//  Item.swift
//  Frontend
//
//  Created by Rebecca Krieger on 2/21/19.
//  Copyright © 2019 Artizian. All rights reserved.
//

import Foundation
class Item{
    var orderID: String
    var listingTitle: String
    //enum
    var numOrdered: Int
    var totalOwed:Float
    var price: Float;
    init(orderNum: String, title: String, quanity: Int, pricePer: Float){
        self.orderID = orderNum
        self.listingTitle = title
        self.numOrdered = quanity
        self.price = pricePer
        self.totalOwed = Float(quanity) * pricePer
    }
}

