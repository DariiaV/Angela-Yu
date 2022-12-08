//
//  SceneDelegate.swift
//  ToDoListRealmApp
//
//  Created by Дария Григорьева on 07.12.2022.
//

import UIKit

class SceneDelegate: UIResponder, UIWindowSceneDelegate {
    
    var window: UIWindow?
    
    func scene(_ scene: UIScene, willConnectTo session: UISceneSession, options connectionOptions: UIScene.ConnectionOptions) {
        guard let scene = (scene as? UIWindowScene) else { return }
        window = UIWindow(windowScene: scene)
        window?.rootViewController = getNavigationController()
        window?.makeKeyAndVisible()
    }
    
    private func getNavigationController() -> UIViewController {
        let navVC = UINavigationController(rootViewController: TaskListViewController())
        navVC.navigationBar.prefersLargeTitles = true
        let appearance = UINavigationBarAppearance()
        appearance.configureWithOpaqueBackground()
        appearance.backgroundColor = .systemBackground
        let blackColor = UIColor(named: "TitleBlackColor") ?? .black
        appearance.titleTextAttributes = [.foregroundColor: blackColor]
        appearance.largeTitleTextAttributes = [.foregroundColor: blackColor]
        
        navVC.navigationBar.standardAppearance = appearance
        navVC.navigationBar.scrollEdgeAppearance = appearance
        return navVC
        
        func sceneDidDisconnect(_ scene: UIScene) {
            // Called as the scene is being released by the system.
            // This occurs shortly after the scene enters the background, or when its session is discarded.
            // Release any resources associated with this scene that can be re-created the next time the scene connects.
            // The scene may re-connect later, as its session was not necessarily discarded (see `application:didDiscardSceneSessions` instead).
        }
        
    }
}
