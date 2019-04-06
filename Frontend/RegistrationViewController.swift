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
        let pass = regPasswordLabel.text
        let conf_pass = regConfirmLabel.text
        let phone_number = regPhoneLabel.text
        
        if isValidRegistration(username: username!, pass: pass!, conf_pass: conf_pass!, phone_number: phone_number ?? "N/A") {
            performSegue(withIdentifier: "registerUnwindSuccess", sender: self)
        }
        else {
            invalidRegistrationLabel.isHidden = false
        }
    }
    
    func isValidRegistration(username: String, pass: String, conf_pass: String, phone_number: String) -> Bool {
        if pass != conf_pass {
            return false
        }
        else {
            return true
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
}
