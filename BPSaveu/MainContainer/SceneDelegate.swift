//
//  SceneDelegate.swift
//  BPSaveu
//
//  Created by yangjian on 2024/1/25.
//

import UIKit

class SceneDelegate: UIResponder, UIWindowSceneDelegate {

    var window: UIWindow?


    func scene(_ scene: UIScene, willConnectTo session: UISceneSession, options connectionOptions: UIScene.ConnectionOptions) {
        guard let _ = (scene as? UIWindowScene) else { return }
        addGradient()
        addLoadingLife()
    }

    func sceneDidDisconnect(_ scene: UIScene) {
    }

    func sceneDidBecomeActive(_ scene: UIScene) {
    }

    func sceneWillResignActive(_ scene: UIScene) {
    }

    func sceneWillEnterForeground(_ scene: UIScene) {
        NotificationCenter.default.post(name: .applicationLoading, object: nil)
    }

    func sceneDidEnterBackground(_ scene: UIScene) {
    }

}

extension SceneDelegate {
    
    func addLoadingLife() {
        NotificationCenter.default.addObserver(forName: .applicationLoading, object: nil, queue: .main) { [weak self] _ in
            if let vc = self?.window?.rootViewController, let vc = vc as? LoadingVC {
                vc.startLoading()
            } else {
                self?.window?.rootViewController = LoadingVC()
            }
        }
        
        NotificationCenter.default.addObserver(forName: .applicationHome, object: nil, queue: .main) { [weak self] _ in
            self?.window?.rootViewController = HomeVC()
        }
    }
    
    func addGradient() {
        if let window = window {
            self.window?.backgroundColor = .white
            let gradientLayer = CAGradientLayer()
            gradientLayer.frame = window.bounds
            gradientLayer.colors = [UIColor(hex: 0xFCFDFD).cgColor, UIColor(hex: 0xE8F9EF).cgColor]
            gradientLayer.startPoint = CGPoint(x: 0.0, y: 0.0)
            gradientLayer.endPoint = CGPoint(x: 1.0, y: 1.0)
            self.window?.layer.addSublayer(gradientLayer)
        }
    }
}


extension Notification.Name {
    static let applicationLoading = Notification.Name(rawValue: "application.loading")
    static let applicationHome = Notification.Name(rawValue: "applciation.home")
}
