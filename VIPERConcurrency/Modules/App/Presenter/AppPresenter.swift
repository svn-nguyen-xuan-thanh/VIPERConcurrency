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
    private let keychainRepository = SwinjectStoryboard.defaultContainer.resolve(KeychainRepository.self)!

    func start() {
        Task {
            if let _ = await keychainRepository.read(ofType: UserDetail.self, key: .userDetail) {
                router.navigateToHomeScreen()
            } else {
                router.navigateToLoginScreen()
            }
        }
    }
}

extension AppPresenter:AppInteractorOutputProtocol {
}
