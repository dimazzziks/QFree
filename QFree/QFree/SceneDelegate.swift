//
//  SceneDelegate.swift
//  QFree
//
//  Created by Maxim Sidorov on 22.10.2020.
//

import UIKit

class SceneDelegate: UIResponder, UIWindowSceneDelegate {

    var window: UIWindow?

    func scene(_ scene: UIScene, willConnectTo session: UISceneSession, options connectionOptions: UIScene.ConnectionOptions) {
        guard let mainScene = (scene as? UIWindowScene) else { return }
        window = UIWindow(windowScene: mainScene)
        window?.overrideUserInterfaceStyle = .light
        window?.rootViewController = BaseNavigationViewController(rootViewController: EntranceModuleBuilder.build())
        window?.makeKeyAndVisible()
    }
}

