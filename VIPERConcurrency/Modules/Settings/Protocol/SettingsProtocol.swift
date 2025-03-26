//  
//  SettingsProtocol.swift
//  VIPERConcurrency
//
//  Created by Thanh Nguyen Xuan on 21/3/25.
//

import UIKit

@MainActor
protocol SettingsViewProtocol: BaseViewProtocol {
}

@MainActor
protocol SettingsPresenterProtocol: AnyObject {
    func logout()
}

@MainActor
protocol SettingsInteractorInputProtocol: AnyObject {
}

@MainActor
protocol SettingsInteractorOutputProtocol: AnyObject {
}

@MainActor
protocol SettingsRouterProtocol: AnyObject {
    func navigateToLoginScreen()
}
