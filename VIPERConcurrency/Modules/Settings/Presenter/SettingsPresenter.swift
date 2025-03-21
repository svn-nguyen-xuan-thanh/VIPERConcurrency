//  
//  SettingsPresenter.swift
//  VIPERConcurrency
//
//  Created by Thanh Nguyen Xuan on 21/3/25.
//

import UIKit
import SwinjectStoryboard

final class SettingsPresenter: SettingsPresenterProtocol {
    weak var view: SettingsViewProtocol?
    var interactor: SettingsInteractorInputProtocol!
    var router: SettingsRouterProtocol!
    private let keychainService = SwinjectStoryboard.defaultContainer.resolve(KeychainServiceProtocol.self)!

    func logout() {
        Task {
            await keychainService.clear(forKey: .userDetail)
        }
        router.navigateToLoginScreen()
    }
}

extension SettingsPresenter:SettingsInteractorOutputProtocol {
}
