//
//  SceneDelegate.swift
//  QFree
//
//  Created by Maxim Sidorov on 22.10.2020.
//

import UIKit
import Firebase

class SceneDelegate: UIResponder, UIWindowSceneDelegate {

    var window: UIWindow?

    func scene(_ scene: UIScene, willConnectTo session: UISceneSession, options connectionOptions: UIScene.ConnectionOptions) {
        FirebaseApp.configure()
        
        print("CURRENT USER:", Auth.auth().currentUser?.email ?? "nil")
        
        guard let mainScene = (scene as? UIWindowScene) else { return }
        window = UIWindow(windowScene: mainScene)
        window?.overrideUserInterfaceStyle = .light
        window?.tintColor = Brandbook.defaultColor
        window?.rootViewController = initialViewController
        window?.makeKeyAndVisible()
    }
    
    private var initialViewController: UIViewController {
        if Auth.auth().currentUser == nil {
            return BaseNavigationController(rootViewController: EntranceModuleBuilder.build())
        }
        
        return TabBarController()
    }
}
