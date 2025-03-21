//
//  ProductRepository.swift
//  VIPERConcurrency
//
//  Created by Thanh Nguyen Xuan on 21/3/25.
//

protocol ProductRepository {
    func fetchProducts() async throws -> ProductResponse
}

final class ProductRepositoryImpl: ProductRepository {
    private let api: APIService

    init(_ api: APIService) {
        self.api = api
    }

    func fetchProducts() async throws -> ProductResponse {
        return try await api.request(router: .fetchProducts)
    }
}

