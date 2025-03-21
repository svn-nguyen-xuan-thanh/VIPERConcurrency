//
//  APIService.swift
//  VIPERConcurrency
//
//  Created by Thanh Nguyen Xuan on 20/3/25.
//

import Alamofire
import Foundation
import ProgressHUD

enum APIError: Error {
    case offline
    case invalidResponse(message: String)
    case unknown

    var errorMessage: String {
        switch self {
        case .offline:
            return "No internet connection"
        case .unknown:
            return "Unknown error"
        case let .invalidResponse(message):
            return message
        }
    }
}

final class APIService {
    private let connectivityManager: ConnectivityProtocol

    init(connectivityManager: ConnectivityProtocol) {
        self.connectivityManager = connectivityManager
    }

    func request<T: Decodable>(router: APIRouter) async throws -> T {
        if !connectivityManager.isReachable {
            throw APIError.offline
        }
        await ProgressHUD.animate()
        let request = try router.asURLRequest()
        let (data, _) = try await URLSession.shared.data(for: request)
        await ProgressHUD.dismiss()
        print("[API]----Request: \(request.httpMethod ?? "") " + (request.url?.absoluteString ?? ""))
        print("[API]----Response: \(String(data: data, encoding: .utf8)!)")
        if let value = try? JSONDecoder().decode(T.self, from: data) {
            return value
        } else if let message = try? JSONDecoder().decode(ErrorMessage.self, from: data) {
            throw APIError.invalidResponse(message: message.message)
        } else {
            throw APIError.unknown
        }
    }

    func requestAlamofire<T: Decodable>(router: APIRouter) async throws -> T {
        if !connectivityManager.isReachable {
            throw APIError.offline
        }
        await ProgressHUD.animate()
        return try await withCheckedThrowingContinuation { continuation in
            Session.default.request(router).responseData { response in
                Task {
                    await ProgressHUD.dismiss()
                }
                print("[API]----Request: \(router.urlRequest?.httpMethod ?? "") " + (router.urlRequest?.url?.absoluteString ?? ""))
                print("[API]----Response: \(String(data: response.data ?? Data(), encoding: .utf8)!)")
                if let data = response.data {
                    if let value = try? JSONDecoder().decode(T.self, from: data) {
                        continuation.resume(returning: value)
                    } else if let message = try? JSONDecoder().decode(ErrorMessage.self, from: data) {
                        continuation.resume(throwing: APIError.invalidResponse(message: message.message))
                    } else {
                        continuation.resume(throwing: APIError.unknown)
                    }
                } else {
                    continuation.resume(throwing: APIError.unknown)
                }
            }
        }
    }
}
