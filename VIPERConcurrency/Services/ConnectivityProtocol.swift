//
//  Untitled.swift
//  VIPERConcurrency
//
//  Created by Thanh Nguyen Xuan on 20/3/25.
//

import Reachability

protocol ConnectivityProtocol {
    var isReachable: Bool { get }
}

final class ConnectivityManager: ConnectivityProtocol {
    private let reachability: Reachability?

    init() {
        reachability = try? Reachability()
        try? reachability?.startNotifier()
    }

    var isReachable: Bool {
        return reachability?.connection != .unavailable
    }
}
