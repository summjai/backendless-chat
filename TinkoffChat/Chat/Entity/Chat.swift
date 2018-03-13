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
    static func generateFakeChats() -> [Chat] {
        var chats = [Chat]()
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
        
        chats.append(Chat(name: "Johny", chatStatus: .online))
        chats.append(Chat(name: "Alice", chatStatus: .online, hasUnreadMessages: false))
        chats.append(Chat(name: "Bob"))
        
        for chat in chats {
            for message in messages {
                chat.addMessage(message: message)
            }
        }
        chats.append(Chat(name: "Empty", hasUnreadMessages: false))
        
        return chats
    }
}

extension Chat {
    private enum CellState {
        case hasMessage
        case noMessage
    }
    
    public func configure(cell: ConversationTableViewCell) {
        
        let state: CellState = lastMessage != nil ? .hasMessage : .noMessage
        
        configureCellForMessage(cell: cell,
                                state: state)
        
        configureCellBackground(cell: cell)
        
        cell.userNameLabel.text = userName
        cell.lastMessageLabel.text = lastMessage?.text ?? "No messages yet"
        cell.dateTimeLabel.text = lastMessage?.dateFormatted()
    }
    
    private func configureCellForMessage(cell: ConversationTableViewCell,
                                         state: CellState) {
        switch state {
        case .hasMessage:
            cell.lastMessageLabel.font = UIFont.normalFont()
        case .noMessage:
            cell.lastMessageLabel.font = UIFont.italicFont()
        }
        
        if hasUnreadMessages {
            cell.lastMessageLabel.font = UIFont.unreadMessage()
            cell.lastMessageLabel.textColor = UIColor.black
        } else {
            cell.lastMessageLabel.font = UIFont.normalFont()
            cell.lastMessageLabel.textColor = UIColor.darkGray
        }
    }
    
    private func configureCellBackground(cell: ConversationTableViewCell) {
        switch chatStatus {
        case .online:
            cell.backgroundColor = UIColor.onlineChat()
        case .offline:
            cell.backgroundColor = UIColor.white
        }
    }
}
