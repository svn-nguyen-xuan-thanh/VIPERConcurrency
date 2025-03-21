//  
//  AppRouter.swift
//  VIPERConcurrency
//
//  Created by Thanh Nguyen Xuan on 20/3/25.
//

import UIKit

final class AppRouter: AppRouterProtocol {
    func navigateToHomeScreen() {
        let homeViewController = R.storyboard.home.instantiateInitialViewController()
        UIApplication.keyWindow()?.rootViewController = homeViewController
    }

    func navigateToLoginScreen() {
        let loginViewController = R.storyboard.login.instantiateInitialViewController()
        UIApplication.keyWindow()?.rootViewController = loginViewController
    }
}
