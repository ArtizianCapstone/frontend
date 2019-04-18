//
//  User.swift
//  Frontend
//
//  Created by Vernon Chan on 12/3/18.
//  Copyright © 2018 Artizian. All rights reserved.
//

import UIKit


struct User : Codable {
    var name: String!
    var password : String!
    var _id: String!
    var phone_number: String!
    var artisans: [Artisan]!
    
    init(name: String, password: String, phone_number: String) {
        self.name = name
        self.password = password
        self.phone_number = phone_number
    }
    init() {
    }
    
    func toJSON() -> Dictionary<String, AnyObject> {
        return [
            "name": self.name as AnyObject,
            "password": self.password as AnyObject,
            "phone_number": self.phone_number as AnyObject
        ]
    }
}

//temporary data structure which models the {{url}}/users JSON response
struct GetAllUsers : Codable {
    let count: Int
    let artisans: [Artisan]
}


struct GetOneUser : Codable {
    let user: User
    
}
