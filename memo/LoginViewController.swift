//
//  LoginViewController.swift
//  memo
//
//  Created by 조윤경 on 2024/02/04.
//

import Foundation
import UIKit

class LoginViewController: UIViewController {

    let usernameTextField: UITextField = {
        let textField = UITextField()
        textField.placeholder = "아이디"
        textField.borderStyle = .roundedRect
        textField.translatesAutoresizingMaskIntoConstraints = false
        return textField
    }()
    
    let passwordTextField: UITextField = {
        let textField = UITextField()
        textField.placeholder = "비밀번호"
        textField.isSecureTextEntry = true
        textField.borderStyle = .roundedRect
        textField.translatesAutoresizingMaskIntoConstraints = false
        return textField
    }()
    
    let loginButton: UIButton = {
        let button = UIButton()
        button.setTitle("로그인", for: .normal)
        button.setTitleColor(.white, for: .normal)
        button.backgroundColor = .blue
        button.layer.cornerRadius = 5
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    let joinButton: UIButton = {
        let button = UIButton()
        button.setTitle("회원가입", for: .normal)
        button.setTitleColor(.white, for: .normal)
        button.backgroundColor = .blue
        button.layer.cornerRadius = 5
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = .white
        
        // 아이디 입력 필드
        view.addSubview(usernameTextField)
        usernameTextField.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 50).isActive = true
        usernameTextField.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20).isActive = true
        usernameTextField.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20).isActive = true
        
        // 비밀번호 입력 필드
        view.addSubview(passwordTextField)
        passwordTextField.topAnchor.constraint(equalTo: usernameTextField.bottomAnchor, constant: 20).isActive = true
        passwordTextField.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20).isActive = true
        passwordTextField.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20).isActive = true
        
        // 로그인 버튼
        view.addSubview(loginButton)
        loginButton.topAnchor.constraint(equalTo: passwordTextField.bottomAnchor, constant: 20).isActive = true
        loginButton.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20).isActive = true
        loginButton.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20).isActive = true
        loginButton.addTarget(self, action: #selector(loginButtonTapped), for: .touchUpInside)
        
        // 회원가입 버튼
        view.addSubview(joinButton)
        joinButton.topAnchor.constraint(equalTo: loginButton.bottomAnchor, constant: 20).isActive = true
        joinButton.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20).isActive = true
        joinButton.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20).isActive = true
        joinButton.addTarget(self, action: #selector(joinButtonTapped), for: .touchUpInside)
    }
    
    @objc func loginButtonTapped() {
        // 로그인 버튼이 눌렸을 때의 동작 구현
        // 여기에 실제 로그인 로직을 추가하면 됩니다.
        print("로그인 버튼이 눌렸습니다.")
    }
    @objc func joinButtonTapped() {
        let newViewController = JoinViewController()
        navigationController?.pushViewController(newViewController, animated: true)
        print("회원가입 버튼이 눌렸습니다.")
    }
    
}
