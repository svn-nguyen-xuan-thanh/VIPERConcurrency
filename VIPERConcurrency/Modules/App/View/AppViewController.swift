//  
//  AppViewController.swift
//  VIPERConcurrency
//
//  Created by Thanh Nguyen Xuan on 20/3/25.
//

import UIKit

final class AppViewController: UIViewController {

    var presenter: AppPresenterProtocol!

    override func viewDidLoad() {
        super.viewDidLoad()
    }
}

extension AppViewController:AppViewProtocol {
}
