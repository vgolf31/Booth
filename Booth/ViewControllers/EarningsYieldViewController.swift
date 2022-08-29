//
//  Earnings_Yield_ViewController.swift
//  Booth
//
//  Created by Veer M on 4/7/20.
//  Copyright © 2020 Veertegh Minhas. All rights reserved.
//

import UIKit
import Firebase
import SwiftUI
class EarningsYieldViewController: UIViewController {
    @IBOutlet weak var explanation_button: UIButton!
    @IBOutlet weak var explanation_view: UIView!
    @IBOutlet weak var explanation_text: UITextView!
    @IBOutlet weak var hide_explanation_button: UIButton!
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet var background: UIView!
    let defaults = UserDefaults.standard
    let date = Date()
    let cal = Calendar.current
    override func viewDidLoad() {
        super.viewDidLoad()
        let day = cal.ordinality(of: .day, in: .year, for: date)
        let nib = UINib(nibName: "TwoLabelCell", bundle: nil)
        tableView.register(nib, forCellReuseIdentifier: "TwoLabelCell");
        tableView.delegate = self
        tableView.dataSource = self
        if(day != (defaults.integer(forKey: "cur_day_e"))){
            self.defaults.set(day, forKey: "cur_day_e")
            find_values()
        }
        if(defaults.string(forKey: "DisplayMode") == "Light") {
            background.backgroundColor = UIColor.white
            explanation_view.backgroundColor = UIColor.white
            explanation_text.textColor = UIColor.black
            explanation_text.backgroundColor = UIColor.white
            hide_explanation_button.backgroundColor = UIColor.white
        } else if(defaults.string(forKey: "DisplayMode") == "Dark"){
            background.backgroundColor = UIColor.black
            explanation_view.backgroundColor = UIColor.black
            explanation_text.textColor = UIColor.white
            explanation_text.backgroundColor = UIColor.black
            hide_explanation_button.backgroundColor = UIColor.black
        }
    }
    override func viewDidAppear(_ animated: Bool) {
        DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
            self.tableView.reloadData()
        }
    }
    @IBAction func explanation_button_clicked(_ sender: Any) {
        explanation_view.isHidden = false;
        explanation_view.isUserInteractionEnabled = true;
    }
    @IBAction func hide_explanation_button_clicked(_ sender: Any) {
        explanation_view.isHidden = true;
        explanation_view.isUserInteractionEnabled = false;
    }
    func find_values(){
        let db = Firestore.firestore();
        db.collection("earnings_yield").getDocuments() {(querySnapshot, err) in
            if let err = err {
                print("error getting documents: \(err)");
            } else{
                for document in querySnapshot!.documents{
                    var data = document.data();
                    var keys = [Any]()
                    let prevalues = Array(data.values)
                    var values = [Float]()
                    for prevalue in prevalues{
                        values.append((prevalue as? NSNumber)?.floatValue ?? 0)
                    }
                    values = values.sorted().reversed()
                    for value in values{
                        for (k, v) in data{
                            if(((v as? NSNumber)?.floatValue ?? 0) == value){
                                keys.append(k)
                                data.removeValue(forKey: k)
                                break
                            }
                        }
                    }
                    self.defaults.set(keys, forKey: "earnings_yield_keys")
                    self.defaults.set(values, forKey: "earnings_yield_values")
                }
            }
        }
    }
}
extension EarningsYieldViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        self.tableView.reloadData()
        let c = tableView.cellForRow(at: indexPath) as! TwoLabelCell
        self.defaults.set(c.label1.text, forKey: "current_ticker")
        if let vc = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "EarningsInfoViewController") as? EarningsInfoViewController
        {
            present(vc, animated: false, completion: nil)
        }
    }
}
extension EarningsYieldViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return defaults.stringArray(forKey: "earnings_yield_keys")?.count ?? 1
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "TwoLabelCell", for: indexPath) as! TwoLabelCell
        let tickers = (defaults.stringArray(forKey: "earnings_yield_keys")) ?? ["Please Wait"]
        let numbers = (defaults.array(forKey: "earnings_yield_values")  as? [Float]) ?? [0.0]
        cell.label1.text = tickers[indexPath.row];
        cell.label2.text = String(round(numbers[indexPath.row]*1000)/1000.0);
        if(defaults.string(forKey: "DisplayMode") == "Light") {
            cell.label1.textColor = UIColor.black
            cell.label2.textColor = UIColor.black
            cell.cell_background.backgroundColor = UIColor.white
            cell.cell_separator.backgroundColor = UIColor.black
        } else if(defaults.string(forKey: "DisplayMode") == "Dark"){
            cell.label1.textColor = UIColor.white
            cell.label2.textColor = UIColor.white
            cell.cell_background.backgroundColor = UIColor.black
            cell.cell_separator.backgroundColor = UIColor.white
        }
        return cell
    }
}
