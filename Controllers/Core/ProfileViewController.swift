//
//  ProfileViewController.swift
//  MovieLibrary
//
//  Created by Aleksandr Shabalin on 18.12.2023.
//

import UIKit

class ProfileViewController: UIViewController {
    
    private let nameLabel = UILabel()
    private let surnameLabel = UILabel()
    private let nicknameLabel = UILabel()
    private let emailLabel = UILabel()
    
    private let scrollView = UIScrollView()
    
    private let nameTextField = UITextField()
    private let surnameTextField = UITextField()
    private let nicknameTextField = UITextField()
    private let emailTextField = UITextField()
    private let saveButton = UIButton()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemBackground
        
        view.addSubview(scrollView)
        
        setupLabel(nameLabel, text: "Name")
        setupLabel(surnameLabel, text: "Surname")
        setupLabel(nicknameLabel, text: "Nickname")
        setupLabel(emailLabel, text: "Email")
        
        setupTextField(nameTextField, placeholder: "Name", autoCapitalization: .words)
        setupTextField(surnameTextField, placeholder: "Surname", autoCapitalization: .words)
        setupTextField(nicknameTextField, placeholder: "Nickname", autoCapitalization: .none)
        setupTextField(emailTextField, placeholder: "Email", autoCapitalization: .none)
        
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillShow), name: UIResponder.keyboardWillShowNotification, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillHide), name: UIResponder.keyboardWillHideNotification, object: nil)
        
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(dismissKeyboard))
        view.addGestureRecognizer(tapGesture)
        
        setupSaveButton()
        loadProfile()
    }
    
    private func setupLabel(_ label: UILabel, text: String) {
        label.text = text
        label.textColor = .label
        view.addSubview(label)
    }
    
    private func setupTextField(_ textField: UITextField, placeholder: String, autoCapitalization: UITextAutocapitalizationType) {
        textField.borderStyle = .roundedRect
        textField.placeholder = placeholder
        textField.autocapitalizationType = autoCapitalization
        view.addSubview(textField)
    }
    
    
    private func setupSaveButton() {
        saveButton.setTitle("Save", for: .normal)
        saveButton.backgroundColor = .systemRed
        saveButton.layer.cornerRadius = 10
        saveButton.addTarget(self, action: #selector(saveProfile), for: .touchUpInside)
        view.addSubview(saveButton)
    }
    
    @objc private func saveProfile() {
        animateButtonTap(saveButton)
        let profile = UserProfile(
            name: nameTextField.text,
            surname: surnameTextField.text,
            nickname: nicknameTextField.text,
            email: emailTextField.text
        )
        
        UserDefaults.standard.set(try? PropertyListEncoder().encode(profile), forKey: "userProfile")
    }
    
    @objc private func keyboardWillShow(notification: NSNotification) {
        if let keyboardSize = (notification.userInfo?[UIResponder.keyboardFrameEndUserInfoKey] as? NSValue)?.cgRectValue {
            let bottomInset = keyboardSize.height - view.safeAreaInsets.bottom
            scrollView.contentInset.bottom = bottomInset
            scrollView.verticalScrollIndicatorInsets.bottom = bottomInset
        }
    }

    @objc private func keyboardWillHide(notification: NSNotification) {
        scrollView.contentInset.bottom = 0
        scrollView.verticalScrollIndicatorInsets.bottom = 0
    }
    
    @objc private func dismissKeyboard() {
        view.endEditing(true)
    }
    
    deinit {
        NotificationCenter.default.removeObserver(self, name: UIResponder.keyboardWillShowNotification, object: nil)
        NotificationCenter.default.removeObserver(self, name: UIResponder.keyboardWillHideNotification, object: nil)
    }
    
    private func animateButtonTap(_ button: UIButton) {
        UIView.animate(withDuration: 0.1,
                       animations: {
            button.transform = CGAffineTransform(scaleX: 0.95, y: 0.95)
        },
                       completion: { _ in
            UIView.animate(withDuration: 0.1) {
                button.transform = CGAffineTransform.identity
            }
        })
    }
    
    private func loadProfile() {
        guard let data = UserDefaults.standard.value(forKey:"userProfile") as? Data else { return }
        let profile = try? PropertyListDecoder().decode(UserProfile.self, from: data)
        
        nameTextField.text = profile?.name
        surnameTextField.text = profile?.surname
        nicknameTextField.text = profile?.nickname
        emailTextField.text = profile?.email
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        
        scrollView.frame = view.bounds
        let contentWidth = view.frame.size.width
        let contentHeight = saveButton.frame.origin.y + saveButton.frame.size.height + 20
        scrollView.contentSize = CGSize(width: contentWidth, height: contentHeight)
        
        let spacing: CGFloat = 50
        let labelHeight: CGFloat = 20
        
        nameLabel.frame = CGRect(x: 20, y: 100, width: view.frame.size.width - 40, height: labelHeight)
        nameTextField.frame = CGRect(x: 20, y: nameLabel.frame.maxY+5, width: view.frame.size.width - 40, height: 40)
        
        surnameLabel.frame = CGRect(x: 20, y: nameTextField.frame.maxY + spacing, width: view.frame.size.width - 40, height: labelHeight)
        surnameTextField.frame = CGRect(x: 20, y: surnameLabel.frame.maxY+5, width: view.frame.size.width - 40, height: 40)
        
        nicknameLabel.frame = CGRect(x: 20, y: surnameTextField.frame.maxY + spacing, width: view.frame.size.width - 40, height: labelHeight)
        nicknameTextField.frame = CGRect(x: 20, y: nicknameLabel.frame.maxY+5, width: view.frame.size.width - 40, height: 40)
        
        emailLabel.frame = CGRect(x: 20, y: nicknameTextField.frame.maxY + spacing, width: view.frame.size.width - 40, height: labelHeight)
        emailTextField.frame = CGRect(x: 20, y: emailLabel.frame.maxY+5, width: view.frame.size.width - 40, height: 40)
        
        saveButton.frame = CGRect(x: (view.frame.size.width - 140) / 2, y: emailTextField.frame.maxY + spacing, width: 140, height: 50)
    }
}

