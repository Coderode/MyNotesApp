//
//  AppDelegate.swift
//  RealmDemo
//
//  Created by Sandeep on 13/06/21.
//

import UIKit

@main
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        // Override point for customization after application launch.
        return true
    }
    static func shared() -> AppDelegate{
        return UIApplication.shared.delegate as! AppDelegate
    }
}

