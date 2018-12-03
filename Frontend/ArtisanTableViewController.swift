//
//  ArtisanTableViewController.swift
//  Frontend
//
//  Created by Vernon Chan on 12/2/18.
//  Copyright © 2018 Artizian. All rights reserved.
//

import UIKit

class ArtisanTableViewController: UITableViewController {

    //MARK: Properties
    var artisans = [Artisan]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        loadSampleArtisans()

        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem
    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return artisans.count
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cellIdentifier = "ArtisanTableViewCell"
        
        guard let cell = tableView.dequeueReusableCell(withIdentifier: cellIdentifier, for: indexPath) as? ArtisanTableViewCell else {
            fatalError("The dequeued cell is not an instance of ArtisanTableViewCell.")
        }

        let artisan = artisans[indexPath.row]
        
        cell.nameLabel.text = artisan.name
        // Configure the cell...

        return cell
    }
    

    /*
    // Override to support conditional editing of the table view.
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return true
    }
    */

    /*
    // Override to support editing the table view.
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            // Delete the row from the data source
            tableView.deleteRows(at: [indexPath], with: .fade)
        } else if editingStyle == .insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
        }    
    }
    */

    /*
    // Override to support rearranging the table view.
    override func tableView(_ tableView: UITableView, moveRowAt fromIndexPath: IndexPath, to: IndexPath) {

    }
    */

    /*
    // Override to support conditional rearranging of the table view.
    override func tableView(_ tableView: UITableView, canMoveRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the item to be re-orderable.
        return true
    }
    */

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

    //MARK: Private Methods
    private func loadSampleArtisans() {
        
        /* following tutorial at
                http://mrgott.com/swift-programing/33-rest-api-in-swift-4-using-urlsession-and-jsondecode
         */
        
        //Make HTTP Request
        let urlString = "http://localhost:3000/users"
        guard let url = URL(string: urlString) else { return }
        
        URLSession.shared.dataTask(with: url) { (data, response, error) in
            if error != nil {
                print(error!.localizedDescription)
            }
            
            guard let data = data else { return }
         
            // JSON decoding and parsing
            do {
                let userResponse = try JSONDecoder().decode(UserResponse.self, from: data)
            
                //Get back to the main queue
                DispatchQueue.main.async {
                    print(userResponse)
                    self.artisans = userResponse.artisans
                    self.tableView?.reloadData()
                    
                }
            } catch let jsonError {
                print(jsonError)
            }
            
        }.resume()
        /*
        
        let artisan1 = Artisan(name: "Sean")
        let artisan2 = Artisan(name: "Rebecca")
        let artisan3 = Artisan(name: "Vernon")
        let artisan4 = Artisan(name: "Zane")
        let artisan5 = Artisan(name: "Jackson")
        
        artisans += [artisan1, artisan2, artisan3, artisan4, artisan5]
        */
    }
}
