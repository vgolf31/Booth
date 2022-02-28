//
//  Return_on_capital_ViewController.swift
//  Booth
//
//  Created by Veer M on 4/7/20.
//  Copyright © 2020 Veertegh Minhas. All rights reserved.
//

import UIKit
import Firebase
import SwiftUI
class ReturnOnCapitalViewController: UIViewController {
    @IBOutlet weak var explanation_button: UIButton!
    @IBOutlet weak var explanation_view: UIView!
    @IBOutlet weak var hide_explanation_button: UIButton!
    @IBOutlet weak var tableView: UITableView!
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
        if(day != (defaults.integer(forKey: "cur_day_c"))){
            self.defaults.set(day, forKey: "cur_day_c")
            find_values()
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
        db.collection("return_on_capital").getDocuments() {(querySnapshot, err) in
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
                    self.defaults.set(keys, forKey: "return_on_capital_keys")
                    self.defaults.set(values, forKey: "return_on_capital_values")
                }
            }
        }
    }
}
extension ReturnOnCapitalViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        self.tableView.reloadData()
    }
}
extension ReturnOnCapitalViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return defaults.stringArray(forKey: "return_on_capital_keys")?.count ?? 1
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "TwoLabelCell", for: indexPath) as! TwoLabelCell
        let tickers = (defaults.stringArray(forKey: "return_on_capital_keys")) ?? ["Please Wait"]
        let numbers = (defaults.array(forKey: "return_on_capital_values")  as? [Float]) ?? [0.0]
        cell.label1.text = tickers[indexPath.row];
        cell.label2.text = String(round(numbers[indexPath.row]*1000)/1000.0);
        return cell
    }
}
