//  
//  LoginProtocol.swift
//  VIPERConcurrency
//
//  Created by Thanh Nguyen Xuan on 20/3/25.
//

import UIKit

@MainActor
protocol LoginViewProtocol: BaseViewProtocol {
    func showMessage(_ message: String)
}

@MainActor
protocol LoginPresenterProtocol: AnyObject {
    func login(with userInfo: UserLoginInfo)
}

@MainActor
protocol LoginInteractorInputProtocol: AnyObject {
    func login(with userInfo: UserLoginInfo)
}

@MainActor
protocol LoginInteractorOutputProtocol: AnyObject {
    func onloginSuccess(with userDetail: UserDetail)
    func onLoginFailed(with error: Error)
}

@MainActor
protocol LoginRouterProtocol: AnyObject {
    func navigateToHomeScreen()
}
