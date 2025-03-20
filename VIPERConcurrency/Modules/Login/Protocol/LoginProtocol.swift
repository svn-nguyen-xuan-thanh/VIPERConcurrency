//  
//  LoginProtocol.swift
//  VIPERConcurrency
//
//  Created by Thanh Nguyen Xuan on 20/3/25.
//

import UIKit

@MainActor
protocol LoginViewProtocol: AnyObject {
    func showMessage(_ message: String)
}

@MainActor
protocol LoginPresenterProtocol: AnyObject {
    func login(with userInfo: UserInfo)
}

@MainActor
protocol LoginInteractorInputProtocol: AnyObject {
    func login(with userInfo: UserInfo)
}

@MainActor
protocol LoginInteractorOutputProtocol: AnyObject {
    func onloginSuccess(with userDetail: UserDetail)
    func onLoginFailed()
}

@MainActor
protocol LoginRouterProtocol: AnyObject {
    func navigateToHomeScreen()
}
