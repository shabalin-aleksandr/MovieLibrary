//
//  ProfileViewController.swift
//  MovieLibrary
//
//  Created by Aleksandr Shabalin on 18.12.2023.
//

import UIKit

class ProfileViewController: UIViewController {
    
    private let nameTextField = UITextField()
    private let surnameTextField = UITextField()
    private let nicknameTextField = UITextField()
    private let emailTextField = UITextField()
    private let saveButton = UIButton()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        setupTextField(nameTextField, placeholder: "Name")
        setupTextField(surnameTextField, placeholder: "Surname")
        setupTextField(nicknameTextField, placeholder: "Nickname")
        setupTextField(emailTextField, placeholder: "Email")
        
        setupSaveButton()
        
        loadProfile()
    }
    
    private func setupTextField(_ textField: UITextField, placeholder: String) {
        textField.borderStyle = .roundedRect
        textField.placeholder = placeholder
        view.addSubview(textField)
    }
    
    private func setupSaveButton() {
        saveButton.setTitle("Save", for: .normal)
        saveButton.backgroundColor = .red
        saveButton.layer.cornerRadius = 10
        saveButton.addTarget(self, action: #selector(saveProfile), for: .touchUpInside)
        view.addSubview(saveButton)
    }
    
    @objc private func saveProfile() {
        let profile = UserProfile(
            name: nameTextField.text,
            surname: surnameTextField.text,
            nickname: nicknameTextField.text,
            email: emailTextField.text
        )
        
        UserDefaults.standard.set(try? PropertyListEncoder().encode(profile), forKey: "userProfile")
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
        
        nameTextField.frame = CGRect(x: 20, y: 100, width: view.frame.size.width - 40, height: 40)
        surnameTextField.frame = CGRect(x: 20, y: 150, width: view.frame.size.width - 40, height: 40)
        nicknameTextField.frame = CGRect(x: 20, y: 200, width: view.frame.size.width - 40, height: 40)
        emailTextField.frame = CGRect(x: 20, y: 250, width: view.frame.size.width - 40, height: 40)
        saveButton.frame = CGRect(x: 20, y: 300, width: view.frame.size.width - 40, height: 50)
    }
}
