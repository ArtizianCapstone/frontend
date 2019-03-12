//
//  PaymentSubview.swift
//  Frontend
//
//  Created by Vernon Chan on 3/1/19.
//  Copyright © 2019 Artizian. All rights reserved.
//

import UIKit

enum ConfirmationStatus {
    case next
    case confirmed
    case unconfirmed
}

struct Payment {
    var amount: Float
    var date: String
    var confirmationStatus: ConfirmationStatus
}

class PaymentSubview: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    @IBOutlet weak var paymentTableView: UITableView!
    
    var payments: [Payment] = []
    var nextPayments: [Payment] = []
    var unconfirmedPayments: [Payment] = []
    var confirmedPayments: [Payment] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        paymentTableView.dataSource = self
        paymentTableView.tableFooterView = UIView()
        paymentTableView.separatorStyle = UITableViewCell.SeparatorStyle.none

        
        //retrieve payments
        payments.append(Payment(amount: 100.0, date: "1/27/2019", confirmationStatus: ConfirmationStatus.next))
        payments.append(Payment(amount: 90.0, date: "1/20/2019", confirmationStatus: ConfirmationStatus.unconfirmed))
        payments.append(Payment(amount: 100.0, date: "1/13/2019", confirmationStatus: ConfirmationStatus.unconfirmed))
        payments.append(Payment(amount: 80.0, date: "1/6/2019", confirmationStatus: ConfirmationStatus.confirmed))
        
        //sort payments by confirmation status
        for payment in payments {
            switch payment.confirmationStatus {
            case .next:
                nextPayments.append(payment)
            case .unconfirmed:
                unconfirmedPayments.append(payment)
            case .confirmed:
                confirmedPayments.append(payment)
            }
        }
        paymentTableView.reloadData()
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 3
    }
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        switch section {
        case 0:
            return "next"
        case 1:
            return "unconfirmed"
        case 2:
            return "confirmed"
        default:
            return "default title"
        }
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        var nextCount = 0, confirmedCount = 0, unconfirmedCount = 0
        
        for payment in payments {
            switch payment.confirmationStatus {
            case .next:
                nextCount += 1
            case .unconfirmed:
                unconfirmedCount += 1
            case .confirmed:
                confirmedCount += 1
            }
        }
        
        switch section {
        case 0:
            return nextCount
        case 1:
            return unconfirmedCount
        case 2:
            return confirmedCount
        default:
            return 0
        } 
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = paymentTableView.dequeueReusableCell(withIdentifier: "PaymentTableViewCell", for: indexPath) as! PaymentTableViewCell
        
        var amountText: String = "$"
        var dateText: String = ""
        var backgroundColor: UIColor = Constants.Colors.gray
        
        switch indexPath.section {
        case 0:
            amountText = amountText + String(nextPayments[indexPath.row].amount) + " due "
            dateText = nextPayments[indexPath.row].date
            backgroundColor = Constants.Colors.green
        case 1:
            amountText = amountText + String(unconfirmedPayments[indexPath.row].amount) + " paid "
            backgroundColor = Constants.Colors.orange
            dateText = unconfirmedPayments[indexPath.row].date
        case 2:
            amountText = amountText + String(confirmedPayments[indexPath.row].amount) + " paid "
            dateText = confirmedPayments[indexPath.row].date
        default:
            break
        }
        
        cell.paymentLabel.text = amountText + dateText
        cell.roundedBoxBackground.backgroundColor = backgroundColor
        cell.roundedBoxBackground.layer.cornerRadius = Constants.RoundedButton.cornerRadius
        
        return cell
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
