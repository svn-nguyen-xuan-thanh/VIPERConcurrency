//
//  Untitled.swift
//  VIPERConcurrency
//
//  Created by Thanh Nguyen Xuan on 20/3/25.
//

import RxSwift

protocol UserRepository {
    func login(with userInfo: UserInfo)  -> Single<UserDetail>
}

final class UserRepositoryImpl: UserRepository {
    private let api: APIService

    init(_ api: APIService) {
        self.api = api
    }

    func login(with userInfo: UserInfo) -> Single<UserDetail> {
        api.request(router: .login(userInfo: userInfo))
    }
}
