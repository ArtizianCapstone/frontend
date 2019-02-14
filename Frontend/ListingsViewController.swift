//
//  ListingsViewController.swift
//  Frontend
//
//  Created by Zane Ali on 2/14/19.
//  Copyright © 2019 Artizian. All rights reserved.
//

import UIKit

class ListingsViewController: UIViewController {
    var listings = [Listing]()
    
    let photo1 = UIImage(named: "defaultImage.png")
    let photo2 = UIImage(named: "defaultImage.png")
    let photo3 = UIImage(named: "defaultImage.png")
    
  
    @IBOutlet weak var tableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        loadListings()
        // Do any additional setup after loading the view.
    }
   
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1 // your number of cell here
    }

    func tableView(tableView: UITableView, numberOfSections: Int) -> Int {
        return 1
    }
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        // your cell coding
        let cellIdentifier = "ListingsTableViewCell"
        
        guard let cell = tableView.dequeueReusableCell(withIdentifier: cellIdentifier, for: indexPath as IndexPath) as? ListingsTableViewCell else {
            fatalError("The dequeued cell is not an instance of ListingsTableViewCell.")
        }
        
        let listing = listings[indexPath.row]
        cell.itemName.text = listing.name
        cell.imageView?.image = photo1
        cell.sellerName.text = listing.artisan
        cell.priceValue.text? = "$" + listing.price.description
        cell.stockValue.text? = listing.quantity.description + ""
        
        // Configure the cell...
        
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
private func loadListings() {
    
    
    
    let listing1 = Listing(name: "Shoes", artisan: "Tom", price: 5.42, quantity : 2)
    //  else{
    //     fatalError("Unable to instantiate listing1")
    // }
    let listing2 = Listing(name: "Pants", artisan: "Jim", price: 5.42, quantity : 2)
    
    let listing3 = Listing(name: "Rugs", artisan: "Sally", price: 5.42, quantity : 2)
    
    listings += [listing1,listing2,listing3]
    
    }

}
