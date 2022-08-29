//
//  MenuViewController.swift
//  Booth
//
//  Created by Veer M on 8/28/22.
//  Copyright © 2022 Veertegh Minhas. All rights reserved.
//

import UIKit

class MenuViewController: UIViewController {
    let defaults = UserDefaults.standard
    
    @IBOutlet weak var title_label: UILabel!
    @IBOutlet var background: UIView!
    @IBOutlet weak var stock_listings_button: UIButton!
    @IBOutlet weak var settings_button: UIButton!
    @IBOutlet weak var tos_button: UIButton!
    override func viewDidLoad() {
        super.viewDidLoad()
        self.defaults.set(true, forKey: "didPass")
        if(defaults.string(forKey: "DisplayMode") == "Light") {
            title_label.textColor = UIColor.black
            background.backgroundColor = UIColor.white
            stock_listings_button.tintColor = UIColor.black
            settings_button.tintColor = UIColor.black
            tos_button.tintColor = UIColor.black
        } else if(defaults.string(forKey: "DisplayMode") == "Dark"){
            title_label.textColor = UIColor.white
            background.backgroundColor = UIColor.black
            stock_listings_button.tintColor = UIColor.white
            settings_button.tintColor = UIColor.white
            tos_button.tintColor = UIColor.white
        }
        // Do any additional setup after loading the view.
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
