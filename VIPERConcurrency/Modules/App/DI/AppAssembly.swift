//  
//  AppAssembly.swift
//  VIPERConcurrency
//
//  Created by Thanh Nguyen Xuan on 20/3/25.
//

import UIKit
import Swinject

@MainActor
final class AppAssembly: @preconcurrency Assembly {
    func assemble(container: Container) {
        container.register(AppPresenterProtocol.self) { resolver in
            let presenter = AppPresenter()
            // Interactor
            let interactor = AppInteractor()
            interactor.output = presenter
            presenter.interactor = interactor
            // Router
            let router = AppRouter()
            presenter.router = router
            return presenter
        }
    }
}
