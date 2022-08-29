//
//  SettingsViewController.swift
//  Booth
//
//  Created by Veer M on 8/28/22.
//  Copyright © 2022 Veertegh Minhas. All rights reserved.
//

import UIKit

class SettingsViewController: UIViewController {

    let defaults = UserDefaults.standard

    @IBOutlet var background: UIView!
    
    @IBOutlet weak var settings_label: UILabel!
    @IBOutlet weak var DisplayMode: UISegmentedControl!
    @IBOutlet weak var peMode: UISegmentedControl!
    @IBOutlet weak var valuationMode: UISegmentedControl!
    override func viewDidLoad() {
        super.viewDidLoad()
        updateDisplay()
        updatePE()
        updateVal()
        // Do any additional setup after loading the view.
    }
    
    @IBAction func DisplayModeChanged(_ sender: Any) {
        if(DisplayMode.selectedSegmentIndex == 1){
            self.defaults.set("Light", forKey: "DisplayMode")
        }
        else if(DisplayMode.selectedSegmentIndex == 0){
            self.defaults.set("Dark", forKey: "DisplayMode")
        }
        updateDisplay()
    }
    func updateDisplay(){
        if(defaults.string(forKey: "DisplayMode") == "Light") {
            DisplayMode.selectedSegmentIndex = 1
            background.backgroundColor = UIColor.white
            settings_label.textColor = UIColor.black
        } else if(defaults.string(forKey: "DisplayMode") == "Dark"){
            DisplayMode.selectedSegmentIndex = 0
            background.backgroundColor = UIColor.black
            settings_label.textColor = UIColor.white
        }
    }
    @IBAction func peModeChanged(_ sender: Any) {
        if(peMode.selectedSegmentIndex == 0){
            self.defaults.set(0, forKey: "PE")
        }
        else if(peMode.selectedSegmentIndex == 1){
            self.defaults.set(1, forKey: "PE")
        }
        else if(peMode.selectedSegmentIndex == 2){
            self.defaults.set(2, forKey: "PE")
        }
        updatePE()
    }
    func updatePE(){
        if(defaults.integer(forKey: "PE") == 0) {
            peMode.selectedSegmentIndex = 0
        } else if(defaults.integer(forKey: "PE") == 1){
            peMode.selectedSegmentIndex = 1
        }else if(defaults.integer(forKey: "PE") == 2){
            peMode.selectedSegmentIndex = 2
        }
    }
    @IBAction func valuationModeChanged(_ sender: Any) {
        if(valuationMode.selectedSegmentIndex == 0){
            self.defaults.set(0, forKey: "VAL")
        }
        else if(valuationMode.selectedSegmentIndex == 1){
            self.defaults.set(1, forKey: "VAL")
        }
        else if(valuationMode.selectedSegmentIndex == 2){
            self.defaults.set(2, forKey: "VAL")
        }
        updateVal()
    }
    func updateVal(){
        if(defaults.integer(forKey: "VAL") == 0) {
            valuationMode.selectedSegmentIndex = 0
        } else if(defaults.integer(forKey: "VAL") == 1){
            valuationMode.selectedSegmentIndex = 1
        }else if(defaults.integer(forKey: "VAL") == 2){
            valuationMode.selectedSegmentIndex = 2
        }
    }
    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
