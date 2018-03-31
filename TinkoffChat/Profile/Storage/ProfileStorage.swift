//
//  ProfileStorage.swift
//  TinkoffChat
//
//  Created by Anastasia Chuikina on 29/03/2018.
//  Copyright © 2018 Anastasia Chuikina. All rights reserved.
//

import Foundation

protocol IProfileStorage {
    func save(profile: Profile, completionHandler: @escaping (_ success: Bool) -> Void )
    func load(completionHandler: @escaping (_ profile: Profile?) -> Void)
}

final class ProfileFileStorage: IProfileStorage {
    
    private enum Constants {
        static let userNameKey = "name"
        static let infoKey = "info"
        static let fileName = "Profile"
        static let userPhotoKey = "userPhoto"
        static var fileManager = FileManager.default
        static var filePath: URL {
            return fileManager.urls(for: .documentDirectory,
                                    in: .userDomainMask).first!.appendingPathComponent(fileName)
        }
    }
    
    func save(profile: Profile, completionHandler: @escaping (_ success: Bool) -> Void) {
        let dataDictionary = serialize(profile: profile)
        let data = NSKeyedArchiver.archivedData(withRootObject: dataDictionary)
        
        let isRandomErrorHappened = Int(arc4random_uniform(2))
        if isRandomErrorHappened == 0 {
            completionHandler(false)
            return
        }
        
        do {
            try data.write(to: Constants.filePath)
            completionHandler(true)
        } catch {
            print("Error writing data \(error)")
            completionHandler(false)
        }
    }
    
    func load(completionHandler: @escaping (_ profile: Profile?) -> Void) {
        guard Constants.fileManager.fileExists(atPath: Constants.filePath.path) else {
            completionHandler(nil)
            return
        }
        do {
            let data = try Data(contentsOf: Constants.filePath)
            let profile = try deserialize(from: data)
            completionHandler(profile)
            return
        } catch {
            print("Error loading data from file \(error)")
            completionHandler(nil)
        }
        completionHandler(nil)
    }
    
    private func serialize(profile: Profile) -> [String: Any?] {
        
        var userPhotoData: Data?
        if let userPhoto = profile.photo {
            userPhotoData = NSKeyedArchiver.archivedData(withRootObject: userPhoto)
        }
        
        return [Constants.userPhotoKey: userPhotoData,
                Constants.userNameKey: profile.userName,
                Constants.infoKey: profile.about]
    }
    
    private func deserialize(from data: Data) throws -> Profile? {
        guard let dictionary = NSKeyedUnarchiver.unarchiveObject(with: data) as? [String: Any] else { return nil }
        let name = dictionary[Constants.userNameKey] as? String
        let userInfo = dictionary[Constants.infoKey] as? String
        
        var userPhoto: UIImage?
        
        if let userPhotoData = dictionary[Constants.userPhotoKey] as? Data {
            userPhoto = NSKeyedUnarchiver.unarchiveObject(with: userPhotoData) as? UIImage
        }

        return Profile(about: userInfo, photo: userPhoto, userName: name)
    }
}
