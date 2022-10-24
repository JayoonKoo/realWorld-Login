//
//  LoginViewController.swift
//  realworld
//
//  Created by 구자윤 on 2022/10/11.
//

import UIKit

final class LoginViewController: UIViewController {
    
    @IBOutlet weak var errorMessageLabel: UILabel!
    @IBOutlet weak var emailInput: UITextField!
    @IBOutlet weak var passwordInput: UITextField!
    @IBOutlet weak var signUpPresentButton: UIButton!
    
    @IBOutlet weak var emailFieldView: UIView!
    @IBOutlet weak var emailTextField: UITextField!
    @IBOutlet weak var emailPlaceHolderLabel: UILabel!
    @IBOutlet weak var emailTextFieldTopConstraint: NSLayoutConstraint!
    
    var viewModel: LoginViewModel?
    weak var delegate: LoginDelegate?
    
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
        guard let email = emailInput.text, let password = passwordInput.text else {return}
        guard let viewModel = viewModel else {
            presentAlert(title: "", message: "로그인에 문제가 있네요, 복구중 입니다. 죄송합니다.(1)")
            return
        }
        if email.isEmpty || password.isEmpty {
            errorMessageLabel.text = "이메일과 비밀번호를 모두 입력해주세요."
            return
        }
        let request = LoginRequest(email: email, password: password)
        viewModel.login(request: request) { result in
            switch result {
                case .success(let user):
                    self.delegate?.didLogin(user: user)
                case .failure(let error):
                    switch error {
                        case .serverError:
                            self.presentAlert(title: "에러", message: serverErrorMessage)
                        case .decodingError:
                            self.presentAlert(title: "", message: "로그인에 문제가 있네요, 복구중 입니다. 죄송합니다.(2)")
                        default:
                            return
                    }
            }
        }
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        view.endEditing(true)
    }
    
}

// MARK: setup
extension LoginViewController {
    private func setup() {
        errorMessageLabel.text = viewModel?.errorMessage
        signUpPresentButton.translatesAutoresizingMaskIntoConstraints = false
        signUpPresentButton.titleLabel?.font = .systemFont(ofSize: 12)
        passwordInput.isSecureTextEntry = true
        
        viewModel?.onErrorUpdated = {
            DispatchQueue.main.async {
                self.errorMessageLabel.text = self.viewModel?.errorMessage
            }
        }
        
        emailFieldView.layer.borderWidth = 1
        emailFieldView.layer.borderColor = UIColor(rgb: 0xe3dfde).cgColor
        emailFieldView.layer.cornerRadius = 5
        
        emailTextField.delegate = self
    }
}


protocol LoginDelegate: AnyObject {
    func didLogin(user: UserModel)
}


// MARK: textFieldDelegate
extension LoginViewController: UITextFieldDelegate {
    func textFieldDidBeginEditing(_ textField: UITextField) {
        emailTextFieldTopConstraint.constant = 8
        emailPlaceHolderLabel.font = UIFont.systemFont(ofSize: 12)
        UIView.animate(withDuration: 0.2) {
            self.emailFieldView.layoutIfNeeded()
        }
    }
    
    func textFieldDidEndEditing(_ textField: UITextField) {
        guard let text = textField.text, text.isEmpty else {return}
        emailTextFieldTopConstraint.constant = 20
        emailPlaceHolderLabel.font = UIFont.systemFont(ofSize: 14)
        UIView.animate(withDuration: 0.2) {
            self.emailFieldView.layoutIfNeeded()
        }
    }
}

