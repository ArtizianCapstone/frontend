//
//  InfoSubview.swift
//  Frontend
//
//  Created by Vernon Chan on 3/1/19.
//  Copyright © 2019 Artizian. All rights reserved.
//

import UIKit

class InfoSubview: UIViewController {

    var artisan: Artisan? = nil
    @IBOutlet weak var scheduleButton: UIButton!
    
    @IBOutlet weak var phone_number: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
//        phone_number.text = artisan?.phone_number
        scheduleButton.backgroundColor = Constants.Colors.gray
        scheduleButton.layer.cornerRadius = Constants.RoundedButton.cornerRadius
    }
    @IBAction func scheduleButton(_ sender: Any) {
        performSegue(withIdentifier: "createMeeting", sender:   self)
    }
    
    override func viewDidAppear(_ animated: Bool) {
//        phone_number.text = artisan?.phone_number

    }
    
    func hide() {
        self.view.isHidden = true
    }
    
    func unhide() {
        self.view.isHidden = false
    }

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */
    
    //start pasting from TempArtisanViewController
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let backItem = UIBarButtonItem()
        backItem.title = "Cancel"
        navigationItem.backBarButtonItem = backItem
    }
    
    func generateMeetings(schedule: MeetingSchedule, num: Int) -> [Meeting] {
        var newMeetings: [Meeting] = []
        for index in 0..<num {
            let meetingDate = schedule.startingDate.addingTimeInterval(TimeInterval(schedule.frequency * index * 604800))
            newMeetings.append(Meeting(userId: "5c00776e2f1dfe588f33138c", artisanId: "5c098020ecc0c26eb4108619", date: meetingDate, numItemsExpected: schedule.numItemsExpected))
        }
        return newMeetings
    }
    
    @IBAction func unwindToThisView(sender: UIStoryboardSegue) {
        if let sourceViewController = sender.source as? CreateMeetingViewController {
            let freq = sourceViewController.freqInt
            
            let dateFormatter = DateFormatter()
            dateFormatter.dateFormat = "MM/dd/yyyy,h:mm a"
            dateFormatter.locale = Locale(identifier: "en_US_POSIX")
            dateFormatter.timeZone = TimeZone(secondsFromGMT: 0)
            print(sourceViewController.timeField.text!)
            let mergedDateFields = sourceViewController.startingDateField.text! + "," + sourceViewController.timeField.text!
            
            //print("merged date string: ", mergedDateFields)
            let date = dateFormatter.date(from: mergedDateFields )
            //print( "merged date: ", date)
            let numItems = Int(sourceViewController.itemsExpectedField.text ?? "0")
            
            let newMeetingSchedule = MeetingSchedule(frequency: freq!, startingDate: date!, numItemsExpected: numItems!)
            print(dateFormatter.string(from: newMeetingSchedule.startingDate))
            let newMeetings = generateMeetings(schedule: newMeetingSchedule, num:3)
            for meeting in newMeetings {
                print(meeting.date)
            }
        }
    }

}
