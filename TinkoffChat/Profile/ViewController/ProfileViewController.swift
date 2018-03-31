//
//  ViewController.swift
//  TinkoffChat
//
//  Created by Anastasia Chuikina on 21/02/2018.
//  Copyright © 2018 Anastasia Chuikina. All rights reserved.
//

import UIKit

final class ProfileViewController: UIViewController {
    
    // MARK: - Types
    private enum SaveButtonsState {
        case enabled
        case disabled
    }
    
    private enum SaveType {
        case GCD
        case operation
    }
    
    // MARK: - IBOutlets
    @IBOutlet private weak var photoButton: UIButton!
    @IBOutlet private weak var profileImageView: UIImageView!
    @IBOutlet private weak var fullNameTextField: UITextField!
    @IBOutlet private weak var personalInfoTextView: UITextView!
    @IBOutlet private weak var editProfileStackView: UIStackView!
    @IBOutlet private weak var editProfileButton: UIButton!
    @IBOutlet private weak var activityIndicator: UIActivityIndicatorView!
    
    // MARK: - Private Properties
    private var profile: Profile? {
        didSet {
            profileImageView.image = profile?.photo ?? #imageLiteral(resourceName: "placeholder-user")
            fullNameTextField.text = profile?.userName ?? "Your name"
            personalInfoTextView.text = profile?.about ?? "About you"
        }
        
        willSet {
            hasUnsavedChanges = (profile != newValue) || hasUnsavedChanges
        }
    }
    private var profileStorage: IProfileStorage?
    private var hasUnsavedChanges: Bool = false {
        didSet {
            setStateOfSaveButtons(to: hasUnsavedChanges ? .enabled : .disabled)
        }
    }
    
