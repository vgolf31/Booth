//
//  PrivacyViewController.swift
//  Booth
//
//  Created by Veer M on 8/29/22.
//  Copyright © 2022 Veertegh Minhas. All rights reserved.
//

import UIKit

class PrivacyViewController: UIViewController {

    @IBOutlet var background: UIView!
    @IBOutlet weak var text_view: UITextView!
    @IBOutlet weak var title_label: UILabel!
    let defaults = UserDefaults.standard
    override func viewDidLoad() {
        super.viewDidLoad()
        if(defaults.string(forKey: "DisplayMode") == "Light") {
            background.backgroundColor = UIColor.white
            text_view.textColor = UIColor.black
            text_view.backgroundColor = UIColor.white
            title_label.textColor = UIColor.black
        } else if(defaults.string(forKey: "DisplayMode") == "Dark"){
            background.backgroundColor = UIColor.black
            text_view.textColor = UIColor.white
            text_view.backgroundColor = UIColor.black
            title_label.textColor = UIColor.white
            
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
