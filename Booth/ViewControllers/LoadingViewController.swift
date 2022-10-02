//
//  LoadingViewController.swift
//  Booth
//
//  Created by Veer M on 9/17/22.
//  Copyright © 2022 Veertegh Minhas. All rights reserved.
//

import UIKit

class LoadingViewController: UIViewController {
    let defaults = UserDefaults.standard
    @IBOutlet weak var loading_button: UIButton!
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }
    override func viewWillAppear(_ animated: Bool) {
        DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
            if(self.defaults.bool(forKey: "didPass") == true){
                if let vc = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "MenuViewController") as? MenuViewController
                {
                    self.present(vc, animated: false, completion: nil)
                }
            } else{
                if let vc = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "OpeningViewController") as? OpeningViewController
                {
                    self.present(vc, animated: false, completion: nil)
                }
            }
        }
    }
    
    @IBAction func loadingButtonPressed(_ sender: Any) {
        if(self.defaults.bool(forKey: "didPass") == true){
            if let vc = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "MenuViewController") as? MenuViewController
            {
                self.present(vc, animated: false, completion: nil)
            }
        } else{
            if let vc = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "OpeningViewController") as? OpeningViewController
            {
                self.present(vc, animated: false, completion: nil)
            }
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
