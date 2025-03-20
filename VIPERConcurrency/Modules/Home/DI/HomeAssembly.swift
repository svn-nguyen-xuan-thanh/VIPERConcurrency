//  
//  HomeAssembly.swift
//  VIPERConcurrency
//
//  Created by Thanh Nguyen Xuan on 20/3/25.
//

import UIKit
import Swinject

@MainActor
final class HomeAssembly: @preconcurrency Assembly {
    func assemble(container: Container) {
        container.register(HomePresenterProtocol.self) { (resolver, viewController: HomeViewController) in
            let presenter = HomePresenter()
            presenter.view = viewController
            // Interactor
            let interactor = HomeInteractor()
            interactor.output = presenter
            presenter.interactor = interactor
            // Router
            let router = HomeRouter()
            router.viewController = viewController
            presenter.router = router
            return presenter
        }
    }
}
