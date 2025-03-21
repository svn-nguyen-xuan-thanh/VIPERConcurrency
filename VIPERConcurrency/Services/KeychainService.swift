//
//  KeychainService.swift
//  VIPERConcurrency
//
//  Created by Thanh Nguyen Xuan on 21/3/25.
//

import Foundation
import KeychainAccess

protocol KeychainServiceProtocol: Actor {
    func write<T: Encodable>(_ object: T, key: KeychainAccessKey)
    func read<T: Decodable>(ofType type: T.Type, key: KeychainAccessKey) -> T?
    func clear(forKey key: KeychainAccessKey)
}

enum KeychainAccessKey: String {
    case userDetail
}

actor KeychainService: KeychainServiceProtocol {
    private let keychain =  Keychain(service: "thanhfnx")

    func write<T: Encodable>(_ object: T, key: KeychainAccessKey) {
        guard let data = try? JSONEncoder().encode(object) else { return }
        try? keychain.set(data, key: key.rawValue)
    }

    func read<T: Decodable>(ofType type: T.Type, key: KeychainAccessKey) -> T? {
        guard let data = try? keychain.getData(key.rawValue) else { return nil }
        return try? JSONDecoder().decode(T.self, from: data)
    }

    func clear(forKey key: KeychainAccessKey) {
        try? keychain.remove(key.rawValue)
    }
}
