//
//  ThirdViewController.swift
//  Test
//
//  Created by Antony Michale Remila on 14/03/17.
//  Copyright © 2017 Antony Michale Remila. All rights reserved.
//

import UIKit
import EventKit

class GeoReminder: UIViewController {

//    @IBOutlet weak var reminderText: UITextField!
//    @IBOutlet weak var myDatePicker: UIDatePicker!
//
//    @IBOutlet weak var txtDatePicker: UITextField!
    
    @IBOutlet weak var textField_Date: UITextField!
    var datePicker : UIDatePicker!
    
//    let eventStore = EKEventStore()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = .white
//        showDatePicker()
//        self.createReminder()
    }
    
//    func createReminder() {
//
//        let reminder = EKReminder(eventStore: eventStore)
//
//        reminder.title = reminderText.text!
//        reminder.calendar =
//        eventStore.defaultCalendarForNewReminders()
//        let date = myDatePicker.date
//        let alarm = EKAlarm(absoluteDate: date)
//
//        reminder.addAlarm(alarm)
//
//        do {
//            try eventStore.save(reminder, commit: true)
//        } catch let error {
//                print("Reminder failed with error \(error.localizedDescription)")
//        }
//    }
    
    
    func pickUpDate(_ textField : UITextField){

        // DatePicker
        self.datePicker = UIDatePicker(frame:CGRect(x: 0, y: 0, width: self.view.frame.size.width, height: 216))
        self.datePicker.backgroundColor = UIColor.white
        self.datePicker.datePickerMode = UIDatePickerMode.date
        textField.inputView = self.datePicker

        // ToolBar
        let toolBar = UIToolbar()
        toolBar.barStyle = .default
        toolBar.isTranslucent = true
        toolBar.tintColor = UIColor(red: 92/255, green: 216/255, blue: 255/255, alpha: 1)
        toolBar.sizeToFit()

        // Adding Button ToolBar
        let doneButton = UIBarButtonItem(title: "Done", style: .plain, target: self, action: #selector(doneClick))
        let spaceButton = UIBarButtonItem(barButtonSystemItem: .flexibleSpace, target: nil, action: nil)
        let cancelButton = UIBarButtonItem(title: "Cancel", style: .plain, target: self, action: #selector(cancelClick))
        toolBar.setItems([cancelButton, spaceButton, doneButton], animated: false)
        toolBar.isUserInteractionEnabled = true
        textField.inputAccessoryView = toolBar

    }
    
    
    override func didReceiveMemoryWarning() {
           super.didReceiveMemoryWarning()
       }
    
    @objc func doneClick() {
        let dateFormatter1 = DateFormatter()
        dateFormatter1.dateStyle = .medium
        dateFormatter1.timeStyle = .none
        textField_Date.text = dateFormatter1.string(from: datePicker.date)
        textField_Date.resignFirstResponder()
    }
    @objc func cancelClick() {
        textField_Date.resignFirstResponder()
    }
    func textFieldDidBeginEditing(_ textField: UITextField) {
        self.pickUpDate(self.textField_Date)
    }
}
