//
//  Untitled.swift
//  VIPERConcurrency
//
//  Created by Thanh Nguyen Xuan on 20/3/25.
//

import Reachability

@MainActor
protocol ConnectivityProtocol {
    var isReachable: Bool { get }
}

final class ConnectivityManager: ConnectivityProtocol {
    static let shared = ConnectivityManager()
    var reachability: Reachability?

    private init() {
        reachability = try? Reachability()
            try? reachability?.startNotifier()
    }

    var isReachable: Bool {
        return reachability?.connection != .unavailable
    }
}
