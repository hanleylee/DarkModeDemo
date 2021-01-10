//
//  AppDelegate.swift
//  HLTest
//
//  Created by Hanley Lee on 2020/05/31.
//  Copyright © 2020 Hanley Lee. All rights reserved.
//

import UIKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {

        window = UIWindow(frame: UIScreen.main.bounds)

        // 如果是 iOS
        if #available(iOS 13.0, *) {
            window?.overrideUserInterfaceStyle = Tools.style.mode
        }

        window?.rootViewController = Tools.getTabVC(withIndex: 0)
        window?.makeKeyAndVisible()

        return true
    }

}

