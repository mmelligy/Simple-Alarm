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
    
    var refresher: UIRefreshControl = {
          let refresher = UIRefreshControl()
          refresher.addTarget(self, action: #selector(handleRefresh), for: .valueChanged)
          
          return refresher
      }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        let nib = UINib(nibName: cellIdentifier , bundle: nil)
        alarmTableView.register(nib, forCellReuseIdentifier: cellIdentifier)
        
        Timer(timeInterval: 30.0, target: self, selector: "handleRefresh", userInfo: nil, repeats: true)
        
    
        alarmTableView.addSubview(refresher)
        handleRefresh()
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
    func scheduleNotification(AlarmMessage : Alarm, timeInterval : Int) {
        let center = UNUserNotificationCenter.current()

        let content = UNMutableNotificationContent()
        content.title = AlarmMessage.category
        content.body = AlarmMessage.massage
        content.categoryIdentifier = "alarm"
        content.userInfo = ["customData": "fizzbuzz"]
        content.sound = UNNotificationSound.default

        let trigger = UNTimeIntervalNotificationTrigger(timeInterval: TimeInterval(timeInterval), repeats: false)

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
        self.refresher.endRefreshing()
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return cellHeight
    }
    
    func tableView(_ tableView: UITableView, editActionsForRowAt indexPath: IndexPath) -> [UITableViewRowAction]? {
        
        let deleteAction = UITableViewRowAction(style: .default, title: "Delete") { (action: UITableViewRowAction, indexPath: IndexPath) in
            self.alarmsArray.remove(at: indexPath.row)
            self.alarmTableView.reloadData()
        }
        deleteAction.backgroundColor = .red
        
        return [deleteAction]
    }
    
}

extension HomeViewController: AddAlarmDelegate {
    func addAlarm(alarm: Alarm) {
        self.dismiss(animated: true) {
            self.alarmsArray.append(alarm)
            self.alarmsArray = self.alarmsArray.sorted(by: { $0.alarmTime < $1.alarmTime })
            let elapsed = Date().timeIntervalSince(alarm.alarmTime)
            print(elapsed)
            let duration = abs(Int(elapsed))
            self.scheduleNotification(AlarmMessage: alarm, timeInterval : duration)
            self.alarmTableView.reloadData()
        }
    }
    
    @objc private func handleRefresh(){
        self.alarmTableView.reloadData()
    }
}
