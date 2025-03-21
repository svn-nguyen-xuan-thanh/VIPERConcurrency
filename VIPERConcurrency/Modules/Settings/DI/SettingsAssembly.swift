//  
//  SettingsAssembly.swift
//  VIPERConcurrency
//
//  Created by Thanh Nguyen Xuan on 21/3/25.
//

import UIKit
import Swinject

@MainActor
final class SettingsAssembly: @preconcurrency Assembly {
    func assemble(container: Container) {
        container.register(SettingsPresenterProtocol.self) { (resolver, viewController: SettingsViewController) in
            let presenter = SettingsPresenter()
            presenter.view = viewController
            // Interactor
            let interactor = SettingsInteractor()
            interactor.output = presenter
            presenter.interactor = interactor
            // Router
            let router = SettingsRouter()
            router.viewController = viewController
            presenter.router = router
            return presenter
        }
    }
}
