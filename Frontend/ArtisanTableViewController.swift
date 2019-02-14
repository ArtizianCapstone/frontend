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
    var user = User()
    var artisans = [Artisan]()
    @IBOutlet weak var addArtisanButton: UIBarButtonItem!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        getUser(id: "5c00776e2f1dfe588f33138c")
        self.tableView?.reloadData()
        
        //loadSampleArtisans()

        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidLoad()
        getUser(id: "5c00776e2f1dfe588f33138c")
    }
  
    @IBAction func addArtisanAction(_ sender: Any) {
        print("here")
        performSegue(withIdentifier: "addArtisanSegue", sender: addArtisanButton)

    }
    private func getUser(id: String) {
        let urlString = "http://localhost:3000/users/" + id
        
        var url = URL(string: urlString)!
        
        URLSession.shared.dataTask(with: url) { (data, response, error) in
            if error != nil {
                print(error!.localizedDescription)
            }
            
            guard let data = data else { return }
            
            // JSON decoding and parsing
            do {
                let oneUser = try JSONDecoder().decode(GetOneUser.self, from: data)
                
                
                //Get back to the main queue
                DispatchQueue.main.async {
                    self.user = oneUser.user
                    //print(user)
                    self.tableView?.reloadData()
                }
            } catch let jsonError {
                print(jsonError)
            }
            
            url = URL(string: urlString + "/artisans")!
            URLSession.shared.dataTask(with: url) { (data, response, error) in
                if error != nil {
                    print(error!.localizedDescription)
                }
                
                guard let data = data else { return }
                
                // JSON decoding and parsing
                do {
                    var artisans = try JSONDecoder().decode([Artisan].self, from: data)
                    artisans = artisans.sorted {$0.name < $1.name }
                    //Get back to the main queue
                    DispatchQueue.main.async {
                        self.user.artisans = artisans
                        print(self.user)
                        self.tableView?.reloadData()
                    }
                } catch let jsonError {
                    print(jsonError)
                }
                
                }.resume()
            
        }.resume()

        
    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if user.artisans != nil { 
            return user.artisans.count
        } else {
            return 20

        }
    }
    
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        return true
    }
    
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if (editingStyle == .delete) {
            user.artisans.remove(at: indexPath.row)
            tableView.deleteRows(at: [indexPath], with: .fade)
        }
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cellIdentifier = "ArtisanTableViewCell"

        guard let cell = tableView.dequeueReusableCell(withIdentifier: cellIdentifier, for: indexPath) as? ArtisanTableViewCell else {
            fatalError("The dequeued cell is not an instance of ArtisanTableViewCell.")
        }
        
        if self.user.artisans != nil {
            let artisan = self.user.artisans[indexPath.row]
            cell.nameLabel.text = artisan.name

        } else {
            cell.nameLabel.text = ""

        }
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

    
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
        if segue.identifier == "showArtisanDetail" {
            let destVC = segue.destination as? ArtisanDetailViewController
            let index = (tableView.indexPathForSelectedRow?.row)!
            
            print (user.artisans[index])
            destVC?.bio = user.artisans[index].bio
            destVC?.name = user.artisans[index].name
            destVC?.number = user.artisans[index].phone_number
            
        }
    }
    

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
                let allUsers = try JSONDecoder().decode(GetAllUsers.self, from: data)
            
                //Get back to the main queue
                DispatchQueue.main.async {
                    self.user.artisans = allUsers.artisans
                    self.tableView?.reloadData()
                    
                }
            } catch let jsonError {
                print(jsonError)
            }
            
        }.resume()
    }
}
