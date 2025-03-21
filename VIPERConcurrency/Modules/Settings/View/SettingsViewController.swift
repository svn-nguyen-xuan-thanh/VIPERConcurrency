//  
//  SettingsViewController.swift
//  VIPERConcurrency
//
//  Created by Thanh Nguyen Xuan on 21/3/25.
//

import UIKit

final class SettingsViewController: UIViewController {

    var presenter: SettingsPresenterProtocol!

    override func viewDidLoad() {
        super.viewDidLoad()
        navigationItem.title = "Settings"
    }
    @IBAction private func logoutButtonTapped(_ sender: Any) {
        showConfirmAlert(
            title: "Confirm to log out",
            message: "Are you sure want to log out?",
            confirmButtonTitle: "Log out") {
                self.presenter.logout()
        }
    }
}

extension SettingsViewController:SettingsViewProtocol {
}
