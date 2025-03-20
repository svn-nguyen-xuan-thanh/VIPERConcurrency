//  
//  AppProtocol.swift
//  VIPERConcurrency
//
//  Created by Thanh Nguyen Xuan on 20/3/25.
//

import UIKit

@MainActor
protocol AppViewProtocol: AnyObject {
}

@MainActor
protocol AppPresenterProtocol: AnyObject {
}

@MainActor
protocol AppInteractorInputProtocol: AnyObject {
}

@MainActor
protocol AppInteractorOutputProtocol: AnyObject {
}

@MainActor
protocol AppRouterProtocol: AnyObject {
}
