//
//  MakeRequest.swift
//  realworld
//
//  Created by 구자윤 on 2022/10/09.
//

import Foundation

class Request {
    
    let baseUrl = "http://localhost:3065"
    
    func makeRequest(url: URL, method: String, body: [String: AnyHashable]) -> URLRequest {
        var request = URLRequest(url: url)
        
        request.httpMethod = method
        request.httpBody = try? JSONSerialization.data(withJSONObject: body, options: .fragmentsAllowed)
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        
        return request
    }
}

