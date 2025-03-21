//
//  APIRouter.swift
//  VIPERConcurrency
//
//  Created by Thanh Nguyen Xuan on 20/3/25.
//

import Alamofire
import Foundation

enum Constants {
    enum AppURLs {
        static let apiUrl = "https://dummyjson.com/"
    }
}

enum APIRouter {
    case login(userInfo: UserLoginInfo)
    case fetchProducts

    private var method: HTTPMethod {
        switch self {
        case .login:
            return .post
        case .fetchProducts:
            return .get
        }
    }

    private var url: String {
        Constants.AppURLs.apiUrl
    }

    private var path: String {
        switch self {
        case .login:
            return "auth/login"
        case .fetchProducts:
            return "products"
        }
    }

    private var encoding: ParameterEncoding {
        switch self {
        case .login:
            return JSONEncoding.default
        case .fetchProducts:
            return URLEncoding.default
        }
    }

    private var params: [String: any Sendable]? {
        switch self {
        case let .login(userInfo):
            return ["username": userInfo.username, "password": userInfo.password]
        case .fetchProducts:
            return ["limit": 0]
        }
    }

    private var header: [String: String] {
        ["Content-Type": "application/json"]
    }
}

extension APIRouter: URLRequestConvertible {
    func asURLRequest() throws -> URLRequest {
        let url = try url.asURL().appendingPathComponent(path)
        var request = URLRequest(url: url)
        request.httpMethod = method.rawValue
        request = try encoding.encode(request, with: params)
        request.headers = HTTPHeaders(header)
        return request
    }
}
