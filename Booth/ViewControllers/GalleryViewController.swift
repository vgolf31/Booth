//
//  GalleryViewController.swift
//  Booth
//
//  Created by Veer M on 9/4/22.
//  Copyright © 2022 Veertegh Minhas. All rights reserved.
//

import UIKit
import UserNotifications
class GalleryViewController: UIViewController {
    
    @IBOutlet weak var backButton: UIButton!
    @IBOutlet weak var addNotificationButton: UIButton!
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet var background: UIView!
    @IBOutlet weak var title_label: UILabel!
    let defaults = UserDefaults.standard
    override func viewDidLoad() {
        super.viewDidLoad()
        UNUserNotificationCenter.current().requestAuthorization(options: [.alert, .badge, .sound]) { success, error in
            if(success){
                
            }
            else if(error != nil){
                print("error occurred")
            }
        }
        if(defaults.string(forKey: "DisplayMode") == "Light") {
            background.backgroundColor = UIColor.white
            tableView.backgroundColor = UIColor.white
            addNotificationButton.tintColor = UIColor.black
            title_label.textColor = UIColor.black
        } else if(defaults.string(forKey: "DisplayMode") == "Dark"){
            background.backgroundColor = UIColor.black
            tableView.backgroundColor = UIColor.black
            addNotificationButton.tintColor = UIColor.white
            title_label.textColor = UIColor.white
        }
        updateArray()
        tableView.delegate = self
        tableView.dataSource = self
    }

    @IBAction func addNotificationButtonPressed(_ sender: Any) {
        if let vc = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "AddNotificationViewController") as? AddNotificationViewController
        {
            present(vc, animated: false, completion: nil)
        }
    }
    func updateArray(){
        var reminders = (defaults.array(forKey: "reminder_array_string")  as? [String]) ?? ["Try making an new reminder"]
        var dates = (defaults.array(forKey: "reminder_array_date")  as? [Date]) ?? [Date.init()]
        let curdate = Date.init()
        var i = 0
        for date in dates{
            if(curdate > date){
                dates.remove(at: i)
                reminders.remove(at: i)
                i = i - 1
            }
            i = i + 1
        }
        self.defaults.set(reminders, forKey: "reminder_array_string")
        self.defaults.set(dates, forKey: "reminder_array_date")
    }
    
}
extension GalleryViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        self.tableView.deselectRow(at: indexPath, animated: true)
    }
}
extension GalleryViewController: UITableViewDataSource{
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return defaults.array(forKey: "reminder_array_string")?.count ?? 1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let reminders = (defaults.array(forKey: "reminder_array_string")  as? [String]) ?? ["Try making an new reminder"]
        let dates = (defaults.array(forKey: "reminder_array_date")  as? [Date]) ?? [Date.init()]
        let cell = self.tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
        cell.textLabel?.text = reminders[indexPath.row]
        let formatter = DateFormatter()
        formatter.dateFormat = "MMM, dd, YYYY"
        cell.detailTextLabel?.text = formatter.string(from: dates[indexPath.row])
        if(defaults.string(forKey: "DisplayMode") == "Light") {
            cell.textLabel?.textColor = UIColor.black
            cell.detailTextLabel?.textColor = UIColor.black
            cell.backgroundColor = UIColor.white
        } else if(defaults.string(forKey: "DisplayMode") == "Dark"){
            cell.textLabel?.textColor = UIColor.white
            cell.detailTextLabel?.textColor = UIColor.white
            cell.backgroundColor = UIColor.black
        }
        return cell
    }
}

