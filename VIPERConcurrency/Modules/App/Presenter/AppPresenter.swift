//  
//  AppPresenter.swift
//  VIPERConcurrency
//
//  Created by Thanh Nguyen Xuan on 20/3/25.
//

import UIKit

final class AppPresenter: AppPresenterProtocol {
    weak var view: AppViewProtocol?
    var interactor: AppInteractorInputProtocol!
    var router: AppRouterProtocol!
}

extension AppPresenter:AppInteractorOutputProtocol {
}
