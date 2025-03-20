//  
//  HomePresenter.swift
//  VIPERConcurrency
//
//  Created by Thanh Nguyen Xuan on 20/3/25.
//

import UIKit

final class HomePresenter: HomePresenterProtocol {
    weak var view: HomeViewProtocol?
    var interactor: HomeInteractorInputProtocol!
    var router: HomeRouterProtocol!
}

extension HomePresenter:HomeInteractorOutputProtocol {
}
