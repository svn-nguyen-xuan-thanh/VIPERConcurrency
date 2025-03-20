//
//  APIService.swift
//  VIPERConcurrency
//
//  Created by Thanh Nguyen Xuan on 20/3/25.
//

import Alamofire
import Foundation
import RxSwift

enum APIError: Error {
    case offline
    case unknown

    var localDescription: String {
        switch self {
        case .offline:
            return "No internet connection"
        case .unknown:
            return "Unknown error"
        }
    }
}

final class APIService {
    private let session: Session
    let connectivityManager: ConnectivityProtocol

    init(
        session: Session = Session.default,
        connectivityManager: ConnectivityProtocol = ConnectivityManager.shared
    ) {
        self.session = session
        self.connectivityManager = connectivityManager
    }

    func request<T: Decodable>(router: APIRouter) -> Single<T> {
        return Single<T>.create { singleEvent in
            if !self.connectivityManager.isReachable {
                singleEvent(.failure(APIError.offline))
                return Disposables.create()
            }
            let request = self.session.request(router)
            request.responseData { response in
                print("[API]----Request: \(router.urlRequest?.httpMethod ?? "") " + (router.urlRequest?.url?.absoluteString ?? ""))
                print("[API]----Response: \(String(data: response.data ?? Data(), encoding: .utf8)!)")
                if let data = response.data, let value = try? JSONDecoder().decode(T.self, from: data) {
                    singleEvent(.success(value))
                } else {
                    singleEvent(.failure(APIError.unknown))
                }
            }
            return Disposables.create {
                request.cancel()
            }
        }
    }
}
