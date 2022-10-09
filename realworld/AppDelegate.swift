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
        
        let signUpViewModel = SignupViewModel()
        let rvc = UIStoryboard(name: "Main", bundle: nil).instantiateInitialViewController() as! SignupViewController
        rvc.viewModel = signUpViewModel
        window?.rootViewController = rvc
        
        return true
    }
}

