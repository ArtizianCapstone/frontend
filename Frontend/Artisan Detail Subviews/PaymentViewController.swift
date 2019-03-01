//
//  PaymentViewController.swift
//  Frontend
//
//  Created by Vernon Chan on 2/24/19.
//  Copyright © 2019 Artizian. All rights reserved.
//

import UIKit

class PaymentViewController: UIViewController {

    @IBOutlet weak var nextTable: UITableView!
    
    @IBOutlet weak var unconfirmedTable: UITableView!
    
    @IBOutlet weak var confirmedTable: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        var cell: UITableViewCell?
        
        if tableView == self.nextTable {
            cell = tableView.dequeueReusableCell(withIdentifier: "nextCell", for: indexPath)
            
            
        } else if tableView == self.unconfirmedTable {
            cell = tableView.dequeueReusableCell(withIdentifier: "unconfirmedCell", for: indexPath)
            
            
        } else if tableView == self.confirmedTable {
            cell = tableView.dequeueReusableCell(withIdentifier: "confirmedCell", for: indexPath)
            
            
        }
        
        return cell!
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
