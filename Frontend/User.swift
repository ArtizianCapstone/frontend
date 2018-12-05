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
    var _id: String!
    var phone_number: String!
    var artisans: [Artisan]!
    
}

//temporary data structure which models the {{url}}/users JSON response
struct GetAllUsers : Codable {
    let count: Int
    let artisans: [Artisan]
}


struct GetOneUser : Codable {
    let user: User
    
}
