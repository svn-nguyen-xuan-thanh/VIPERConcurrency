//  
//  HomePresenter.swift
//  VIPERConcurrency
//
//  Created by Thanh Nguyen Xuan on 20/3/25.
//

import UIKit
import SwinjectStoryboard

final class HomePresenter: HomePresenterProtocol {
    weak var view: HomeViewProtocol?
    var interactor: HomeInteractorInputProtocol!
    var router: HomeRouterProtocol!
    private var keychainRepository = SwinjectStoryboard.defaultContainer.resolve(KeychainRepository.self)!

    var products: [Product] = []

    func onViewDidLoad() {
        if let userDetail = keychainRepository.userDetail {
            view?.updateView(with: userDetail)
            interactor.fetchProducts()
        } else {
            router.navigateToLoginScreen()
        }
    }

    func fetchProducts() {
        interactor.fetchProducts()
    }
}

extension HomePresenter:HomeInteractorOutputProtocol {
    func onFetchProductsSuccess(with products: [Product]) {
        self.products = products
        view?.reloadTableView()
    }

    func onFetchProductsFailure(with error: Error) {
        var message = "Fetch products failed. "
        if let error = error as? APIError {
            message.append(error.errorMessage)
        }
        view?.showMessage(message)
    }
}
