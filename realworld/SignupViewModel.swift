//
//  SignupViewModel.swift
//  realworld
//
//  Created by 구자윤 on 2022/10/09.
//

import Foundation

class SignupViewModel {
    let baseUrl = "http://localhost:3065/user"
    
    func submitSignUp(email: String, nickname: String, password: String, completion: @escaping () -> Void) {
        guard let url = URL(string: baseUrl) else {
            print("url 생성 오류")
            return
        }
        let request = makeRequest(url: url, method: "POST", body: [
            "email": email,
            "nickname": nickname,
            "password": password
        ])
        
        URLSession.shared.dataTask(with: request) { data, _, error in
            if let error = error {
                print("error :\(error)")
                return
            }
            completion()
        }
    }
}
