//  
//  LoginPresenter.swift
//  VIPERConcurrency
//
//  Created by Thanh Nguyen Xuan on 20/3/25.
//

import UIKit

final class LoginPresenter: LoginPresenterProtocol {
    weak var view: LoginViewProtocol?
    var interactor: LoginInteractorInputProtocol!
    var router: LoginRouterProtocol!

    func login(with userInfo: UserLoginInfo) {
        interactor.login(with: userInfo)
    }
}

extension LoginPresenter:LoginInteractorOutputProtocol {
    func onloginSuccess(with userDetail: UserDetail) {
        view?.showMessage("Login successfully! Redirecting to home screen...")
        DispatchQueue.main.asyncAfter(deadline: .now() + 2) {
            self.router.navigateToHomeScreen()
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
