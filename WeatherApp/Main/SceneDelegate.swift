//
//  SceneDelegate.swift
//  WeatherApp
//
//  Created by Andrey on 29.12.21.
//

import UIKit

class SceneDelegate: UIResponder, UIWindowSceneDelegate {
    
    var window: UIWindow?
    
    func scene(_ scene: UIScene, willConnectTo session: UISceneSession, options connectionOptions: UIScene.ConnectionOptions) {
        
        guard let windowScene = (scene as? UIWindowScene) else { return }
        window = UIWindow(frame: windowScene.coordinateSpace.bounds)
        window?.windowScene = windowScene
        configureBackgroundImageView()
        window?.rootViewController = PageVC()
        window?.makeKeyAndVisible()
    }
    
    private var backgroundImageView: UIImageView = {
        let imageView = UIImageView(image: UIImage(named: "sunnyBackground"))
        imageView.contentMode = .scaleAspectFill
        imageView.clipsToBounds = true
        return imageView
    }()
    
    private func configureBackgroundImageView() {
        window?.addSubview(backgroundImageView)
        backgroundImageView.translatesAutoresizingMaskIntoConstraints = false
        if let window = window {
            NSLayoutConstraint.activate([
                backgroundImageView.topAnchor.constraint(equalTo: window.topAnchor),
                backgroundImageView.leftAnchor.constraint(equalTo: window.leftAnchor),
                backgroundImageView.rightAnchor.constraint(equalTo: window.rightAnchor),
                backgroundImageView.bottomAnchor.constraint(equalTo: window.bottomAnchor)
            ])
        }
    }
    
    func sceneDidDisconnect(_ scene: UIScene) { }
    
    func sceneDidBecomeActive(_ scene: UIScene) { }
    
    func sceneWillResignActive(_ scene: UIScene) { }
    
    func sceneWillEnterForeground(_ scene: UIScene) { }
    
    func sceneDidEnterBackground(_ scene: UIScene) { }
}

