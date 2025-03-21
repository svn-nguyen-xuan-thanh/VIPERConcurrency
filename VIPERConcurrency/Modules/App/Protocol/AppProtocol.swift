//  
//  AppProtocol.swift
//  VIPERConcurrency
//
//  Created by Thanh Nguyen Xuan on 20/3/25.
//

import UIKit

@MainActor
protocol AppPresenterProtocol: AnyObject {
    func start()
}

@MainActor
protocol AppInteractorInputProtocol: AnyObject {
}

@MainActor
protocol AppInteractorOutputProtocol: AnyObject {
}

@MainActor
protocol AppRouterProtocol: AnyObject {
    func navigateToHomeScreen()
    func navigateToLoginScreen()
}
