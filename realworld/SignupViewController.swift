//
//  SignupViewController.swift
//  realworld
//
//  Created by 구자윤 on 2022/10/07.
//

import UIKit

class SignupViewController: UIViewController {

    @IBOutlet weak var emailInput: UITextField!
    @IBOutlet weak var nickNameInput: UITextField!
    @IBOutlet weak var passwordInput: UITextField!
    @IBOutlet weak var confirmPasswordInput: UITextField!
    @IBOutlet weak var errorMessageLabel: UILabel!
    
    var errorMessage = "" {
        didSet {
            errorMessageLabel.text = errorMessage
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setup()
    }

    @IBAction func onSignup(_ sender: UIButton) {
        errorMessage = ""
        if isEmpty {
            errorMessage = "모든 필드가 채워져야 합니다."
            return
        }
        if isPasswordNotEqual {
            errorMessage = "비밀번호 확인이 일치하지 않습니다."
            return
        }
    }
}

// MARK: setup
extension SignupViewController {
    private func setup() {
        errorMessageLabel.text = errorMessage
        passwordInput.isSecureTextEntry = true
        confirmPasswordInput.isSecureTextEntry = true
        
        emailInput.delegate = self
        nickNameInput.delegate = self
        passwordInput.delegate = self
        confirmPasswordInput.delegate = self
    }
}

// MARK: textFieldDelegate
extension SignupViewController: UITextFieldDelegate {
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        switch textField {
            case emailInput:
                nickNameInput.becomeFirstResponder()
            case nickNameInput:
                passwordInput.becomeFirstResponder()
            case passwordInput:
                confirmPasswordInput.becomeFirstResponder()
            default:
                confirmPasswordInput.resignFirstResponder()
        }
        return true
    }
}

// MARK: Validation
extension SignupViewController {
    var isEmpty: Bool {
        guard let email = emailInput.text,
              let nickName = nickNameInput.text,
              let password = passwordInput.text,
              let confirmPassword = confirmPasswordInput.text else {
            return true
        }
        if email.isEmpty || nickName.isEmpty || password.isEmpty || confirmPassword.isEmpty {
            return true
        }
        return false
    }
    
    var isPasswordNotEqual: Bool {
        guard let password = passwordInput.text,
              let confirmPassword = confirmPasswordInput.text else {
            return true
        }
        if password.trimmingCharacters(in: .whitespacesAndNewlines) !=
            confirmPassword.trimmingCharacters(in: .whitespacesAndNewlines) {
            return true
        }
        return false
    }
}
