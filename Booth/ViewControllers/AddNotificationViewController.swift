//
//  AddNotificationViewController.swift
//  Booth
//
//  Created by Veer M on 9/10/22.
//  Copyright © 2022 Veertegh Minhas. All rights reserved.
//

import UIKit
import UserNotifications
class AddNotificationViewController: UIViewController {
    @IBOutlet weak var title_field: UITextField!
    @IBOutlet weak var body_field: UITextField!
    @IBOutlet weak var date_field: UIDatePicker!
    @IBOutlet weak var addNotificationButton: UIButton!
    @IBOutlet weak var title_label: UILabel!
    @IBOutlet var background: UIView!
    let defaults = UserDefaults.standard
    override func viewDidLoad() {
        super.viewDidLoad()
        if(defaults.string(forKey: "DisplayMode") == "Light") {
            background.backgroundColor = UIColor.gray
            title_label.textColor = UIColor.black
        } else if(defaults.string(forKey: "DisplayMode") == "Dark"){
            background.backgroundColor = UIColor.white
            title_label.textColor = UIColor.white
        }
        date_field.isUserInteractionEnabled = true
    }
    
    @IBAction func addNotificationPressed(_ sender: Any) {
        if(title_field.text != nil && body_field.text != nil && date_field.date > Date.init()){
            print("reached", title_field.text!, body_field.text!)
            var currentstringarray = self.defaults.array(forKey: "reminder_array_string")
            var currentdatearray = self.defaults.array(forKey: "reminder_array_date")
            if(currentstringarray == nil || currentdatearray == nil){
                let new_string_array:[String] = [title_field.text!]
                let new_date_array:[Date] = [date_field.date]
                self.defaults.set(new_string_array, forKey: "reminder_array_string")
                self.defaults.set(new_date_array, forKey: "reminder_array_date")
            } else{
                currentstringarray?.append(title_field.text!)
                currentdatearray?.append(date_field.date)
                self.defaults.set(currentstringarray, forKey: "reminder_array_string")
                self.defaults.set(currentdatearray, forKey: "reminder_array_date")
            }
            let content = UNMutableNotificationContent()
            content.title = title_field.text!
            content.sound = .default
            content.body = body_field.text!
            let targetDate = date_field.date
            let trigger = UNCalendarNotificationTrigger(dateMatching: Calendar.current.dateComponents([.year, .month, .day, .hour, .minute, .second], from: targetDate), repeats: false)
            let letters = "abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789"
            let identifier = String((0..<6).map{ _ in letters.randomElement()! })
            let request = UNNotificationRequest(identifier: identifier, content: content, trigger: trigger)
            UNUserNotificationCenter.current().add(request) { error in
                if(error != nil){
                    print("Something went wrong scheduling the notification")
                }
            }
            if let vc = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "GalleryViewController") as? GalleryViewController
            {
                present(vc, animated: false, completion: nil)
            }
        }
    }
    


}
