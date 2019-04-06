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
        if isValidRegistration() {
            performSegue(withIdentifier: "registerUnwindSuccess", sender: self)
        }
        else {
            invalidRegistrationLabel.isHidden = false
        }
    }
    
    func isValidRegistration() -> Bool {
        if regPasswordLabel.text != regConfirmLabel.text {
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
