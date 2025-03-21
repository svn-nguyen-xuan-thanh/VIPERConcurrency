//  
//  SettingsRouter.swift
//  VIPERConcurrency
//
//  Created by Thanh Nguyen Xuan on 21/3/25.
//

import UIKit

final class SettingsRouter: SettingsRouterProtocol {
    weak var viewController: SettingsViewController?

    func navigateToLoginScreen() {
        let loginViewController = R.storyboard.login.instantiateInitialViewController()
        UIApplication.keyWindow()?.rootViewController = loginViewController
    }
}
