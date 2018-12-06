//
//  ArtisanDetailViewController.swift
//  Frontend
//
//  Created by Vernon Chan on 12/4/18.
//  Copyright © 2018 Artizian. All rights reserved.
//

import UIKit

class ArtisanDetailViewController: UIViewController {
    var name: String = ""
    var bio: String = ""
    var number: String = ""
    
    @IBOutlet weak var cellNumber: UILabel!
    @IBOutlet weak var bioField: UITextView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = name
        cellNumber.text = number
        bioField.text = bio
        
        print(name)
        print(bio)
        print(number)
        // Do any additional setup after loading the view.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
