//
//  AppDelegate.swift
//  FirstRxSwift
//
//  Created by Tolga İskender on 3.10.2020.
//  Copyright © 2020 Tolga İskender. All rights reserved.
//

import UIKit
import CoreData

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {
    
    var window: UIWindow?
    
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        startVC()
        return true
    }
    fileprivate func startVC(){
        let vc = HomeVC.init(nibName: "HomeVC", bundle: nil)
        let navController = UINavigationController(rootViewController: vc)
        window = UIWindow(frame: UIScreen.main.bounds)
        window?.rootViewController = navController
        window?.makeKeyAndVisible()
    }
}

