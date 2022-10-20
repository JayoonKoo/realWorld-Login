//
//  LoginViewModel.swift
//  realworld
//
//  Created by 구자윤 on 2022/10/14.
//

import Foundation


class LoginViewModel: Request {
    
    var onErrorUpdated: () -> Void = {}
    
    var errorMessage: String = "" {
        didSet {
            onErrorUpdated()
        }
    }
    
    func login(request: LoginRequest, completion: @escaping (Result<UserModel, LoginError>) -> Void) {
        guard let url = URL(string: "\(baseUrl)/user/login") else {
            print("url 생성 오류")
            return
        }
        
        let request = makeRequest(url: url, method: "POST", body: [
            "email": request.email,
            "password": request.password
        ])
        
        URLSession.shared.dataTask(with: request) { data, response, error in
            guard let response = response as? HTTPURLResponse, let data = data else {
                completion(.failure(.serverError))
                return
            }
            let statusCode = response.statusCode
            if (200..<300).contains(statusCode) {
                do {
                    let user = try JSONDecoder().decode(UserModel.self, from: data)
                    completion(.success(user))
                } catch {
                    print(error.localizedDescription)
                    completion(.failure(.decodingError))
                }
            } else if 401 == statusCode {
                self.errorMessage = String(bytes: data, encoding: .utf8) ?? ""
            } else {
                completion(.failure(.serverError))
            }
        }.resume()
    }
}

