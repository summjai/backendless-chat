//
//  Chat.swift
//  TinkoffChat
//
//  Created by Anastasia Chuikina on 11/03/2018.
//  Copyright © 2018 Anastasia Chuikina. All rights reserved.
//

import UIKit

enum ChatStatus {
    case online
    case offline
}

final class Chat {
    let userName: String
    var messages = [Message]()
    var chatStatus: ChatStatus = .offline
    var hasUnreadMessages: Bool = true
    
    var lastMessage: Message? {
        return messages.last
    }
    
    init(name: String) {
        self.userName = name
    }
    
    convenience init(name: String,
                     chatStatus: ChatStatus = .offline,
                     hasUnreadMessages: Bool = true) {
        self.init(name: name)
        self.chatStatus = chatStatus
        self.hasUnreadMessages = hasUnreadMessages
    }
    
    public func addMessage(message: Message) {
        messages.append(message)
    }
}
extension Chat {
    //swiftlint:disable function_body_length
    static func generateFakeChats() -> (online: [Chat], offline: [Chat]) {
        var offline = [Chat]()
        var online = [Chat]()
        
        var messages = [Message]()
        
        messages.append(Message(text: "Chat message 1",
                               date: Date(),
                               messageType: .incoming))
        messages.append(Message(text: "Message 2 hello",
                               date: Date(),
                               messageType: .outgoing))
        
        if let date = Calendar.current.date(byAdding: .day, value: -2, to: Date()) {
            messages.append(Message(text: "Bye i don wanna talk",
                                    date: date,
                                    messageType: .incoming))
            }

        let chat1 = Chat(name: "Johny", chatStatus: .online)
        let chat2 = Chat(name: "Alice", chatStatus: .online, hasUnreadMessages: false)
        let chat3 = Chat(name: "Bob", chatStatus: .online)
        let chat4 = Chat(name: "Stranger", chatStatus: .online, hasUnreadMessages: false)
        let chat5 = Chat(name: "Andrew", chatStatus: .online)
        
        chat1.addMessage(message: messages[0])
        chat2.addMessage(message: messages[1])
        chat3.addMessage(message: messages[2])
        chat5.addMessage(message: messages[0])
        
        let chat6 = Chat(name: "Johny", chatStatus: .offline)
        let chat7 = Chat(name: "Alice", chatStatus: .offline, hasUnreadMessages: false)
        let chat8 = Chat(name: "Bob", chatStatus: .offline)
        let chat9 = Chat(name: "Stranger", hasUnreadMessages: false)
        let chat10 = Chat(name: "Andrew", chatStatus: .offline)
        
        chat6.addMessage(message: messages[0])
        chat7.addMessage(message: messages[1])
        chat8.addMessage(message: messages[2])
        chat10.addMessage(message: messages[0])
        
        online.append(chat1)
        online.append(chat2)
        online.append(chat3)
        online.append(chat4)
        online.append(chat5)

        offline.append(chat6)
        offline.append(chat7)
        offline.append(chat8)
        offline.append(chat9)
        offline.append(chat10)
        
        return (online: online, offline: offline)
    }
}

extension Chat {
    private enum CellState {
        case hasMessage
        case noMessage
    }
    
    public func configure(cell: ConversationTableViewCell) {
        
//         let state: CellState = lastMessage != nil ? .hasMessage : .noMessage
//         configureCellForMessage(cell: cell,
//                                 state: state)

        cell.online = chatStatus == .online
        cell.hasUnreadMessages = hasUnreadMessages
        cell.name = userName
        cell.message = lastMessage?.text ?? "No messages yet"
        cell.date = lastMessage?.dateFormatted()
    }
    
//    private func configureCellForMessage(cell: ConversationTableViewCell,
//                                         state: CellState) {
//        switch state {
//        case .hasMessage:
//            cell.lastMessageLabel.font = UIFont.normalFont()
//        case .noMessage:
//            cell.lastMessageLabel.font = UIFont.italicFont()
//        }
//
//        if hasUnreadMessages {
//            cell.lastMessageLabel.font = UIFont.unreadMessage()
//            cell.lastMessageLabel.textColor = UIColor.black
//        } else {
//            cell.lastMessageLabel.font = UIFont.normalFont()
//            cell.lastMessageLabel.textColor = UIColor.darkGray
//        }
//    }
    
//    private func configureCellBackground(cell: ConversationTableViewCell) {
//        switch chatStatus {
//        case .online:
//            cell.backgroundColor = UIColor.onlineChat()
//        case .offline:
//            cell.backgroundColor = UIColor.white
//        }
//    }
}
