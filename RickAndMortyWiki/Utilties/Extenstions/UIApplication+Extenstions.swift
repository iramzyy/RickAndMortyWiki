//
//  UIApplication+Extenstions.swift
//  RickAndMortyWiki
//
//  Created by Ahmed Ramzy on 28/09/2024.
//

import UIKit

public extension UIApplication {
    static func topViewController(_ base: UIViewController?
        = UIApplication.shared.keyWindow?.rootViewController) -> UIViewController? {
        if let navigationController = base as? UINavigationController, navigationController.viewControllers.count > 0 {
            return topViewController(navigationController.visibleViewController)
        }

        if let tabBarController = base as? UITabBarController {
            if let selected = tabBarController.selectedViewController {
                return topViewController(selected)
            }
        }

        if let presentedViewController = base?.presentedViewController {
            return topViewController(presentedViewController)
        }

        return base
    }

    static func tabBarController() -> UITabBarController? {
        let topController = UIApplication.topViewController()
        let tabBarController = topController?.tabBarController
        return tabBarController
    }

    static func topNavigationController() -> UINavigationController? {
        let topController = UIApplication.topViewController()
        let tabBarController = topController?.tabBarController
        let tabBarNavigationController = tabBarController?.navigationController
        let topNavigationController = topController?.navigationController
        let navigationController = topNavigationController ?? tabBarNavigationController
        return navigationController
    }
}
