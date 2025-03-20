//  ___FILEHEADER___

import UIKit
import Swinject

@MainActor
final class ___FILEBASENAMEASIDENTIFIER___: @preconcurrency Assembly {
    func assemble(container: Container) {
        container.register(___VARIABLE_productName:identifier___PresenterProtocol.self) { (resolver, viewController: ___VARIABLE_productName:identifier___ViewController) in
            let presenter = ___VARIABLE_productName:identifier___Presenter()
            presenter.view = viewController
            // Interactor
            let interactor = ___VARIABLE_productName:identifier___Interactor()
            interactor.output = presenter
            presenter.interactor = interactor
            // Router
            let router = ___VARIABLE_productName:identifier___Router()
            router.viewController = viewController
            presenter.router = router
            return presenter
        }
    }
}
