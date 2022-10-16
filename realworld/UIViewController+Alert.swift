//
//  UIViewController+Alert.swift
//  realworld
//
//  Created by 구자윤 on 2022/10/14.
//

import UIKit

extension UIViewController {
    func presentAlert(title: String, message: String) {
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        let cancleAction = UIAlertAction(title: "확인", style: .cancel)
        alert.addAction(cancleAction)
        
        self.present(alert, animated: false)
    }
}
