//  
//  LoginInteractor.swift
//  VIPERConcurrency
//
//  Created by Thanh Nguyen Xuan on 20/3/25.
//

import UIKit
import Swinject
import SwinjectStoryboard

final class LoginInteractor: LoginInteractorInputProtocol {
    weak var output: LoginInteractorOutputProtocol?
    private let userRepository = SwinjectStoryboard.defaultContainer.resolve(UserRepository.self)!

    func login(with userInfo: UserLoginInfo) {
        Task { [userRepository] in
            do {
                let userDetail = try await userRepository.login(with: userInfo)
                output?.onloginSuccess(with: userDetail)
            } catch {
                output?.onLoginFailed(with: error)
            }
        }
    }
}
