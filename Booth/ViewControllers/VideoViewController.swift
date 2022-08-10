//
//  VideoViewController.swift
//  Booth
//
//  Created by Veer M on 8/4/22.
//  Copyright © 2022 Veertegh Minhas. All rights reserved.
//

import UIKit
import WebKit
class VideoViewController: UIViewController {

    @IBOutlet weak var videoWebView: WKWebView!
    
    @IBOutlet weak var continue_button: UIButton!
    override func viewDidLoad() {
        super.viewDidLoad()
        getVideo(videoCode: "fzig7KJFuNU")
        // Do any additional setup after loading the view.
    }
    func getVideo(videoCode:String){
        let url = URL(string: "https://www.youtube.com/embed/\(videoCode)")
        videoWebView.load(URLRequest(url: url!))
    }
    @IBAction func continueButtonPressed(_ sender: Any) {

        let initialViewController = storyboard?.instantiateViewController(withIdentifier: "EarningsYieldViewController") as? EarningsYieldViewController
        view.window?.rootViewController = initialViewController
        view.window?.makeKeyAndVisible()
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
