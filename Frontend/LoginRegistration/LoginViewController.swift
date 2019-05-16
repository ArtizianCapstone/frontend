//
//  LoginViewController.swift
//  Frontend
//
//  Created by Zane Ali on 12/3/18.
//  Copyright © 2018 Artizian. All rights reserved.
//

import UIKit
import Alamofire
//import AWSCore
//import AWSCognitoIdentityProvider

class LoginViewController: UIViewController {
    
    @IBOutlet weak var incorrectUsernameOrPass: UILabel!
   // var users = ["jkurtz": "5c00776e2f1dfe588f33138c",
    //             "bfoote":  "5c01b47607170f9377b207bc"]
    //"we will have a master password for now"]
    


    override func viewDidLoad() {
        super.viewDidLoad()
        //TODO: Get the database information using POSTMAN
        // Do any additional setup after loading the view.
    }
    var authenticated = false
    var userid = ""
    @IBOutlet weak var loginButton: UIButton!
    @IBOutlet weak var username: UITextField!
    @IBOutlet weak var password: UITextField!
    
    @IBAction func loginAction(_ sender: Any) {
        authenticateUsers(completion: {
            if (self.authenticated == true) {
                self.performSegue(withIdentifier: "loginSegue", sender: self.loginButton)
            }else{
                self.incorrectUsernameOrPass.isHidden = false
            }
        }, username: self.username.text!, password: self.password.text!)
    }
    @IBAction func unwindRegistrationSuccess(_ sender: UIStoryboardSegue) {
        if let sourceViewController = sender.source as? RegistrationViewController {
            let newUser = User(name: sourceViewController.regUserLabel.text!, password: sourceViewController.regPasswordLabel.text!, phone_number: sourceViewController.regPhoneLabel.text ?? "N/A")
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
    
    private func authenticateUsers(completion: @escaping () -> (), username : String, password: String){
        //AWSServiceConfiguration *serviceConfiguration = [[AWSServiceConfiguration alloc] initWithRegion:AWSRegionUSEast1 credentialsProvider:nil];

        Alamofire.request("http://ec2-3-83-249-93.compute-1.amazonaws.com:3000/users", method: .get).responseJSON{ response in
            if let json = response.result.value{
                let json1 = json as! [String : Any]
                
                let json2 = json1["users"] as! NSArray
                for user in json2 {
                    let user = user as! [String : Any]
                    let uname = (user["name"] ?? "") as! String
                    let pass = (user["password"] ?? "") as! String
                    if ((uname == username) && (pass == password)) {
                        Constants.userID = user["_id"] as! String
                        self.authenticated = true
                        break
                    }
                }
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
