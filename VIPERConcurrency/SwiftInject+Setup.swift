//
//  Swinject.swift
//  VIPERConcurrency
//
//  Created by Thanh Nguyen Xuan on 20/3/25.
//

import Swinject
import SwinjectStoryboard

extension SwinjectStoryboard {
    class func setup() {
        Container.loggingFunction = nil

        defaultContainer.register(ConnectivityProtocol.self) { _ in
            return ConnectivityManager()
        }

        defaultContainer.register(KeychainServiceProtocol.self) { _ in
            return KeychainService()
        }

        defaultContainer.register(APIService.self) { resolver in
            let connectivityManager = resolver.resolve(ConnectivityProtocol.self)!
            return APIService(connectivityManager: connectivityManager)
        }
        .inObjectScope(.container)

        defaultContainer.register(AppDatabase.self) { resolver in
            return AppDatabaseManager()
        }
        .inObjectScope(.container)

        defaultContainer.register(UserRepository.self) { resolver in
            let api = resolver.resolve(APIService.self)!
            return UserRepositoryImpl(api)
        }
        .inObjectScope(.container)

        defaultContainer.register(ProductRepository.self) { resolver in
            let api = resolver.resolve(APIService.self)!
            return ProductRepositoryImpl(api)
        }
        .inObjectScope(.container)

        defaultContainer.register(AppPresenterProtocol.self) { _ in
            let assembler = Assembler([AppAssembly()])
            return assembler.resolver.resolve(AppPresenterProtocol.self)!
        }
        .inObjectScope(.container)

        defaultContainer.storyboardInitCompleted(LoginViewController.self) { resolver, controller in
            let assembler = Assembler([LoginAssembly()])
            controller.presenter = assembler.resolver.resolve(
                LoginPresenterProtocol.self,
                argument: controller
            )
        }

        defaultContainer.storyboardInitCompleted(HomeViewController.self) { resolver, controller in
            let assembler = Assembler([HomeAssembly()])
            controller.presenter = assembler.resolver.resolve(
                HomePresenterProtocol.self,
                argument: controller
            )
        }

        defaultContainer.storyboardInitCompleted(SettingsViewController.self) { resolver, controller in
            let assembler = Assembler([SettingsAssembly()])
            controller.presenter = assembler.resolver.resolve(
                SettingsPresenterProtocol.self,
                argument: controller
            )
        }
    }
}
