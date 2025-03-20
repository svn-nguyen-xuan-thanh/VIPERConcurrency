//  
//  LoginAssembly.swift
//  VIPERConcurrency
//
//  Created by Thanh Nguyen Xuan on 20/3/25.
//

import UIKit
import Swinject

@MainActor
final class LoginAssembly: @preconcurrency Assembly {
    func assemble(container: Container) {
        container.register(LoginPresenterProtocol.self) { (resolver, viewController: LoginViewController) in
            let presenter = LoginPresenter()
            presenter.view = viewController
            // Interactor
            let interactor = LoginInteractor()
            interactor.output = presenter
            presenter.interactor = interactor
            // Router
            let router = LoginRouter()
            router.viewController = viewController
            presenter.router = router
            return presenter
        }
    }
}
