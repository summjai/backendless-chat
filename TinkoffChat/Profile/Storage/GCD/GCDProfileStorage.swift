//
//  GCDProfileStorage.swift
//  TinkoffChat
//
//  Created by Anastasia Chuikina on 30/03/2018.
//  Copyright © 2018 Anastasia Chuikina. All rights reserved.
//

import Foundation

final class GCDProfileStorage: IProfileStorage {
    
    // MARK: Private Properties
    private let profileStorage = ProfileFileStorage()
    
    // MARK: Public Methods
    func save(profile: Profile, completionHandler: @escaping (Bool) -> Void) {
        DispatchQueue.global().async {
            self.profileStorage.save(profile: profile) { completion in
                completionHandler(completion)
            }
        }
    }
    
    func load(completionHandler: @escaping (Profile?) -> Void) {
        self.profileStorage.load { profile in
            completionHandler(profile)
        }
    }
}
