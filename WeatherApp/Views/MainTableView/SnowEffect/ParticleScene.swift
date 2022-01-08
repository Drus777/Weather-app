//
//  ParticleScene.swift
//  SpriteKitSnow
//
//  Created by Алексей Авдейчик on 22.12.21.
//

import Foundation
import SpriteKit

class ParticleScene: SKScene {
    override func didMove(to view: SKView) {
        super.didMove(to: view)
        setupParticleEmitter()
    }
    
    private func setupParticleEmitter() {
        let particleEmitter = SKEmitterNode(fileNamed: "Snow")!
        particleEmitter.position = CGPoint(x: size.width / 2, y: size.width - 50)
        addChild(particleEmitter)
    }
}
