//
//  KeyboardManager.swift
//  TinkoffChat
//
//  Created by Anastasia Chuikina on 27/03/2018.
//  Copyright © 2018 Anastasia Chuikina. All rights reserved.
//

import IQKeyboardManagerSwift

// MARK: -
@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {
    
    var window: UIWindow?
    
    func application(application: UIApplication,
                     didFinishLaunchingWithOptions launchOptions: [NSObject: AnyObject]?) -> Bool {
        
        IQKeyboardManager.sharedManager().enable = true
        
        return true
    }
}
