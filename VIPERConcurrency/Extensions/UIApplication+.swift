//
//  UIApplication+.swift
//  VIPERConcurrency
//
//  Created by Thanh Nguyen Xuan on 21/3/25.
//

import UIKit

extension UIApplication {
    class func keyWindow() -> UIWindow? {
        let windowScene = UIApplication.shared.connectedScenes.first as? UIWindowScene
        return windowScene?.windows.first(where: { $0.isKeyWindow }) ?? windowScene?.windows.first
    }
}
