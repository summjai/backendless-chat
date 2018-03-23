//
//  SwiftThemesViewController.swift
//  TinkoffChat
//
//  Created by Anastasia Chuikina on 23/03/2018.
//  Copyright © 2018 Anastasia Chuikina. All rights reserved.
//

import UIKit

class SwiftThemesViewController: UIViewController {
    
    var model: Themes?
    
    // swiftlint:disable void_return
    var selectedColor: ((UIColor) -> ())?
    
    @IBAction func dismiss(_ sender: UIBarButtonItem) {
        dismiss(animated: true, completion: nil)
    }
    
    @IBAction func firsetThemeSelected(_ sender: UIButton) {
        guard let color = model?.theme1 else { return }
        newColorSelected(color: color)
    }
    
    @IBAction func secondThemeSelected(_ sender: UIButton) {
        guard let color = model?.theme2 else { return }
        newColorSelected(color: color)
    }
    
    @IBAction func thirdThemeSelected(_ sender: UIButton) {
        guard let color = model?.theme3 else { return }
        newColorSelected(color: color)
    }
    
    private func newColorSelected(color: UIColor) {
        view.backgroundColor = color
        selectedColor?(color)
    }
}
