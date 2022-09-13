//
//  SignInViewController.swift
//  Booth
//
//  Created by Veer M on 9/4/22.
//  Copyright © 2022 Veertegh Minhas. All rights reserved.
//

import UIKit
import FirebaseAuth
class SignInViewController: UIViewController {
    var handle: AnyObject?
    @IBOutlet weak var username_field: UITextField!
    @IBOutlet weak var password_field: UITextField!
    @IBOutlet weak var sign_in_button: UIButton!
    @IBOutlet weak var error_label: UILabel!
    @IBOutlet var background: UIView!
    @IBOutlet weak var username_label: UILabel!
    @IBOutlet weak var password_label: UILabel!
    @IBOutlet weak var title_label: UILabel!
    let defaults = UserDefaults.standard
    override func viewDidLoad() {
        super.viewDidLoad()
        if(defaults.string(forKey: "DisplayMode") == "Light") {
            background.backgroundColor = UIColor.white
            username_label.textColor = UIColor.black
            password_label.textColor = UIColor.black
            title_label.textColor = UIColor.black
        } else if(defaults.string(forKey: "DisplayMode") == "Dark"){
            background.backgroundColor = UIColor.black
            username_label.textColor = UIColor.white
            password_label.textColor = UIColor.white
            title_label.textColor = UIColor.white
        }
        error_label.layer.opacity = 0
    }
    override func viewWillAppear(_ animated: Bool) {
        if(defaults.bool(forKey: "signedIn") == true){
            if let vc = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "GalleryViewController") as? GalleryViewController
            {
                present(vc, animated: false, completion: nil)
            }
        }
        handle = Auth.auth().addStateDidChangeListener { auth, user in
        }
    }
    override func viewWillDisappear(_ animated: Bool) {
        Auth.auth().removeStateDidChangeListener(handle! as! NSObjectProtocol)
    }
    @IBAction func sign_in_clicked(_ sender: Any) {
        if(username_field.text != nil && password_field != nil){
            Auth.auth().signIn(withEmail: username_field.text!, password: password_field.text!)
            { [weak self] authResult, error in
                guard self != nil
                else {
                    return
                }
                if let error = error {
                    print(error.localizedDescription)
                    self!.error_label.layer.opacity = 1
                    self!.error_label.text = "Error: Email or Password is incorrect"
                } else {
                    print("signed in")
                    self!.defaults.set(true, forKey: "signedIn")
                    if let vc = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "GalleryViewController") as? GalleryViewController
                    {
                        self!.present(vc, animated: false, completion: nil)
                    }
                }
            }
        }
    }

}
