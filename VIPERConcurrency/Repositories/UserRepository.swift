//
//  Untitled.swift
//  VIPERConcurrency
//
//  Created by Thanh Nguyen Xuan on 20/3/25.
//

protocol UserRepository {
    func login(with userInfo: UserLoginInfo) async throws -> UserDetail
}

final class UserRepositoryImpl: UserRepository {
    private let api: APIService

    init(_ api: APIService) {
        self.api = api
    }

    func login(with userInfo: UserLoginInfo) async throws -> UserDetail {
        return try await api.request(router: .login(userInfo: userInfo))
    }
}
