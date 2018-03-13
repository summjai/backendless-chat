//
//  ChatListViewController.swift
//  TinkoffChat
//
//  Created by Anastasia Chuikina on 10/03/2018.
//  Copyright © 2018 Anastasia Chuikina. All rights reserved.
//

import UIKit

final class ChatListViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {
    
    // MARK: - Types
    private enum Constants {
        static let showChatSegue = "ShowChat"
    }
    
    // MARK: - IBOutlets
    @IBOutlet weak var conversationTable: UITableView!
    
    // MARK: - Private Properties
    private let textCellIdentifier = "TextCell"
    private let chats: (online: [Chat], offline: [Chat]) = Chat.generateFakeChats()
    
    // MARK: - UIViewController
    override func viewDidLoad() {
        super.viewDidLoad()
        
        conversationTable.delegate = self
        conversationTable.dataSource = self
        
        let textCellNib = UINib.init(nibName: "ConversationTableViewCell",
                                     bundle: nil)
        conversationTable.register(textCellNib,
                                   forCellReuseIdentifier: "TextCell")
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        guard let identifier = segue.identifier else { return }
        
        if identifier == Constants.showChatSegue {
            guard
                let chat = sender as? Chat,
                let destination = segue.destination as? ChatViewController else { return }
            let presentationModel = ChatPresentationModel(userName: chat.userName)
            destination.model = presentationModel
        }
    }
    
    // MARK: - UITableViewDataSource
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        switch section {
        case 0:
            return chats.online.count
        case 1:
            return chats.offline.count
        default:
            return 0
        }
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 2
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = conversationTable.dequeueReusableCell(withIdentifier: textCellIdentifier,
                                                               for: indexPath)
                                                    as? ConversationTableViewCell else { return UITableViewCell() }
        var chat: Chat
        switch indexPath.section {
        case 0:
            chat = chats.online[indexPath.row]
        case 1:
            chat = chats.offline[indexPath.row]
        default:
            chat = Chat(name: "Error in section handling")
        }
        
        chat.configure(cell: cell)
        
        return cell
    }

    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath as IndexPath, animated: true)
        
        var chat: Chat
        switch indexPath.section {
        case 0:
            chat = chats.online[indexPath.row]
        case 1:
            chat = chats.offline[indexPath.row]
        default:
            chat = Chat(name: "Error in section handling")
        }
        
        performSegue(withIdentifier: "ShowChat", sender: chat)
    }
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        if section == 0 {
            return "Online"
        } else {
            return "History"
        }
    }
    
    func tableView(_ tableView: UITableView, estimatedHeightForRowAt indexPath: IndexPath) -> CGFloat {
        return 44
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 88
    }
}
