//
//  UIFont+Extension.swift
//  TinkoffChat
//
//  Created by Anastasia Chuikina on 12/03/2018.
//  Copyright © 2018 Anastasia Chuikina. All rights reserved.
//

import UIKit

extension UIFont {
    static func normalFont() -> UIFont {
        return UIFont.systemFont(ofSize: 17.0, weight: .regular)
    }
    
    static func italicFont() -> UIFont {
        guard let font = UIFont(name: "HelveticaNeue-LightItalic", size: 17) else {
            return UIFont.normalFont()
        }
        return font
    }
    
    static func unreadMessage() -> UIFont {
        return UIFont.boldSystemFont(ofSize: 20.0)
    }
}
