//
//  Coordinator.swift
//  QFree
//
//  Created by Саид Дагалаев on 07.12.2020.
//

import UIKit

class Coordinator {
    static func rootVC(vc: UIViewController) {
        let sceneDelegate = UIApplication.shared.connectedScenes
                .first!.delegate as! SceneDelegate
        sceneDelegate.window!.rootViewController = vc
        sceneDelegate.window!.makeKeyAndVisible()
    }
}
