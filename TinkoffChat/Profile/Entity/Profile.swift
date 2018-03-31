//
//  Profile.swift
//  TinkoffChat
//
//  Created by Anastasia Chuikina on 29/03/2018.
//  Copyright © 2018 Anastasia Chuikina. All rights reserved.
//

import Foundation

final class Profile {
    var about: String?
    var photo: UIImage?
    var userName: String?
    
    init(about: String? = nil,
         photo: UIImage? = nil,
         userName: String? = nil) {
        self.about = about
        self.photo = photo
        self.userName = userName
    }
}

// MARK: Equatable
extension Profile: Equatable {
    //swiftlint:disable operator_whitespace
    static func ==(lhs: Profile, rhs: Profile) -> Bool {
        return lhs.about == rhs.about && lhs.photo == rhs.photo && lhs.userName == rhs.userName
    }
}
