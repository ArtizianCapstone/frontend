//
//  bannerQuote.swift
//  Frontend
//
//  Created by Rebecca Krieger on 12/4/18.
//  Copyright © 2018 Artizian. All rights reserved.
//

import Foundation
import UIKit
class bannerQuote {
    var message: String
    var textColor: UIColor
    var backgroundColor: UIColor
    init(message: String, textColor: UIColor, backgroundColor: UIColor){
        self.message = message
        self.textColor = textColor
        self.backgroundColor = backgroundColor
    }
    init(message: String){
        self.message = message
        self.textColor = UIColor.white
        self.backgroundColor = UIColor.green
    }
}
