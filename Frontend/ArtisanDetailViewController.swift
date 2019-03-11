//
//  ArtisanDetailViewController.swift
//  Frontend
//
//  Created by Vernon Chan on 12/4/18.
//  Copyright © 2018 Artizian. All rights reserved.
//

import UIKit

class ArtisanDetailViewController: UIViewController {
    var artisan: Artisan?
    
    var name: String = ""
    var bio: String = ""
    var number: String = ""
    
    var infoSubviewNew: InfoSubview?
    var paymentSubviewNew: PaymentSubview?
    var listingSubviewNew: ListingSubview?
    
    @IBOutlet weak var infoSubview: InfoSubview!
    @IBOutlet weak var paymentSubview: PaymentSubview!
    @IBOutlet weak var listingSubview: ListingSubview!
    
    
    @IBAction func switchViewAction(_ sender: UISegmentedControl) {
        infoSubviewNew!.view.isHidden = true
        paymentSubviewNew!.view.isHidden = true
        listingSubviewNew!.view.isHidden = true
        
        switch sender.selectedSegmentIndex {
            case 0:
                infoSubviewNew!.view.isHidden = false
                break
            case 1:
                paymentSubviewNew!.view.isHidden = false
                break
            case 2:  
                listingSubviewNew!.view.isHidden = false
                break
            default:
                break
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = name
        
        //print(name)
        //print(bio)
        //print(number)
        
        guard let listingSubviewNew1 = children[0] as? ListingSubview else {
            fatalError("Check storyboard for missing ListingView")
        }
        
        guard let paymentSubviewNew1 = children[1] as? PaymentSubview else {
            fatalError("Check storyboard for missing PaymentSubview")
        }
        
        guard let infoSubviewNew1 = children[2] as? InfoSubview else {
            fatalError("Check storyboard for missing Infoview")
        }
        
        listingSubviewNew = listingSubviewNew1
        paymentSubviewNew = paymentSubviewNew1
        infoSubviewNew = infoSubviewNew1
        
        infoSubviewNew?.artisan = self.artisan
        infoSubviewNew?.phone_number.text = self.artisan?.phone_number
        listingSubviewNew?.artisan = self.artisan
    
        infoSubviewNew?.getMeetings(artisanId: (artisan?._id)!) {
            //reload array
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
