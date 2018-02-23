//
//  AppDelegate.swift
//  TinkoffChat
//
//  Created by Anastasia Chuikina on 21/02/2018.
//  Copyright © 2018 Anastasia Chuikina. All rights reserved.
//

import UIKit

@UIApplicationMain
final class AppDelegate: UIResponder, UIApplicationDelegate {
    
    var window: UIWindow?
    
    func application(_ application: UIApplication,
                     didFinishLaunchingWithOptions launchOptions: [UIApplicationLaunchOptionsKey: Any]?) -> Bool {
        
        window = UIWindow(frame: UIScreen.main.bounds)
        
        if let _window = window {
            _window.rootViewController = ViewController()
            _window.makeKeyAndVisible()
        }
        printTransitionInfo()
        return true
    }
    
    func applicationWillResignActive(_ application: UIApplication) {
        printTransitionInfo()
    }
    
    func applicationDidEnterBackground(_ application: UIApplication) {
        printTransitionInfo()
    }
    
    func applicationWillEnterForeground(_ application: UIApplication) {
        printTransitionInfo()
    }
    
    func applicationDidBecomeActive(_ application: UIApplication) {
        printTransitionInfo()
    }
    
    func applicationWillTerminate(_ application: UIApplication) {
        printTransitionInfo()
    }
    
    private func printTransitionInfo(method: String = #function) {
        let fromState: String
        let toState: String
        
        let stateDescription = String(describing: UIApplication.shared.applicationState)
        
        switch method {
        case "application(_:didFinishLaunchingWithOptions:)":
            fromState = "Background"
            toState = stateDescription
        case "applicationWillResignActive":
            fromState = stateDescription
            toState = "Background"
        case "applicationDidEnterBackground":
            fromState = "Active"
            toState = stateDescription
        case "applicationWillEnterForeground":
            fromState = stateDescription
            toState = "Active"
        case "applicationDidBecomeActive":
            fromState = "Background"
            toState = stateDescription
        case "applicationWillTerminate":
            fromState = stateDescription
            toState = "Not running"
        default:
            fromState = "Unknown"
            toState = "Unknown"
        }
        
        print("Application moved from \(fromState) to \(toState): \(method)")
    }
}
