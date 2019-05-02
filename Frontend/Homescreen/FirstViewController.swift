//
//  HomeViewController.swift
//  Frontend
//
//  Created by Vernon Chan on 11/27/18.
// Edited by rebeca Krieger 11/28/ 18 - 12/2/18
//  Copyright © 2018 Artizian. All rights reserved.
//

import UIKit
import Alamofire
//home screen
//UICollectionViewDelegateFlowLayout,
//firstViewController
struct HomeMeeting : Codable {
    
    //MARK: Properties
    
    var artisanName: String
    var time: Date
    var numItems: Int
    
    //MARK: Initialization
    init(artisanName: String, time: Date, numItems: Int ) {
        self.artisanName = artisanName
        self.time = time
        self.numItems = numItems
    }
}

class FirstViewController: UIViewController, UICollectionViewDelegateFlowLayout, UICollectionViewDataSource, UITableViewDataSource, UITableViewDelegate{
    
    @IBOutlet weak var totalGeneratedLabel: UILabel!
    @IBOutlet weak var shipmentOverviewLabel: UILabel!
    @IBOutlet weak var paymentOverviewLabel: UILabel!
    @IBOutlet weak var meetingTable: UITableView!
    
    
    var meetings = [HomeMeeting]()
    let cellSpacingHeight: CGFloat = 8
    var numListings: String  = "loading..."

    //var meetingData = [MeetingCellData]()
    let bannerQuotes = [
        bannerQuote(message: "Artisans make up the core of the community", textColor: UIColor.white, backgroundColor: UIColor(patternImage: UIImage(named: "stockImage1.jpg")!)),
        bannerQuote(message: "Listings with photos get 30% higher interaction", textColor: UIColor.white, backgroundColor: UIColor(patternImage: UIImage(named: "stockImage2.jpg")!)),
        //bannerQuote(message: "Listings with photos get 30% higher interation", textColor: UIColor.black, cellImage: UIImage(named: "stockImage2.jpg")!),
        bannerQuote(message: "Incorperate keywords in listings "),
        bannerQuote(message: "Artisans make up the core of the community"),
        bannerQuote(message: "Listings with photos get 30% higher interaction", textColor: UIColor.blue, backgroundColor: UIColor.yellow),
        bannerQuote(message: "Incorperate keywords in listings "),
        
        bannerQuote(message: "Artisans make up the core of the community")
    ]
    
    
    @IBOutlet weak var listingActivityIndicator: UIActivityIndicatorView!
    @IBOutlet weak var welcomeMessage: UILabel!
    
    @IBOutlet weak var banner: UICollectionView!
    @IBOutlet weak var bannerLayout: UICollectionViewFlowLayout!
    @IBOutlet weak var fakeGraphHolder: UIImageView!
 
    override func viewDidLoad() {
        print("\n" + Constants.userID + "\n")   
        super.viewDidLoad()
        //   banner.register(customBannerCell.self, forCellWithReuseIdentifier: "customCell")
        banner.delegate = self
        banner.dataSource = self
        bannerLayout.itemSize = CGSize(width: view.frame.width, height: view.frame.height)
        
        //loadTodaysMeetings {
        //    self.meetingTable.reloadData()
        //}
        
        totalGeneratedLabel.layer.masksToBounds = true
        totalGeneratedLabel.layer.cornerRadius=16.0;
        paymentOverviewLabel.layer.masksToBounds = true
        paymentOverviewLabel.layer.cornerRadius=16.0;
        shipmentOverviewLabel.layer.masksToBounds = true
        shipmentOverviewLabel.layer.cornerRadius=16.0;

        //  bannerLayout.scrollDirection = .horizontal
        // Do any additional setup after loading the view, typically from a nib.
        
        //meeting sample data
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy/MM/dd HH:mm"
        //meetings.append(Meeting(artisanName: "Camila Aguero", time: formatter.date(from: "2016/10/08 11:30")!, numItems: 10))
        //meetings.append(Meeting(artisanName: "Diego Avila", time: formatter.date(from: "2016/10/08 14:00")!, numItems: 7))
        //meetings.append(Meeting(artisanName: "Sebastian Alverado", time: formatter.date(from: "2016/10/08 17:00")!, numItems: 8))
        
    }
    
