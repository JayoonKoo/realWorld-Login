//
//  Erros.swift
//  realworld
//
//  Created by 구자윤 on 2022/10/09.
//

import Foundation


enum SignUpError: Error {
    case duple(String)
    case serverError
}
