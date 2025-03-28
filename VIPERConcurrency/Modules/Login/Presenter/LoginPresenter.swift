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
    private let keychainService = SwinjectStoryboard.defaultContainer.resolve(KeychainServiceProtocol.self)!

    func login(with userInfo: UserLoginInfo) {
        view?.showLoading()
        interactor.login(with: userInfo)
    }
}

extension LoginPresenter:LoginInteractorOutputProtocol {
    func onloginSuccess(with userDetail: UserDetail) {
        view?.hideLoading()
        view?.showMessage("Login successfully! Redirecting to home screen...")
        Task {
            await keychainService.write(userDetail, key: .userDetail)
            try? await Task.sleep(nanoseconds: 2 * 1000000000)
            router.navigateToHomeScreen()
        }
    }

    func onLoginFailed(with error: Error) {
        var message = "Login failed! "
        if let error = error as? APIError {
            message.append("\(error.errorMessage)!")
        }
        view?.hideLoading()
        view?.showMessage(message)
    }
}
