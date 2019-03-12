//
//  ArtisanFormViewController.swift
//  Frontend
//
//  Created by Zane Ali on 12/4/18.
//  Copyright © 2018 Artizian. All rights reserved.
//

import UIKit
import Alamofire

class ArtisanFormViewController: UIViewController {
    @IBOutlet weak var bioText: UITextView!
    @IBOutlet weak var submitButton: UIButton!

    @IBOutlet weak var errorLabel: UILabel!
    
    @IBOutlet weak var phoneNumber: UITextField!
    @IBOutlet weak var firstName: UITextField!
    @IBOutlet weak var lastName: UITextField!
    @IBOutlet weak var middleName: UITextField!
    
    var name:String = ""
    var number:String = ""

    override func viewDidLoad() {
        bioText.layer.borderWidth = 1.0
        bioText.layer.cornerRadius = 5.0
        bioText.layer.borderColor = UIColor(red: 0.9, green: 0.9, blue: 0.9, alpha: 1.0).cgColor
        /*submitButton.layer.borderWidth = 1.0
        submitButton.layer.cornerRadius = 5.0
        submitButton.layer.borderColor = UIColor(red:0, green: 0, blue: 0, alpha: 1.0).cgColor*/
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        submitButton.backgroundColor = Constants.Colors.blue
        submitButton.layer.cornerRadius = Constants.RoundedButton.cornerRadius
        
    }
    
    @IBAction func submitAction(_ sender: Any) {
        //TODO add support for country codes longer than 1 digit
        var phoneNumNoHyphens = phoneNumber.text!
        phoneNumNoHyphens = String(phoneNumber.text!.filter { "01234567890.".contains($0) })
        
        //TODO implement some sort of checking system for each of the fields
        //concatonating the names since the database only supports one name for now
        //first name, last name, phone number, and
        //ideally we'd replace these with actual error checking with try catches and sh**, but such is life
        
        //these errors are appended to the error list, but the problem is that once one occurs the rest don't show up
        if (firstName.text! == "" || lastName.text! == "" || phoneNumber.text! == "")
        {
            errorLabel.isHidden = false;
            if (firstName.text! == ""){
                errorLabel.text!.append("\nFirst name is a required field")
            }
            if (lastName.text! == ""){
                errorLabel.text!.append("\nLast name is a required field")
            }
            if (phoneNumber.text! == ""){
                errorLabel.text!.append("\nPhone number is a required field")
            }
            if (phoneNumNoHyphens.count < 11){
                errorLabel.text!.append("\nInvalid phone number entered")
            }
        }else{
            print(phoneNumber.text!)
            number = phoneNumber.text!
            //middle name is optional
            if (middleName.text! != ""){
                name = firstName.text! + " " + middleName.text! + " " + lastName.text!
            }else{
                name = firstName.text! + " " + lastName.text!
            }
            //currently this userID is hard coded in, but in the future we should have a global userID maybe?
            let json: [String: Any] = ["userId": "5c00776e2f1dfe588f33138c", "name": name,"bio": bioText.text!, "phone_number": phoneNumNoHyphens]
            let bio = bioText.text!
            
            let artisan = Artisan( name: name, phone_number:phoneNumNoHyphens, bio: bio )
            print("artisan before post", artisan)
            postMeetings(artisan: artisan) {
                
            }
            performSegue(withIdentifier: "CreatedArtisanSegue", sender: submitAction)
            //guard let jsonData = try? JSONSerialization.data(withJSONObject: json) else {return}
            
            // create post request
           // guard let url = URL(string: "http://localhost:3000/artisans") else {return}
            //var request = URLRequest(url: url)
            //request.httpMethod = "POST"
            //request.addValue("application/json", forHTTPHeaderField: "Content-Type")
            // insert json data to the request
            //request.httpBody = jsonData
            /*
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
            }.resume()*/
            /*
                guard let data = data, error == nil else {
                    print(error?.localizedDescription ?? "No data")
                    return
                }
                let responseJSON = try? JSONSerialization.jsonObject(with: data, options: [])
                if let responseJSON = responseJSON as? [String: Any] {
                    print(responseJSON)
                }
            }
            
            task.resume()*/
            //performSegue(withIdentifier: "CreatedArtisanSegue", sender: submitAction)
 
        
        
        }
    }
    
    private func postMeetings(artisan: Artisan, completion : @escaping () -> ()) {
        let artisanJSON = artisan.toJSON()
        Alamofire.request( "http://ec2-3-83-249-93.compute-1.amazonaws.com:3000/artisans/noimage", method: .post, parameters: artisanJSON ).responseJSON { response in
            if let json = response.result.value {
                // serialized json response
                print("json from artisan post", json)
                completion()
            }
        }
    }
        
    override func prepare(for segue: UIStoryboardSegue, sender: Any?)
    {
        if(segue.destination is ArtisanCreatedViewController){
            let vc = segue.destination as? ArtisanCreatedViewController
            vc?.username = name
            vc?.number = number
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
