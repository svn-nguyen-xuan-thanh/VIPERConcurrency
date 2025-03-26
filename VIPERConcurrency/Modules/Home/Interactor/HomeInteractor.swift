//  
//  HomeInteractor.swift
//  VIPERConcurrency
//
//  Created by Thanh Nguyen Xuan on 20/3/25.
//

import UIKit
import SwinjectStoryboard

final class HomeInteractor: HomeInteractorInputProtocol {
    weak var output: HomeInteractorOutputProtocol?
    private let productRepository = SwinjectStoryboard.defaultContainer.resolve(ProductRepository.self)!
    private let databaseManager = SwinjectStoryboard.defaultContainer.resolve(AppDatabase.self)!

    func fetchProducts(fetchFromLocal: Bool) {
        let localFetchTask: Task<Void, any Error> = if fetchFromLocal {
            Task {
                let products: [Product] = try await databaseManager.getAll()
                output?.onFetchProductsSuccess(with: products, fromLocal: true)
            }
        } else {
            Task {}
        }
        Task { [productRepository] in
            do {
                let products = try await productRepository.fetchProducts().products
                localFetchTask.cancel()
                Task.detached(priority: .background) {
                    try await self.databaseManager.saveAll(products)
                }
                output?.onFetchProductsSuccess(with: products, fromLocal: false)
            } catch {
                output?.onFetchProductsFailure(with: error)
            }
        }
    }
}
