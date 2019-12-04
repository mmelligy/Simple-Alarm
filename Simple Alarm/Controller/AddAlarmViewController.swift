//
//  AddAlarmViewController.swift
//  Simple Alarm
//
//  Created by Mahmoud El-Melligy on 12/3/19.
//  Copyright © 2019 Mahmoud El-Melligy. All rights reserved.
//

import UIKit

protocol AddAlarmDelegate {
    func addAlarm(alarm :Alarm)
}


class AddAlarmViewController: UIViewController {
    
    var delegate: AddAlarmDelegate?
    
    @IBOutlet weak var timePicker: UIDatePicker!
    @IBOutlet weak var messageTextFiled: UITextField!
    @IBOutlet weak var repeatButton: UIButton!
    @IBOutlet weak var categoryButton: UIButton!
    
    var repeatButtonV = "Not repeat"
    var category = "Schedule"
    var time = Date()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        //getting current time
        let date = Date()
        let calendar = Calendar.current
        let hour = calendar.component(.hour, from: date)
        let minutes = calendar.component(.minute, from: date)
        print("\(hour):\(minutes)")
        
    }
    
    @IBAction func cancelButtonPressed(_ sender: Any) {
        self.dismiss(animated: true, completion: nil)
    }
    
    
    @IBAction func didchangeDatePicker(_ sender: UIDatePicker) {
        self.time = sender.date
    }
    
    @IBAction func categoryButtonPressed(_ sender: Any) {
        if category == "Schedule"{
            categoryButton.setTitle("Meetings", for: .normal)
            category = "Meetings"
        }else{
            categoryButton.setTitle("Schedule", for: .normal)
            category = "Schedule"
        }
        
    }
    
    @IBAction func repeatButtonPressed(_ sender: Any) {
        if repeatButtonV == "Not repeat"{
            repeatButton.setTitleColor(#colorLiteral(red: 0.6901960784, green: 0.231372549, blue: 0.2745098039, alpha: 1), for: .normal)
            repeatButtonV = "repeat"
        }else{
            repeatButton.setTitleColor(#colorLiteral(red: 0, green: 0, blue: 0, alpha: 1), for: .normal)
            repeatButtonV = "Not repeat"
        }
        
    }
    
    
    @IBAction func addNewTimeButtonPressed(_ sender: Any) {
        
        self.dismiss(animated: true) {
            
            guard let categoryselected: String = self.category else {return}
            guard let repeatAlarm: String = self.repeatButtonV else {return}
            
            
            let alarm = Alarm(timeAlarm: self.time, dailyStartWeekly: repeatAlarm, category: categoryselected)
            
            
            self.delegate?.addAlarm(alarm: alarm)
            
//            let ViewController = HomeViewController(nibName: "HomeView", bundle: nil) as! HomeViewController
//            ViewController.repeatButtonV = self.repeatButtonV
//            ViewController.category = self.category
            
        }
        
        
    }
    
    
    
}
