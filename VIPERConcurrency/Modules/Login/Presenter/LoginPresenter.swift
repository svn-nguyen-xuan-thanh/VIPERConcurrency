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
}

extension LoginPresenter:LoginInteractorOutputProtocol {
}
