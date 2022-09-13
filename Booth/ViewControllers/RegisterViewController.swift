//
//  RegisterViewController.swift
//  Booth
//
//  Created by Veer M on 9/4/22.
//  Copyright © 2022 Veertegh Minhas. All rights reserved.
//

import UIKit
import FirebaseAuth

class RegisterViewController: UIViewController {
    var handle: AnyObject?
    @IBOutlet weak var username_field: UITextField!
    @IBOutlet weak var first_password_field: UITextField!
    @IBOutlet weak var second_password_field: UITextField!
    @IBOutlet weak var error_label: UILabel!
    @IBOutlet weak var register_button: UIButton!
    let defaults = UserDefaults.standard
    @IBOutlet var background: UIView!
    @IBOutlet weak var title_label: UILabel!
    @IBOutlet weak var username_label: UILabel!
    @IBOutlet weak var password1_label: UILabel!
    @IBOutlet weak var password2_label: UILabel!
    override func viewDidLoad() {
        super.viewDidLoad()
        if(defaults.bool(forKey: "signedIn") == true){
            if let vc = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "GalleryViewController") as? GalleryViewController
            {
                present(vc, animated: false, completion: nil)
            }
        }
        if(defaults.string(forKey: "DisplayMode") == "Light") {
            background.backgroundColor = UIColor.white
            username_label.textColor = UIColor.black
            password1_label.textColor = UIColor.black
            password2_label.textColor = UIColor.black
            title_label.textColor = UIColor.black
        } else if(defaults.string(forKey: "DisplayMode") == "Dark"){
            background.backgroundColor = UIColor.black
            username_label.textColor = UIColor.white
            password1_label.textColor = UIColor.white
            password2_label.textColor = UIColor.white
            title_label.textColor = UIColor.white
        }
        error_label.layer.opacity = 0
    }
    override func viewWillAppear(_ animated: Bool) {
        handle = Auth.auth().addStateDidChangeListener { auth, user in
        }
    }
    override func viewWillDisappear(_ animated: Bool) {
        Auth.auth().removeStateDidChangeListener(handle! as! NSObjectProtocol)
    }
    @IBAction func register_button_pressed(_ sender: Any) {
        if(username_field.text == nil || first_password_field.text == nil || second_password_field.text == nil){
            error_label.layer.opacity = 1
            error_label.text = "Error: Please fill all fields"
        }
        else if(username_field.text!.contains("@") == false){
            error_label.layer.opacity = 1
            error_label.text = "Error: Email not valid"
        }
        else if(first_password_field.text != second_password_field.text){
            error_label.layer.opacity = 1
            error_label.text = "Error: Passwords do not match"
        }else{
            Auth.auth().createUser(withEmail: username_field.text!, password: first_password_field.text!) { authResult, error in
                if let error = error {
                    print(error.localizedDescription)
                    self.error_label.layer.opacity = 1
                    self.error_label.text = "Error: email doesn't exist or your password is too weak"
                } else {
                    print("signed up")
                    self.defaults.set(true, forKey: "signedIn")
                    if let vc = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "GalleryViewController") as? GalleryViewController
                    {
                        self.present(vc, animated: false, completion: nil)
                    }
                }
            }
        }
    }
    


}
