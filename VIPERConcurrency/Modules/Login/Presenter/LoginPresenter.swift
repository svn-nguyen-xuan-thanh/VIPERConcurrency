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

    func login(with userInfo: UserInfo) {
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

    func onLoginFailed() {
        view?.showMessage("Login failed! Username or password is incorrect!")
    }
}
