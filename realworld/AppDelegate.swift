//
//  AppDelegate.swift
//  realworld
//
//  Created by 구자윤 on 2022/10/07.
//

import UIKit

@main
class AppDelegate: UIResponder, UIApplicationDelegate {
    var window: UIWindow?

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        window = UIWindow(frame: UIScreen.main.bounds)
        window?.makeKeyAndVisible()
        window?.backgroundColor = .systemBackground
        
//        let rvc = UIStoryboard(name: "Main", bundle: nil).instantiateInitialViewController() as! SignupViewController
//        let rvc = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "SignupViewController") as! SignupViewController
        let rvc = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "LoginViewController") as! LoginViewController
//        let signUpViewModel = SignupViewModel()
//        rvc.delegate = self
//        rvc.viewModel = signUpViewModel
        window?.rootViewController = rvc
        
        return true
    }
}

// MARK: Delegate
extension AppDelegate: SignUpDelegate {
    func didSignUp() {
        // TODO: didSignUp
        print("TODO: didSignUp")
    }
}

