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

struct ErrorMessage: Decodable {
    let message: String
}

final class APIService {
    private let session: Session
    private let connectivityManager: ConnectivityProtocol

    init(
        session: Session = Session.default,
        connectivityManager: ConnectivityProtocol
    ) {
        self.session = session
        self.connectivityManager = connectivityManager
    }

    func request<T: Decodable>(router: APIRouter) async throws -> T {
        if !connectivityManager.isReachable {
            throw APIError.offline
        }
        await ProgressHUD.animate()
        return try await withCheckedThrowingContinuation { continuation in
            session.request(router).responseData { response in
                print("[API]----Request: \(router.urlRequest?.httpMethod ?? "") " + (router.urlRequest?.url?.absoluteString ?? ""))
                print("[API]----Response: \(String(data: response.data ?? Data(), encoding: .utf8)!)")
                if let data = response.data {
                    if let value = try? JSONDecoder().decode(T.self, from: data) {
                        Task { @MainActor in
                            ProgressHUD.dismiss()
                        }
                        continuation.resume(returning: value)
                    } else if let message = try? JSONDecoder().decode(ErrorMessage.self, from: data) {
                        Task { @MainActor in
                            ProgressHUD.dismiss()
                        }
                        continuation.resume(throwing: APIError.invalidResponse(message: message.message))
                    } else {
                        Task { @MainActor in
                            ProgressHUD.dismiss()
                        }
                        continuation.resume(throwing: APIError.unknown)
                    }
                } else {
                    Task { @MainActor in
                        ProgressHUD.dismiss()
                    }
                    continuation.resume(throwing: APIError.unknown)
                }
            }
        }
    }

//    func request<T: Decodable>(router: APIRouter) -> Single<T> {
//        return Single<T>.create { singleEvent in
//            if !self.connectivityManager.isReachable {
//                singleEvent(.failure(APIError.offline))
//                return Disposables.create()
//            }
//            let request = self.session.request(router)
//            request.responseData { response in
//                print("[API]----Request: \(router.urlRequest?.httpMethod ?? "") " + (router.urlRequest?.url?.absoluteString ?? ""))
//                print("[API]----Response: \(String(data: response.data ?? Data(), encoding: .utf8)!)")
//                if let data = response.data, let value = try? JSONDecoder().decode(T.self, from: data) {
//                    singleEvent(.success(value))
//                } else {
//                    singleEvent(.failure(APIError.unknown))
//                }
//            }
//            return Disposables.create {
//                request.cancel()
//            }
//        }
//    }
}
