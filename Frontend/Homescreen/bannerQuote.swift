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
    var cellImage:UIImage?
    init(message: String, textColor: UIColor, backgroundColor: UIColor){
        self.message = message
        self.textColor = textColor
        self.backgroundColor = backgroundColor
        self.cellImage = nil
    }
    init(message: String, cellImage: UIImage){
        self.message = message
        self.textColor = UIColor.white
        self.cellImage = cellImage
        self.backgroundColor = UIColor.white
    }
    init(message: String, textColor: UIColor, cellImage: UIImage){
        self.message = message
        self.textColor = textColor
        self.cellImage = cellImage
        self.backgroundColor = UIColor.white
    }
    init(message: String){
        self.message = message
        self.textColor = UIColor.black
        self.backgroundColor = UIColor.white
        self.cellImage = nil
    }
}
