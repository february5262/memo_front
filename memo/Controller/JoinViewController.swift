//
//  JoinViewController.swift
//  memo
//
//  Created by 조윤경 on 2024/02/04.
//

import Foundation
import UIKit

class JoinViewController: UIViewController {
    
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
    
    let JoinButton: UIButton = {
        let button = UIButton()
        button.setTitle("로그인", for: .normal)
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
        view.addSubview(JoinButton)
        JoinButton.topAnchor.constraint(equalTo: passwordTextField.bottomAnchor, constant: 20).isActive = true
        JoinButton.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20).isActive = true
        JoinButton.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20).isActive = true
        JoinButton.addTarget(self, action: #selector(JoinButtonTapped), for: .touchUpInside)
    }
    
    @objc func JoinButtonTapped() {
        // 로그인 버튼이 눌렸을 때의 동작 구현
        // 여기에 실제 로그인 로직을 추가하면 됩니다.
        print("로그인 버튼이 눌렸습니다.")
    }
}
