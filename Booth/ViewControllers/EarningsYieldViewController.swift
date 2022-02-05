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
    @IBOutlet weak var hide_explanation_button: UIButton!
    @IBOutlet weak var tableView: UITableView!
    let defaults = UserDefaults.standard
    override func viewDidLoad() {
        super.viewDidLoad()
        let nib = UINib(nibName: "TwoLabelCell", bundle: nil)
        tableView.register(nib, forCellReuseIdentifier: "TwoLabelCell");
        tableView.delegate = self
        tableView.dataSource = self
        let db = Firestore.firestore();
        db.collection("earnings_yield").getDocuments() {(querySnapshot, err) in
            if let err = err {
                print("error getting documents: \(err)");
            } else{
                for document in querySnapshot!.documents{
                    let data = document.data();
                    var keys = [Any]()
                    let prevalues = Array(data.values)
                    var values = [Float]()
                    for prevalue in prevalues{
                        values.append((prevalue as? NSNumber)?.floatValue ?? 0)
                    }
                    values = values.sorted().reversed()
                    print("values: ", values)
                    for value in values{
                        for (k, v) in data{
                            if(((v as? NSNumber)?.floatValue ?? 0) == value){
                                keys.append(k);
                            }
                        }
                    }
                    self.defaults.set(keys, forKey: "earnings_yield_keys")
                    self.defaults.set(values, forKey: "earnings_yield_values")
                    print("sorted!");
                   
                }
            }
        }
        tableView.reloadData()
    }
    override func viewDidAppear(_ animated: Bool) {
        tableView.reloadData()
    }
    @IBAction func explanation_button_clicked(_ sender: Any) {
        explanation_view.isHidden = false;
        explanation_view.isUserInteractionEnabled = true;

    }
    @IBAction func hide_explanation_button_clicked(_ sender: Any) {
        explanation_view.isHidden = true;
        explanation_view.isUserInteractionEnabled = false;
    }
}
extension EarningsYieldViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        print("you tapped me!")
    }
}
extension EarningsYieldViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return defaults.stringArray(forKey: "earnings_yield_keys")?.count ?? 2
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "TwoLabelCell", for: indexPath) as! TwoLabelCell
        let tickers = (defaults.stringArray(forKey: "earnings_yield_keys")) ?? ["Please Wait", "Loading"]
        let numbers = (defaults.array(forKey: "earnings_yield_values")  as? [Float]) ?? [0.0, 0.0]
        cell.label1.text = tickers[indexPath.row];
        cell.label2.text = String(numbers[indexPath.row]);
        return cell
    }
}