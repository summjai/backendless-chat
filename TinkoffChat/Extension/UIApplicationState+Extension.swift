//
//  UIApplicationState+Extension.swift
//  TinkoffChat
//
//  Created by Anastasia Chuikina on 23/02/2018.
//  Copyright © 2018 Anastasia Chuikina. All rights reserved.
//

import UIKit

extension UIApplicationState: CustomStringConvertible {
    public var description: String {
        switch self {
        case .active:
            return "Active"
        case .inactive:
            return "Inactive"
        case .background:
            return "Background"
        }
    }
}
