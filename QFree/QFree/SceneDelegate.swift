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
        
//        FOR DEBUG
//        signOut()
        
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
        } else {
            // TODO: - Show main menu
//            let currentUserViewController = BaseViewController()
            let tabBarController = TabBarController()
//            let currentUserEmail = Auth.auth().currentUser?.email ?? "nil"
//            let currentUserEmailLabel = UILabel()
//            currentUserEmailLabel.font = Brandbook.font()
//            currentUserEmailLabel.text = currentUserEmail
//            currentUserViewController.view.addSubview(currentUserEmailLabel)
//            currentUserEmailLabel.translatesAutoresizingMaskIntoConstraints = false
//            NSLayoutConstraint.activate([
//                currentUserEmailLabel.centerXAnchor.constraint(equalTo: currentUserViewController.view.centerXAnchor),
//                currentUserEmailLabel.centerYAnchor.constraint(equalTo: currentUserViewController.view.centerYAnchor)
//            ])
            return tabBarController
        }
    }
    
//    FOR DEBUG
    private func signOut() {
        do {
            try Auth.auth().signOut()
        } catch {
            print("SIGN OUT ERROR")
        }
    }
}

