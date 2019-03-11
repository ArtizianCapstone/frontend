//
//  InfoSubview.swift
//  Frontend
//
//  Created by Vernon Chan on 3/1/19.
//  Copyright © 2019 Artizian. All rights reserved.
//

import UIKit
import Alamofire

class InfoSubview: UIViewController {

    var artisan: Artisan? = nil
    
    @IBOutlet weak var testLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        testLabel.text = artisan?.phone_number
        
        
        // Do any additional setup after loading the view.
    }
    @IBAction func scheduleButton(_ sender: Any) {
        performSegue(withIdentifier: "createMeeting", sender:   self)
    }
    
    override func viewDidAppear(_ animated: Bool) {
        testLabel.text = artisan?.phone_number
        
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
            newMeetings.append(Meeting(userId: "5c00776e2f1dfe588f33138c", artisanId: (artisan?._id)!, date: meetingDate, numItemsExpected: schedule.numItemsExpected))
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
                postMeetings(meeting: meeting) {
                    // call another get meetings right here
                    self.getMeetings(artisanId: (self.artisan?._id)!) {
                        //reload array
                    }
                }
                print(meeting.date)
            }
            
        }
    }
    
    private func postMeetings(meeting: Meeting, completion : @escaping () -> ()) {
        let meetingJSON = meeting.toJSON()
        Alamofire.request( "http://ec2-3-83-249-93.compute-1.amazonaws.com:3000/meetings", method: .post, parameters: meetingJSON ).responseJSON { response in
            if let json = response.result.value {
                // serialized json response
                print("json from alamo fire", json)
                completion()
            }
        }
    }
    
    func getMeetings(artisanId: String, completion : @escaping () -> ()) {
        let url = "http://ec2-3-83-249-93.compute-1.amazonaws.com:3000/meetings/5c00776e2f1dfe588f33138c/" + artisanId
        Alamofire.request(url).responseJSON { response in
            if let json = response.result.value {
                // serialized json response
                print("json from meeting get request", json)

                //check if json is empty
                // if json is not empty set artisan.scheduledMeetings to true
                
                // convert json data to meeting structure and add to array for tableview
                /*
                if let jsonarray = json as? [[String: Any]] {
                    let dateFormatter = DateFormatter()
                    let calendar = Calendar.current
                    dateFormatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ss.SSS'Z'"
                    dateFormatter.locale = Locale(identifier: "en_US_POSIX")
                    for x in jsonarray {
                 
                        self.meetings.append(Meeting(artisanName: artisanJSON!["name"]! as! String, time: myDate, numItems: x["itemsExpected"] as! Int))
                    }
                }*/
                completion()
            }
        }
    }
}
