//
//  CreateMeetingViewController.swift
//  Frontend
//
//  Created by Jackson Kurtz on 3/1/19.
//  Copyright © 2019 Artizian. All rights reserved.
//

import Foundation
import UIKit

class CreateMeetingViewController: UIViewController, UIPickerViewDelegate, UIPickerViewDataSource, UITextFieldDelegate{
    
    @IBOutlet weak var invalidEntryLabel: UILabel!
    @IBOutlet weak var itemsExpectedField: UITextField!
    @IBOutlet weak var frequencyField: UITextField!
    @IBOutlet weak var startingDateField: UITextField!
    @IBOutlet weak var timeField: UITextField!
    
    var freqInt: Int?
    
    var frequencyPickerView = UIPickerView()
    var startingDatePicker = UIDatePicker()
    var startingTimePicker = UIDatePicker()
    
    let frequency = ["Weekly", "Every 2 weeks", "Every 3 weeks", "Every 4 weeks"]
    
    func isStringAnInt(stringNumber: String) -> Bool {
        
        if let _ = Int(stringNumber) {
            return true
        }
        return false
    }
    
    func ValidEntry() -> Bool{
        
        let itemsExpected:String = itemsExpectedField.text ?? ""
        if let numItems = Int(itemsExpected) {
           return itemsExpected != "" && isStringAnInt(stringNumber: itemsExpected) && numItems >= 0
        }
        else {
            return false
        }
        
    }
    
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        print("should change text field function is called...")
        if textField == itemsExpectedField {
            return true
        }
        else {
           return false
        }
    }
    
    func ShowErrorMessage(message:String) {
        invalidEntryLabel.text = message
        invalidEntryLabel.isHidden = false
    }
    
    @IBAction func saveSchedule(_ sender: Any) {
        if ValidEntry() {
            performSegue(withIdentifier: "createSchedule", sender: self)
        }
        else {
            ShowErrorMessage(message: "Invalid items expected")
        }
    }
    
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

        startingDateField.delegate = self
        frequencyField.delegate = self
        itemsExpectedField.delegate = self
        timeField.delegate = self
        
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
