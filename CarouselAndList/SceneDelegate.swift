//
//  SceneDelegate.swift
//  CarouselAndList
//
//  Created by Furkan ic on 8.02.2025.
//


import UIKit
import SwiftUI

class SceneDelegate: UIResponder, UIWindowSceneDelegate {
    
    var window: UIWindow?
    
    func scene(_ scene: UIScene, willConnectTo session: UISceneSession, options connectionOptions: UIScene.ConnectionOptions) {
        guard let windowScene = (scene as? UIWindowScene) else { return }
         setupWindow(with: windowScene)
         
        let mainviewController = mainView(.swiftUI)
        let navigationController = UINavigationController(rootViewController: mainviewController)
        window?.rootViewController = navigationController
    }
    
    private func mainView(_ framework: UIFramework) -> UIViewController {
        switch framework {
        case .swiftUI:
            UIHostingController(rootView: MainView())
        case .UIKit:
            UIViewController()
        }
    }

    private func setupWindow(with windowScene: UIWindowScene) {
        window = UIWindow(windowScene: windowScene)
        window?.makeKeyAndVisible()
    }
    
    func sceneDidDisconnect(_ scene: UIScene) {}
    
    func sceneDidBecomeActive(_ scene: UIScene) {}
    
    func sceneWillResignActive(_ scene: UIScene) {}
    
    func sceneWillEnterForeground(_ scene: UIScene) {}
    
    func sceneDidEnterBackground(_ scene: UIScene) {}
    
}

enum UIFramework {
    case swiftUI
    case UIKit
}
