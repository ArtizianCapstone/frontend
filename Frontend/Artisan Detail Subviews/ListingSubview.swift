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
    
    var artisan: Artisan? = nil
    
    @IBOutlet weak var myTableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        loadArtisanMeetings {
            
        }
        
        // Do any additional setup after loading the view.
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
        meetingQuantity.append( "makes 2 per meeting")
        myTableView.dataSource = self
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 100
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 3
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "MeetingTableViewCell", for: indexPath) as! MeetingTableViewCell
        cell.title.text = meetingNames[indexPath.row]
        cell.price.text = meetingPrices[indexPath.row].description
        cell.stock.text = meetingStock[indexPath.row].description
        cell.meetingQuantity.text = meetingQuantity[indexPath.row]
        
        return cell
    }
    
    private func loadArtisanMeetings(completion : @escaping () -> ()) {
        
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
