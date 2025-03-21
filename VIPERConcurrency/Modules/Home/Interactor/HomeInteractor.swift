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

    func fetchProducts() {
        Task { [productRepository] in
            do {
                let products = try await productRepository.fetchProducts().products
                output?.onFetchProductsSuccess(with: products)
            } catch {
                output?.onFetchProductsFailure(with: error)
            }
        }
    }
}
