//
//  AddListingsViewController.swift
//  Frontend
//
//  Created by Zane Ali on 1/22/19.
//  Copyright © 2019 Artizian. All rights reserved.
//

import UIKit

class AddListingsViewController: UIViewController {
    @IBOutlet weak var itemName: UITextField!
    
    @IBOutlet weak var itemDescription: UITextView!
    
    @IBOutlet weak var itemPrice: UITextField!
    
    @IBOutlet weak var submitButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        itemPrice.keyboardType = .numberPad
        
       itemDescription.layer.borderWidth = 1.0
        // Do any additional setup after loading the view.
    }
    
    @IBAction func submitAction(_ sender: Any) {
        if (itemDescription.text! == "" || itemPrice.text! == "" || itemName.text! == ""){
            print("error")
        }
        var price = Float(itemPrice.text!) ?? 0
        let json: [String: Any] = [ "name": itemName.text!,"description": itemDescription.text!, "price": price]
        
        guard let jsonData = try? JSONSerialization.data(withJSONObject: json) else {return}
        
        // create post request
        guard let url = URL(string: "http://localhost:3000/listings") else {return}
        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        request.addValue("application/json", forHTTPHeaderField: "Content-Type")
        // insert json data to the request
        request.httpBody = jsonData
        
        let task = URLSession.shared
        task.dataTask(with: request) { (data, response, error) in
            if let response = response {
                print( response )
            }
            if let data = data {
                do {
                    let json = try JSONSerialization.jsonObject(with: data, options: [])
                    print( json )
                }
                catch{
                    print(error)
                }
            }
            }.resume()
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
