//
//  HomeViewController.swift
//  Frontend
//
//  Created by Vernon Chan on 11/27/18.
// Edited by rebeca Krieger 11/28/ 18 - 12/2/18
//  Copyright © 2018 Artizian. All rights reserved.
//

import UIKit
//home screen
class FirstViewController: UIViewController, UICollectionViewDelegateFlowLayout, UICollectionViewDataSource {
    let bannerQuotes = [bannerQuote(message: "Listings with photos get 30% higher interation", textColor: UIColor.blue, backgroundColor: UIColor.green), bannerQuote(message: "Incorperate keywords in listings "),
                        bannerQuote(message: "Artisans make up the core of the community")
    ]

    @IBOutlet weak var welcomeMessage: UILabel!
    //@IBOutlet weak var bannerContainer: UIView!
    @IBOutlet weak var banner: UICollectionView!
    
    @IBOutlet weak var bannerLayout: UICollectionViewFlowLayout!
    @IBOutlet weak var fakeGraphHolder: UIImageView!
    override func viewDidLoad() {
        super.viewDidLoad()
      //  banner.register(customBannerCell.self, forCellWithReuseIdentifier: "customCell")
        banner.delegate = self
        banner.dataSource = self
        bannerLayout.itemSize = CGSize(width: view.frame.width, height: view.frame.height)
        bannerLayout.scrollDirection = .horizontal
        // Do any additional setup after loading the view, typically from a nib.
    }
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return bannerQuotes.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = banner.dequeueReusableCell(withReuseIdentifier: "customCell", for: indexPath) as! customBannerCell
        // Do any custom modifications you your cell, referencing the outlets you defined in the Custom cell file.
        cell.messageLabel.backgroundColor = bannerQuotes[indexPath.row].backgroundColor
        cell.messageLabel.textColor = bannerQuotes[indexPath.row].textColor
        //print(bannerQuotes[indexPath.row].message)
        cell.messageLabel.text = bannerQuotes[indexPath.row].message
        
        return cell
        
    }


}

