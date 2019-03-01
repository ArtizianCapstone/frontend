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
    
    var infoViewController: InfoViewController!
    var paymentViewController: PaymentViewController!
    var listingViewController: ListingViewController!
    
    @IBOutlet weak var viewContainer: UIView!
    
    @IBAction func switchViewAction(_ sender: UISegmentedControl) {
        switch sender.selectedSegmentIndex {
        case 0:
            viewContainer.bringSubviewToFront(infoViewController.view)
            break
        case 1:
            viewContainer.bringSubviewToFront(paymentViewController.view)
            break
        case 2:  
            viewContainer.bringSubviewToFront(listingViewController.view)
            break
        default:
            break
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = name
        
        print(name)
        print(bio)
        print(number)
        
        infoViewController = InfoViewController()
        infoViewController.artisan = self.artisan

        paymentViewController = PaymentViewController()
        listingViewController = ListingViewController()
        
        viewContainer.addSubview(paymentViewController.view)
        viewContainer.addSubview(listingViewController.view)
        viewContainer.addSubview(infoViewController.view)
        
        
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
