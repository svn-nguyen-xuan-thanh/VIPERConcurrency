//  
//  HomeRouter.swift
//  VIPERConcurrency
//
//  Created by Thanh Nguyen Xuan on 20/3/25.
//

import UIKit

final class HomeRouter: HomeRouterProtocol {
    weak var viewController: HomeViewController?

    func navigateToLoginScreen() {
        let loginViewController = R.storyboard.login.instantiateInitialViewController()
        UIApplication.keyWindow()?.rootViewController = loginViewController
    }
}
