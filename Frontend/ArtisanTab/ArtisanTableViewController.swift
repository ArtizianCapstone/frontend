//
//  ArtisanTableViewController.swift
//  Frontend
//
//  Created by Vernon Chan on 12/2/18.
//  Copyright © 2018 Artizian. All rights reserved.
//

import UIKit
import Alamofire

class ArtisanTableViewController: UITableViewController {
    //MARK: Properties
    var user = User()
    var artisans = [Artisan]()
    @IBOutlet weak var addArtisanButton: UIBarButtonItem!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        //getUser(id: "5c00776e2f1dfe588f33138c")
        getArtisans {
            self.tableView?.reloadData()
        }
        print("after view did load: ", artisans.count)
        
        
        self.tableView?.reloadData()
        
        //loadSampleArtisans()

        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidLoad()
        //getUser(id: "5c00776e2f1dfe588f33138c")
        getArtisans() {
            self.tableView?.reloadData()
        }
    }
    
    @IBAction func addArtisanAction(_ sender: Any) {
        print("here")
        performSegue(withIdentifier: "addArtisanSegue", sender: addArtisanButton)

    }
    private func getUser(id: String) {
        let urlString = "http://localhost:3000/users/" + id
        //let urlString = "http:///ec2-3-83-249-93.compute-1.amazonaws.com:3000/users/" + id
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
        if artisans != nil {
            return artisans.count
        } else {
            return 20

        }
    }
    
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        return true
    }
    
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if (editingStyle == .delete) {
            let artisanToDelete = artisans[indexPath.row]
            let url = "http://ec2-3-83-249-93.compute-1.amazonaws.com:3000/artisans/" + artisanToDelete._id!
            
            self.artisans.remove(at: indexPath.row)
            tableView.deleteRows(at: [indexPath], with: .fade)
            
            
            Alamofire.request(url, method: .delete)
                .responseJSON { response in
                    if let json = response.result.value{
                        print ("json from alamofire", json)
                    }
            }
        }
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cellIdentifier = "ArtisanTableViewCell"

        guard let cell = tableView.dequeueReusableCell(withIdentifier: cellIdentifier, for: indexPath) as? ArtisanTableViewCell else {
            fatalError("The dequeued cell is not an instance of ArtisanTableViewCell.")
        }
        
        //if self.user.artisans != nil {
        if self.artisans != nil {
            //let artisan = self.user.artisans[indexPath.row]
        let artisan = self.artisans[indexPath.row]
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
            
            print (artisans[index])
            destVC?.bio = artisans[index].bio
            destVC?.name = artisans[index].name
            destVC?.number = artisans[index].phone_number
            destVC?.artisan = artisans[index]
        }
    }
    

    //MARK: Private Methods
    
    private func loadSampleArtisans() {
        
        /* following tutorial at
                http://mrgott.com/swift-programing/33-rest-api-in-swift-4-using-urlsession-and-jsondecode
         */
        
        //Make HTTP Request
        let urlString = "http://localhost:3000/users"
        //let urlString = "http://ec2-3-83-249-93.compute-1.amazonaws.com:3000/users"
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
    
    private func getArtisans(completion : @escaping () -> ()) {
        
        Alamofire.request("http://ec2-3-83-249-93.compute-1.amazonaws.com:3000/artisans").responseJSON { response in
            if let json = response.result.value {
                // serialized json response
                print("GET artisans json response", json)
                if let jsonarray = json as? [[String: Any]] {
                    var newArtisans:[Artisan] = []
                    for x in jsonarray {
                        let name = x["name"] as? String ?? "no name"
                        let _id = x["_id"] as? String ?? "no id"
                        let phone_number = x["phone_number"] as? String ?? "no phone number"
                        let bio = x["bio"] as? String ?? "no bio "
                        
                        newArtisans.append(Artisan(name: name, phone_number: phone_number, bio: bio, _id: _id))
                    }
                    print("count of new artisans", newArtisans.count)
                    newArtisans = newArtisans.sorted {$0.name < $1.name }
                    self.artisans = newArtisans
                }   
                
            }
            completion()
            
        }
        
        
    }
    
}
