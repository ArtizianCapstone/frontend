//
//  MeetingHistoryViewController.swift
//  Frontend
//
//  Created by Vernon Chan on 5/15/19.
//  Copyright © 2019 Artizian. All rights reserved.
//

import UIKit

class MeetingHistoryViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    var meetingHistory: [Meeting] = []
    
    @IBOutlet weak var meetingHistoryTableView: UITableView!
    @IBOutlet weak var testLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "Meeting History"
        meetingHistoryTableView.dataSource = self
        meetingHistoryTableView.delegate = self
        meetingHistoryTableView.tableFooterView = UIView()

        // Do any additional setup after loading the view.
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        print("COUNT: " + String(meetingHistory.count))
        return meetingHistory.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "MeetingHistoryTableViewCell", for: indexPath) as! MeetingHistoryTableViewCell
        
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "MM/dd/yyyy"
        
        let timeFormatter = DateFormatter()
        timeFormatter.dateFormat = "HH:mm a"
        
        let dateString = dateFormatter.string(from: (meetingHistory[indexPath.row].date))
        let timeString = timeFormatter.string(from: (meetingHistory[indexPath.row].date))
            
        cell.dateLabel.text = dateString + " " + timeString
        cell.itemCountLabel.text = String(meetingHistory[indexPath.row].numItemsExpected) + " items"
        
        return cell
        
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
