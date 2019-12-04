//
//  AlarmModel.swift
//  Simple Alarm
//
//  Created by Mahmoud El-Melligy on 12/3/19.
//  Copyright © 2019 Mahmoud El-Melligy. All rights reserved.
//

import Foundation


class Alarm {
    var alarmTime: Date!
    var dailyStartWeekly: String!
    var category: String!
    
    init(timeAlarm: Date, dailyStartWeekly: String, category: String!) {
        self.alarmTime = timeAlarm
        self.dailyStartWeekly = dailyStartWeekly
        self.category = category
    }
}
