//
//  ChatViewController.swift
//  TinkoffChat
//
//  Created by Anastasia Chuikina on 13/03/2018.
//  Copyright © 2018 Anastasia Chuikina. All rights reserved.
//

import UIKit

class ChatViewController: UIViewController, ChatPresentationModelDelegate {
    
    // MARK: - Outlets
    @IBOutlet internal weak var tableView: UITableView!
    @IBOutlet private weak var sendButton: UIButton!
    @IBOutlet private weak var messageTextView: UITextView!
    @IBOutlet private weak var bottomConstraint: NSLayoutConstraint!
    
    @IBAction func dismissKeyboard(_ sender: UITapGestureRecognizer) {
        view.endEditing(true)
    }
    
    // MARK: - Public Properties
    var model: ChatPresentationModelProtocol!
    
    // MARK: - UIViewController
    override func viewDidLoad() {
        super.viewDidLoad()
        configureTableView()
        setupMessageTextView()
        self.model.delegate = self
        registerForKeyboardNotifications()
        configureTitle(with: model.userName)
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        scrollToBottom()
    }
    
    override func viewWillTransition(to size: CGSize, with coordinator: UIViewControllerTransitionCoordinator) {
        super.viewWillTransition(to: size, with: coordinator)
        tableView.reloadData()
    }
    
    deinit {
        NotificationCenter.default.removeObserver(self)
    }
    
    // MARK: - Private Methods
    private func setupMessageTextView() {
        self.messageTextView.layer.borderWidth = 1
        self.messageTextView.layer.cornerRadius = 10
        self.messageTextView.layer.borderColor = UIColor.black.cgColor
    }
    
    private func configureTitle(with userName: String) {
        self.title = userName
    }
    
    private func configureTableView() {
        tableView.dataSource = self
    }
    
    private func registerForKeyboardNotifications() {
        NotificationCenter.default.addObserver(self, selector: #selector(moveScreen(_:)),
                                               name: .UIKeyboardWillChangeFrame, object: nil)
    }
    
    private func scrollToBottom() {
        DispatchQueue.main.async {
            let numberOfSections = self.tableView.numberOfSections
            let numberOfRows = self.tableView.numberOfRows(inSection: numberOfSections - 1)
            if numberOfRows > 0 {
                let indexPath = IndexPath(row: numberOfRows - 1, section: (numberOfSections - 1))
                self.tableView.scrollToRow(at: indexPath, at: .bottom, animated: true)
            }
        }
    }
    
    @objc private func moveScreen(_ notification: Notification) {
        if let userInfo = notification.userInfo {
            
            guard
                let frame = userInfo[UIKeyboardFrameEndUserInfoKey] as? NSValue,
                let durationValue = userInfo[UIKeyboardAnimationDurationUserInfoKey] as? NSNumber,
                let animationCurveRawValue = userInfo[UIKeyboardAnimationCurveUserInfoKey] as? NSNumber else { return }
            
            let endFrame = frame.cgRectValue
            
            let duration: TimeInterval = durationValue.doubleValue
            let animationCurveRaw = animationCurveRawValue.uintValue
            let animationCurve = UIViewAnimationOptions(rawValue: animationCurveRaw)
            if endFrame.origin.y >= UIScreen.main.bounds.height {
                bottomConstraint.constant = 0.0
            } else {
                bottomConstraint.constant = endFrame.size.height
            }
            view.layoutIfNeeded()
            UIView.animate(withDuration: duration,
                           delay: 0,
                           options: animationCurve,
                           animations: { self.view.layoutIfNeeded() },
                           completion: { _ in self.scrollToBottom() }
            )}
    }
}

// MARK: - UITableViewDataSource
extension ChatViewController: UITableViewDataSource {
    private struct CellIdentifier {
        static let incomingCellIdentifier = "IncomingCell"
        static let outgoingCellIdentifier = "OutgoingCell"
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return model.getNumberOfRows()
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let message = model.getMessage(at: indexPath)
        let isIncoming = message.messageType == .incoming
        let identifier = isIncoming ? CellIdentifier.incomingCellIdentifier : CellIdentifier.outgoingCellIdentifier
        
        let cell = tableView.dequeueReusableCell(withIdentifier: identifier, for: indexPath)
        
        guard let messageCell = cell as? MessageCellConfiguration & UITableViewCell else {
            assertionFailure("Wrong cell type")
            return cell
        }
        
        messageCell.textOfMessage = message.text
        return cell
    }
}
