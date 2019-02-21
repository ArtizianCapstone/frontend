//
//  UpcomingPaymentsVC.swift
//  Frontend
//
//  Created by Rebecca Krieger on 2/21/19.
//  Copyright © 2019 Artizian. All rights reserved.
//

import UIKit

class UpcomingPaymentsVC: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    //change from string to artisan id number
    let PaymentsList = [Payment(artisan: "Diego Rameriz", whenNextSeeing: NSDate.init(), itemsBought: [
        Item(orderNum: "323 - 457 - 980", title: "table", quanity: 2, pricePer: 40),
        Item(orderNum: "423 - 957 - 980", title: "chair", quanity: 3, pricePer: 20),
        Item(orderNum: "423 - 957 - 980", title: "desk", quanity: 3, pricePer: 80),
        Item(orderNum: "573 - 487 - 980", title: "table", quanity: 5, pricePer: 40)], whenPaid: NSDate.init())]
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
