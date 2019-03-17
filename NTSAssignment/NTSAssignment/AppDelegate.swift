//
//  AppDelegate.swift
//  NTSAssignment
//
//  Created by Prajwal S on 15/03/19.
//  Copyright © 2019 Prajwal S. All rights reserved.
//

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
        let viewController = ListBuilder().build()
        window?.rootViewController = UINavigationController(rootViewController: viewController)
        window?.makeKeyAndVisible()

        return true
    }
    
}

