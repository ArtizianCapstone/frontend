//
//  Colors.swift
//  Frontend
//
//  Created by Vernon Chan on 3/8/19.
//  Copyright © 2019 Artizian. All rights reserved.
//

import UIKit


struct Constants {
    
    // these are the colors we should use for our table view cell background colors.
    struct Colors {
        static let gray = UIColor(red: 239/255, green: 239/255, blue: 244/255, alpha: 1.0)
        static let red = UIColor(red: 255/255, green: 230/255, blue: 224/255, alpha: 1.0)
        static let orange = UIColor(red: 255/255, green: 245/255, blue: 224/255, alpha: 1.0)
        static let green = UIColor(red: 240/255, green: 255/255, blue: 224/255, alpha: 1.0)
        static let blue = UIColor(red: 238/255, green: 255/255, blue: 254/255, alpha: 1.0)
    }
    
    // we can reference the base URLs with Database.serverUrl or Database.localUrl
    // instead of hardcoding the strings everywhere in the app.
    struct Database {
        static let serverUrl = "http://ec2-3-83-249-93.compute-1.amazonaws.com:3000/"
        static let localUrl = "http://localhost:3000/"
    }
}

