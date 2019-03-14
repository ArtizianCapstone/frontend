//
//  Payment.swift
//  Frontend
//
//  Created by Rebecca Krieger on 2/21/19.
//  Copyright © 2019 Artizian. All rights reserved.
//

import Foundation
//change from string to artisan id number
class Payment{
    var name: String
    var expectedPayoutDate: Date
    var itemsCompensatedFor: [Item]
    var datePaidOut:Date?
    var totalPayout: Float
    init(artisan: String, whenNextSeeing: Date, itemsBought: [Item], whenPaid: Date?){
        self.name = artisan
        self.expectedPayoutDate = whenNextSeeing
        self.itemsCompensatedFor = itemsBought
        self.datePaidOut = whenPaid
        self.totalPayout = 0;
        for boughtthing in itemsCompensatedFor {
            totalPayout += (boughtthing.totalOwed)
        }
    }
}
