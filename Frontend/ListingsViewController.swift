//
//  ListingsViewController.swift
//  Frontend
//
//  Created by Zane Ali on 2/14/19.
//  Copyright © 2019 Artizian. All rights reserved.
//

import UIKit
import Alamofire

class ListingsViewController: UIViewController,UITableViewDelegate, UITableViewDataSource {
    var listings = [Listing]()
    
    @IBOutlet weak var funFact: UITextView!
    
    
    @IBOutlet weak var factDetails: UITextView!
    override func viewDidLoad() {
        super.viewDidLoad()
        self.tableView.delegate = self
        self.tableView.dataSource = self
        funFact.text! = "\nTip:"
        factDetails.text! = "\nListings with photos sell 20% more frequently"
        funFact.layer.cornerRadius = 5.0
       
        
        loadListings()
        // Do any additional setup after loading the view.
    }
    
    @IBOutlet weak var tableView: UITableView!
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return listings.count // your number of cell here
    }
    
    func tableView(tableView: UITableView, numberOfSections: Int) -> Int {
        return 1
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cellIdentifier = "ListingsTableViewCell"
        
        guard let cell = tableView.dequeueReusableCell(withIdentifier: cellIdentifier, for: indexPath as IndexPath) as? ListingsTableViewCell else {
            fatalError("The dequeued cell is not an instance of ListingsTableViewCell.")
        }
        
        let listing = listings[indexPath.row]
        cell.itemName.text = listing.name
        cell.imageView?.image = listing.photo
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
    
    Alamofire.request("http://localhost:3000/listings").responseJSON { response in
        print("Request: \(String(describing: response.request))")   // original url request
        print("Response: \(String(describing: response.response))") // http url response
        print("Result: \(response.result)")                         // response serialization result
        
        if let json = response.result.value {
            print("JSON: \(json)") // serialized json response
        }
    }
    
    let defaultImage = UIImage(named: "defaultPhoto.png")
    
    let photo1 = UIImage(named: "shoes1.jpg")
    let photo2 = UIImage(named: "pants.jpg")
    let photo3 = UIImage(named: "rugs.jpeg")
    
    
    let listing1 = Listing(name: "Shoes", artisan: "Tom Savage", price: 42.51, quantity : 2, photo: photo1!)
    
    let listing2 = Listing(name: "Pants", artisan: "Jim Morrisey", price: 30.00, quantity : 2, photo: photo2 ?? defaultImage!)
    
    let listing3 = Listing(name: "Rugs", artisan: "Sally Susanna", price: 5000, quantity : 2, photo: photo3 ?? defaultImage!)
    
    listings += [listing1,listing2,listing3]
    
    }

}
