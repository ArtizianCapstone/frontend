//
//  InfoSubview.swift
//  Frontend
//
//  Created by Vernon Chan on 3/1/19.
//  Copyright © 2019 Artizian. All rights reserved.
//

import UIKit

class InfoSubview: UIViewController {

    var artisan: Artisan? = nil
    
    @IBOutlet weak var testLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        testLabel.text = artisan?.name
        // Do any additional setup after loading the view.
    }
    
    func hide() {
        self.view.isHidden = true
    }
    
    func unhide() {
        self.view.isHidden = false
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
