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
    
        
    }
    
    @IBOutlet weak var profileImageView: UIImageView!

    
    @IBOutlet weak var editImageView: UIImageView!
    
    
    
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
