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
class ReturnInfoViewController: UIViewController {
    let defaults = UserDefaults.standard
    @IBOutlet weak var return_stock_label: UITextField!
    @IBOutlet weak var return_stock_info: UITextView!
    override func viewDidLoad() {
        if(defaults.string(forKey: "DisplayMode") == "Light") {
            return_stock_label.textColor = UIColor.black
            return_stock_label.backgroundColor = UIColor.white
            return_stock_info.textColor = UIColor.black
            return_stock_info.backgroundColor = UIColor.white
        } else if(defaults.string(forKey: "DisplayMode") == "Dark"){
            return_stock_label.textColor = UIColor.white
            return_stock_label.backgroundColor = UIColor.black
            return_stock_info.textColor = UIColor.white
            return_stock_info.backgroundColor = UIColor.black
        }
        let stored_value = defaults.string(forKey: "current_ticker")!
        let db = Firestore.firestore();
        let docRef = db.collection("stock_info").document(stored_value)
        docRef.getDocument { (document, error) in
            if let document = document, document.exists {
                let dataDescription = document.data().map(String.init(describing:)) ?? "nil"
                self.return_stock_info.text = dataDescription.replacingOccurrences(of: ", ", with: "\n\n").replacingOccurrences(of: "\"", with: "").replacingOccurrences(of: "[", with: "").replacingOccurrences(of: "]", with: "")
            } else {
                print("Document does not exist")
            }
        }
        return_stock_label.text = stored_value
    }
    override func viewDidAppear(_ animated: Bool) {

    }
}
