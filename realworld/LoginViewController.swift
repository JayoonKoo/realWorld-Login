//
//  LoginViewController.swift
//  realworld
//
//  Created by 구자윤 on 2022/10/11.
//

import UIKit

class LoginViewController: UIViewController {
    
    @IBOutlet weak var errorMessageLabel: UILabel!
    @IBOutlet weak var emailInput: UITextField!
    @IBOutlet weak var passwordInput: UITextField!
    @IBOutlet weak var signUpPresentButton: UIButton!
    
    var errorMessage = "" {
        didSet {
            errorMessageLabel.text = errorMessage
        }
    }
    
    var viewModel: LoginViewModel?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setup()
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let signUpVC = segue.destination as! SignupViewController
        let signUpViewModel = SignupViewModel()
        
        signUpVC.viewModel = signUpViewModel
    }
    
    @IBAction func onTapLoginBtn(_ sender: Any) {
        errorMessage = ""
        guard let email = emailInput.text, let password = passwordInput.text else {return}
        guard let viewModel = viewModel else {
            presentAlert(title: "", message: "로그인에 문제가 있네요, 복구중 입니다. 죄송합니다.(1)")
            return
        }
        if email.isEmpty || password.isEmpty {
            errorMessage = "이메일과 비밀번호를 모두 입력해주세요."
            return
        }
        let request = LoginRequest(email: email, password: password)
        viewModel.login(request: request) { result in
            switch result {
                case .success(let user):
                    print(user)
                case .failure(let error):
                    switch error {
                        case .invalidateUser:
                            self.errorMessage = "이메일과 비밀번호가 일치하지 않습니다."
                        case .serverError:
                            self.presentAlert(title: "에러", message: serverErrorMessage)
                        case .decodingError:
                            self.presentAlert(title: "", message: "로그인에 문제가 있네요, 복구중 입니다. 죄송합니다.(2)")
                    }
            }
        }
    }
    
}

// MARK: setup
extension LoginViewController {
    private func setup() {
        errorMessageLabel.text = errorMessage
        signUpPresentButton.translatesAutoresizingMaskIntoConstraints = false
        signUpPresentButton.titleLabel?.font = .systemFont(ofSize: 12)
        passwordInput.isSecureTextEntry = true
    }
}

