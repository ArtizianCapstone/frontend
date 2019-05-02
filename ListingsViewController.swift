//
//  ListingsViewController.swift
//  Frontend
//
//  Created by Zane Ali on 2/14/19.
//  Copyright © 2019 Artizian. All rights reserved.
//

import UIKit
import Alamofire
import AlamofireImage


class ListingsViewController: UIViewController,UITableViewDelegate, UITableViewDataSource {
    var listings = [Listing]()
    
    
    
    @IBOutlet weak var addListingsButton: UIButton!
    @IBOutlet weak var funFact: UITextView!
    
    
    @IBOutlet weak var factDetails: UITextView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.tableView.delegate = self
        self.tableView.dataSource = self
        loadListings {
            self.tableView.reloadData()
        }
       
        funFact.text! = "\nTip:"
        factDetails.text! = "\nListings with photos sell 20% more frequently"
        funFact.layer.cornerRadius = 5.0
       
        // Do any additional setup after loading the view.
    }
    
    override func viewDidAppear(_ animated: Bool) {
        loadListings {
            self.tableView.reloadData()
        }
    }
    
    @IBOutlet weak var tableView: UITableView!
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        print (self.listings.count)
        return listings.count
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
        cell.sellerName.text = listing.artisanName
        cell.priceValue.text? = "$" + listing.price.description
        cell.stockValue.text? = listing.quantity.description + ""
        cell.sellerImage.image = listing.photo
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
    @IBAction func addListings(_ sender: Any) {
        performSegue(withIdentifier: "AddListingsSegue", sender: addListingsButton)

    }
    private func loadListings(completion : @escaping () -> ()) {
        
        let defaultImage = UIImage(named: "default.jpg")
    
        Alamofire.request("http://ec2-3-83-249-93.compute-1.amazonaws.com:3000/listings").responseJSON { response in
            
        
            if let json = response.result.value {
            // serialized json response
                if let jsonarray = json as? [[String: Any]] {
                   
                    for x in jsonarray {
                        print(x)
                        print ("\n------\n")
                        let artisan = x["artisan"] as? [String: Any]
                        
                        let newListing = Listing()
                        newListing.name = x["name"] as? String ?? "No Product Name"
                        newListing.artisanName = artisan?["name"] as? String ?? "No Artisan Name"
                        newListing.price = x["price"] as? Float ?? 0.0
                        newListing._id = x["_id"] as? String ?? "No product id"

                        newListing.photo = defaultImage
                        if let imageDB = x["listingImage"] as? String{
                            let imagerequest = URL(string: ("http://ec2-3-83-249-93.compute-1.amazonaws.com:3000/" + imageDB))
                            print(imagerequest)
                            self.getImage(url: imagerequest, listing: newListing){
                                }
                        }
                        self.listings.append(newListing)
                    
                       /*self.listings.append(Listing(name: (x["name"] as? String ?? "No Name"), artisan: (x["artisan"] as? String) ?? "No artisan" , price: (x["price"] as? Float) ?? 0.0, quantity : 0, photo: defaultImage!))*/
                    
                    
             
                        // access all key / value pairs in dictionary
                    }
                }
              
            }
            completion()

        }
    }
    private func getImage(url: URL?, listing: Listing, completion : @escaping () -> ()) {
        let defaultImage = UIImage(named: "defaultPhoto.png")
        print ("HERERERERERE")
        Alamofire.request(url ?? URL(string: "http://www.rangerwoodperiyar.com/images/joomlart/demo/default.jpg")!, method: .get).responseImage { response in
            guard response.result.value != nil else {
                // Handle error
                return
            }
            listing.photo = response.result.value
        }
        completion()
    }
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if (editingStyle == .delete) {
            let listingToDelete = listings[indexPath.row]
            let url = Constants.Database.serverUrl + "listings/" + listingToDelete._id
            
            self.listings.remove(at: indexPath.row)
            tableView.deleteRows(at: [indexPath], with: .fade)
            
            Alamofire.request(url, method: .delete)
                .responseJSON { response in
                    if let json = response.result.value{
                        print ("deleted listing return json: ", json)
                    }
            }
        }
    }
    
}
