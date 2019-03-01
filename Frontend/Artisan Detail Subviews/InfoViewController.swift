//
//  InfoViewController.swift
//  Frontend
//
//  Created by Vernon Chan on 2/20/19.
//  Copyright © 2019 Artizian. All rights reserved.
//

import UIKit

class InfoViewController: UIViewController {
    @IBOutlet weak var phoneNumber: UILabel!
    @IBOutlet weak var biography: UITextView!
    
    var artisan: Artisan? = nil
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        phoneNumber.text = artisan?.phone_number
        biography.text = artisan?.bio
        
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
