//
//  LoginViewController.swift
//  VIPERConcurrency
//
//  Created by Thanh Nguyen Xuan on 20/3/25.
//

import UIKit

final class LoginViewController: UIViewController {
    @IBOutlet private var usernameTextField: UITextField!
    @IBOutlet private var passwordTextField: UITextField!

    var presenter: LoginPresenterProtocol!

    override func awakeFromNib() {
        super.awakeFromNib()
        Task { @MainActor in
            setupViews()
        }

        // Alternative code, which one is better?
        // https://www.massicotte.org/awakefromnib
        MainActor.assumeIsolated {
            setupViews()
        }
    }

    override func viewDidLoad() {
        super.viewDidLoad()
    }

    private func setupViews() {
        passwordTextField.isSecureTextEntry = true
    }
}

extension LoginViewController:LoginViewProtocol {
}
