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
    var selectedListing = Listing()
  
    
    @IBOutlet weak var addListingsButton: UIButton!
    @IBOutlet weak var funFact: UITextView!
    @IBOutlet weak var ListingsLabel: UILabel!
    @IBOutlet weak var factDetails: UITextView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.tableView.delegate = self
        self.tableView.dataSource = self
        
        self.ListingsLabel.sizeToFit()
        funFact.text! = "\nTip:"
        factDetails.text! = "\nListings with photos sell 20% more frequently"
        funFact.layer.cornerRadius = 5.0
       
        // Do any additional setup after loading the view.
    }
    
    override func viewDidAppear(_ animated: Bool) {
        loadListings {
            self.retrieveListingImages()
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

    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        print("row: \(indexPath.row)")
        print(listings[indexPath.row].toStrDict())
        //let vc = DetailedListingViewController(nibName: "DetailedListingViewController", bundle: nil)
        //print("Here")
        //vc.loaded_listing = listings[indexPath.row]
        setSelectedListing(listing: listings[indexPath.row]) {}
        performSegue(withIdentifier: "detailedListingSegue", sender: addListingsButton)
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

    @IBAction func addListings(_ sender: Any) {
        performSegue(withIdentifier: "AddListingsSegue", sender: addListingsButton)

    }
        
    private func loadListings(completion : @escaping () -> ()) {
        //clear listings array
        listings = []
        let defaultImage = UIImage(named: "default.jpg")
    
        Alamofire.request("http://ec2-3-83-249-93.compute-1.amazonaws.com:3000/listings/byuser/" + Constants.userID).responseJSON { response in
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
                        newListing.description = x["description"] as? String ?? ""
                        newListing.photo = defaultImage
                        
                        if let photo_url = x["listingImage"] as? String {
                            newListing.photo_url = photo_url
                        }
                        if( !self.listings.contains(where: { $0._id == newListing._id }) ) {
                            self.listings.append(newListing)
                        }
                    }
                }
            }
            completion()
        }
    }
    
    func retrieveListingImages() {
        for (i, listing) in listings.enumerated() {
            print("getting listing # " + "\(i)")
            getImage( listing: listing ){
                print("retrieved listing image #" + "\(i)")
            }
        }
    }
    
    private func getImage( listing: Listing, completion : @escaping () -> ()) {
        var url = "http://www.rangerwoodperiyar.com/images/joomlart/demo/default.jpg"
        if let photo_url = listing.photo_url {
            url = Constants.Database.serverUrl + photo_url
            print("retrieving image with photo url: " + url)
        }
        Alamofire.request(URL(string: url)!, method: .get).responseImage { response in
            guard response.result.value != nil else {
                print("error getting image, returning...")
                return
            }
            print("updating listing image...")
            listing.photo = response.result.value
            self.tableView.reloadData()
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
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?)
    {
        if let vc = segue.destination as? DetailedListingViewController
        {
            vc.loaded_listing = self.selectedListing
        }
    }
    
    private func setSelectedListing(listing: Listing, completion : @escaping () -> ()) {
        self.selectedListing = listing
        completion()
    }
    
}
