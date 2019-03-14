//
//  ExpVCTestViewController.swift
//  Frontend
//
//  Created by Rebecca Krieger on 3/11/19.
//  Copyright © 2019 Artizian. All rights reserved.
//

import UIKit
import ExpandableCell
class ExpVCTestViewController: UIViewController {    
   
    @IBOutlet var tableView: ExpandableTableView!
    static let PaymentsList: [Payment] = [Payment(artisan: "Diego Rameriz", whenNextSeeing:  UpcomingPaymentsVC.randomDateMaker(), itemsBought: [
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
    let parentCells = [String](repeating: ExpandableCell2.ID, count: PaymentsList.count)
    
        //{(PaymentsList) -> [[String]] in
      //  return []
        
    //}
    
    //for payment in PaymentsList {}
        
      /*
        [
            [ExpandableCell2.ID,//
                ExpandableCell2.ID,//
                ExpandableSelectableCell2.ID,//
            ]
        ]*/
        
        var cell: UITableViewCell {
            return tableView.dequeueReusableCell(withIdentifier: ExpandedCell.ID)!
        }
        
        override func viewDidLoad() {
            super.viewDidLoad()
            
            tableView.expandableDelegate = self
            tableView.animation = .automatic
            
            tableView.register(UINib(nibName: "NormalCell", bundle: nil), forCellReuseIdentifier: NormalCell.ID)
            tableView.register(UINib(nibName: "ExpandedCell", bundle: nil), forCellReuseIdentifier: ExpandedCell.ID)
            tableView.register(UINib(nibName: "ExpandableCell", bundle: nil), forCellReuseIdentifier: ExpandableCell2.ID)
            tableView.register(UINib(nibName: "ExpandableSelectableCell", bundle: nil), forCellReuseIdentifier: ExpandableSelectableCell2.ID)
            tableView.register(UINib(nibName: "InitiallyExpandedExpandableCell", bundle: nil), forCellReuseIdentifier: ExpandableInitiallyExpanded.ID)
        }
        
        override func viewDidAppear(_ animated: Bool) {
            super.viewDidAppear(animated)
            
            //        tableView.openAll()
        }
        
        override func didReceiveMemoryWarning() {
            super.didReceiveMemoryWarning()
            // Dispose of any resources that can be recreated.
        }
    
        //scroll view methods are being forwarded correctly
        func scrollViewDidScroll(_ scrollView: UIScrollView) {
            print("scrollViewDidScroll")
        }
        
        func scrollViewDidEndDragging(_ scrollView: UIScrollView, willDecelerate decelerate: Bool) {
            print("scrollViewDidScroll, decelerate:\(decelerate)")
        }
        func scrollViewDidEndScrollingAnimation(_ scrollView: UIScrollView) {
            print("scrollViewDidEndScrollingAnimation")
        }
    }
    
extension ExpVCTestViewController: ExpandableDelegate {
    func expandableTableView(_ expandableTableView: ExpandableTableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = expandableTableView.dequeueReusableCell(withIdentifier: parentCells[indexPath.row]) else { return UITableViewCell() }
      /*  if cell is ExpandableCell2
        {
            cell.DateShown.text = UpcomingPaymentsVC.formatter.string(from:
                PaymentsList[indexPath.row].expectedPayoutDate)
            cell.MoneyOwed.text = NSString(format: "%.2f",PaymentsList[indexPath.row].totalPayout) as String
            cell.ArtisanName.text = PaymentsList[indexPath.row].name
        }*/
        return cell
    }

    
        
        func expandableTableView(_ expandableTableView: ExpandableTableView, expandedCellsForRowAt indexPath: IndexPath) -> [UITableViewCell]? {
            var interiorList: [ExpandedCell] = []
            for itemIncluded in ExpVCTestViewController.PaymentsList[indexPath.row].itemsCompensatedFor {
                let cell = tableView.dequeueReusableCell(withIdentifier: ExpandedCell.ID) as! ExpandedCell
                interiorList.append(cell)
                cell.OrderID.text = itemIncluded.orderID
                cell.ItemName.text = itemIncluded.listingTitle
                cell.Quanity.text = String(itemIncluded.numOrdered)
                cell.MoneyMade.text = String(itemIncluded.totalOwed)
            }
            return interiorList
        }
        
        func expandableTableView(_ expandableTableView: ExpandableTableView, heightsForExpandedRowAt indexPath: IndexPath) -> [CGFloat]? {
            var heightArray: [CGFloat] = []
            for itemIncluded in ExpVCTestViewController.PaymentsList[indexPath.row].itemsCompensatedFor{
                heightArray.append(33)
            }
            return heightArray
            
        }
        
        func numberOfSections(in tableView: ExpandableTableView) -> Int {
            return 1
        }
        
        func expandableTableView(_ expandableTableView: ExpandableTableView, numberOfRowsInSection section: Int) -> Int {
            return parentCells.count
        }
        
        func expandableTableView(_ expandableTableView: ExpandableTableView, didSelectRowAt indexPath: IndexPath) {
            print("didSelectRow:\(indexPath)")
        }
        
        func expandableTableView(_ expandableTableView: ExpandableTableView, didSelectExpandedRowAt indexPath: IndexPath) {
                    print("didSelectExpandedRowAt:\(indexPath)")
        }
        
        func expandableTableView(_ expandableTableView: ExpandableTableView, expandedCell: UITableViewCell, didSelectExpandedRowAt indexPath: IndexPath) {
            if let cell = expandedCell as? ExpandedCell {
                print("\(cell.OrderID.text ?? "")")
            }
        }

        func expandableTableView(_ expandableTableView: ExpandableTableView, heightForHeaderInSection section: Int) -> CGFloat {
            return 20
        }
        
        /*func expandableTableView(_ expandableTableView: ExpandableTableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
           /* guard let cell = expandableTableView.dequeueReusableCell(withIdentifier: ExpandableCell2.ID) else { return UITableViewCell() }*/
            let cell = tableView.dequeueReusableCell(withIdentifier: ExpandableCell.ID) as! ExpandedCell2
            cell.DateShown.text = UpcomingPaymentsVC.formatter.string(from:
            PaymentsList[indexPath.row].expectedPayoutDate)
                cell.MoneyOwed.text = NSString(format: "%.2f",PaymentsList[indexPath.row].totalPayout) as String
                cell.ArtisanName.text = PaymentsList[indexPath.row].name
            return cell
        }*/
        
        func expandableTableView(_ expandableTableView: ExpandableTableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
            return 45
        }
        
        @objc(expandableTableView:didCloseRowAt:) func expandableTableView(_ expandableTableView: UITableView, didCloseRowAt indexPath: IndexPath) {
            let cell = expandableTableView.cellForRow(at: indexPath)
            cell?.contentView.backgroundColor = #colorLiteral(red: 0.1764705926, green: 0.01176470611, blue: 0.5607843399, alpha: 1)
            cell?.backgroundColor = #colorLiteral(red: 0.1764705926, green: 0.01176470611, blue: 0.5607843399, alpha: 1)
        }
        
        func expandableTableView(_ expandableTableView: UITableView, shouldHighlightRowAt indexPath: IndexPath) -> Bool {
            return true
        }
        
        func expandableTableView(_ expandableTableView: UITableView, didUnhighlightRowAt indexPath: IndexPath) {
            //        let cell = expandableTableView.cellForRow(at: indexPath)
            //        cell?.contentView.backgroundColor = #colorLiteral(red: 0.9529411793, green: 0.6862745285, blue: 0.1333333403, alpha: 1)
            //        cell?.backgroundColor = #colorLiteral(red: 0.9529411793, green: 0.6862745285, blue: 0.1333333403, alpha: 1)
        }
        
        //    func expandableTableView(_ expandableTableView: ExpandableTableView, titleForHeaderInSection section: Int) -> String? {
        //        return "Section \(section)"
        //    }
        //
        //    func expandableTableView(_ expandableTableView: ExpandableTableView, heightForHeaderInSection section: Int) -> CGFloat {
        //        return 33
        //    }
    }
    
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */


