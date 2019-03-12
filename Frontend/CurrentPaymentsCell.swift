//
//  CurrentPaymentsCell.swift
//  
//
//  Created by Rebecca Krieger on 2/20/19.
//

import UIKit
import ExpandableCell

private let reuseIdentifier = "customItemPerPaymentCell"
class CurrentPaymentsCell: ExpandableCell, UITableViewDelegate {

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        if (!hasUpdated){
            print("updating items array")
            self.ItemsTable.reloadData()
            print("in CPC")
            print(ItemsArray)
            hasUpdated = true
            print(String(describing: self.superview))
        }
    }
    @IBOutlet weak var DateShown: UILabel!
    @IBOutlet weak var ArtisanName: UILabel!
    @IBOutlet weak var AmountToPay: UILabel!
    @IBOutlet weak var ItemsTable: PaymentItemsTable!
    var ItemsArray: [Item] = []
    var hasUpdated:Bool = false
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return ItemsArray.count
    }
    private func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        UpcomingPaymentsVC.formatter.dateFormat = "MM/dd/yyyy"
        let cell = tableView.dequeueReusableCell(withIdentifier: "customItemPerPaymentCell", for: indexPath) as? Itemperpaymentcell
      //  cell?.DateShown.text = ItemsArray[indexPath.row].________-
        
        return cell!
    }


}
