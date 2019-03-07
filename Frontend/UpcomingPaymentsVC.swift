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

    @IBOutlet weak var weeklyTotal: UILabel!
    var tempTotal: Float = 0.0
    let calendar = Calendar.current
    static let formatter = DateFormatter()



    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
      //  weeklyTotal.text = NSString(format: "%.2f",tempTotal) as String
    }
    static func randomDateMaker() -> Date{
        formatter.dateFormat = "MM/dd/yyyy"
        let dateFormatter = DateFormatter()
        dateFormatter.isLenient = true
        let day = Int.random(in: 8 ... 30)
        let strday = String(format: "%02d", day)
        let month = Int.random(in: 3 ... 12)
        let strmonth = String(format: "%02d", month)
        let tempstring = strmonth + "/" + strday + "/2019"
        return dateFormatter.date(from:tempstring) ?? (NSDate.init() as Date);
    }
    

    
    @IBOutlet weak var upcomingPaymentsTable: UITableView!
    //change from string to artisan id number
    let PaymentsList: [Payment] = [Payment(artisan: "Diego Rameriz", whenNextSeeing:  UpcomingPaymentsVC.randomDateMaker(), itemsBought: [
        Item(orderNum: "323 - 457 - 980", title: "table", quanity: 2, pricePer: Float(40)),
        Item(orderNum: "423 - 957 - 980", title: "chair", quanity: 3, pricePer: Float(20)),
        Item(orderNum: "423 - 957 - 980", title: "desk", quanity: 3, pricePer: Float(80)),
        Item(orderNum: "573 - 487 - 980", title: "table", quanity: 5, pricePer: Float(40))], whenPaid: nil),
    Payment(artisan: "Tina Tilapia", whenNextSeeing:  UpcomingPaymentsVC.randomDateMaker(),itemsBought: [
            Item(orderNum: "323 - 457 - 980", title: "pot", quanity: 1, pricePer: Float(20)),
            Item(orderNum: "423 - 957 - 980", title: "vase", quanity: 2, pricePer: Float(30)),
            Item(orderNum: "423 - 957 - 980", title: "mug", quanity: 4, pricePer: Float(25)),
            Item(orderNum: "573 - 487 - 980", title: "bowl", quanity: 4, pricePer: Float(40))], whenPaid: nil),
        Payment(artisan: "Amilia Bedilia", whenNextSeeing:  UpcomingPaymentsVC.randomDateMaker(), itemsBought: [
            Item(orderNum: "323 - 457 - 980", title: "vase", quanity: 2, pricePer: Float(30)),
            Item(orderNum: "423 - 957 - 980", title: "curtains", quanity: 1, pricePer: Float(160))], whenPaid: nil),
        Payment(artisan: "Rufus DaDodge", whenNextSeeing:  UpcomingPaymentsVC.randomDateMaker(), itemsBought: [
            Item(orderNum: "323 - 457 - 980", title: "ball", quanity: 7, pricePer: Float(2)),
            Item(orderNum: "423 - 957 - 980", title: "frisbee", quanity: 4, pricePer: Float(5)),
            Item(orderNum: "423 - 957 - 980", title: "bowl", quanity: 2, pricePer: Float(10)),
            Item(orderNum: "573 - 487 - 980", title: "miniture suit", quanity: 1, pricePer: Float(80))], whenPaid: nil)
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
        var component = calendar.dateComponents([.day,.month,.year], from: Date())
        UpcomingPaymentsVC.formatter.dateFormat = "MM/dd/yyyy"
        let cell = tableView.dequeueReusableCell(withIdentifier: "customCurrentPaymentCell", for: indexPath) as? CurrentPaymentsCell
        // Configure the cell...
        cell?.DateMeeting.text = UpcomingPaymentsVC.formatter.string(from:
            PaymentsList[indexPath.row].expectedPayoutDate)
        cell?.ArtisanName.text = PaymentsList[indexPath.row].name
        cell?.AmountToPay.text = NSString(format: "%.2f",PaymentsList[indexPath.row].totalPayout) as String
        if calendar.compare(PaymentsList[indexPath.row].expectedPayoutDate, to: NSDate.init() as Date, toGranularity: .weekOfYear) == .orderedSame
        {
            tempTotal += PaymentsList[indexPath.row].totalPayout
            weeklyTotal.text = NSString(format: "%.2f",tempTotal) as String
        }
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
