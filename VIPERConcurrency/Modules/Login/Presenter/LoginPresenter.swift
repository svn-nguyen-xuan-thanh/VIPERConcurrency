//  
//  LoginPresenter.swift
//  VIPERConcurrency
//
//  Created by Thanh Nguyen Xuan on 20/3/25.
//

import UIKit
import SwinjectStoryboard

final class LoginPresenter: LoginPresenterProtocol {
    weak var view: LoginViewProtocol?
    var interactor: LoginInteractorInputProtocol!
    var router: LoginRouterProtocol!
    private var keychainRepository = SwinjectStoryboard.defaultContainer.resolve(KeychainRepository.self)!

    func login(with userInfo: UserLoginInfo) {
        interactor.login(with: userInfo)
    }
}

extension LoginPresenter:LoginInteractorOutputProtocol {
    func onloginSuccess(with userDetail: UserDetail) {
        view?.showMessage("Login successfully! Redirecting to home screen...")
        Task {
            await keychainRepository.write(userDetail, key: .userDetail)
            try? await Task.sleep(nanoseconds: 2 * 1000000000)
            router.navigateToHomeScreen()
        }
    }

    func onLoginFailed(with error: Error) {
        var message = "Login failed! "
        if let error = error as? APIError {
            message.append("\(error.errorMessage)!")
        }
        view?.showMessage(message)
    }
}
