//
//  MessageCell.swift
//  TinkoffChat
//
//  Created by Anastasia Chuikina on 13/03/2018.
//  Copyright © 2018 Anastasia Chuikina. All rights reserved.
//

import UIKit

protocol MessageCellConfiguration: class {
    var textOfMessage: String? { get set }
}

class MessageCell: UITableViewCell, MessageCellConfiguration {
    
    enum MessageCellType {
        case incoming
        case outgoing
    }
    
    @IBOutlet private weak var messageLabel: UILabel!
    
    @IBOutlet private weak var messageContainerView: UIView! {
        didSet {
            messageContainerView.clipsToBounds = true
        }
    }
    
    var textOfMessage: String? {
        didSet {
            messageLabel.text = textOfMessage
        }
    }
}
