//
//  AddListingsViewController.swift
//  Frontend
//
//  Created by Zane Ali on 1/22/19.
//  Copyright © 2019 Artizian. All rights reserved.
//

import UIKit
import Alamofire
import AlamofireImage

class AddListingsViewController: UIViewController,UIPickerViewDelegate,UIPickerViewDataSource {
    
    @IBOutlet weak var itemName: UITextField!
    
 
    @IBOutlet weak var pickerView: UIPickerView!
    var pickerData: [String : String] = [String : String]()
    var pickerArray: [String] = [String]()

    @IBOutlet weak var cancelButton: UIButton!
    @IBOutlet weak var itemDescription: UITextView!
    
    @IBOutlet weak var itemPrice: UITextField!
    
    @IBOutlet weak var submitButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        itemPrice.keyboardType = .numberPad
        
        itemDescription.layer.borderWidth = 1.0
        itemDescription.layer.cornerRadius = 5.0
        itemDescription.layer.borderColor = UIColor(red: 0.9, green: 0.9, blue: 0.9, alpha: 1.0).cgColor
        
        self.pickerView.delegate = self
        self.pickerView.dataSource = self
        
        loadData {
           self.pickerView.reloadAllComponents()
        }
        // Do any additional setup after loading the view.
    }
    
    @IBAction func dismessVC(_ sender: Any) {
        dismiss(animated: true, completion: nil)
    }
    
    @IBAction func submitAction(_ sender: Any) {
        print("TEST")
        if (itemDescription.text! == "" || itemPrice.text! == "" || itemName.text! == ""){
            print("Forms not filled: error")
        }else{
            let price = Float(itemPrice.text!) ?? 0
            let item  = itemName.text!
            let row = self.pickerView.selectedRow(inComponent: 0)
            let artisanName = pickerArray[row]
            let artisanID = (pickerData[artisanName])
            let description = itemDescription.text!
            
            let newListing = Listing()
            newListing.price = price
            newListing.name = item
            newListing.artisan = artisanID ?? "None"
            newListing.description = description
            postListing(listing: newListing){

            }
    
        }
    }
   
    private func postListing(listing: Listing, completion: @escaping () -> ()) {
        let listingJSON = listing.toJSON()
        Alamofire.request("http://ec2-3-83-249-93.compute-1.amazonaws.com:3000/listings/noimage", method: .post, parameters: listingJSON ).responseJSON { response in
            if let json = response.result.value{
                print ("json from alamofire", json)
                completion()
            }
        }
        
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    // Number of columns of data
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
    return 1
    }
    
    // The number of rows of data
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        print (pickerArray.count)
        return pickerArray.count
    }
    
    // The data to return fopr the row and component (column) that's being passed in
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
            return pickerArray[row]
    }
    func loadData(completion : @escaping () -> ()) {
        
        Alamofire.request("http://ec2-3-83-249-93.compute-1.amazonaws.com:3000/artisans").responseJSON { response in
            
            if let json = response.result.value {
                // serialized json response
                if let dict = json as? [String: Any] {
                    
                    if let artisans = (dict["artisans"] as? [[String: Any]]) {
                        for x in artisans  {
                            self.pickerData[(x["name"]! as! String)] = (x["_id"]! as! String)
                            self.pickerArray.append(x["name"]! as! String)
                        }
                    }
                }
            }
            completion()
        }
        
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        print( pickerArray[row])
        // This method is triggered whenever the user makes a change to the picker selection.
        // The parameter named row and component represents what was selected.
    }
}
