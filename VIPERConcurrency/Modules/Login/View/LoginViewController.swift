//
//  LoginViewController.swift
//  VIPERConcurrency
//
//  Created by Thanh Nguyen Xuan on 20/3/25.
//

import UIKit
import RxSwift
import RxCocoa

final class LoginViewController: UIViewController {
    @IBOutlet private var usernameTextField: UITextField!
    @IBOutlet private var passwordTextField: UITextField!
    @IBOutlet private var loginButton: UIButton!
    @IBOutlet private var messageLabel: UILabel!

    var presenter: LoginPresenterProtocol!
    private let disposeBag = DisposeBag()

    override func awakeFromNib() {
        super.awakeFromNib()
        Task { @MainActor in
            setupViews()
        }

        // Alternative code, which one is better?
        // https://www.massicotte.org/awakefromnib
        /*
         MainActor.assumeIsolated {
         setupViews()
         }
         */
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        bindViews()
    }

    private func setupViews() {
        passwordTextField.isSecureTextEntry = true
        loginButton.isEnabled = false
    }

    private func bindViews() {
        let usernameValid = usernameTextField.rx.text.orEmpty
            .map { !$0.isEmpty }

        let passwordValid = passwordTextField.rx.text.orEmpty
            .map { !$0.isEmpty }

        Observable.combineLatest(usernameValid, passwordValid)
            .map { $0 && $1 }
            .bind(to: loginButton.rx.isEnabled)
            .disposed(by: disposeBag)
    }

    @IBAction private func loginButtonTapped(_ sender: Any) {
        let userName = usernameTextField.text ?? ""
        let password = passwordTextField.text ?? ""

        let userInfo = UserInfo(username: userName, password: password)
        presenter.login(with: userInfo)
    }
}

extension LoginViewController: LoginViewProtocol {
    func showMessage(_ message: String) {
        messageLabel.text = message
    }
}
