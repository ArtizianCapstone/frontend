//
//  OrdersViewController.swift
//  Frontend
//
//  Created by Zane Ali on 1/24/19.
//  Copyright © 2019 Artizian. All rights reserved.
//

import UIKit

class OrdersViewController: UIViewController {
    @IBOutlet weak var addListingsButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    @IBAction func addListingsAction(_ sender: Any) {
        performSegue(withIdentifier: "AddListingSegue", sender: addListingsButton)
        
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
