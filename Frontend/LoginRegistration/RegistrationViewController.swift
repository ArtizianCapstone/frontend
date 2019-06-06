//
//  RegistrationViewController.swift
//  Frontend
//
//  Created by Jackson Kurtz on 4/6/19.
//  Copyright © 2019 Artizian. All rights reserved.
//

import UIKit

class RegistrationViewController: UIViewController {

    @IBOutlet weak var regUserLabel: UITextField!
    @IBOutlet weak var regPasswordLabel: UITextField!
    @IBOutlet weak var regConfirmLabel: UITextField!
    
    @IBOutlet weak var regPhoneLabel: UITextField!
    @IBOutlet weak var invalidRegistrationLabel: UILabel!
    
    @IBAction func Register(_ sender: Any) {
        let username = regUserLabel.text
        let pass = regPasswordLabel.text!
        let conf_pass = regConfirmLabel.text!
        let phone_number = regPhoneLabel.text
        
        if isValidRegistration(username: username!, pass: pass, conf_pass: conf_pass, phone_number: phone_number ?? "N/A") {
            performSegue(withIdentifier: "registerUnwindSuccess", sender: self)
        }
    }
    
    func ShowInvalidMessage(message: String) {
        invalidRegistrationLabel.text = message
        invalidRegistrationLabel.isHidden = false

    }
    
    func IsValidUsername(username: String) -> Bool {
        if username.count > 0 && username.count < 15 {
            return true
        }
        else {
            ShowInvalidMessage(message: "Invalid Username!")
            return false
        }
    }
    
    func IsValidPassword(pass:String, conf_pass:String) -> Bool {
        if pass != conf_pass {
            ShowInvalidMessage(message: "Passwords don't match!")
            return false
        }
        else if pass.count > 0 && pass.count < 18 {
            return true
        }
        else {
            ShowInvalidMessage(message: "Invalid password")
            return false
        }
    }
    
    func IsValidPhoneNumber(phone_number:String) -> Bool{
        if(phone_number.count == 0 ) {
            return true
        }
        else if phone_number.count > 9 && phone_number.count < 13, let _ = Int(phone_number) {
            return true
        }
        else  {
            ShowInvalidMessage(message: "Invalid phone number")
            return false
        }

    }
    
    func isValidRegistration(username: String, pass: String, conf_pass: String, phone_number: String) -> Bool {
        if IsValidUsername(username: username) && IsValidPassword(pass: pass, conf_pass: conf_pass) && IsValidPhoneNumber(phone_number: phone_number) {
            return true
        }
        else {
            return false
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        invalidRegistrationLabel.text = ""
        invalidRegistrationLabel.isHidden = true
    }
    /*taken from https://stackoverflow.com/questions/32163848/how-can-i-convert-a-string-to-an-md5-hash-in-ios-using-swift
    */
    

}
