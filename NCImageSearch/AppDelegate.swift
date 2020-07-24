//
//  AppDelegate.swift
//  NCImageSearch
//
//  Created by Nitin Chadha on 11/06/20.
//  Copyright © 2020 Nitin Chadha. All rights reserved.
//

import UIKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {
    
    var window: UIWindow?

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        // Override point for customization after application launch.
        
        window = UIWindow(frame: UIScreen.main.bounds)
        window!.rootViewController = ApplicationRouter.shared.initializeWorkflow()
        window!.makeKeyAndVisible()
        
        return true
    }

    


}

