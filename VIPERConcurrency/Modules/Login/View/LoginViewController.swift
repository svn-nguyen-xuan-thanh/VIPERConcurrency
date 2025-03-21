//
//  LoginViewController.swift
//  VIPERConcurrency
//
//  Created by Thanh Nguyen Xuan on 20/3/25.
//

import UIKit
import Combine

final class LoginViewController: UIViewController {
    @IBOutlet private var usernameTextField: UITextField!
    @IBOutlet private var passwordTextField: UITextField!
    @IBOutlet private var loginButton: UIButton!
    @IBOutlet private var messageLabel: UILabel!

    var presenter: LoginPresenterProtocol!

    private let usernameSubject = CurrentValueSubject<String, Never>("")
    private let passwordSubject = CurrentValueSubject<String, Never>("")
    private var cancellables = Set<AnyCancellable>()

    override func awakeFromNib() {
        super.awakeFromNib()
        // https://www.massicotte.org/awakefromnib
        Task { @MainActor in
            setupViews()
        }
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
        usernameSubject.send(usernameTextField.text ?? "")
        passwordSubject.send(passwordTextField.text ?? "")
        NotificationCenter.default.publisher(for: UITextField.textDidChangeNotification, object: usernameTextField)
            .compactMap { ($0.object as? UITextField)?.text }
            .subscribe(usernameSubject)
            .store(in: &cancellables)

        NotificationCenter.default.publisher(for: UITextField.textDidChangeNotification, object: passwordTextField)
            .compactMap { ($0.object as? UITextField)?.text }
            .subscribe(passwordSubject)
            .store(in: &cancellables)

        Publishers.CombineLatest(usernameSubject, passwordSubject)
            .map { !$0.isEmpty && !$1.isEmpty }
            .receive(on: DispatchQueue.main)
            .assign(to: \.isEnabled, on: loginButton)
            .store(in: &cancellables)
    }

    @IBAction private func loginButtonTapped(_ sender: Any) {
        view.endEditing(true)
        let username = usernameTextField.text ?? ""
        let password = passwordTextField.text ?? ""

        let userInfo = UserLoginInfo(username: username, password: password)
        loginButton.isEnabled = false
        presenter.login(with: userInfo)
    }
}

extension LoginViewController: LoginViewProtocol {
    func showMessage(_ message: String) {
        messageLabel.text = message
    }
}
