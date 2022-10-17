//
//  Erros.swift
//  realworld
//
//  Created by 구자윤 on 2022/10/09.
//

import Foundation

let serverErrorMessage = "서버 에러 - 잠시 후 다시 시도해주세요"

enum SignUpError: Error {
    case duple(String)
    case serverError
}

enum LoginError: Error {
    case invalidateUser(String?)
    case serverError
    case decodingError
}
