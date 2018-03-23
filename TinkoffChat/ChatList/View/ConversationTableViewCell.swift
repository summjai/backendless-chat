//
//  ConversationTableViewCell.swift
//  TinkoffChat
//
//  Created by Anastasia Chuikina on 10/03/2018.
//  Copyright © 2018 Anastasia Chuikina. All rights reserved.
//

import UIKit

protocol ConversationCellConfiguration: class {
    var name: String { get set }
    var message: String? { get set }
    var date: String? { get set }
    var online: Bool { get set }
    var hasUnreadMessages: Bool { get set }
}

final class ConversationTableViewCell: UITableViewCell, ConversationCellConfiguration {

    @IBOutlet private weak var userNameLabel: UILabel!
    
    @IBOutlet private weak var lastMessageLabel: UILabel!
    
    @IBOutlet private weak var dateTimeLabel: UILabel!
    
    public var name: String = "" {
        didSet {
            userNameLabel.text = name
        }
    }
    
    public var message: String? {
        didSet {
            if message == "No messages yet" {
                lastMessageLabel.font = UIFont.italicFont()
            } else {
                lastMessageLabel.font = UIFont.normalFont()
            }

            lastMessageLabel.text = message
        }
    }
    
    public var date: String? {
        didSet {
            dateTimeLabel.text = date
        }
    }
    
    public var online: Bool = false {
        didSet {
            if online {
                backgroundColor = UIColor.onlineChat()
            } else {
                backgroundColor = UIColor.white
            }
        }
    }
    
    public var hasUnreadMessages: Bool = false {
        didSet {
            if hasUnreadMessages {
                lastMessageLabel.font = UIFont.unreadMessage()
                lastMessageLabel.textColor = UIColor.black
            } else {
                lastMessageLabel.font = UIFont.normalFont()
                lastMessageLabel.textColor = UIColor.lightGray
            }
        }
    }
}
