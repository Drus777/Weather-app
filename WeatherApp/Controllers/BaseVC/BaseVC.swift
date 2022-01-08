//
//  BaseVC.swift
//  WeatherApp
//
//  Created by Andrey on 29.12.21.
//

import UIKit
import SpriteKit

final class BaseVC: UIViewController {
    
    private let currentView: UIView?
    
    private let skView: SKView = {
        let skView = SKView()
        skView.backgroundColor = .clear
        return skView
    }()
    
    override func loadView() {
        view = currentView
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        configureSkView()
        initSkScene()
    }
    
    init(view: UIView) {
        self.currentView = view
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        return nil
    }
    
    func configureSkView() {
        currentView!.addSubview(skView)
        skView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            skView.topAnchor.constraint(equalTo: currentView!.topAnchor, constant: 20),
            skView.leftAnchor.constraint(equalTo: currentView!.leftAnchor, constant: 20),
            skView.rightAnchor.constraint(equalTo: currentView!.rightAnchor, constant: -20),
            skView.bottomAnchor.constraint(equalTo: currentView!.bottomAnchor, constant: -600)
        ])
    }
    
    private func initSkScene() {
        let particleScene = ParticleScene(size: CGSize(width: 1080, height: 1000))
        particleScene.scaleMode = .aspectFill
        particleScene.backgroundColor = .clear
        
        skView.presentScene(particleScene)
    }
}



