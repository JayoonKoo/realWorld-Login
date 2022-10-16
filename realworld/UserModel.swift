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
    let password: String
}

