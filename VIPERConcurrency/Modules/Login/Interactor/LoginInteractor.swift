//  
//  LoginInteractor.swift
//  VIPERConcurrency
//
//  Created by Thanh Nguyen Xuan on 20/3/25.
//

import UIKit
import RxSwift
import Swinject
import SwinjectStoryboard

final class LoginInteractor: LoginInteractorInputProtocol {
    weak var output: LoginInteractorOutputProtocol?
    private let userRepository = SwinjectStoryboard.defaultContainer.resolve(UserRepository.self)!
    private let disposeBag = DisposeBag()

    func login(with userInfo: UserInfo) {
        userRepository.login(with: userInfo).subscribe { [weak self] userDetail in
            self?.output?.onloginSuccess(with: userDetail)
        } onFailure: { [weak self] _ in
            self?.output?.onLoginFailed()
        }
        .disposed(by: disposeBag)
    }
}
