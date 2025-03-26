//
//  BaseViewProtocol.swift
//  VIPERConcurrency
//
//  Created by Thanh Nguyen Xuan on 26/3/25.
//

import UIKit
import ProgressHUD

@MainActor
protocol BaseViewProtocol: AnyObject {
    func showLoading()
    func hideLoading()
}

extension UIViewController: BaseViewProtocol {
    func showLoading() {
        ProgressHUD.animate()
    }

    func hideLoading() {
        ProgressHUD.dismiss()
    }
}
