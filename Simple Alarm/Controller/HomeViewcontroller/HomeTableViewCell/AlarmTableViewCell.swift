//
//  AlarmTableViewCell.swift
//  Simple Alarm
//
//  Created by Mahmoud El-Melligy on 12/3/19.
//  Copyright © 2019 Mahmoud El-Melligy. All rights reserved.
//

import UIKit

class AlarmTableViewCell: UITableViewCell {

    @IBOutlet weak var pmamLabel: UILabel!
    @IBOutlet weak var timeAlarmLabel: UILabel!
    @IBOutlet weak var dailyStartWeeklyLabel: UILabel!
    @IBOutlet weak var switchButton: UISwitch!
    
    
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        
    }
    
    func sitUpAlarmTableViewCell(alarm:Alarm){
        let countDown = printTime(timeEnd: alarm)
        dailyStartWeeklyLabel.text = alarm.dailyStartWeekly + "/" + countDown
        let formatterforAmorPm = DateFormatter()
        formatterforAmorPm.dateFormat = "a"
        pmamLabel.text = formatterforAmorPm.string(for: alarm.alarmTime)
        let formatter = DateFormatter()
        formatter.dateFormat = "hh:mm"
        timeAlarmLabel.text = formatter.string(for: alarm.alarmTime)
        
        
    }
    
    // MARK:- countDown Function
    func printTime(timeEnd : Alarm) -> String{
        let startTime = Date()
        let formatter = DateComponentsFormatter()
        formatter.allowedUnits = [.hour,.minute,.second]
        formatter.unitsStyle = .short
        let difference = formatter.string(from: startTime, to: timeEnd.alarmTime)!
    
        return difference
    }
    
}
