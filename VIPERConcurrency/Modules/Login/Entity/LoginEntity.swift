//  
//  LoginEntity.swift
//  VIPERConcurrency
//
//  Created by Thanh Nguyen Xuan on 20/3/25.
//

struct UserInfo {
    let username: String
    let password: String
}

struct UserDetail: Decodable {
    let id: Int
    let username: String
    let email: String
    let accessToken: String
}
