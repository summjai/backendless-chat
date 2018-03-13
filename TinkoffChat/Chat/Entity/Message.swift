//
//  Message.swift
//  TinkoffChat
//
//  Created by Anastasia Chuikina on 11/03/2018.
//  Copyright © 2018 Anastasia Chuikina. All rights reserved.
//

import Foundation

enum MessageType {
    case incoming
    case outgoing
}

final class Message {
    let text: String
    let date: Date
    let messageType: MessageType
    
    init(text: String,
         date: Date,
         messageType: MessageType) {
        self.text = text
        self.date = date
        self.messageType = messageType
    }
    
    public func dateFormatted() -> String {
        if date.timeIntervalSinceNow > -3600*24.0 {
            let dateFormatter = DateFormatter()
            dateFormatter.dateFormat = "hh:mm"
            return dateFormatter.string(from: date)
        } else {
            let dateFormatter = DateFormatter()
            dateFormatter.dateFormat = "dd MMM"
            return dateFormatter.string(from: date)
        }
    }
}
