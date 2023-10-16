//
//  SceneDelegate.swift
//  ToDoList
//
//  Created by Yuliya on 13/10/2023.
//

import UIKit

class SceneDelegate: UIResponder, UIWindowSceneDelegate {

    var window: UIWindow?

    func scene(_ scene: UIScene, willConnectTo session: UISceneSession, options connectionOptions: UIScene.ConnectionOptions) {

        guard let windowScene = (scene as? UIWindowScene) else { return }
        
        window = UIWindow(frame: UIScreen.main.bounds)
        window?.windowScene = windowScene
        
        let viewController = ViewController()
        window?.rootViewController = viewController
        window?.makeKeyAndVisible()
    }
}
