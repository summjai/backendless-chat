//
//  LoadProfileOperation.swift
//  TinkoffChat
//
//  Created by Anastasia Chuikina on 31/03/2018.
//  Copyright © 2018 Anastasia Chuikina. All rights reserved.
//

import Foundation

final class LoadProfileOperation: Operation {
    private let profileStorage: IProfileStorage
    private let completionHandler: (Profile?) -> Void
    
    init(profileStorage: IProfileStorage,
         completionHandler: @escaping (Profile?) -> Void) {
        self.profileStorage = profileStorage
        self.completionHandler = completionHandler
    }
    
    override func main() {
        if isCancelled {
            return
        }
        profileStorage.load { profile in
            self.completionHandler(profile)
        }
    }
}
