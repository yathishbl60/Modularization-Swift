//
//  AppDelegate.swift
//  NTSAssignment
//
//  Created by Prajwal S on 15/03/19.
//  Copyright © 2019 Prajwal S. All rights reserved.
//

import ListModule
import SDWebImage
import UIKit

@UIApplicationMain
final class AppDelegate: UIResponder, UIApplicationDelegate {
    
    private var window: UIWindow?
    
    func application(_ application: UIApplication,
                     didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        // Clear cache to show demo of animation at first time load
        SDImageCache.shared().clearMemory()
        SDImageCache.shared().clearDisk()

        window = UIWindow(frame: UIScreen.main.bounds)
        window?.tintColor = #colorLiteral(red: 0.9215686275, green: 0.1960784314, blue: 0.137254902, alpha: 1)

        let viewController = ListBuilder().build()
        window?.rootViewController = UINavigationController(rootViewController: viewController)
        window?.makeKeyAndVisible()

        return true
    }
    
}

