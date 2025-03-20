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

        defaultContainer.register(AppPresenterProtocol.self) { _ in
            let assembler = Assembler([AppAssembly()])
            return assembler.resolver.resolve(AppPresenterProtocol.self)!
        }.inObjectScope(.container)

        defaultContainer.storyboardInitCompleted(LoginViewController.self) { _, c in
            let assembler = Assembler([LoginAssembly()])
            c.presenter = assembler.resolver.resolve(LoginPresenterProtocol.self, argument: c)
        }
    }
}
