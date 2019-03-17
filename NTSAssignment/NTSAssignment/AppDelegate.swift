//
//  AppDelegate.swift
//  NTSAssignment
//
//  Created by Prajwal S on 15/03/19.
//  Copyright © 2019 Prajwal S. All rights reserved.
//

import UIKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {
    
    var window: UIWindow?
    
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        
        window = UIWindow(frame: UIScreen.main.bounds)
        if let viewController = ListBuilder().build() {
            window?.rootViewController = UINavigationController(rootViewController: viewController)
            window?.makeKeyAndVisible()
        } else {
            assertionFailure("Couldn't load Listview")
        }
        
        return true
    }
    
}