    override func viewDidAppear(_ animated: Bool) {
        loadTodaysMeetings {
            self.meetingTable.reloadData()
        }
        paymentOverviewLabel.isHidden = true
        listingActivityIndicator.isHidden = false
        listingActivityIndicator.startAnimating()
        loadListings {
            self.paymentOverviewLabel.text = "Active listings: " + self.numListings
            self.listingActivityIndicator.stopAnimating()
            self.listingActivityIndicator.isHidden = true
            self.paymentOverviewLabel.isHidden = false

        }
        
        
    }
    
    private func loadTodaysMeetings(completion : @escaping () -> ()) {
        Alamofire.request("http://ec2-3-83-249-93.compute-1.amazonaws.com:3000/meetings").responseJSON { response in
            if let json = response.result.value {
                // serialized json response
 //               print("homescreen get meetings json:", json)
                var todaysMeetings:[HomeMeeting] = []
                if let jsonarray = json as? [[String: Any]] {
                    let dateFormatter = DateFormatter()
                    let calendar = Calendar.current
                    dateFormatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ss.SSS'Z'"
                    dateFormatter.locale = Locale(identifier: "en_US_POSIX")
                    for x in jsonarray {
                        //if()
                        let dateString = x["date"] as! String
                        let myDate = dateFormatter.date(from: dateString )!
                        let artisanJSON = x["artisan"] as? [String: Any]
                        
                        //print("artisanJSON:")
                        //print(artisanJSON!["name"]!)
                        if calendar.isDateInToday(myDate) {
                            todaysMeetings.append(HomeMeeting(artisanName: artisanJSON!["name"] as? String ?? "Camila Sandoval", time: myDate, numItems: x["itemsExpected"] as? Int ?? 0))
                        }
                    }
                    self.meetings = todaysMeetings
                }
                completion()
            }
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return bannerQuotes.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        NSLog("drew a cell")
        let cell = banner.dequeueReusableCell(withReuseIdentifier: "customCell", for: indexPath) as! customBannerCell
        // Do any custom modifications you your cell, referencing the outlets you defined in the Custom cell file.
        
        if bannerQuotes[indexPath.row].cellImage == nil{
            cell.messageLabel.backgroundColor = bannerQuotes[indexPath.row].backgroundColor
        }
        else {
            cell.cellBackgroundImage.image = bannerQuotes[indexPath.row].cellImage
            print("reached")
        }
        
        cell.messageLabel.textColor = bannerQuotes[indexPath.row].textColor
        //print(bannerQuotes[indexPath.row].message)
        cell.messageLabel.text = bannerQuotes[indexPath.row].message
        
        return cell
        
    }

    private func loadListings(completion : @escaping () -> ()) {
        //clear listings array
        
        Alamofire.request("http://ec2-3-83-249-93.compute-1.amazonaws.com:3000/listings").responseJSON { response in
            if let json = response.result.value {
                // serialized json response
                if let jsonarray = json as? [[String: Any]] {
                    self.numListings = "\(jsonarray.count)"
                }
            }
            completion()
        }
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return meetings.count
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return cellSpacingHeight
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let headerView = UIView()
        headerView.backgroundColor = UIColor.clear
        return headerView
        }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "meetingCell", for: indexPath) as! CustomMeetingCell

        cell.layer.cornerRadius = 8
        
        //add meeting data to labels
        let meeting = meetings[indexPath.section]
        cell.artisanNameLabel.text = meeting.artisanName
        let formatter = DateFormatter()
        formatter.dateFormat = "h:mm a" // "a" prints "pm" or "am"
        formatter.string(from: Date()) // "12 AM"
        cell.meetingTimeLabel.text = formatter.string(from: meeting.time)
        cell.numItemsLabel.text = String(meeting.numItems) + " items expected"

        return cell
    }
    
}

