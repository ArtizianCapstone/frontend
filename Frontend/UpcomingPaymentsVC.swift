//
//  UpcomingPaymentsVC.swift
//  Frontend
//
//  Created by Rebecca Krieger on 2/21/19.
//  Copyright © 2019 Artizian. All rights reserved.
//

import UIKit
private let reuseIdentifier = "customCurrentPaymentCell"

class UpcomingPaymentsVC: UIViewController, UITableViewDataSource, UITableViewDelegate {

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    @IBOutlet weak var upcomingPaymentsTable: UITableView!
    //change from string to artisan id number
    let PaymentsList = [Payment(artisan: "Diego Rameriz", whenNextSeeing: NSDate.init(), itemsBought: [
        Item(orderNum: "323 - 457 - 980", title: "table", quanity: 2, pricePer: 40),
        Item(orderNum: "423 - 957 - 980", title: "chair", quanity: 3, pricePer: 20),
        Item(orderNum: "423 - 957 - 980", title: "desk", quanity: 3, pricePer: 80),
        Item(orderNum: "573 - 487 - 980", title: "table", quanity: 5, pricePer: 40)], whenPaid: NSDate.init()),
    Payment(artisan: "Tina Tilapia", whenNextSeeing: NSDate.init(), itemsBought: [
            Item(orderNum: "323 - 457 - 980", title: "pot", quanity: 1, pricePer: 20),
            Item(orderNum: "423 - 957 - 980", title: "vase", quanity: 2, pricePer: 30),
            Item(orderNum: "423 - 957 - 980", title: "mug", quanity: 4, pricePer: 25),
            Item(orderNum: "573 - 487 - 980", title: "bowl", quanity: 4, pricePer: 40)], whenPaid: NSDate.init())
        ]
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return PaymentsList.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let formatter = DateFormatter()
        formatter.dateFormat = "MM/dd/yyyy"
        let cell = tableView.dequeueReusableCell(withIdentifier: "customCurrentPaymentCell", for: indexPath) as? CurrentPaymentsCell
        // Configure the cell...
        cell?.DateMeeting.text = formatter.string(from:
            PaymentsList[indexPath.row].expectedPayoutDate as Date)
        cell?.ArtisanName.text = PaymentsList[indexPath.row].name
        cell?.AmountToPay.text = NSString(format: "%.2f",PaymentsList[indexPath.row].totalPayout) as String
        return cell!
    }
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
        
        /* if segue.identifier == "toDetail" {
         let destVC = segue.destination as? BuyShippingViewController
         let selectedIndexPath = tableView.indexPathForSelectedRow
         destVC?.dataFromTable = ordersList[(selectedIndexPath?.row)!]
         }*/
        
    }

}
