//
//  ListingSubview.swift
//  Frontend
//
//  Created by Vernon Chan on 3/1/19.
//  Copyright © 2019 Artizian. All rights reserved.
//

import UIKit
import Alamofire

class ListingSubview: UIViewController, UITableViewDelegate, UITableViewDataSource {
    var meetingNames : [String] = []
    var meetingPrices : [Float] = []
    var meetingStock : [Int] = []
    var meetingQuantity : [String] = []
    
    var listings:[Listing] = []
    var artisan: Artisan? = nil
    
    @IBOutlet weak var myTableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        
        // Do any additional setup after loading the view.
        /*
        meetingNames.append( "Table Cloth")
        meetingNames.append( "Small Rug")
        meetingNames.append( "Small Blanket")
        
        meetingPrices.append( 40.0)
        meetingPrices.append( 50.0)
        meetingPrices.append( 30.0)
        
        meetingStock.append( 10)
        meetingStock.append( 15)
        meetingStock.append( 5)
        
        meetingQuantity.append( "makes 4 per meeting")
        meetingQuantity.append( "makes 3 per meeting")
        meetingQuantity.append( "makes 2 per meeting")*/
        myTableView.dataSource = self
        myTableView.delegate = self
        myTableView.tableFooterView = UIView()
    }
 
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 100
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return listings.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        print("cell for row at")
        let cell = tableView.dequeueReusableCell(withIdentifier: "MeetingTableViewCell", for: indexPath) as! MeetingTableViewCell
        let rowListing = listings[indexPath.row]
        cell.title.text = rowListing.name
        cell.price.text = "$" + "\(rowListing.price)"
        cell.stock.text = rowListing.description
        cell.meetingQuantity.text = "\(rowListing.quantity)"
        
        return cell
    }
    
    func getListings(artisanId: String, completion : @escaping () -> ()) {
        let url = "http://ec2-3-83-249-93.compute-1.amazonaws.com:3000/listings/5c00776e2f1dfe588f33138c/" + artisanId
        Alamofire.request(url).responseJSON { response in
            if let json = response.result.value {
                // serialized json response
                print("json from listings get request", json)
                
                // convert json data to meeting structure and add to array for tableview
                var retrievedListings:[Listing] = []
                
                if let jsonarray = json as? [[String: Any]] {
                    let dateFormatter = DateFormatter()
                    dateFormatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ss.SSS'Z'"
                    dateFormatter.locale = Locale(identifier: "en_US_POSIX")
                    
                    for x in jsonarray {
                        let dateString = x["creation_date"] as! String
                        let myDate = dateFormatter.date(from: dateString )!
                        let listing_quantity = x["quantity"] as? String ?? "0"
                        let listing_image = x["listingImage"] as? String ?? ""
                        //let artisanJSON = x["artisan"] as? [String: Any]
                        retrievedListings.append(Listing( name: x["name"] as! String, artisanId: artisanId, price: x["price"] as! Float, description: x["description"] as! String, creation_date: myDate, quantity: Int(listing_quantity)!, photo_url: listing_image))
                        //retrievedListings.append(Li( userId: "5c00776e2f1dfe588f33138c", artisanId: artisanId, date: myDate, numItemsExpected: x["itemsExpected"] as! Int))
                    }
                    self.listings = retrievedListings
                    print("listings count", self.listings.count)
                }
                //self.myTableView.reloadData()
                completion()
            }
        }
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
