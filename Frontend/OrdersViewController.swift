//
//  OrdersViewController.swift
//  Frontend
//
//  Created by Zane Ali on 1/24/19.
//  Copyright © 2019 Artizian. All rights reserved.
//

import UIKit

private let reuseIdentifier = "customPaymentCell"

class OrdersViewController: UIViewController, UITableViewDataSource, UITableViewDelegate{

    @IBOutlet weak var tableView: UITableView!
    override func viewDidLoad() {
        super.viewDidLoad()
        // Uncomment the following line to preserve selection between
    }
    
    let ordersList = [Order(whenOrdered: NSDate.init(), orderNum: "123 - 456 - 780", stat: "incomplete", shipDate: NSDate.init(), whenDueEarly: NSDate.init(), whenDueLate: NSDate.init()),
        Order(whenOrdered: NSDate.init(), orderNum: "323 - 457 - 980", stat: "incomplete", shipDate: NSDate.init(), whenDueEarly: NSDate.init(), whenDueLate: NSDate.init())]
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return ordersList.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "customOrderCell", for: indexPath) as? OrderCell
        // Configure the cell...
       // cell?.present.text = (ordersList[indexPath.row].on ? "Here" : "Absent")
     //   cell?.name.text = ordersList[indexPath.row].name
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
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {

        // Get the new view controller using [segue destinationViewController].
        // Pass the select ded object to the new view controller.
    }
    */


}
