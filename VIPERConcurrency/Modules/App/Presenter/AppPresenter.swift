//  
//  AppPresenter.swift
//  VIPERConcurrency
//
//  Created by Thanh Nguyen Xuan on 20/3/25.
//

import UIKit
import SwinjectStoryboard

final class AppPresenter: AppPresenterProtocol {
    var interactor: AppInteractorInputProtocol!
    var router: AppRouterProtocol!
    private let keychainService = SwinjectStoryboard.defaultContainer.resolve(KeychainServiceProtocol.self)!

    func start() {
        Task {
            if let _ = await keychainService.read(ofType: UserDetail.self, key: .userDetail) {
                router.navigateToHomeScreen()
            } else {
                router.navigateToLoginScreen()
            }
        }
    }
}

extension AppPresenter:AppInteractorOutputProtocol {
}
