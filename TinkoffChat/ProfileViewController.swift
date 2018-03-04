//
//  ViewController.swift
//  TinkoffChat
//
//  Created by Anastasia Chuikina on 21/02/2018.
//  Copyright © 2018 Anastasia Chuikina. All rights reserved.
//

import UIKit

final class ProfileViewController: UIViewController {
    
    // MARK: - UIViewController
    override func viewDidLoad() {
        
        super.viewDidLoad()
        
        fullNameTextField.text = "Anastasia Chuikina"
        personalInfoTextView.text = "Hi!gdhdsghfghjsjsrhsetsethsaeths"
        
        profileImageView.clipsToBounds = true
        profileImageView.layer.cornerRadius = 50
        
        photoButton.clipsToBounds = true
        photoButton.layer.cornerRadius = 50
        
        profileButton.backgroundColor = .clear
        profileButton.layer.cornerRadius = 15
        profileButton.layer.borderWidth = 1
        profileButton.layer.borderColor = UIColor.black.cgColor
        
        
}
    
    // MARK: - IBOutlets
    @IBOutlet weak var profileImageView: UIImageView!
    @IBOutlet weak var profileButton: UIButton!
    @IBOutlet weak var photoButton: UIButton!
    @IBOutlet weak var fullNameTextField: UITextField!
    @IBOutlet weak var personalInfoTextView: UITextView!
    
    // MARK: - IBAction
    @IBAction func editProfileButton(_ sender: UIButton) {
    }
    @IBAction func editPhotoButton(_ sender: Any) {
    }
    
    override func didReceiveMemoryWarning() {
        printViewControllerLifecycleStage()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        printViewControllerLifecycleStage()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        printViewControllerLifecycleStage()
    }
    
    override func viewWillLayoutSubviews() {
        super.viewWillLayoutSubviews()
        printViewControllerLifecycleStage()
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        printViewControllerLifecycleStage()
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        printViewControllerLifecycleStage()
    }
    
    override func viewDidDisappear(_ animated: Bool) {
        super.viewDidDisappear(animated)
        printViewControllerLifecycleStage()
    }
    
    // MARK: - Private Methods 
    private func printViewControllerLifecycleStage(method: String = #function) {

        switch method {
        case "viewWillAppear":
            print("View moved from Disappeared/Disappearing to Appearing:")
        case "viewDidAppear":
            print("View moved from Appearing to Appeared:")
        case "viewWillLayoutSubviews()":
            print("View will layout subviews:")
        case "viewDidLayoutSubviews()":
            print("View did layout subviews:")
        case "viewWillDisappear":
            print("View moved from Appeared/Appearing to Disappearing:")
        case "viewDidDisappear":
            print("View moved from Disappearing to Disappeared:")
        default:
            ()
        }
        print(method, "\n")
    }
    
}
