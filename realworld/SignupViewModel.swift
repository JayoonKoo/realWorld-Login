//
//  SignupViewModel.swift
//  realworld
//
//  Created by 구자윤 on 2022/10/09.
//

import Foundation

final class SignupViewModel: Request {
    
    func submitSignUp(email: String, nickname: String, password: String, completion: @escaping (Result<UserModel?, SignUpError>) -> Void) {
        guard let url = URL(string: "\(baseUrl)/user") else {
            print("url 생성 오류")
            return
        }
        let request = makeRequest(url: url, method: "POST", body: [
            "email": email,
            "nickname": nickname,
            "password": password
        ])
        
        URLSession.shared.dataTask(with: request) { data, response, error in
            DispatchQueue.main.async {
                guard let response = response as? HTTPURLResponse else {
                    completion(.failure(.serverError))
                    return
                }
                let statusCode = response.statusCode
                if (200..<300).contains(statusCode) {
                    completion(.success(nil))
                } else if statusCode == 403 {
                    completion(.failure(.duple("이미 사용중인 사용자 입니다")))
                } else if statusCode >= 500 {
                    completion(.failure(.serverError))
                }
            }
        }.resume()
    }
}
