//
//  AppDelegate.swift
//  Booth
//
//  Created by Veer M on 4/6/20.
//  Copyright © 2020 Veertegh Minhas. All rights reserved.
//

import UIKit
import Firebase
@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?
    let defaults = UserDefaults.standard
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        // Override point for customization after application launch.
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        if(defaults.bool(forKey: "didPass") == true){
            guard let initialViewController = storyboard.instantiateViewController(withIdentifier: "MenuViewController") as? MenuViewController
            else {
                fatalError("Unable to instantiate an ViewController from the storyboard")
            }
            self.window?.rootViewController = initialViewController
            self.window?.makeKeyAndVisible()
        } else{
            guard let initialViewController = storyboard.instantiateViewController(withIdentifier: "OpeningViewController") as? OpeningViewController
            else {
                fatalError("Unable to instantiate an ViewController from the storyboard")
            }
            self.window?.rootViewController = initialViewController
            self.window?.makeKeyAndVisible()
        }
        FirebaseApp.configure()
        return true
    }

}

