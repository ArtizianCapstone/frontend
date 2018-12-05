//
//  ArtisanCreatedViewController.swift
//  Frontend
//
//  Created by Zane Ali on 12/5/18.
//  Copyright © 2018 Artizian. All rights reserved.
//

import UIKit

class ArtisanCreatedViewController: UIViewController {
    @IBOutlet weak var nameField: UILabel!
    
    @IBOutlet weak var numberField: UILabel!
    
    @IBOutlet weak var homeButton: UIButton!
    @IBOutlet weak var viewArtisanButton: UIButton!
    @IBOutlet weak var addAnotherButton: UIButton!
    var username:String = ""
    var number:String = ""
    
    override func viewDidLoad() {
        super.viewDidLoad()
        nameField.text! = username
        numberField.text! = number
        // Do any additional setup after loading the view.
    }
    
    @IBAction func viewArtisan(_ sender: Any) {
      //  performSegue(withIdentifier: "goHome", sender: )
    }
    @IBAction func addArtisan(_ sender: Any) {
        performSegue(withIdentifier: "AddAnotherArtisanSegue", sender: addAnotherButton)
    }
    
    @IBAction func goHome(_ sender: Any) {
        performSegue(withIdentifier: "goHome", sender: homeButton)
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
