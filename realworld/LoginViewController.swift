//
//  LoginViewController.swift
//  realworld
//
//  Created by 구자윤 on 2022/10/11.
//

import UIKit

class LoginViewController: UIViewController {
    
    @IBOutlet weak var errorMessageLabel: UILabel!
    var errorMessage = ""
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setup()
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let signUpVC = segue.destination as! SignupViewController
        let signUpViewModel = SignupViewModel()
        
        signUpVC.viewModel = signUpViewModel
    }
    
}

// MARK: setup
extension LoginViewController {
    private func setup() {
        errorMessageLabel.text = errorMessage
    }
}

