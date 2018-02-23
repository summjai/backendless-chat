//
//  AppDelegate.swift
//  TinkoffChat
//
//  Created by Anastasia Chuikina on 21/02/2018.
//  Copyright © 2018 Anastasia Chuikina. All rights reserved.
//

import UIKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?

    let stateForm = "Application moved from %@ to %@:"
    
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplicationLaunchOptionsKey: Any]?) -> Bool {
    
        window = UIWindow(frame: UIScreen.main.bounds)
        
        if let _window = window {
            _window.rootViewController = ViewController()
            _window.makeKeyAndVisible()

            print(String(format: stateForm, "Not running", "Background"), #function, "\n")
        
        // print("Application moved from Not running to Background: \(#function)" )
            
        }
        
        return true
    }
   
    func applicationWillResignActive(_ application: UIApplication) {
        
         print(String(format: stateForm, "Active", "Background"), #function, "\n")
        
        // print("Application moved from Active to Background:",#function)
    }

    func applicationDidEnterBackground(_ application: UIApplication) {
        
         print(String(format: stateForm, "Active", "Background"), #function, "\n")
        
        // print("Application moved from Active to Background:",#function)
    }

    func applicationWillEnterForeground(_ application: UIApplication) {
        
         print(String(format: stateForm, "Background", "Active"), #function, "\n")
        
         //print("Application moved from Background to Active:",#function)
    }

    func applicationDidBecomeActive(_ application: UIApplication) {
        
         print(String(format: stateForm, "Background", "Active"), #function, "\n")
        
        //print("Application moved from Background to Active:",#function)
    }

    func applicationWillTerminate(_ application: UIApplication) {
        
         print(String(format: stateForm, "Background", "Not running"), #function, "\n")
        
        //print("Application moved from Background to Not running:",#function)
    }
    

    func willFinishLaunchingWithOptions(_ application: UIApplication) {
        
         print(String(format: stateForm, "Background", "Not running"), #function, "\n")
        
        //print("Application moved from Background to Not running:",#function)
    }
}

