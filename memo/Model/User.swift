//
//  User.swift
//  memo
//
//  Created by 조윤경 on 3/4/24.
//

import Foundation

struct User: Codable{
    var nickname: String
    var password: String
}
struct SignupResponse: Codable {
    let status: Int
    let success: Bool?
    let message: String
    let data: User?
}
