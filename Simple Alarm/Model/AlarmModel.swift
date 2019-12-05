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
    var massage: String!
    
    init(alarmTime: Date, dailyStartWeekly: String, category: String!, massage: String) {
        self.alarmTime = alarmTime
        self.dailyStartWeekly = dailyStartWeekly
        self.category = category
        self.massage = massage
    }
}
