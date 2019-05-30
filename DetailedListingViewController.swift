//
//  DetailedListingViewController.swift
//  
//
//  Created by Zane Ali on 5/23/19.
//

import UIKit

class DetailedListingViewController: UIViewController {

    @IBOutlet weak var listingName: UILabel!
    @IBOutlet weak var artisanName: UILabel!
    @IBOutlet weak var listingImage: UIImageView!
    @IBOutlet weak var listingPrice: UITextField!
    @IBOutlet weak var listingDescription: UITextView!
    @IBOutlet weak var backButton: UIButton!
    
    
    var loaded_listing = Listing()
    
    override func viewDidLoad() {
        
        super.viewDidLoad()
        loadListing()
        // Do any additional setup after loading the view
    }
    
    @IBAction func backAction(_ sender: Any) {
        dismiss(animated: true, completion: nil)
    }
    
    
    private func loadListing(){
        print(loaded_listing.toStrDict())
        listingName.text! = loaded_listing.name
        artisanName.text! = loaded_listing.artisanName
        listingImage.image = loaded_listing.photo
        listingPrice.text! = "$" + loaded_listing.price.description
        listingDescription.text! = loaded_listing.description
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
