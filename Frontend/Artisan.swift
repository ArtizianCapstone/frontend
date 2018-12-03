//
//  Artisan.swift
//  Frontend
//
//  Created by Vernon Chan on 12/2/18.
//  Copyright © 2018 Artizian. All rights reserved.
//

import UIKit

//temporary data structure which models the {{url}}/users JSON response
struct UserResponse : Codable {
    let count: Int
    let artisans: [Artisan]
}

struct Artisan : Codable {
    
    //MARK: Properties
    
    var name: String
    var phone_number: String
    /*
    //MARK: Initialization
    init(name: String, phone_number: String) {
        self.name = name
        self.phone_number = phone_number
    }
 */
}
