//
//  OperationProfileStorage.swift
//  TinkoffChat
//
//  Created by Anastasia Chuikina on 31/03/2018.
//  Copyright © 2018 Anastasia Chuikina. All rights reserved.
//

import Foundation

final class OperationProfileStorage: IProfileStorage {
    private let queue = OperationQueue()
    private let profileStorage: IProfileStorage = ProfileFileStorage()
    
    func save(profile: Profile,
              completionHandler: @escaping (Bool) -> Void) {
        let operation = SaveProfileOperation(userProfile: profile,
                                             profileStorage: profileStorage,
                                             completionHandler: completionHandler)
        queue.addOperation(operation)
    }
    
    func load(completionHandler: @escaping (Profile?) -> Void) {
        let operation = LoadProfileOperation(profileStorage: profileStorage,
                                             completionHandler: completionHandler)
        queue.addOperation(operation)
    }
}
