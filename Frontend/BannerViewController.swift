//
//  BannerViewController.swift
//  Frontend
//
//  Created by Rebecca Krieger on 12/3/18.
//  Copyright © 2018 Artizian. All rights reserved.
//

import Foundation
import UIKit
class BannerViewController: UICollectionViewController, UICollectionViewDelegateFlowLayout {
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return bannerQuotes.count
    }
    let bannerQuotes = [bannerQuote(message: "Listings with photos get 30% higher interation", textColor: UIColor.blue, backgroundColor: UIColor.green), bannerQuote(message: "Incorperate keywords in listings "),
        bannerQuote(message: "Artisans make up the core of the community")
    ]
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = banner.dequeueReusableCell(withReuseIdentifier: "customCell", for: indexPath) as! customBannerCell
        // Do any custom modifications you your cell, referencing the outlets you defined in the Custom cell file.
       // cell.messageLabel.backgroundColor = bannerQuotes[indexPath.row].backgroundColor
        //cell.messageLabel.textColor = bannerQuotes[indexPath.row].textColor
        cell.messageLabel.textColor = UIColor.white
        cell.messageLabel.text = "hello"
        print(bannerQuotes[indexPath.row].message)
       // cell.messageLabel.text = bannerQuotes[indexPath.row].message
       
        return cell
        
    }

    @IBOutlet var banner: UICollectionView!
    
    @IBOutlet weak var bannerLayout: UICollectionViewFlowLayout!
    // The size of each item. Pick a suitable height so that the items do not get stacked:
    // The most important part:
  
    
    override func viewDidLoad() {
        super.viewDidLoad()
        collectionView.register(customBannerCell.self, forCellWithReuseIdentifier: "customBannerCell")
        banner.delegate = self
        banner.dataSource = self
        bannerLayout.itemSize = CGSize(width: view.frame.width, height: view.frame.height)
        bannerLayout.scrollDirection = .horizontal
        // Do any additional setup after loading the view, typically from a nib.
    }
    // Then initialize collectionView
}
