//  
//  HomeProtocol.swift
//  VIPERConcurrency
//
//  Created by Thanh Nguyen Xuan on 20/3/25.
//

import UIKit

@MainActor
protocol HomeViewProtocol: AnyObject {
    func updateView(with userDetail: UserDetail)
    func reloadTableView()
    func showMessage(_ message: String)
}

@MainActor
protocol HomePresenterProtocol: AnyObject {
    var products: [Product] { get set }

    func onViewDidLoad()
    func fetchProducts()
}

@MainActor
protocol HomeInteractorInputProtocol: AnyObject {
    func fetchProducts()
}

@MainActor
protocol HomeInteractorOutputProtocol: AnyObject {
    func onFetchProductsSuccess(with products: [Product])
    func onFetchProductsFailure(with error: Error)
}

@MainActor
protocol HomeRouterProtocol: AnyObject {
    func navigateToLoginScreen()
}
