//
//  ChatPresentationModel.swift
//  TinkoffChat
//
//  Created by Anastasia Chuikina on 13/03/2018.
//  Copyright © 2018 Anastasia Chuikina. All rights reserved.
//

import UIKit

protocol ChatPresentationModelProtocol {
    var userName: String { get }
    func getNumberOfRows() -> Int
    weak var delegate: ChatPresentationModelDelegate? { get set }
    func getMessage(at indexPath: IndexPath) -> Message
}

protocol ChatPresentationModelDelegate: class {
    var tableView: UITableView! { get set }
}

final class ChatPresentationModel: ChatPresentationModelProtocol {
    
    // MARK: - Public Properties
    weak var delegate: ChatPresentationModelDelegate?
    var userName: String

    // MARK: - Private Properties
    private var messages = [Message]()
    
    // MARK: - Initialization
    init(userName: String) {
        self.userName = userName
        generateFakeMessages()
    }
    
    func getNumberOfRows() -> Int {
        return messages.count
    }
    
    func getMessage(at indexPath: IndexPath) -> Message {
        return messages[indexPath.row]
    }
    
    // MARK: - Private Methods
    
    private func generateFakeMessages() {
        let lenghts = [1, 30, 300]
        for length in lenghts {
            messages.append(Message(text: randomString(length: length), date: Date(), messageType: .incoming))
            messages.append(Message(text: randomString(length: length), date: Date(), messageType: .outgoing))
        }
    }
    
    private func randomString(length: Int) -> String {
        
        let letters: NSString = "abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789"
        let len = UInt32(letters.length)
        
        var randomString = ""
        
        for _ in 0 ..< length {
            let rand = arc4random_uniform(len)
            var nextChar = letters.character(at: Int(rand))
            randomString += NSString(characters: &nextChar, length: 1) as String
        }
        
        return randomString
    }
}
