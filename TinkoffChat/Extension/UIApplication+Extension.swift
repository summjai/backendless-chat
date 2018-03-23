//
//  UIApplication+Extension.swift
//  TinkoffChat
//
//  Created by Anastasia Chuikina on 23/03/2018.
//  Copyright © 2018 Anastasia Chuikina. All rights reserved.
//

import UIKit

extension UIApplication {
    
    private enum Constants {
        static let colorThemeDefaultsKey = "colorTheme"
    }
    
    static func setColorTheme(color: UIColor) {
        UINavigationBar.appearance().tintColor = color
        UINavigationBar.appearance().backgroundColor = color
    }
    
    static func loadColorTheme() {
        let defaults = UserDefaults()
        guard
            let data = defaults.data(forKey: Constants.colorThemeDefaultsKey),
            let color = NSKeyedUnarchiver.unarchiveObject(with: data) as? UIColor else { return }
        setColorTheme(color: color)
    }
    
    static func saveColorTheme(color: UIColor) {
        setColorTheme(color: color)
        let defaults = UserDefaults()
        defaults.set(NSKeyedArchiver.archivedData(withRootObject: color), forKey: Constants.colorThemeDefaultsKey)
    }
}
