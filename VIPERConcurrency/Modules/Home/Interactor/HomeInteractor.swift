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
    private var localFetchTask: Task<Void, Never>?

    func fetchProducts() {
        localFetchTask = Task { [databaseManager] in
            do {
                let products: [Product] = try await databaseManager.getAll()
                output?.onFetchProductsSuccess(with: products, fromLocal: true)
                print("Loaded \(products.count) products from local database.")
            } catch {}
        }
        Task { [productRepository, databaseManager] in
            do {
                let products = try await productRepository.fetchProducts().products
                localFetchTask?.cancel()
                Task.detached(priority: .background) {
                    try await databaseManager.saveAll(products)
                }
                output?.onFetchProductsSuccess(with: products, fromLocal: false)
            } catch {
                output?.onFetchProductsFailure(with: error)
            }
        }
    }
}
