//
//  LoginViewController.swift
//  Frontend
//
//  Created by Zane Ali on 12/3/18.
//  Copyright © 2018 Artizian. All rights reserved.
//

import UIKit
import Alamofire


class LoginViewController: UIViewController {
    
    @IBOutlet weak var incorrectUsernameOrPass: UILabel!
    var users = ["jkurtz": "5c00776e2f1dfe588f33138c",
                 "bfoote":  "5c01b47607170f9377b207bc"]
    //"we will have a master password for now"]
    


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
        }else{
            incorrectUsernameOrPass.isHidden = false;
        }
    }
    
    @IBAction func unwindRegistrationSuccess(_ sender: UIStoryboardSegue) {
        if let sourceViewController = sender.source as? RegistrationViewController {
            let newUser = User(name: sourceViewController.regUserLabel.text!, phone_number: sourceViewController.regPhoneLabel.text ?? "N/A")
            postUser(user: newUser) {
                //actions after post finishes
            }
        }
    }
    
    @IBAction func unwindRegistrationCancel(_ sender: UIStoryboardSegue) {
    }
    
    private func postUser(user: User, completion : @escaping () -> ()) {
        let userJson = user.toJSON()
        Alamofire.request( "http://ec2-3-83-249-93.compute-1.amazonaws.com:3000/users", method: .post, parameters: userJson ).responseJSON { response in
            if let json = response.result.value {
                // serialized json response
                print("json from alamo fire", json)
                completion()
            }
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
