//
//  ViewController.swift
//  TinkoffChat
//
//  Created by Anastasia Chuikina on 21/02/2018.
//  Copyright © 2018 Anastasia Chuikina. All rights reserved.
//

import UIKit

final class ProfileViewController: UIViewController {
    
    // MARK: - IBOutlets
    @IBOutlet private weak var photoButton: UIButton!
    @IBOutlet private weak var profileButton: UIButton!
    @IBOutlet private weak var profileImageView: UIImageView!
    @IBOutlet private weak var fullNameTextField: UITextField!
    @IBOutlet private weak var personalInfoTextView: UITextView!
    
    // MARK: - IBAction
    @IBAction func editPhotoButton(_ sender: Any) {
        showImagePickingActionSheet()
    }
    
    @IBAction func editProfileButton(_ sender: UIButton) {
        
    }
    
    // MARK: - UIViewController
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
//               Fatal error: Unexpectedly found nil while unwrapping an Optional value
//               На данном этапе еще нет аутлета кнопки
//               print(profileButton.frame)
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        configureUI()
        print(profileButton.frame)
    }
    override func viewDidAppear(_ animated: Bool) {
        print(profileButton.frame)
//        На этом этапе, после имплементации layoutSubviews() методов, установился корректный фрэйм
    }

    // MARK: - Private Methods
    private func showImagePickingActionSheet() {
        print("Выбери изображение профиля \n")
        
        let actionSheet = UIAlertController(title: "Выбери изображение профиля",
                                            message: nil,
                                            preferredStyle: .actionSheet)
        
        let galleryAction = UIAlertAction(title: "Усановить из галлереи",
                                          style: .default,
                                          handler: { _ in
                                            self.showImagePickerWith(.photoLibrary)
        })
        
        let cameraAction = UIAlertAction(title: "Сделать фото",
                                         style: .default,
                                         handler: { _ in
                                            self.showImagePickerWith(.camera)
        })
        
        let cancelAction = UIAlertAction(title: "Отмена",
                                         style: .default,
                                         handler: nil)
        
        actionSheet.addAction(galleryAction)
        
        if UIImagePickerController.isSourceTypeAvailable(.camera) {
            actionSheet.addAction(cameraAction)
        }
        
        actionSheet.addAction(cancelAction)
        
        self.present(actionSheet,
                     animated: true,
                     completion: nil)
    }
    
    private func showImagePickerWith(_ sourceType: UIImagePickerControllerSourceType) {
        let imagePicker = UIImagePickerController()
        imagePicker.delegate = self
        imagePicker.sourceType = sourceType
        imagePicker.allowsEditing = true
        present(imagePicker,
                animated: true,
                completion: nil)
    }
    
    private func configureUI() {
        fullNameTextField.text = "Anastasia Chuikina"
        personalInfoTextView.text = "Beginner IOS-developer🐣"
        
        personalInfoTextView.textContainerInset = .zero
        personalInfoTextView.contentInset = UIEdgeInsets(top: 0,
                                                         left: -5,
                                                         bottom: 0,
                                                         right: 0)
        
        profileImageView.clipsToBounds = true
        profileImageView.layer.cornerRadius = 50
        
        photoButton.clipsToBounds = true
        photoButton.layer.cornerRadius = 50
        
        profileButton.layer.borderWidth = 1
        profileButton.layer.cornerRadius = 15
        profileButton.backgroundColor = .clear
        profileButton.layer.borderColor = UIColor.black.cgColor
    }
}

// MARK: - UIImagePickerControllerDelegate

extension ProfileViewController: UIImagePickerControllerDelegate {
    
    public func imagePickerController(_ picker: UIImagePickerController,
                                      didFinishPickingMediaWithInfo info: [String: Any]) {

        if let image = info[UIImagePickerControllerEditedImage] as? UIImage {
            profileImageView.image = image
        }
        
        dismiss(animated: true,
                completion: nil)
    }
    
    public func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        dismiss(animated: true,
                completion: nil)
    }
}

// MARK: - UINavigationControllerDelegate

extension ProfileViewController: UINavigationControllerDelegate {
    
}
