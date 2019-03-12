//
//  CreateMeetingViewController.swift
//  Frontend
//
//  Created by Jackson Kurtz on 3/1/19.
//  Copyright © 2019 Artizian. All rights reserved.
//

import Foundation
import UIKit

class CreateMeetingViewController: UIViewController, UIPickerViewDelegate, UIPickerViewDataSource{
    
    @IBOutlet weak var itemsExpectedField: UITextField!
    @IBOutlet weak var frequencyField: UITextField!
    @IBOutlet weak var startingDateField: UITextField!
    @IBOutlet weak var timeField: UITextField!
    
    var freqInt: Int?
    
    var frequencyPickerView = UIPickerView()
    var startingDatePicker = UIDatePicker()
    var startingTimePicker = UIDatePicker()
    
    let frequency = ["Weekly", "Every 2 weeks", "Every 3 weeks", "Every 4 weeks"]
    
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return frequency.count
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return frequency[row]
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        freqInt = row + 1
        frequencyField.text = frequency[row]
    }
    
    override func viewDidLoad() {
        frequencyField.inputView = frequencyPickerView
        
        frequencyPickerView.delegate = self
        frequencyField.text = frequency[0]
        freqInt = 1
        
        startingDatePicker.datePickerMode = .date
        startingDatePicker.addTarget(self, action: #selector(CreateMeetingViewController.dateChanged(startingDatePicker:)), for: .valueChanged)
        startingDateField.inputView = startingDatePicker
        
        startingTimePicker.datePickerMode = .time
        startingTimePicker.addTarget(self, action: #selector(CreateMeetingViewController.timeChanged(startingTimePicker:)), for: .valueChanged)
        timeField.inputView = startingTimePicker

        
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "MM/dd/yyyy"
        let timeFormatter = DateFormatter()
        timeFormatter.dateFormat = "h:mm a"
        startingDateField.text = dateFormatter.string(from: startingDatePicker.date)
        timeField.text = timeFormatter.string(from: startingTimePicker.date)
        
    }
    
    @objc func dateChanged( startingDatePicker: UIDatePicker ) {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "MM/dd/yyyy"
        startingDateField.text = dateFormatter.string(from: startingDatePicker.date)
    }
    @objc func timeChanged( startingTimePicker: UIDatePicker ) {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "h:mm a"
        timeField.text = dateFormatter.string(from: startingTimePicker.date)
    }
    /*
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let vc = segue.destination as! TempArtisanViewController
        vc.createdMeetingLabel.text = "meeting created!"
    }*/
}
