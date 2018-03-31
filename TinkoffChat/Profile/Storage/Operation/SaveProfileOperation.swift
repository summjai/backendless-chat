//
//  SaveProfileOperation.swift
//  TinkoffChat
//
//  Created by Anastasia Chuikina on 31/03/2018.
//  Copyright © 2018 Anastasia Chuikina. All rights reserved.
//

import Foundation

final class SaveProfileOperation: Operation {
    private let profile: Profile
    private let completionHandler: (Bool) -> Void
    private let profileStorage: IProfileStorage
    
    init(userProfile: Profile,
         profileStorage: IProfileStorage,
         completionHandler: @escaping (Bool) -> Void) {
        self.profile = userProfile
        self.profileStorage = profileStorage
        self.completionHandler = completionHandler
    }
    
    override func main() {
        if isCancelled {
            return
        }
        profileStorage.save(profile: profile) { status in
            self.completionHandler(status)
        }
    }
}
