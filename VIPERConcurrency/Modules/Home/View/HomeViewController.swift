//  
//  HomeViewController.swift
//  VIPERConcurrency
//
//  Created by Thanh Nguyen Xuan on 20/3/25.
//

import UIKit

final class HomeViewController: UIViewController {

    var presenter: HomePresenterProtocol!

    override func viewDidLoad() {
        super.viewDidLoad()
    }
}

extension HomeViewController:HomeViewProtocol {
}
