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
    private var keychainService = SwinjectStoryboard.defaultContainer.resolve(KeychainServiceProtocol.self)!

    var products: [Product] = []

    func onViewDidLoad() {
        Task {
            if let userDetail = await keychainService.read(ofType: UserDetail.self, key: .userDetail) {
                view?.updateView(with: userDetail)
                view?.showLoading()
                interactor.fetchProducts()
            } else {
                router.navigateToLoginScreen()
            }
        }
    }

    func fetchProducts() {
        interactor.fetchProducts()
    }

    func navigateToSettingsScreen() {
        router.navigateToSettingsScreen()
    }
}

extension HomePresenter:HomeInteractorOutputProtocol {
    func onFetchProductsSuccess(with products: [Product], fromLocal: Bool) {
        self.products = products
        if !fromLocal {
            view?.hideLoading()
        }
        view?.reloadTableView()
    }

    func onFetchProductsFailure(with error: Error) {
        var message = "Fetch products failed. "
        if let error = error as? APIError {
            message.append(error.errorMessage)
        }
        view?.hideLoading()
        view?.showMessage(message)
    }
}
