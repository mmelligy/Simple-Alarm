//
//  ViewController.swift
//  Simple Alarm
//
//  Created by Mahmoud El-Melligy on 12/3/19.
//  Copyright © 2019 Mahmoud El-Melligy. All rights reserved.
//

import UIKit
import UserNotifications

class HomeViewController: UIViewController {
    
    @IBOutlet weak var alarmTableView: UITableView!
    
    var alarmsArray = [Alarm]()
    
    var categorySelected = "Schedule"
    
    //declaring cell of the table view
    fileprivate let cellIdentifier = "AlarmTableViewCell"
    fileprivate let cellHeight: CGFloat = 80
    
    //getting the date
    let date = Date()
    let formatter = DateFormatter()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        let nib = UINib(nibName: cellIdentifier , bundle: nil)
        alarmTableView.register(nib, forCellReuseIdentifier: cellIdentifier)
        
//        let center = UNUserNotificationCenter.current()
//
//        center.requestAuthorization(options: [.alert, .badge ,.sound]) { (success, error) in
//        }
//
//        let content = UNMutableNotificationContent()
//        content.title = "hey I'm a notification"
//        content.body = "look at me"
//        content.sound = UNNotificationSound.default
//
//        let date = Date().addingTimeInterval(10)
//
//        let dateComponents = Calendar.current.dateComponents([.year, .month, .day , .hour , .minute, .second], from: date)
//
//        let trigger = UNCalendarNotificationTrigger(dateMatching: dateComponents, repeats: false)
//
//        let uuidString = UUID().uuidString
//
//        let request = UNNotificationRequest(identifier: uuidString, content: content, trigger: trigger)
//        center.add(request) { (error) in
//            print(error)
//        }
        var dateComponents = DateComponents()
        dateComponents.hour = 10
        dateComponents.minute = 30
        let trigger = UNCalendarNotificationTrigger(dateMatching: dateComponents, repeats: false)
        
        scheduleNotification()
        
        
    }
    
    @IBAction func segmentButtonPressed(_ sender: UISegmentedControl) {
        switch sender.selectedSegmentIndex{
        case 0:
            categorySelected = "Schedule"
        case 1:
            categorySelected = "Meetings"
        default:
            break
        }
    }
    func scheduleNotification() {
        let center = UNUserNotificationCenter.current()

        let content = UNMutableNotificationContent()
        content.title = "Late wake up call"
        content.body = "The early bird catches the worm, but the second mouse gets the cheese."
        content.categoryIdentifier = "alarm"
        content.userInfo = ["customData": "fizzbuzz"]
        content.sound = UNNotificationSound.default

        var dateComponents = DateComponents()
        dateComponents.hour = 10
        dateComponents.minute = 30
        let trigger = UNTimeIntervalNotificationTrigger(timeInterval: 5, repeats: false)

        let request = UNNotificationRequest(identifier: UUID().uuidString, content: content, trigger: trigger)
        center.add(request)
    }
    func registerCategories() {
        let center = UNUserNotificationCenter.current()
        center.delegate = self as? UNUserNotificationCenterDelegate

        let show = UNNotificationAction(identifier: "show", title: "Tell me more…", options: .foreground)
        let category = UNNotificationCategory(identifier: "alarm", actions: [show], intentIdentifiers: [])

        center.setNotificationCategories([category])
    }
    func userNotificationCenter(_ center: UNUserNotificationCenter, didReceive response: UNNotificationResponse, withCompletionHandler completionHandler: @escaping () -> Void) {
        // pull out the buried userInfo dictionary
        let userInfo = response.notification.request.content.userInfo

        if let customData = userInfo["customData"] as? String {
            print("Custom data received: \(customData)")

            switch response.actionIdentifier {
            case UNNotificationDefaultActionIdentifier:
                // the user swiped to unlock
                print("Default identifier")

            case "show":
                // the user tapped our "show more info…" button
                print("Show more information…")
                break

            default:
                break
            }
        }

        // you must call the completion handler when you're done
        completionHandler()
    }
    
    @IBAction func addNewAlarmPressed(_ sender: Any) {
        
        let controller = AddAlarmViewController(nibName: "AddAlarm", bundle: nil)
        controller.delegate = self
        self.present(controller, animated: true)
    }
    
}
extension HomeViewController: UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return alarmsArray.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: cellIdentifier) as! AlarmTableViewCell
        cell.sitUpAlarmTableViewCell(alarm: alarmsArray[indexPath.row])
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return cellHeight
    }
    
    
    
}

extension HomeViewController: AddAlarmDelegate {
    func addAlarm(alarm: Alarm) {
        self.dismiss(animated: true) {
            self.alarmsArray.append(alarm)
            self.alarmTableView.reloadData()
        }
    }
}