    lazy var gcdButton: UIButton = {
        let button = UIButton()
        button.setTitle("GCD", for: .normal)
        
        button.setTitleColor(UIColor.black, for: .normal)
        button.setTitleColor(UIColor.lightGray, for: .disabled)
        
        button.layer.borderWidth = 1
        button.layer.cornerRadius = 5
        button.layer.borderColor = UIColor.black.cgColor
        
        button.addTarget(self, action: #selector(saveUsingGCD), for: .touchUpInside)
        return button
    }()
    
    lazy var operationButton: UIButton = {
        let button = UIButton()
        
        button.setTitle("Operation", for: .normal)
        
        button.setTitleColor(UIColor.black, for: .normal)
        button.setTitleColor(UIColor.lightGray, for: .disabled)
        
        button.layer.borderWidth = 1
        button.layer.cornerRadius = 5
        button.layer.borderColor = UIColor.black.cgColor
        
        button.addTarget(self, action: #selector(saveUsingOperation), for: .touchUpInside)
        return button
    }()
    
    // MARK: - UIViewController
    override func viewDidLoad() {
        configureUI()
        loadProfile()
        
        fullNameTextField.delegate = self
        personalInfoTextView.delegate = self
    }
    
    // MARK: - IBAction
    @IBAction func editPhotoButton(_ sender: Any) {
        showImagePickingActionSheet()
    }
    
    @IBAction func dismiss(_ sender: UIBarButtonItem) {
        dismiss(animated: true, completion: nil)
    }
    
    @IBAction func edit(_ sender: UIButton) {
        editProfileButton.removeFromSuperview()
        
        gcdButton.heightAnchor.constraint(equalToConstant: 44).isActive = true
        gcdButton.widthAnchor.constraint(equalToConstant: 70).isActive = true
        
        operationButton.heightAnchor.constraint(equalToConstant: 44).isActive = true
        operationButton.widthAnchor.constraint(equalToConstant: 70).isActive = true
        
        view.setNeedsLayout()
        
        editProfileStackView.addArrangedSubview(gcdButton)
        editProfileStackView.addArrangedSubview(operationButton)
        
        editProfileStackView.translatesAutoresizingMaskIntoConstraints = false
        
        fullNameTextField.isUserInteractionEnabled = true
        personalInfoTextView.isUserInteractionEnabled = true
        
        setStateOfSaveButtons(to: .disabled)
        
        fullNameTextField.becomeFirstResponder()
    }
    
    @objc private func saveUsingGCD() {
        saveProfile(type: .GCD)
    }
    
    @objc private func saveUsingOperation() {
        saveProfile(type: .operation)
    }

    // MARK: - Private Methods
    private func loadProfile() {
        profileStorage = GCDProfileStorage()
        profileStorage?.load { profile in
            self.profile = profile
        }
    }
    
    private func saveProfile(type: SaveType) {
        
        switch type {
        case .GCD:
            profileStorage = GCDProfileStorage()
        case .operation:
            profileStorage = OperationProfileStorage()
        }
        
        activityIndicator.startAnimating()
        
        setStateOfSaveButtons(to: .disabled)
        
        let profile = createProfileModelFromFields()
        profileStorage?.save(profile: profile) { status in
            DispatchQueue.main.asyncAfter(deadline: .now() + 1.0) {
                self.activityIndicator.stopAnimating()
                self.setStateOfSaveButtons(to: .enabled)
                if status {
                    self.showSuccessAlert()
                    self.hasUnsavedChanges = false
                } else {
                    self.showErrorAlert(type: type)
                }
            }
        }
    }
    
    private func configureUI() {
        personalInfoTextView.textContainerInset = .zero
        personalInfoTextView.contentInset = UIEdgeInsets(top: 0,
                                                         left: -5,
                                                         bottom: 0,
                                                         right: 0)
        
        profileImageView.clipsToBounds = true
        profileImageView.layer.cornerRadius = 50
        
        photoButton.clipsToBounds = true
        photoButton.layer.cornerRadius = 50
        
        editProfileButton.layer.borderWidth = 1
        editProfileButton.layer.cornerRadius = 5
        editProfileButton.layer.borderColor = UIColor.black.cgColor
    }
    
    private func createProfileModelFromFields() -> Profile {
        return Profile(about: personalInfoTextView.text,
                       photo: profileImageView.image,
                       userName: fullNameTextField.text)
    }
    
    private func setStateOfSaveButtons(to state: SaveButtonsState) {
        switch state {
        case .enabled:
            gcdButton.isEnabled = true
            operationButton.isEnabled = true
            gcdButton.layer.borderColor = UIColor.black.cgColor
            operationButton.layer.borderColor = UIColor.black.cgColor
        case .disabled:
            gcdButton.isEnabled = false
            operationButton.isEnabled = false
            gcdButton.layer.borderColor = UIColor.lightGray.cgColor
            operationButton.layer.borderColor = UIColor.lightGray.cgColor
        }
    }
    
    private func showSuccessAlert() {
        let alert = UIAlertController(title: nil,
                                      message: "Данные успешно сохранены",
                                      preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "ОК", style: .cancel, handler: nil))
        present(alert, animated: true, completion: nil)
    }
    
    private func showErrorAlert(type: SaveType) {
        let alert = UIAlertController(title: "Ошибка",
                                      message: "Данные не сохранены",
                                      preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "ОК",
                                      style: .cancel,
                                      handler: nil))
        alert.addAction(UIAlertAction(title: "Повторить",
                                      style: .default,
                                      handler: { _ in
            self.saveProfile(type: type)
        }))
        present(alert, animated: true, completion: nil)
    }
}

// MARK: - UIImagePickerControllerDelegate
extension ProfileViewController: UIImagePickerControllerDelegate {
    
    public func imagePickerController(_ picker: UIImagePickerController,
                                      didFinishPickingMediaWithInfo info: [String: Any]) {

        if let image = info[UIImagePickerControllerEditedImage] as? UIImage {
            profileImageView.image = image
            profile = Profile(about: profile?.about,
                              photo: image,
                              userName: profile?.userName)
        }
        
        dismiss(animated: true,
                completion: nil)
    }
    
    public func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        dismiss(animated: true,
                completion: nil)
    }
    
    private func showImagePickingActionSheet() {
        let actionSheet = UIAlertController(title: "Выбери изображение профиля",
                                            message: nil,
                                            preferredStyle: .actionSheet)
        
        let galleryAction = UIAlertAction(title: "Установить из галлереи",
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
}

// MARK: - UINavigationControllerDelegate
extension ProfileViewController: UINavigationControllerDelegate {
}

// MARK: - UITextFieldDelegate
extension ProfileViewController: UITextFieldDelegate {
    func textFieldDidEndEditing(_ textField: UITextField) {
        profile = Profile(about: profile?.about,
                          photo: profile?.photo,
                          userName: textField.text)
    }
}

// MARK: - UITextViewDelegate
extension ProfileViewController: UITextViewDelegate {
    func textViewDidEndEditing(_ textView: UITextView) {
        profile = Profile(about: textView.text,
                          photo: profile?.photo,
                          userName: profile?.userName)
    }
}
