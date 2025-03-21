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

    func navigateToSettingsScreen() {
        guard let settingsViewController = R.storyboard.settings.instantiateInitialViewController() else {
            return
        }
        viewController?.navigationController?.pushViewController(settingsViewController, animated: true)
    }
}
