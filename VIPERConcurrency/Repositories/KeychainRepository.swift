//
//  KeychainRepository.swift
//  VIPERConcurrency
//
//  Created by Thanh Nguyen Xuan on 21/3/25.
//

import Foundation
import KeychainAccess

protocol KeychainRepository {
    var userDetail: UserDetail? { get set }
}

final class KeychainRepositoryImpl: KeychainRepository {
    private let keychain =  Keychain(service: "thanhfnx")

    var userDetail: UserDetail? {
        get {
            if let data = try? keychain.getData("userDetail"),
               let result = try? JSONDecoder().decode(UserDetail.self, from: data) {
                return result
            }
            return nil
        }
        set {
            try? keychain.set(JSONEncoder().encode(newValue), key: "userDetail")
        }
    }
}
