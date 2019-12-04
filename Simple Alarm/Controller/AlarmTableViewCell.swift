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

        // Configure the view for the selected state
    }
    
    func sitUpAlarmTableViewCell(alarm:Alarm){
        dailyStartWeeklyLabel.text = alarm.dailyStartWeekly
        let formatterforAmorPm = DateFormatter()
        formatterforAmorPm.dateFormat = "a"
        pmamLabel.text = formatterforAmorPm.string(for: alarm.alarmTime)
        let formatter = DateFormatter()
        formatter.dateFormat = "hh:mm"
        timeAlarmLabel.text = formatter.string(for: alarm.alarmTime)
        
        
    }
    
}
