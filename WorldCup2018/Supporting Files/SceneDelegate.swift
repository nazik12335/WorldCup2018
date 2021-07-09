//
//  SceneDelegate.swift
//  WorldCup2018
//
//  Created by Nazik on 09.07.2021.
//

import UIKit

class SceneDelegate: UIResponder, UIWindowSceneDelegate {

  var window: UIWindow?
  var appFlowCoordinator = AppFlowCoordinator()
  func scene(_ scene: UIScene, willConnectTo session: UISceneSession, options connectionOptions: UIScene.ConnectionOptions) {
  
    guard let windowScene = (scene as? UIWindowScene) else { return }
    
     self.window = UIWindow(frame: windowScene.coordinateSpace.bounds)
     self.window?.windowScene = windowScene
    appFlowCoordinator.start(window: self.window)
     
  }

  func sceneDidDisconnect(_ scene: UIScene) {}

  func sceneDidBecomeActive(_ scene: UIScene) {}

  func sceneWillResignActive(_ scene: UIScene) {}

  func sceneWillEnterForeground(_ scene: UIScene) {}

  func sceneDidEnterBackground(_ scene: UIScene) {}
}

