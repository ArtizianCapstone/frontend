//
//  LoginViewController.swift
//  Frontend
//
//  Created by Zane Ali on 12/3/18.
//  Copyright © 2018 Artizian. All rights reserved.
//

import UIKit

class LoginViewController: UIViewController {
    
    var users = ["jkurtz": "5c00776e2f1dfe588f33138c",
                 "bfoote":  "5c01b47607170f9377b207bc"]
    //"we will have a master password for now"
    
    override func viewDidLoad() {
        super.viewDidLoad()
        //TODO: Get the database information using POSTMAN
        // Do any additional setup after loading the view.
    }
    var authenticated = false
    @IBOutlet weak var loginButton: UIButton!
    @IBOutlet weak var username: UITextField!
    @IBOutlet weak var password: UITextField!
    
    @IBAction func loginAction(_ sender: Any) {
        print(username.text ?? "")
        print(password.text ?? "")
        if (users[username.text!] != nil && password.text! == "Artizian1"){
            authenticated = true
            performSegue(withIdentifier: "loginSegue", sender: loginButton)
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
