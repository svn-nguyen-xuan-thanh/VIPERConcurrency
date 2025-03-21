//  
//  LoginRouter.swift
//  VIPERConcurrency
//
//  Created by Thanh Nguyen Xuan on 20/3/25.
//

import UIKit

final class LoginRouter: LoginRouterProtocol {
    weak var viewController: LoginViewController?

    func navigateToHomeScreen() {
        let keyWindow = UIApplication.keyWindow()
        keyWindow?.rootViewController = R.storyboard.home.instantiateInitialViewController()
    }
}
