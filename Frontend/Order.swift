//
//  Order.swift
//  
//
//  Created by Rebecca Krieger on 2/7/19.
//

import Foundation
class Order{
    
    var orderDate: NSDate
    var orderDetails: String
    //enum
    var status: String
    var sd:NSDate
    var dd1:NSDate
    var dd2:NSDate
    init(whenOrdered: NSDate, orderNum: String, stat: String, shipDate: NSDate, whenDueEarly: NSDate,whenDueLate: NSDate){
        self.orderDate = whenOrdered
        self.orderDetails = orderNum
        self.status = stat
        self.sd = shipDate
        self.dd1 = whenDueEarly
        self.dd2 = whenDueLate
        
    }
}
