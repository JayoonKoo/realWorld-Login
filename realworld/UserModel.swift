//
//  UserModel.swift
//  realworld
//
//  Created by 구자윤 on 2022/10/09.
//
import Foundation

struct UserModel: Codable {
    let id: Int
    let email: String
    let nickname: String
}

struct LoginRequest {
    let email: String
    let password: String
}

struct LoginResponse: Codable {
    let id: Int
    let nickname: String
    let email: String
    let Posts: [PostModel]
}
